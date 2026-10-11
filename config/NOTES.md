# Settings template & installers — assumptions and evidence

Target product: prime-agent 0.10.0 (Rust build), live settings at
`~/.prime/agent/settings.json`. Everything below was observed on this
machine's install; no public docs consulted.

## Key shapes in config/settings.json

Shapes mirror the live file and the strings embedded in
`~/.local/share/prime-agent/prime-agent` (struct field lists from serde
error text):

- `defaultProvider`, `defaultModel`, `subagentDefaultModel`,
  `auxiliaryModel`, `defaultThinkingLevel`, `providerBackupModel`,
  `rlmMaxDepth` — plain scalar slots (all `null` in the untouched file).
  `defaultThinkingLevel` is one of `off|minimal|low|medium|high|xhigh|max`
  (binary enum strings); `high` chosen.
- `providerBackupModel` uses the selector form `provider/model-id`
  (binary: `selectors use the form "provider/model-id"`), same as the
  existing `recentModels` entries.
- `agentTraces` is an object: `{"enabled": true}` — matches both the live
  file and `struct AgentTracesSettings with 1 element` in the binary.

## autoRefine — object form (resolved by capability survey §3.3)

`autoRefine` is an object: `{enabled, turnInterval, compact, cooldownMs}`
— field names confirmed in upstream types.rs per the capability survey,
§3.3 (`docs/capability-survey.md`). The template ships the house style of
explicit nulls: `enabled: true` turns auto-refinement on; the other three
stay `null` so
prime-agent's own defaults apply for the turn interval, post-compaction
trigger, and cooldown. Supporting evidence in the same section: trigger
paths `crates/pa-core/src/session_engine/auto_refine_trigger.rs` and
`crates/pa-daemon/src/compact_autorefine.rs`, and the boundary message
"N assistant turns since last auto-refine review".

An earlier revision of this branch shipped scalar `true` per the tower's
initial directive; it was replaced with the object form before merge so
the live settings file cannot hit a deserialize failure or a silently
ignored scalar.

## Skill discovery path (install-skills.sh default)

Assumption: user skills are discovered at
`${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}/skills`.

Evidence:

- The `prime-agent` launcher pins
  `PRIME_AGENT_CODING_AGENT_DIR="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"`
  and the binary repeats `.prime/agent` as the user config root while also
  using a project-relative `.prime/agent` (`package install --local`
  targets the project config).
- The build payload ships built-in skills in `share/prime-agent/skills/`
  (`~/.local/share/prime-agent/skills/` on this machine), i.e. skills are
  directory-per-skill with `SKILL.md` inside.
- `~/.prime/agent/skills/` does not exist on a fresh install; the script
  creates it when the agent dir exists.

The capability survey (M1, landed as `docs/capability-survey.md`, §1.1)
confirms the default above — `~/.prime/agent/skills/<name>/` is the
personal/global discovery root. If a future survey revision lands on a
different directory, pass it as the first argument — the script never
guesses beyond the default above and fails loudly when the agent dir
itself is absent.

## Scripts: constraints honored

- bash + coreutils + jq only (`cp`, `mv`, `mktemp`, `mkdir`, `date`,
  `basename`, `ls`, `printf`).
- `set -euo pipefail` in both.
- Secrets are never read or written: credentials live in `auth.json`,
  which neither script touches; `settings.json` holds no credential
  material. `apply-settings.sh` writes the merged settings with mode 0600
  and atomically (temp file + `mv` in the same directory).
- `apply-settings.sh` honors `PRIME_AGENT_CODING_AGENT_DIR` (same override
  the launcher uses) plus explicit `SETTINGS_TARGET` / `SETTINGS_TEMPLATE`
  environment overrides for testing.

## Merge semantics

`jq -s '.[0] * .[1]' existing template` — recursive deep merge where the
template wins for managed keys and every key not in the template is
preserved as-is (including nested objects like `telemetry`). Idempotency:
both sides are canonicalized with `jq -S` and compared; when equal the
script exits 0 without touching the file (and without creating another
backup). Backups are named `settings.json.bak-<UTC timestamp>`; two
modifications landing in the same second get a `.N` suffix so no backup
is ever overwritten.

## Change record

- 2026-10-11 (retier B0109): `subagentDefaultModel` and `auxiliaryModel`
  moved from `gpt-5.1-codex-mini` to `gpt-6-luna`. Reason:
  `gpt-5.1-codex-mini` is account-gated on ChatGPT-auth codex ("not
  supported when using Codex with a ChatGPT account", verified live
  2026-10-11), so a volume lane pinned to it could never spawn;
  `gpt-6-luna` is verified live on this account. The two keys remain
  declared-but-unhonored at spawn on 0.10.0 (finding F1) — lane routing
  still happens via explicit `model=` args in the skills; the template
  keys follow the tier table so the template stays self-consistent.
  Live re-apply and jq verification recorded in
  `verification/smoke-test-rerun-20261011.log`.
  Operator override, same day: the tier target was first drafted as
  `gpt-5.6-luna`, then the operator pinned it to `gpt-6-luna` before
  landing (both probed live on the codex auth; `gpt-6-luna` answers
  routing-ok).

