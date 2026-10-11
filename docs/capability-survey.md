# Prime Agent 0.10.0 — Capability Survey (B0100)

- Surveyed: 2026-10-11, by agent-survey (mission M1, read-only)
- Subject: prime-agent 0.10.0 (Rust build) at `~/.local/share/prime-agent/prime-agent` (61 MB binary), wrapper `~/.local/bin/prime-agent`
- Agent dir (settings/store root): `~/.prime/agent` (env overrides: `PRIME_AGENT_CODING_AGENT_DIR` or `PI_CODING_AGENT_DIR`; Python side: `rlm/harness.py:127-133`)
- Method: read-only CLI probes (`--help`, `help <cmd>`, `prompt`, `package list`, `model list`), `strings(1)` over the binary, source-level reads of the Python kernel runtime (`~/.prime/agent/kernel-venv/lib/python3.11/site-packages/rlm/`), bundled `SKILL.md` docs, and upstream GitHub source/issues as corroboration (version-skew caveat: upstream `main` may be ahead of 0.10.0).

---

## 1. Skill discovery paths

### 1.1 Discovery roots (skills outside the bundled dir)

| Root | Path | Notes |
|---|---|---|
| Explicit | `--skill <path>` (repeatable) + settings `skills: Vec<String>` (path list) | Highest precedence; bad path errors `Skill path does not exist` (binary strings) |
| Project | `<project>/.prime/agent/skills/<name>/` | Per skill-creator SKILL.md:21 |
| Personal/global | `~/.prime/agent/skills/<name>/` | Per skill-creator SKILL.md:22; dir does not exist yet on this machine (created on demand) |
| Shared agents dir | `~/.agents/skills/<name>/` | **Observed**: `prime-agent prompt` lists `godspeed`, `omarchy`, `shokunin`, `tower`, `ufo` loaded from `/home/vgpnk/.agents/skills/.../SKILL.md`; `.agents` + `skills` literals in binary |
| npm package | `skills/` dir inside a package, or `pi.skills` paths in its `package.json`; `node_modules` scan | skill-creator SKILL.md:23 |
| Capability packages | package-provided skills (see §4), root overridable via `PI_PACKAGE_DIR` | settings `packages: Vec<Value>` records installs |
| Built-in/bundled | `~/.local/share/prime-agent/skills/` (XDG_DATA_HOME-aware) | 13 bundled dirs; 12 routed as skills, `factory` is a gated machine library instead |

Precedence (skill-creator SKILL.md:27): explicit `--skill` paths and `skills` settings entries → project → global → package → built-in. First skill found wins on name collision.

`--no-skills` (`-ns`) disables discovery entirely. Analogous flags: `--prompt-template <path>` / `-np --no-prompt-templates`, `--theme <path>` / `--no-themes` (settings keys `prompts` / `themes`, same `Vec<String>` shape — upstream `crates/pa-core/src/settings/types.rs`).

### 1.2 Loading mechanics

- At startup only each skill's `name` + `description` enter the system prompt; full `SKILL.md` loads on demand (skill-creator SKILL.md:8). Observed prompt layer breakdown (`prime-agent prompt`): `skills-inventory (skill discovery) 9228 chars`, part of the dynamic tail; cached static layers 23,166 of 32,832 chars.
- Python-backed skills ship a `pyproject.toml` and are installed into the kernel venv (`~/.prime/agent/kernel-venv`, uv-managed, python3.11); the prompt lists them as `<type>python</type>` with `<python_import>` (e.g. `agent_message`, `refine`, `goal`).
- Frontmatter rules (skill-creator SKILL.md:50-60): `name` ≤64 chars `[a-z0-9-]`, must match directory name; `description` required ≤1024 chars — **empty description = silently not loaded**; `disable-model-invocation: true` hides from the system prompt (only `/skill:<name>` invokes).
- `/reload` picks up new/changed skills, prompts, themes, keybindings without restart (binary: `Reloading keybindings, skills, prompts, themes...`).
- Slash-command registration of skills is gated by settings `enableSkillCommands` ("Register skills as /skill:name commands"); built-in skills gated by `enableBuiltinSkills`; per-skill bundled toggles in `bundledSkills` (currently only `{websearch: bool}` — upstream types.rs).
- Related source (symbol paths in binary): `crates/pa-core/src/skills/{discovery,frontmatter,prompt_templates,mod}.rs`.

### 1.3 Observed inventory (from `prime-agent prompt`, cwd = worktree)

- 5 user skills from `~/.agents/skills`: godspeed, omarchy, shokunin, tower, ufo.
- 12 bundled skills from `~/.local/share/prime-agent/skills`: agent-message, agent-observe, attach-image, compact, edit, goal, mcp, prime-intellect, refine, rlm-heartbeat, skill-creator, websearch (`factory/` present in the dir but not routed as a skill — see §5).

---

## 2. RLM subagents and model resolution

### 2.1 Spawn API (kernel-side, `rlm/__init__.py:170-193`)

```python
rlm.spawn(prompt: str, *, name: str, model: str | None = None, thinking: str | None = None) -> RLMSpawnHandle
```

- Per-spawn override **exists**: `model` takes an exact `provider/model` selector; `thinking` takes a level (`off|minimal|low|medium|high|xhigh|max`); "levels invalid for the resolved model fail the spawn".
- Default when omitted: **inherited from the parent** (system prompt: "if not given, `model` and `thinking` are inherited from the parent").
- `rlm.create_session(prompt, name=None, model=None, thinking=None, cwd=None)` creates a resident **depth-0** session (depth-0 + daemon-backed callers only).
- `rlm.find_models(query, limit=8) -> list[RLMModel]` — `.selector` is "the exact string to spawn the model".
- Also: `rlm.list_subagents()`, `rlm.collect(targets=None, timeout_ms=0)`, `rlm.delete_subagent`, `rlm.rename`, `rlm.progress_note(msg)` (≤512 chars, ~1 note/10 s throttle). Results never return from `spawn`; they arrive via `agent_message`.

### 2.2 `subagentDefaultModel` semantics

- Settings key: `subagentDefaultModel: Option<String>` in `~/.prime/agent/settings.json` (currently `null`); upstream types.rs `subagent_default_model`.
- Semantics (upstream [issue #921](https://github.com/PrimeIntellect-ai/prime-agent/issues/921), which proposed the setting): a persistent default model/provider for RLM subagents. Expected resolution order:
  1. explicit `rlm.spawn(model=...)`
  2. configured `subagentDefaultModel`
  3. parent-model inheritance
- The key ships in the 0.10.0 settings struct, so the proposal landed; the exact admission-time validation behavior ("fail clearly if unavailable") is per the issue text — see Open Questions.

### 2.3 `rlmMaxDepth` — recursion limit

- Settings key `rlmMaxDepth: Option<u64>` (global default). Per-session live value adjustable in-session: `/rlm-max-depth [<non-negative integer> [--global]]` (binary usage string); `--global` "Saved and saved as global default" → writes the settings key.
- Valid range: **any non-negative integer** (daemon rejects otherwise: `RLM max depth must be a non-negative integer.`). Wire shape (upstream `crates/pa-daemon/src/rlm_surface.rs`): `{maxDepth, global?}` → `{maxDepth, source: "chat", globalSaved}`; the session value is persisted durably (`rlm_max_depth_state`; failure logs `pa-daemon: failed to persist rlm_max_depth_state`).
- Meaning: each session has a recursion depth starting at 0 (root; prompt tail prints `Recursive agent depth: 0 (root)`); `rlm.spawn` creates children at depth+1 and errors with `RLM recursion depth limit reached (RLM_DEPTH=N)` at the bound. Workers receive `RLM_DEPTH` env (must be non-negative integer). At depth == max the child gets no sub-agent instructions (third-party writeup: `allowRecursion = depth < maxDepth`; at 0 the spawn instructions are dropped from the system prompt entirely).
- Default when the setting is unset: **not observed** (compiled-in value; see Open Questions).
- Main-agent `--model <id>` / `--provider <name>` flags set the root session model, which children inherit absent overrides. Observed `prime-agent model list` shows providers kimi-coding, openai-codex, prime-inference, zai, xai (truncated sample: `zai glm-5.3-flash`, `openai-codex gpt-5.6-luna`, `prime-inference anthropic/claude-fable-5`, …).

---

## 3. Goals, autonomous mode, /refine + autoRefine

### 3.1 `--goal` / `/goal` (persistent objective)

- CLI: `--goal <objective>` seeds a persistent goal for a **new root session**; `--goal-token-budget <n>` sets a positive token budget (top-level `--help`).
- In-session: `/goal [--budget <tokens>] <objective>`; the command list documents "Set or view a persistent goal; supports pause, resume, and clear". Budget parse error: `Goal token budget must be a positive integer.`
- REPL API (`skills/goal/SKILL.md`): `goal.get()` → `{goal, remaining_tokens, completion_budget_report}` with `objective/status/token_budget/tokens_used/time_used_seconds`; `goal.create(objective, token_budget=None)` (fails while a goal is active/paused/budget-limited; replaces completed/errored goals); `goal.complete()` (agent must call it — the harness keeps re-prompting until it does). Only one active goal per session.
- Continuation machinery (binary strings): `pending goal continuation lock`, `goal_backoff_wake`, continuation reasons `objective_updated` / `Goal budget limit` / `Goal continuation`, stall signal `consecutive turns made no progress`.

### 3.2 `--autonomous` / `--autonomous-gate` (bounded gate-driven runs)

- Flags (top-level `--help`, defaults shown):
  - `--autonomous` — continue until gates pass or a limit is reached
  - `--autonomous-gate <command>` (repeatable) — shell command gate; pass required
  - `--autonomous-gate-retries <n>` (3), `--autonomous-gate-timeout-ms <n>` (300000)
  - `--autonomous-max-continuations <n>` (3), `--autonomous-max-turns <n>` (12), `--autonomous-max-tokens <n>` (80000), `--autonomous-timeout-ms <n>` (1800000)
- In-session: `/autonomous [status|off]` or `/autonomous on [--max-continuations <n|unlimited>] [--max-turns <n|unlimited>] [--max-tokens <n|unlimited>] [--timeout-ms <n|unlimited>] [--gate <command>] [--gate-retries <n>] [--gate-timeout-ms <n>] [--subagent-keep-alive-ms <n>]` (binary usage string).
- Settings `autonomous: {maxContinuations, maxTurns, maxTokens, timeoutMs}` persists defaults; each limit is `number | "unlimited"` (upstream `AutonomousLimitSetting`).
- Behavior while autonomous (system-prompt string in binary): "No human input is available in autonomous mode. Continue working until the host evaluator, verifier, or configured autonomous limits stop the run… Do not end the session yourself; the verifier/evaluator decides completion when configured gates pass."
- Telemetry/status meta tracks `gateAttempt`, `gateFailure`, `limitReason`, `continuationsUsed`, `turnsUsed`, `tokensUsed`. README caveat: "A passed gate checks only what that gate verifies; reaching a limit does not imply task success."

### 3.3 `/refine` + autoRefine (continual harness)

- What it is: refinement analyzes the trajectory and applies small, evidence-backed updates to harness state (prompt notes, memories, skills, subagent specs, factory entries). It never rewrites the base system prompt; every event is recorded with rollback support (`/refine rollback <refinement-id>` usage string; `rollbackOf` fields).
- Kernel API (`skills/refine/SKILL.md`): `refine.status()` → `{pending, in_flight}`; `refine.run(instructions=None, global_=False)` → returns `{"scheduled": True}` immediately, runs at turn end. `global_=True` targets the cross-session store. `rlm.harness.*` CRUD (create/update/delete × memory/prompt_note/skill/subagent/factory, plus `overview`, `search`, `plan_refinement`, `record_refinement`) all take `global_: bool`.
- Scope rules (refine-scope system prompts in binary): local = session/task/project progress; global = "stable cross-session lessons, durable user preferences, reusable skills/subagents"; global entries are read-only context from a local review — create a local override instead of editing global entries.
- Stores on disk (Python source `rlm/harness.py:37-38,167-180`; state = `harness_state.json`, history = `refinement_history.jsonl`):
  - **Global**: `<agentDir>/harness/harness_state.json` → `~/.prime/agent/harness/harness_state.json`; override `RLM_GLOBAL_HARNESS_STATE_DIR`.
  - **Local**: `$RLM_HARNESS_STATE_DIR/harness_state.json`, else `<RLM_SESSION_DIR>/harness/harness_state.json`; without a session dir it refuses: "Local harness state requires RLM_HARNESS_STATE_DIR or RLM_SESSION_DIR."
  - **Observed**: neither store exists yet on this machine (`find ~/.prime/agent -name harness_state.json` → nothing; `~/.prime/agent/harness/` absent) — stores are created lazily on first harness write/refinement.
  - `rlm.get_harness_state(state_dir=None, *, global_=False)` can read another agent's state by path. Entries carry `scope: local|global`, `version` (increments per update), `source: agent|refine`.
- **autoRefine** (settings `autoRefine: {enabled, turnInterval, compact, cooldownMs}` — field names confirmed in upstream types.rs): schedules refinement reviews automatically on a turn interval and after compaction, with a cooldown. Observed behavior strings: boundary message `N assistant turns since last auto-refine review`; trace events `autorefine.review_started` / `autorefine.review_done`; daemon paths `crates/pa-core/src/session_engine/auto_refine_trigger.rs`, `crates/pa-daemon/src/compact_autorefine.rs`, error `pa-daemon: auto-refinement after compaction failed`. With `autoRefine: null` the effective defaults (on/off, interval N) are not observable from strings alone — see Open Questions.

---

## 4. `prime-agent package` — capability packages as a skill distribution path

- Usage (binary help text): `prime-agent package <install|remove|list|update>` — "Packages can provide skills, prompts, and themes."
  - `package install <source> [--local]` — `--local` installs into the current project instead of the user configuration
  - `package remove <source> [--local]`, `package list`, `package update [source]`
- Accepted sources (usage examples in binary): `./local/path`, `git:git@github.com:user/repo`, `https://github.com/user/repo`, `ssh://git@github.com:user/repo`, `npm:@foo/bar`.
- Bookkeeping: installs are recorded under settings key `packages: Vec<Value>`; `prime-agent config` (TUI) toggles package-provided resources ("Configure package resources"; config UI strings: Global/Project × skills/themes).
- `PI_PACKAGE_DIR` env redirects the package root / packaged-version lookup (binary strings; installer even `unset PI_PACKAGE_DIR` in one path). Default package store dir: **not directly observed** (no package ever installed here; `prime-agent package list` → `No packages installed.`).
- Verdict: yes — packages are a first-class alternative skill (and prompt/theme) distribution channel alongside the `~/.agents/skills` and `.prime/agent/skills` directories, with project-vs-user scoping via `--local`.

---

## 5. Related runtime facts (context for the above)

- **Factory** (opt-in): state-machine workflows of subagent specs. Harness kind `factory` written via `rlm.harness.create_factory`; runs via `rlm.factory.run/status/stop/resume`. Ships disabled; `/factory on` persists `factory.enabled: true` in settings (fail-closed on unreadable settings — `rlm/factory.py:3255-3276`). Machine library: bundled seeds inside the runtime wheel (`rlm/machines/<name>/MACHINE.md`; `PRIME_AGENT_MACHINES_DIR` override) + personal library `<agentDir>/machines/<name>/MACHINE.md` (`rlm/factory.py:3608,3624,3982`); managed by `prime-agent factory list|import|export`.
- **Python runtime**: kernel venv `~/.prime/agent/kernel-venv` ships the `prime-agent-runtime` wheel (`rlm` package: `__init__.py`, `harness.py`, `factory.py`, `repl.py`, `mcp.py`, …). The binary refuses to start kernels without a runtime beside it ("reinstall prime-agent so the kernel runtime ships beside the binary").
- **Session store**: `~/.prime/agent/` — `settings.json`, `auth.json` (secret), `sessions/<uuid>.jsonl` (+ `.window-cache.json`), `session-artifacts/`, `session-leases/`, `daemon-workers/`, `logs/`, `mcp-service-catalog.v2.json`, `telemetry.json(l)`, `models/`, `kernel-venv/`. Subagent registries land in session artifacts as `rlm-subagents.jsonl` / `rlm-subagent.json`; cron store `scheduled-jobs.json`; MCP connections `mcp-connections.json` (filenames from binary strings).
- **Install/update**: `install.sh` in the install dir; `prime-agent update [--check] [--nightly|--stable]`, `updateChannel: stable|nightly`.

---

## 6. Open questions

1. **rlmMaxDepth default value** when the setting is unset — compiled in; not visible via strings/CLI without starting a session. Range confirmed: any u64 ≥ 0; 0 disables sub-agent instructions per third-party writeup (unverified locally).
2. **subagentDefaultModel admission-time behavior** — validated against authenticated models at child admission per issue #921, but exact 0.10.0 failure/fallback behavior unverified; resolution order (explicit → setting → parent) is from the issue, not observed at runtime.
3. **`~/.agents/skills` precedence and configurability** — observed as a live discovery root (5 skills loaded), but its position relative to `~/.prime/agent/skills` (both "global"?) and any setting/env to disable it are undocumented in local sources.
4. **autoRefine defaults** — is it on with `autoRefine: null`? Default `turnInterval` (the observed string mentions "9 assistant turns since last auto-refine review" but that is a dynamic counter, not necessarily the configured threshold)? `compact` and `cooldownMs` defaults unknown.
5. **Local harness store location in practice** — `<session_dir>/harness/harness_state.json`; which directory serves as `RLM_SESSION_DIR` for daemon sessions (not yet observable; no harness store exists yet on this machine).
6. **Package install default directory** (when `PI_PACKAGE_DIR` is unset) and whether package skills get venv-installed like Python skills.
7. **Version skew** — upstream `main` files fetched for corroboration (`settings/types.rs`, `rlm_surface.rs`, issue #921) may differ from the installed 0.10.0.
