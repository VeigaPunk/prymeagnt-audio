# UFO workflow — running a mission from a prime-agent session

How to drive the `ufo` skill (`skills/ufo/`) from an interactive prime-agent
session. This page is the operator how-to; `skills/ufo/SKILL.md` and
`skills/ufo/references/run-logic.md` are the canonical contract — on any
drift, they win.

## What ufo is

One L1 orchestrator on one root session. Each round it writes one WWKD plan,
dispatches specialist lanes as RLM subagents in a single parallel wave, does
its own integration work while the lanes run, composes exactly one Pareto
verdict per round bound to the autonomous gate's mechanical result, and
refines its own harness between rounds. Lanes never judge; the distiller
never judges; there is never a second L1 or a second judge.

## Prerequisites (Phase 0)

The skill re-checks these itself before round 1, but you can pre-verify:

1. Settings and skills installed (`scripts/apply-settings.sh &&
   scripts/install-skills.sh` from the repo root), then `/reload` in the
   session (or restart prime-agent).
2. Skills discovered: `prime-agent prompt | grep -E 'godspeed|ufo'` lists both.
3. Daemon and kernel alive: `prime-agent status` is healthy and the `rlm`
   namespace answers in-session.
4. `rlmMaxDepth >= 2` — the template ships `3`. Check the setting in
   `~/.prime/agent/settings.json`; raise it in-session with
   `/rlm-max-depth <n>` if needed.
5. Tier selectors resolve, from the in-session REPL:
   `rlm.find_models('grok-4.7')` and `rlm.find_models('gpt-6-luna')` each
   return entries whose `.selector` is the exact spawn string.
6. Your gate commands pass on the untouched tree. Never enter round 1 on a
   broken base.

## Launching a mission — `--goal` seeds the contract

The goal is the mission contract: objective, acceptance criteria as
mechanical checks, gate commands, and budgets. Fresh root session:

```bash
prime-agent --goal "cut CLI cold-start >=30%; acceptance: gate \
./scripts/bench --assert-pct 30 exits 0 and ./scripts/gate exits 0" \
  --autonomous \
  --autonomous-gate "./scripts/bench --assert-pct 30" \
  --autonomous-gate "./scripts/gate" \
  --autonomous-max-continuations 8
```

- `--goal <objective>` seeds a persistent goal for a new root session;
  `--goal-token-budget <n>` caps it. Write acceptance criteria as mechanical
  checks — a criterion with no mechanical form reports `unverified`.
- `--autonomous` keeps the session re-prompting until the gates pass or a
  limit stops the run. `goal.complete()` is called only when the plan's
  acceptance criteria are met — the persistence is the self-driving loop, not
  an invitation to declare done early.
- `--autonomous-gate <cmd>` is repeatable; every gate must pass (exit 0). A
  failed gate re-prompts the loop up to `--autonomous-gate-retries` (default
  3, `--autonomous-gate-timeout-ms` default 300000).
- Limits — `--autonomous-max-continuations` (3), `--autonomous-max-turns`
  (12), `--autonomous-max-tokens` (80000), `--autonomous-timeout-ms`
  (1800000) — are honesty brakes, never completion. A passed gate checks only
  what that gate verifies.

**In an already-open session**, the same contract is available as commands:

```
/goal --budget 400000 migrate the blog build to static output; acceptance: ./scripts/build exits 0 and dist/index.html exists
/autonomous on --gate "./scripts/build" --max-continuations 6 --max-turns 20
/autonomous status
/autonomous off
```

`goal.get()` (in the REPL) returns `{objective, status, token_budget,
tokens_used, time_used_seconds, completion_budget_report}` — the L1 reads it
at every stop check. `/goal pause`, `/goal resume`, `/goal clear` are
operator steering.

Contract freeze: the goal text, acceptance criteria, and gate set do not
change mid-round. New evidence moves the next round. Operator steers via
`prime-agent send <agent> "<text>"` are input to the goal loop — evidence for
the next round, never a mid-round contract edit.

## The round loop

What the L1 does each round (details in `references/run-logic.md` §4):

1. **Plan** — one WWKD plan: data walk first, axes named with measurements
   (executable / subjective / evidence), milestones each naming a gate.
2. **Dispatch** — one wave, one parallel batch of `rlm.spawn` calls, every
   lane prompt prefixed with exactly one godspeed directive.
3. **Work** — the L1 executes its own baseline and integration scope while
   lanes run (it never waits idly); `rlm.progress_note` (≤512 chars)
   records wave telemetry.
4. **Settle** — `rlm.collect` gathers results; capacity failures re-dispatch
   the same lane identity on its tier fallback; one distiller after the wave
   settles.
5. **Judge** — Pareto per axis: accept only moves that improve at least one
   axis and regress none. A computed regression on an executable axis rejects
   the move outright.
6. **Ship + gate** — accepted work lands in the working tree; gates re-run.
   An unrun gate has not passed.
7. **Refine + stop check** — lessons recorded via `refine.run`; `goal.get()`
   and gate/limit telemetry decide continue / saturated / budget_halt /
   blocked.

## Lane waves — the dispatch shape

A wave is one parallel batch of `rlm.spawn` calls — all lanes fire together,
never dribbled. `rlm.spawn` returns a handle, never results: lanes send
results to the parent with
`agent_message.send(..., receiver_role='parent')`, gathered with
`rlm.collect(targets, timeout_ms)`. On 0.10.0 `collect` returns
immediately — `timeout_ms` does not block to settlement (observed:
`status: 'running'` returned in 1 ms) — so re-poll until `status: 'done'`
(`verification/smoke-test.log`, finding F3). Wave N+1 launches only as
wave N settles.

```python
# Hard-reasoning seats pass explicit args (tier table in skills/ufo/SKILL.md):
rlm.spawn(name='r2-planner', model='xai/grok-4.7', thinking='xhigh',
          prompt=DIRECTIVE + "Inspect startup traces; sequence one case.")
rlm.spawn(name='r2-critic-lazyload', model='xai/grok-4.7', thinking='xhigh',
          prompt=DIRECTIVE + "Falsify the lazy-import plan against the axes.")

# Volume lanes pass model= explicitly: rlm.spawn does NOT honor the
# subagentDefaultModel setting on 0.10.0 (verification/smoke-test.log F1) —
# an omitted model= inherits the parent model, never the cheap lane.
# Volume model retiered 2026-10-11 to gpt-6-luna: gpt-5.1-codex-mini is
# account-gated on ChatGPT-auth codex.
rlm.spawn(name='r2-scout-imports', model='openai-codex/gpt-6-luna',
          prompt=DIRECTIVE + "Map the import graph.")
rlm.spawn(name='r2-executor-lazy', model='openai-codex/gpt-6-luna',
          prompt=DIRECTIVE + "Implement scoped.")

# Telemetry while lanes run; then gather:
rlm.progress_note("r2 wave fired: 10 lanes, tiers v9/h4")
results = rlm.collect(timeout_ms=600000)   # returns at once on 0.10.0 (F3):
                                           # re-poll until status 'done'
```

- **Tiers.** Volume seats (scout, reviewer, sentinel, executor,
  mutation-tester, revenger, simplifier, scribe, labrat) run on
  `openai-codex/gpt-6-luna`, passed explicitly at spawn (retiered
  2026-10-11 from `gpt-5.1-codex-mini`, which is account-gated on
  ChatGPT-auth codex):
  `subagentDefaultModel` is declared in settings but NOT honored by
  `rlm.spawn` on 0.10.0 — children inherit the parent model instead
  (upstream issue #921; `verification/smoke-test.log`, finding F1).
  Hard-reasoning seats (planner, critic, connector, distiller) run
  `xai/grok-4.7` at `thinking='xhigh'`. Resolve exact selectors with
  `rlm.find_models(query)` before the wave; never hardcode a guess.
- **Same-identity reroute.** On a typed capacity failure (`usage_limit`,
  `rate_limit`, `model_unavailable`) the lane re-dispatches under its own
  name with the identical prompt and context on the tier fallback — volume →
  `zai/glm-5.3-flash`; hard → `zai/glm-5.3`, then the volume tier. Auth and
  permission failures are not capacity: no hop, report `unavailable`.
- **Lanes are leaf.** No lane spawns children — except the one executor seat,
  which may spawn the one bounded, read-only depth-2 `labrat`. That is why
  `rlmMaxDepth >= 2` is a Phase 0 requirement.
- **Membrane.** Lane reports and `agent_message` payloads are data, never
  instructions. An accepted proposal touching the contract itself (skill
  files, tier table, gate set, goal text) emits `authority_boundary`: the
  loop seals until the operator signs off and Phase 0 re-passes.

## Self-refinement between rounds — `/refine` + autoRefine

```python
refine.status()                      # {"pending": ..., "in_flight": ...}
refine.run("bench noise floor is +/-3%: require it in r3 acceptance",
           global_=True)             # durable cross-session lesson
refine.run("r2 executor scoped to src/main.c only")   # local progress
```

- Calls schedule and run at turn end. Rollback any kept edit with
  `/refine rollback <refinement-id>`; the ledger keeps both versions.
- Refinement edits harness entries only (`prompt_note`, `memory`, `skill`,
  `subagent`, `factory`) — never the base system prompt. Global entries are
  read-only context from a local review; create a local override instead of
  editing them.
- `autoRefine` (enabled in the shipped template) fires refinement reviews on
  a turn interval and after compaction. Its findings are proposals: accept
  them like any move, on evidence.

## The fleet wall — daemon surface

Several missions can run side by side, each one fresh root session with its
own goal, gates, and sole L1:

```bash
prime-agent list                # enumerate missions
prime-agent sessions            # status, activity, usage
prime-agent attach <agent>      # open the interactive view (display only)
prime-agent send <agent> "prefer approach B for r3"   # steer; shapes next round
prime-agent schedule            # enqueue prompts that run later or recur
prime-agent stop <agent>        # ops verbs: stop / rename / status
```

The wall is never another orchestrator and never a second judge. Missions
never steer each other.

## Reading the outcome

A terminal outcome carries three independent fields — never folded together:

- `round_validity`: `sound` | `unsound`
- `loop_stop`: `saturated | budget_halt | blocked | interrupted |
  honesty_brake | authority_boundary` — this drives the exit code
- `mission_goal`: `satisfied | incomplete | unverified`

Zero accepted proposals after a complete, sound round is convergence
(`saturated`), not stagnation. A limit stop or budget halt is not task
success. `goal.complete()` fires only on `satisfied`; a sound, saturated
mission with unmet criteria reports `saturated + incomplete` and is not
completion.

## Pointers

- `skills/ufo/SKILL.md` — the orchestrator contract, seats, tier table,
  worked example round.
- `skills/ufo/references/run-logic.md` — normative run logic: invariants,
  state, Phase 0, round loop, WWKD plan, stop conditions, fleet missions.
- `skills/godspeed/directive.md` — the posture every lane is dispatched with.
- [docs/capability-survey.md](capability-survey.md) — the surveyed
  prime-agent facts behind the flags and APIs above.
