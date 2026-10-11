# Shokunin workflow — craft rounds and minting lanes on prime-agent

How to run the `shokunin` skill (`skills/shokunin/`) from an interactive
prime-agent session: minting specialist lanes, running one-axis-move craft
rounds, and promoting lanes. This page is the operator how-to; on any drift
`skills/shokunin/SKILL.md` wins, and the substrate-neutral protocol files
(`~/.agents/skills/shokunin/protocol/`) still own what a verdict, a gate, and
a mint bar *are*.

## What shokunin is — and is not

A shokunin is a domain specialist, iterated by craft rounds until it can
iterate itself. The skill is the orchestrator: it runs craft rounds, mints new
lanes, and judges rounds. It does **not** do general-purpose orchestration —
that is the `ufo` skill's job:

| UFO (`ufo` skill) | Shokunin (this skill) |
|---|---|
| Multi-axis Pareto seat map each round | Per-axis verdicts; ONE axis-move per round |
| Any problem, planned wwkd-first | Only domain-specialist agents: mint → iterate → promote |
| Roster of generalist specialists | Each lane owns exactly one province |

Never describe a shokunin round as "passing Pareto", never import the seat
map, never blend verdicts into a scalar.

## Invoking it from a session

After `scripts/install-skills.sh` + `/reload` (or a restart), prime-agent
discovers the skill at `~/.prime/agent/skills/shokunin/`. Only its `name` +
`description` load at startup; the full `SKILL.md` loads on a trigger match.
Ask in natural language, using the trigger vocabulary:

- *"Run a craft round for lane kotoba."*
- *"Grind kotoba's depth axis."*
- *"Mint a new specialist lane for benchmark analysis."*
- *"Judge the round-4 report for kotoba."*

If discovery is not available, force it explicitly:
`prime-agent --skill ~/.prime/agent/skills/shokunin`, or check what loaded
with `prime-agent prompt | grep shokunin`.

## The two stores

- **Global harness store** (`~/.prime/agent/harness/harness_state.json`,
  history in `refinement_history.jsonl` beside it) — the *executable* lane
  state: subagent specs, domain memory, skills. Persists across sessions.
- **Repo-local `.shokunin/`** — the *auditable* round history inside the
  project the fleet works on.

| File | Purpose |
|---|---|
| `.shokunin/MANIFEST.json` | Fleet-canonical roster + rank + append-only `rounds[]` ledger. Corrections are appended `closure-correction` entries — never in-place edits. |
| `.shokunin/<id>/SCORECARD.md` | Per-lane axis table: axis → score 0–10 → evidence pointer → last-change round. Scores prioritize work; a number never judges a round. |
| `.shokunin/<id>/LOG.md` | Append-only iteration log: verdicts, accepted changes, falsifiable next moves. |
| `.shokunin/<id>/PROVINCE.md` | Domain boundary: owned surfaces (real paths), refusals. |
| `.shokunin/<id>/SHONEN.md` | Probation checklist (four boxes); created at mint, deleted only at promotion. |
| `.shokunin/<id>/corpus/` | `README.md` index, `knowledge/` notes, `lessons/` per round. |
| `.shokunin/reports/round-<N>/<id>.md` | The lane's round report. Lands last, cites its commit hash. |
| `.shokunin/l0-questions.md` | Operator side channel: append `<lane> \| round-<N> \| <question>`; the operator answers by editing in place. |

`rounds[]` entry shape:
`{round, date, type, lanes: {<id>: <status>}, promotions: [...], minted:
[...], notes}` with `<status>` ∈ `ok | failed | not-dispatched |
in-flight`. Round numbers are per-lane counters. Dispatch evidence goes in
`notes` (lane, round, model selector, timestamp) because live session state
is ephemeral.

## Minting a lane

On prime-agent a mint creates a **global harness entry, not a filesystem
agent dir**. The minted lane is a triple in the harness store:

1. a **subagent spec** — name, domain, owned axes, province summary, model
   selectors, the round contract it is dispatched with;
2. a **domain-knowledge memory** — the lane's cited domain facts;
3. a **skill entry** — the lane's executable craft instructions.

Procedure (the orchestrator runs this when you ask it to mint):

1. **Mint bar.** Two documented *unplaceable* demand instances (work no
   existing province could absorb, each with an evidence pointer) or an
   explicit operator directive. A mint without the bar is void.
2. **Roster scan.** `rlm.harness.overview(global_=True)` +
   `rlm.list_subagents()` + `.shokunin/MANIFEST.json` + every
   `.shokunin/<id>/PROVINCE.md`, recording *why* each existing lane rejects
   the demand. A mint without a roster scan is void.
3. **Create the entry** — promote the harness triple, all with `global_=True`,
   e.g. `rlm.harness.create_subagent(..., global_=True)`,
   `rlm.harness.create_memory(..., global_=True)`,
   `rlm.harness.create_skill(..., global_=True)`. The spec text sets the lane
   git identity convention `<id>-shokunin <<id>@shokunin.local>`.
4. **MINT record** at `.shokunin/mints/<id>.md`: reasoning, demand instances
   with evidence, rejected roster fit, claimed boundary.
5. **Probation (shonen).** The lane self-iterates through **≥3 verified
   rounds** building `corpus/` + `PROVINCE.md` before any roster row exists;
   probation is recorded as a `rounds[]` entry of `type: "mint"`. Only the
   operator adds the roster row after probation.
6. **Boundaries.** The minting lane never writes outside `.shokunin/<its-id>/`
   plus the new sibling's seed files, and never edits the `MANIFEST.json`
   roster or a sibling's books.

Example ask: *"Mint a lane named `tekisei` for load-test calibration. Demand
instances: (1) ...evidence pointer..., (2) ...evidence pointer..."* The
orchestrator enforces the bar and refuses if it is not met.

## Running a craft round

A round is ONE axis-move. Six axes exist — **depth, coverage, operability,
freshness, calibration, adjacency** — and a lane owns the subset recorded in
its `SCORECARD.md` and subagent spec. The orchestrator's eight steps:

1. **Declare the axis set** from the lane's `SCORECARD.md`.
2. **Pick ONE axis** — the lane's lowest.
3. **Declare the falsifiable claim** — before→after delta + how measured. No
   claim, no round.
4. **Do the work** — exactly one verifiable improvement. Sub-lanes, when
   warranted: **≥8 `rlm.spawn` calls in one turn**, roles routed planner/
   connector → strongest reasoning (`thinking="high"`), executor/scribe/scout
   → fast (`thinking="low"`), reviewer/critic/sentinel → economy; selectors
   resolved with `rlm.find_models` at dispatch time, never hardcoded.
5. **Judge EVERY owned axis**: `improved` / `harmed` / `unchanged` /
   `unprovable-but-better`. No scalars. An unrun check has not passed.
6. **Admit or reject** — admit only if ≥1 axis improved AND none harmed. A
   trade is reported as a trade; the operator rules via
   `.shokunin/l0-questions.md`. Never average a trade into an accept.
7. **Record** — `SCORECARD.md` before→after, `LOG.md` append, report at
   `.shokunin/reports/round-<N>/<id>.md`, `rounds[]` append in
   `MANIFEST.json`.
8. **Honest stop** — a harmed or unprovable round halts progression on that
   axis. Never re-roll a verdict.

### The round prompt

Dispatch prompts embed the round contract **verbatim** from
`skills/shokunin/templates/round-prompt.md` — fill `<LANE>`, `<ROUND>`,
`<PROJECT_ROOT>`, `<DOMAIN>`, `<OWNED_AXES>`, `<CLAIM>`, delete the field
table, and dispatch. A dispatched prompt missing any contract item fails the
round's closure fidelity check. Child-lane items fixed by the contract: the
report path, commit-before-report ordering with hash citation, the `SHONEN`
heading, commit-hash citation (never subject/tag), and the write scope
(`.shokunin/<LANE>/**` + the lane's own report file).

### Worked example — kotoba, round 4

Province: prompt & skill craft; owned axes `depth, calibration`. The
scorecard's lowest axis is `depth` (22 table rows in
`skills/shokunin/SKILL.md`, counted by `grep -c '^| '` at `a1b2c3d`).
Claim: adding a quoted trigger/anti-trigger decision table raises the count
22 → 26 at the round commit.

```python
# Orchestrator, turn 1 — dispatch (a fleet round issues ≥8 in one turn):
models = rlm.find_models("coder", limit=8)
sel = models[0].selector
h = rlm.spawn(prompt=ROUND_PROMPT, name="kotoba", model=sel, thinking="low")
```

```bash
# Lane, turn 2 — the one-axis-move edit, then books, then commit, then report:
$EDITOR skills/shokunin/SKILL.md
git add .shokunin/kotoba .shokunin/reports/round-4/kotoba.md
git -c user.name=kotoba-shokunin -c user.email=kotoba@shokunin.local \
    commit -m "kotoba r4: depth — description trigger decision table" \
    -- .shokunin/kotoba .shokunin/reports/round-4/kotoba.md
git rev-parse HEAD                 # → 9f31e2a... (cited in the report)
# then: agent_message.send({"lane": "kotoba", "round": 4, "commit": "9f31e2a",
#   "report": ".shokunin/reports/round-4/kotoba.md"}, receiver_role='parent')
```

```python
# Orchestrator, turn 3 — judge every owned axis:
# (collect returns at once on 0.10.0: timeout_ms does not block to
#  settlement — re-poll until status 'done' — verification/smoke-test.log F3)
rlm.collect(timeout_ms=60000)
# depth: improved — grep re-run → 26 at 9f31e2a (was 22 at a1b2c3d)
# calibration: unchanged — no claim made, none measured
# Admit (≥1 improved, none harmed). Record the closure:
#   MANIFEST.json rounds[] append:
#   {"round": 4, "date": "2026-10-11", "type": "closure",
#    "lanes": {"kotoba": "ok"}, "promotions": [], "minted": [],
#    "notes": "dispatch: rlm.spawn kotoba model=<sel> thinking=low; report cites 9f31e2a"}
refine.status()
refine.run("shokunin/kotoba r4: skill descriptions measure depth by quoted-trigger "
           "+ anti-trigger table rows; apply to future description edits",
           global_=True)   # → {"scheduled": True}; lands at turn end
```

If round 5's evidence falsifies the lesson:
`/refine rollback <refinement-id>` — the ledger keeps both. A report that
exists but carries no evidence, no hash, or a placeholder is a marker, not a
report: the round is recorded `failed` and closes nothing.

## Fleet mode — driving many rounds

- **In-session round-robin (default).** The orchestrator fills
  `templates/round-prompt.md` per lane, issues the spawns for round N, checks
  the reports against the content contract, records closure in
  `MANIFEST.json`, dispatches round N+1.
- **Unattended.** `prime-agent --goal "<round-robin objective>"` +
  `/autonomous on --gate "<report-check command>"`. The gate must check
  report **content** (SHONEN heading + minimum substance), never mere file
  existence — a gate that passes on a marker file is a conformance defect.
  Mind the autonomous limits: a limit stop is not task success.
- **Resident driver.** `rlm.create_session(prompt, name=..., cwd=<project>)`
  hosts a long-lived fleet driver at depth 0; lanes it spawns sit at depth+1,
  bounded by `rlmMaxDepth` (shipped: 3).
- **Headless.** The canonical `scripts/shokunin-watchdog.sh` with
  `SUBSTRATE_CMD=prime-agent` (`%C` → lane cwd, `%P` → prompt file) stays
  usable; round-completion detection applies the same content check.

## Promotion gates

- **shonen → shokunin.** Every `SHONEN.md` box checked by a reviewer who did
  not author the round's changes — a fresh reviewer the orchestrator spawns
  (`rlm.spawn(name="<id>-promotion-review", ...)`) or the operator; never
  self-attestation. The four boxes: real decision tables/error patterns/
  checklists with cited sources; an end-to-end domain task executed and
  logged; instructions executable without oral context; no cross-domain bleed
  with `PROVINCE.md` accurate. Promotion updates the lane's harness entries
  via `refine.run(..., global_=True)`, deletes `SHONEN.md` in a committed
  change, and records `promotions: [{id, from: "shonen", to: "shokunin"}]`.
- **shokunin → jin'i-ryu (self-iterating).** At least one logged round in
  which the lane proposed and landed a falsifiable improvement to its *own*
  harness entries (spec/skill/memory), with the delta and its falsification
  condition in `LOG.md`.

`autoRefine`'s scheduled reviews maintain the harness between rounds; they
never admit a round, never move a rank, and never substitute for a
verdict-gated promotion.

## Honesty rules (digest)

An unrun check has not passed. Marker files are failed rounds. Unverifiable
claims are reported `unprovable-but-better` or `unchanged`, never forced into
`improved`. No forced admits — a trade is reported, the operator rules.
Round commits carry the lane identity; a round committed under the operator
identity is a conformance defect. Evidence pointers must resolve at closure
time — nothing under `/tmp`; commits cited by hash.

## Pointers

- `skills/shokunin/SKILL.md` — the canonical prime-agent adaptation
  (substrate mapping, mint mechanics, round procedure, gates).
- `skills/shokunin/templates/round-prompt.md` — the dispatch template with
  the verbatim round contract.
- `~/.agents/skills/shokunin/protocol/` — substrate-neutral protocol
  (`PROTOCOL.md`, `AXES.md`, `CORPUS.md`, ...).
- [docs/capability-survey.md](capability-survey.md) — the surveyed
  prime-agent facts behind the APIs above (§3.3 covers `/refine` + the
  harness stores).
