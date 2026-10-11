---
name: shokunin
description: >-
  Shokunin (職人) craft fleet for prime-agent — mint domain-specialist agents as
  global /refine harness entries (subagent spec + domain memory + skill), then
  iterate them with one-axis-move craft rounds judged per axis
  (improved/harmed/unchanged/unprovable-but-better, never scalar scores).
  Activate on "craft round", "axis move", "grind an axis", minting/creating a
  specialist agent, running or judging a shokunin round, or fleet/watchdog
  rounds. Anti-trigger: general-purpose orchestration and any-problem planning
  are the ufo/godspeed postures, not this skill. Sibling arbitration: contested
  domain scope between lanes is reported to the operator via
  .shokunin/l0-questions.md — never silently absorbed.
---

# Shokunin — 職人, the craft fleet (prime-agent adaptation)

A shokunin is a domain specialist, iterated by craft rounds until it can iterate
itself. This skill is the orchestrator: it runs craft rounds, mints new lanes,
and judges rounds. It does not do general-purpose orchestration.

This file binds the substrate-neutral shokunin protocol onto prime-agent
(0.10.0 surveyed). Canonical sources, still binding for the craft rules
themselves (verdict vocabulary, gates, honesty): the installed shokunin skill —
`~/.agents/skills/shokunin/SKILL.md` plus `protocol/` (`PROTOCOL.md`,
`PROTOCOL-APPENDIX.md`, `MISSION.md`, `AXES.md`, `CORPUS.md`). Where the two
disagree on substrate mechanics, this file wins on prime-agent; the protocol
still owns what a verdict, a gate, and a mint bar *are*.

## Identity — you are the shokunin orchestrator on prime-agent

You run craft rounds and mints. You are **not UFO** (the `ufo` skill), and the
distinction is load-bearing, not cosmetic:

| UFO (ufo skill) | Shokunin (this skill) |
|---|---|
| Multi-axis Pareto seat map each round | Per-axis verdicts; ONE axis-move per round |
| Any problem, planned wwkd-first | Only domain-specialist agents: mint → iterate → promote |
| Roster of generalist specialists | Each lane owns exactly one province |

Keep the distinction explicit in every report: never describe a shokunin round
as "passing Pareto", never import the seat map, never blend verdicts into a
scalar. A round is admitted on per-axis verdicts only (see step 5 below).

## Loading on prime-agent

prime-agent reads only each skill's `name` + `description` into the system
prompt at startup; the full `SKILL.md` loads on demand when the task matches
the trigger strings above. Enablement paths, in precedence order (first found
wins on name collision):

- Explicit: `prime-agent --skill <path>/shokunin` (repeatable), or a `skills`
  entry in `settings.json`
- Project skill: `<project>/.prime/agent/skills/shokunin/`
- Personal global skill: `~/.prime/agent/skills/shokunin/`
- Shared agents dir: `~/.agents/skills/shokunin/` (observed live discovery root)

`/reload` picks up new or changed skill files without a restart. When this
skill ships inside a repo (as here, `skills/shokunin/`), point one of the paths
above at it or copy it into a discovery dir.

## The substrate mapping (canonical → prime-agent)

Canonical concept | prime-agent surface
--- | ---
Fleet root `$SHOKUNIN_ROOT` with child repos `<id>-shokunin/` | The project git repo where the lanes work; per-lane books live under `.shokunin/<id>/` in that repo (below). There are **no filesystem agent dirs**.
A rostered lane | A named **subagent spec** in the global continual-harness store, spawnable via `rlm.spawn(prompt, name=<id>, ...)`
`scripts/shokunin-watchdog.sh` respawn-per-round driver | In-session round-robin driven by the orchestrator; for unattended runs, `prime-agent --goal "<round-robin objective>"` + `/autonomous on --gate <report-check command>`; the canonical watchdog script remains the headless option with `SUBSTRATE_CMD=prime-agent`
`shokunin.conf` lane table + host model route table | The harness store is the roster (`rlm.harness.overview(global_=True)`, `rlm.list_subagents()`); model routing resolves per spawn via `rlm.find_models(query, limit=8)` → `.selector`, passed as `model=` / `thinking=` to `rlm.spawn` (default: `subagentDefaultModel` setting, else parent inheritance)
L2 floor: ≥8 lanes in one batched AgentSwarm call | ≥8 `rlm.spawn` calls issued in one turn, one per L2 lane (prime-agent's kernel queues them; results never return from `spawn` — they arrive via `agent_message`)
Lane ↔ orchestrator messages | `agent_message.send(..., receiver_role='parent' \| 'child')`; orchestrator gathers with `rlm.collect(timeout_ms=...)`
`.ufo/reports/round-<N>/<lane>.md` | `.shokunin/reports/round-<N>/<lane>.md` in the project repo
`MANIFEST.json` rounds ledger | `.shokunin/MANIFEST.json` (repo-local, append-only `rounds[]`)
L0 side channel `.ufo/l0-questions.md` | `.shokunin/l0-questions.md`; live lane→orchestrator questions additionally ride `agent_message` / `rlm.progress_note` (≤512 chars)
Promotion of a lane | `refine.run(instructions, global_=True)` updating the lane's harness entries (surveyed API: returns `{"scheduled": True}`, runs at turn end); undo via `/refine rollback <refinement-id>`
Freshness pressure | `autoRefine` settings `{enabled, turnInterval, compact, cooldownMs}` schedule harness reviews at a turn interval and after compaction — they complement rounds and never replace per-axis verdicts

### Mint mechanics — the key decision

**On prime-agent, minting creates a global continual-harness entry, not a
filesystem agent dir.** A minted shokunin is a triple recorded in the global
harness store (`~/.prime/agent/harness/harness_state.json`, history in
`refinement_history.jsonl` next to it, both persisting across sessions):

1. a **subagent spec** (`rlm.harness.create_subagent(..., global_=True)`) —
   the lane's name, domain, owned axes, province summary, model selectors, and
   the round contract it must be dispatched with;
2. a **domain-knowledge memory** (`rlm.harness.create_memory(..., global_=True)`)
   — the lane's cited domain facts, the harness-side twin of its repo-local
   corpus;
3. a **skill entry** (`rlm.harness.create_skill(..., global_=True)`) — the
   lane's executable craft instructions.

All three are promoted through `/refine` (global scope) — the same evidence-
backed, rollback-able channel the harness uses for every other refinement —
via `refine.run(..., global_=True)` or direct `rlm.harness.create_*` calls.
Nothing is scaffolded under `~/.prime/agent/skills/` or any agent directory at
mint time; a lane becomes repo-local bookkeeping (`.shokunin/<id>/`) plus
global harness state. The canonical mint artifacts map across:

| Canonical mint artifact | prime-agent form |
|---|---|
| `<id>-shokunin/` seed repo (7 files) | the harness triple above |
| `MINT.md` in the seed repo | `.shokunin/mints/<id>.md` in the project repo (reasoning, demand instances, rejected roster fit, claimed boundary) |
| `shokunin.conf` lane row + remote wiring | the subagent spec itself; roster mirrored into `.shokunin/MANIFEST.json` |
| lane git identity configured at mint | unchanged mechanism — lanes commit with `git -c user.name=<id>-shokunin -c user.email=<id>@shokunin.local` (below) |
| `corpus/` in the child repo | `.shokunin/<id>/corpus/` (repo-local), summarized into the harness memory entry |

## Bookkeeping — repo-local `.shokunin/`

When the fleet runs inside a project, all books live under `.shokunin/` in that
project's repo. The global harness store holds *executable* lane state; the
repo holds *auditable* round history. File contract:

| File | Purpose |
|---|---|
| `.shokunin/MANIFEST.json` | Fleet-canonical roster + rank + the append-only `rounds[]` ledger (shape below). Corrections are appended `closure-correction` entries naming what they supersede — never in-place edits. |
| `.shokunin/<id>/SCORECARD.md` | Per-lane axis table: owned axis → score 0–10 → evidence pointer → last-change round; plus `planned` and `retired`. Every score is a claim: it carries the counting command that produced it and the commit it was measured against. A score prioritizes work (which axis is lowest); **a number never judges a round** — only verdicts do. |
| `.shokunin/<id>/LOG.md` | Append-only iteration log: round entries with verdicts, accepted changes, falsifiable next moves. Entries are never rewritten or deleted; corrections land as new entries. |
| `.shokunin/<id>/PROVINCE.md` | Domain boundary: owned surfaces (real, resolvable paths), refusals. Corrected to reality when a surface moves; the correction is logged. |
| `.shokunin/<id>/SHONEN.md` | Probation checklist (four boxes, canonical seed text), created at mint, deleted only at promotion. |
| `.shokunin/<id>/corpus/` | `README.md` index, `knowledge/` sourced domain notes, `lessons/` per-round lessons. Corpus rules bind: a count carries its command, a negative claim carries its search sweep, a quote names its location, no credential material ever, corrections are new entries. |
| `.shokunin/reports/round-<N>/<id>.md` | The lane's round report (shape below). Lands last, cites its commit hash. |
| `.shokunin/l0-questions.md` | Operator side channel: append `<lane> \| round-<N> \| <question>`. Append-only; the operator answers by editing in place. |

`rounds[]` entry shape (per canonical step-4, unchanged):
`{round, date, type, lanes: {<id>: <status>}, promotions: [{id, from, to}], minted: [id...], notes}`
with `<status>` ∈ `ok | failed | not-dispatched | in-flight`; `type` carries
`closure-correction` (append-only corrections), `retroactive-closure` (presence-
of-evidence only, never read as a pass), and `mint` (non-closure: no `lanes`
map; carries the mint evidence pointer and the probation note). Round numbers
are **per-lane counters**; `reports/round-<N>/` collects whichever lanes ran
their Nth round. Dispatch evidence on prime-agent is the orchestrator's own
spawn record — put a digest line (lane, round, model selector, timestamp) in
`notes`, because live session state (`rlm.list_subagents()`) is ephemeral and
the committed entry is the pointer that resolves at closure.

## Running a craft round (prime-agent, in-session)

A round is ONE axis-move. Six axes exist — **depth, coverage, operability,
freshness, calibration, adjacency** (definitions and expert signals: canonical
`AXES.md`, restated in the worked example below) — and a lane owns the subset
recorded in its `SCORECARD.md` and subagent spec.

1. **Declare the axis set.** Read the lane's `.shokunin/<id>/SCORECARD.md`
   (create it if missing, per the contract above). Name the axes in play, each
   with direction and an observable that decides movement.
2. **Pick ONE axis.** The lane's lowest axis in `SCORECARD.md`. Saturated or
   wrong-fit axes may be retired or split — record the reason in
   `SCORECARD.md`.
3. **Declare the falsifiable claim.** State the before→after delta that counts
   as improvement and how it is measured. No claim, no round.
4. **Do the work.** Land exactly one verifiable improvement. When sub-lanes are
   warranted, dispatch **≥8 `rlm.spawn` calls in one turn** — one per L2 lane,
   roles routed per the bucket table: planner/connector → strongest reasoning
   selector (`thinking="high"`), executor/scribe/scout → fast execution
   (`thinking="low"`), reviewer/critic/sentinel class → economy selector
   (fallback: fast). Resolve selectors with `rlm.find_models` at dispatch time;
   never hardcode aliases. Measure on the delivered revision, not intent.
5. **Judge EVERY axis the lane owns.** Each axis gets a verdict: `improved`,
   `harmed`, `unchanged`, or `unprovable-but-better`. **No scalars** — a number
   is not a verdict. An unrun check has not passed; a claim you could not
   verify is reported `unprovable-but-better` or `unchanged`, never `improved`.
6. **Admit or reject.** Admit only if ≥1 axis improved AND none harmed. A
   trade (one up, one down) is NOT an improvement: report both verdicts and
   let the operator rule (via `.shokunin/l0-questions.md`). Never average a
   trade into an accept.
7. **Record.** Before→after in `SCORECARD.md` (every score carries its
   counting command and measured commit), evidence in `LOG.md` (append-only),
   the report at `.shokunin/reports/round-<N>/<id>.md`, and a `rounds[]`
   append in `.shokunin/MANIFEST.json`.
8. **Honest stop.** If the round harmed an axis or the claim stays unprovable,
   the round is reported as such and the lane halts progression on that axis.
   Never force a harmed/unprovable round through, never re-roll the verdict to
   make the ledger prettier. If a landed round is later falsified, the
   correction channel is a new LOG entry plus — for harness entries the round
   produced — `/refine rollback <refinement-id>`.

**Round report shape.** The report carries, in order: **Work performed** (one
bullet per item, each with an evidence pointer — path:line, command output, or
commit hash); **Landed changes** (each tied to a `LOG.md` entry and the commit
carrying it); **Before → after measurements** (one per claim, with the counting
command and the commit it was measured against); **SHONEN** (one line per
`SHONEN.md` box: `[x]` only with a named non-author verifier, `[~]` with a
resolvable pointer, `[ ]` if untouched). The report **lands last** — written
only after the lane's work is committed, citing that commit's hash
(`git rev-parse HEAD` at write time); pathspec-limited commits only
(`git commit -- .shokunin/<id> .shokunin/reports/round-<N>/<id>.md`), never
`commit -a`. A contentless report is a **failed round**: a file at the report
path with no evidence, no hash, or a placeholder is a marker, not a report —
it closes nothing and the round is recorded `failed`.

**Dormancy and the L0 side channel.** Two consecutive dispatched-and-reported
rounds with no `LOG.md` activity flag a probationary lane **dormant** in the
round notes; undispatched rounds do not count, and dormancy is a review trigger
for the operator, never an automatic retirement. The operator is reachable via
`.shokunin/l0-questions.md` (append `<lane> | round-<N> | <question>`); note
the open question in the report and route around it — never block the round on
an answer.

## Minting a new agent on prime-agent (the auto-creation mechanic)

Minting is how the fleet grows: the mechanic exists so the fleet creates its
own specialists instead of absorbing every new demand into an existing lane.
On prime-agent the mint lands as a global harness entry (see *Mint mechanics*
above) — never a filesystem agent dir.

1. **Enforce the mint bar.** Require either (a) two documented *unplaceable*
   demand instances — work no existing province could absorb, each with an
   evidence pointer — or (b) an explicit operator directive. The bar is stated
   in canonical `PROTOCOL.md` §Lifecycle; a restatement elsewhere that drifts
   does not relax it.
2. **Roster scan.** Scan `rlm.harness.overview(global_=True)` +
   `rlm.list_subagents()` + `.shokunin/MANIFEST.json` + every
   `.shokunin/<id>/PROVINCE.md`. For each existing lane record why its province
   rejects the demand. That rejected-fit record is part of the mint evidence,
   not a formality — a mint without a roster scan is void.
3. **Create the entry.** Promote the harness triple (subagent spec + memory +
   skill, all `global_=True`) with the lane's name, domain, owned axes,
   province summary, resolved model selectors, and the round contract it will
   be dispatched with (`templates/round-prompt.md`, filled). Set the lane's
   git identity convention (`<id>-shokunin <<id>@shokunin.local>`) in the spec
   text so every round commit can carry it.
4. **MINT record.** Write `.shokunin/mints/<id>.md`: the reasoning, the cause,
   the demand instances with evidence pointers, the rejected roster fit, and
   the claimed domain boundary.
5. **Probation (shonen).** The lane self-iterates through **≥3 verified
   rounds** building `.shokunin/<id>/corpus/` + `PROVINCE.md` before any
   roster row exists. Probation state is recorded as a `rounds[]` entry of
   `type: "mint"` (carrying the mint evidence pointer and the probation note),
   not as a roster row. Only the operator adds the roster row after probation.
6. **Boundaries.** The minting lane never writes outside `.shokunin/<its-id>/`
   + the new sibling's seed files (its `.shokunin/mints/<id>.md` and harness
   entries); it never edits the `MANIFEST.json` roster or a sibling's
   post-seed content.

## Promotion gates

A promotion is a decision backed by artifacts, not a vibe; every gate names its
verifier and its evidence.

- **shonen → shokunin.** Every `SHONEN.md` box checked by a reviewer who did
  not author the round's changes — a fresh reviewer the *orchestrator* spawns
  (`rlm.spawn(name="<id>-promotion-review", ...)`) or the operator; never
  self-attestation, and a subagent the lane dispatched is still the lane. The
  four boxes: real decision tables/error patterns/checklists with cited
  sources; an end-to-end domain task executed and logged; instructions
  executable by an agent without oral context; no cross-domain bleed with
  `PROVINCE.md` still accurate. Any `[x]` without a named non-author verifier
  counts as `[~]`. On promotion: `refine.run(..., global_=True)` updates the
  lane's harness entries to shokunin rank, `.shokunin/<id>/SHONEN.md` is
  deleted in a committed change, the `rounds[]` entry records
  `promotions: [{id, from: "shonen", to: "shokunin"}]`, and the review is
  recorded in the promoting round's report and `LOG.md`.
- **shokunin → jin'i-ryu (self-iterating).** At least one logged round in
  which the shokunin — given its round telemetry — proposed and landed a
  falsifiable improvement to its *own* harness entries (spec/skill/memory) via
  `rlm.harness.update_*(..., global_=True)` or a `refine.run(global_=True)`
  instruction carrying the proposal. The delta and its falsification condition
  are recorded in `LOG.md`.

`autoRefine` interplay: its scheduled reviews maintain the harness between
rounds; they never admit a round, never move a rank, and never substitute for
a verdict-gated promotion.

## Fleet mode on prime-agent (driving many rounds)

- **In-session round-robin (default).** The orchestrator fills
  `templates/round-prompt.md` per lane and issues the spawns for round N; when
  the reports land and pass the content check, it records closure in
  `MANIFEST.json` and dispatches round N+1.
- **Unattended runs.** `prime-agent --goal "<round-robin objective>"` keeps the
  session re-prompting toward the objective (`goal.complete()` ends it), and
  `/autonomous on --gate "<report-check command>"` bounds continuations with a
  shell gate. The gate must check report **content** (SHONEN heading + minimum
  substance), never mere file existence — a gate that passes on a marker file
  is a conformance defect. Mind the autonomous limits (`--autonomous-max-turns`,
  `--autonomous-max-tokens`, ...): a limit stop is not task success.
- **Resident driver.** `rlm.create_session(prompt, name=..., cwd=<project>)`
  hosts a long-lived fleet driver at depth 0; lanes it spawns sit at depth+1,
  subject to `rlmMaxDepth` (workers receive `RLM_DEPTH`).
- **Headless option.** The canonical `scripts/shokunin-watchdog.sh` stays
  usable: `SUBSTRATE_CMD` expands `%C` (lane cwd) / `%P` (prompt file), so
  `SUBSTRATE_CMD=prime-agent` is the whole port. Round-completion detection
  must apply the same content check as above.

## Invariants

Restated faithfully from canonical `PROTOCOL.md` §Invariants:

- **Specialize, don't generalize.** A shokunin's skill/memory entries contain
  cited, verifiable knowledge of its domain — never generic agent advice.
- **One domain per shokunin; a domain belongs to one shokunin.** Contested
  scope is reported (report + `.shokunin/l0-questions.md`), not silently
  absorbed; the operator arbitrates by refining `PROVINCE.md` and the ruling
  is recorded in the round notes. Silence is never a ruling.
- **Rounds are evidence-driven.** Every `LOG.md` entry cites the work that
  motivated it. `LOG.md`, `rounds[]`, and `l0-questions.md` are append-only;
  corrections land as new entries pointing at the superseded text.
- **Local-first.** Lanes push only to the project repo's own remote, restricted
  to their `.shokunin/` paths; domain source trees are read-only; publishing
  and any domain-facing action stay operator-owned. Bookkeeping never
  front-runs an operator gate.
- **Provenance or it didn't happen.** `MANIFEST.json` is canonical for rank and
  roster; the harness store is canonical for executable spawn state; on drift
  between them the spec is corrected from `MANIFEST.json` + `PROVINCE.md` via
  `rlm.harness.update_*(..., global_=True)` in the next round. Lane authorship
  is auditable: round commits carry the lane identity.

## Honesty rules

- An unrun check has not passed. "Should work" is not evidence. Every claimed
  command was re-run at write time with its observed output.
- **Marker files are failed rounds.** A report that exists but carries no real
  content (no evidence pointer, no checkable commit hash, a placeholder) counts
  as a failed round; completion checks — orchestrator, `/autonomous --gate`, or
  watchdog — validate content, never mere existence.
- Unverifiable claims are reported as unverifiable (`unprovable-but-better` or
  `unchanged`), never forced into `improved`.
- **No forced admits.** A trade is reported as a trade; the operator rules.
  Never average, never re-roll.
- Lane identity commits (`git -c user.name=<id>-shokunin
  -c user.email=<id>@shokunin.local commit ...`) are attribution, not
  decoration: a round committed under the operator identity is a conformance
  defect.
- Evidence pointers must resolve at closure time: paths under `/tmp` and
  session-scoped artifacts are not evidence — commit the artifact or cite a
  reproducible command. Commits are cited by hash, never by subject or tag.

## The round-prompt contract

Dispatch prompts embed the operative contract **verbatim** — a prompt missing
any item fails closure fidelity. The shipped template is
`templates/round-prompt.md` (in this skill directory). Round-level items:
(i) mission/axes binding — the lane works exactly one axis-move; (ii) the L2
floor — ≥8 `rlm.spawn` calls in one turn when sub-lanes are dispatched;
(iii) commit-then-push ordering; (iv) push scope; (v) the L0 side channel.
Child-lane items: (1) the report path and filename;
(2) commit-before-report ordering with hash citation; (3) the `SHONEN` heading
requirement; (4) the commit-hash citation rule; (5) the lane's write scope
(`.shokunin/<id>/**` + its own report file). Where a dispatched prompt
conflicts with current protocol files, the files win — a lane re-reads the
contract at the start of every round.

## Worked example — one full craft round on prime-agent

Project: a repo with a `skills/` tree. Lane `kotoba` — province: prompt & skill
craft, owned axes `depth, calibration`. This is its round 4. Calls are the
surveyed prime-agent REPL APIs; file paths are repo-local.

**Turn 1 — orchestrator declares the round.**

Read `.shokunin/kotoba/SCORECARD.md`:

```
# SCORECARD — kotoba
| axis        | score | evidence                                          | last-change |
|-------------|-------|---------------------------------------------------|-------------|
| depth       | 4     | grep -c '^| ' skills/shokunin/SKILL.md → 22, at a1b2c3d | r3 |
| calibration | 6     | self-assessment matched r3 audit, at a1b2c3d       | r3 |
planned: depth — add a trigger-string/anti-trigger decision table for
         skill-description contracts
retired: (none)
```

Axis = `depth` (lowest). Claim: *"adding a quoted trigger-strings +
anti-trigger decision table raises depth: table rows 22 → 26, counted by
`grep -c '^| '` on the skill, measured at the round commit."*

Dispatch (a fleet round issues ≥8 such calls in the same turn; this example
shows the one lane):

```python
models = rlm.find_models("coder", limit=8)
sel = models[0].selector                      # exact string spawn accepts
h = rlm.spawn(prompt=ROUND_PROMPT, name="kotoba", model=sel, thinking="low")
```

`ROUND_PROMPT` is `templates/round-prompt.md` filled for (kotoba, round 4) —
contract embedded verbatim.

**Turn 2 — the lane works, commits, files the report.**

```bash
$EDITOR skills/shokunin/SKILL.md   # the one-axis-move edit (description contract table)
git add .shokunin/kotoba .shokunin/reports/round-4/kotoba.md
git -c user.name=kotoba-shokunin -c user.email=kotoba@shokunin.local \
    commit -m "kotoba r4: depth — description trigger decision table" \
    -- .shokunin/kotoba .shokunin/reports/round-4/kotoba.md
git rev-parse HEAD                 # → 9f31e2a... (cited in the report)
```

```python
agent_message.send(
    {"lane": "kotoba", "round": 4, "commit": "9f31e2a",
     "report": ".shokunin/reports/round-4/kotoba.md"},
    receiver_role='parent')
```

The report carries Work performed / Landed changes / Before→after / `SHONEN`
heading with one line per box.

**Turn 3 — the orchestrator judges every owned axis.**

```python
rlm.collect(timeout_ms=60000)      # gather the lane's message
```

- `depth`: **improved** — `grep -c '^| ' skills/shokunin/SKILL.md`
  → 26 at `9f31e2a` (was 22 at `a1b2c3d`; command re-run at judging time).
- `calibration`: **unchanged** — no claim made, none measured.

Admit: ≥1 improved, none harmed. *(Honest-stop variant: if calibration had
measured harmed — say the self-assessment now overstates coverage — the
verdicts are `improved` + `harmed`, the round is rejected as a trade, kotoba
halts progression on calibration, and the operator rules via
`.shokunin/l0-questions.md`. Nothing is averaged.)*

**Turn 3 — record.**

- `SCORECARD.md`: depth row 4 → 5, evidence = the grep + `9f31e2a`.
- `LOG.md`: appended entry citing claim, both verdicts, both commits.
- `.shokunin/MANIFEST.json` append:

```json
{"round": 4, "date": "2026-10-11", "type": "closure", "closed_at": "2026-10-11T18:40:00+02:00",
 "lanes": {"kotoba": "ok"}, "promotions": [], "minted": [],
 "notes": "dispatch: rlm.spawn kotoba model=<sel> thinking=low; report cites 9f31e2a; SHONEN heading present"}
```

- Close any stable cross-session lesson into the harness:

```python
refine.status()   # {"pending": ..., "in_flight": ...}
refine.run("shokunin/kotoba r4: skill descriptions measure depth by quoted-trigger "
           "+ anti-trigger table rows; apply to future description edits",
           global_=True)   # → {"scheduled": True}; lands at turn end
```

The lesson lands in `~/.prime/agent/harness/harness_state.json` with the event
in `refinement_history.jsonl`; if round 5's evidence falsifies it,
`/refine rollback <refinement-id>` undoes it — the ledger keeps both.

A marker report instead — say the lane wrote a 100-byte "work pushed" note with
no hash — records `{"kotoba": "failed"}` in `rounds[]` and files a conformance
defect in the round notes; real work sitting uncommitted does not rescue it.

## Pointers

- Canonical substrate-neutral contract (verdicts, gates, mint bar, incidents):
  `~/.agents/skills/shokunin/SKILL.md` + `protocol/` (`PROTOCOL.md`,
  `PROTOCOL-APPENDIX.md`, `MISSION.md`, `AXES.md`, `CORPUS.md`).
- `templates/round-prompt.md` (this skill dir) — the dispatch template with the
  verbatim round contract.
- Harness APIs: bundled `refine` and `rlm` skill docs in prime-agent
  (`refine.run/refine.status`, `rlm.harness.*` with `global_=True`,
  `/refine rollback`); subagent surface: `rlm.spawn`, `rlm.find_models`,
  `rlm.list_subagents`, `rlm.collect`, `agent_message`.
- Posture distinction: the `ufo` and `godspeed` skills.
