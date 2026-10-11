# prymeagnt — prime-agent setup: routing, installers, fleet skills

Configuration and skills for a [prime-agent](https://github.com/PrimeIntellect-ai/prime-agent)
0.10.0 install. The repo turns a bare prime-agent into the house fleet setup:

- **`config/settings.json`** — the settings template: model routing (default,
  subagent, provider backup), RLM recursion depth, auto-refinement, agent
  traces.
- **`scripts/apply-settings.sh`** — idempotently merges that template into the
  live settings file, preserving every key the template does not manage, with
  a timestamped backup before any change.
- **`scripts/install-skills.sh`** — copies `skills/` into prime-agent's user
  skill discovery directory.
- **`skills/`** — three skills adapted for prime-agent:
  - **godspeed** — the execution posture: name the axes, iterate cheap and in
    parallel, keep moves that improve any axis and harm none. Loaded as a
    directive prefix, never expanded into prose.
  - **ufo** — the UFO-FSD orchestrator: one L1 root session plans (wwkd),
    dispatches specialist RLM lanes in parallel waves, composes exactly one
    Pareto verdict per round bound to the autonomous gate, and refines its own
    harness between rounds. See `skills/ufo/references/run-logic.md`.
  - **shokunin** — the craft fleet: mints domain-specialist lanes as global
    harness entries and iterates them with one-axis-move craft rounds judged
    per axis (`improved` / `harmed` / `unchanged` / `unprovable-but-better`,
    never scalar scores).

Evidence for every claim about prime-agent behavior lives in
[docs/capability-survey.md](docs/capability-survey.md) (the B0100 survey) and
[config/NOTES.md](config/NOTES.md).

## Model routing

`config/settings.json` routes work like this:

| Seat / lane | Model | Thinking | Routed by |
|---|---|---|---|
| L1 root session, default model | `openai-codex` / `gpt-6-sol` | `high` | `defaultProvider` + `defaultModel` + `defaultThinkingLevel` |
| Volume RLM lanes — scout, reviewer, sentinel, executor, mutation-tester, revenger, simplifier, scribe, labrat | `openai-codex` / `gpt-5.1-codex-mini` | lane's own choice | `subagentDefaultModel` (the lane omits `model=`); `auxiliaryModel` matches |
| Hard-reasoning seats — planner, critic, connector, distiller | `xai` / `grok-4.7` | `xhigh` | explicit `rlm.spawn(model='xai/grok-4.7', thinking='xhigh')` per the ufo tier table |
| Provider backup | `zai` / `glm-5.3-flash` | — | `providerBackupModel` |
| Volume-tier capacity fallback | `zai` / `glm-5.3-flash` | — | ufo tier fallback chain |
| Hard-tier capacity fallback | `zai` / `glm-5.3` | — | ufo tier fallback chain, then volume tier |

Per-spawn model resolution order (capability survey §2): explicit `model=`
argument → `subagentDefaultModel` → parent-model inheritance. Pinning
`subagentDefaultModel` is what keeps volume lanes cheap by default; hard seats
always pass explicit arguments. A `thinking` level the resolved model does not
support fails the spawn as a typed `effort_unsupported` outcome — it is never
silently clamped.

Other managed keys: `rlmMaxDepth: 3` (ufo needs ≥ 2 so the executor's depth-2
`labrat` can spawn; `rlmMaxDepth` is daemon-enforced),
`autoRefine: {"enabled": true, ...}` with `turnInterval` / `compact` /
`cooldownMs` left `null` so prime-agent's own defaults apply, and
`agentTraces: {"enabled": true}`.

## Install — one command

Requires an installed prime-agent (0.10.0 surveyed) plus bash, coreutils and
`jq`. From the repo root:

```bash
scripts/apply-settings.sh && scripts/install-skills.sh
```

- **`apply-settings.sh`** deep-merges `config/settings.json` into
  `~/.prime/agent/settings.json` (override the agent dir with
  `PRIME_AGENT_CODING_AGENT_DIR`, the paths with `SETTINGS_TEMPLATE` /
  `SETTINGS_TARGET`). The template wins on the keys it manages; every other
  key in your live file is preserved as-is. A
  `settings.json.bak-<UTC timestamp>` backup is written before any
  modification; the write is atomic and the file stays owner-only (0600).
  Running it again when nothing changed is a no-op.
- **`install-skills.sh`** copies each `skills/<name>/` directory into
  `~/.prime/agent/skills/` (override the source with `SKILLS_SOURCE`, the
  target with an explicit first argument). It fails loudly instead of guessing
  when the prime-agent config dir does not exist.

Afterwards: restart prime-agent so the new settings apply to new sessions, or
run `/reload` inside an interactive session to pick up the installed skills
without a restart (the survey confirms `/reload` discovers new/changed
skills; settings changes apply to fresh sessions).

Quick check that the skills are discovered:

```bash
prime-agent prompt | grep -E 'godspeed|shokunin|ufo'
```

The full verification procedure — the three smoke tests and how to read
`verification/` output — is in
[docs/smoke-testing.md](docs/smoke-testing.md).

## Docs

- [docs/capability-survey.md](docs/capability-survey.md) — B0100 survey of
  prime-agent 0.10.0: skill discovery paths and precedence, the RLM spawn API
  and model resolution, goals, autonomous gates, `/refine` + autoRefine, and
  capability packages. Preserved verbatim as evidence.
- [docs/ufo-workflow.md](docs/ufo-workflow.md) — running a UFO mission from an
  interactive prime-agent session: `--goal` seeding, the autonomous gate loop,
  RLM lane waves and tiers, the `/refine` loop, the fleet wall.
- [docs/shokunin-workflow.md](docs/shokunin-workflow.md) — craft rounds and
  minting lanes: the `.shokunin/` books, global harness entries, the round
  prompt contract, promotion gates.
- [docs/smoke-testing.md](docs/smoke-testing.md) — the three smoke tests, and
  how to read the evidence a verification run writes to `verification/`.
