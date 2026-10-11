# Smoke testing — verifying the setup, and reading `verification/` output

How to confirm the applied settings and installed skills actually work on a
machine before trusting the routing in real missions, and how to interpret
the evidence a verification run writes to `verification/`.

## Preconditions

- `scripts/apply-settings.sh` and `scripts/install-skills.sh` have run
  (see the [README](../README.md#install--one-command)); `jq` is installed;
  `prime-agent` is on `PATH`.
- Nothing here is destructive: the one-shot tests use `--no-session` so they
  leave no session residue, and no test writes outside prime-agent's own
  stores.

## Check 0 — settings and skill discovery (install checks)

Settings reflect every routed key:

```bash
jq '{defaultProvider, defaultModel, defaultThinkingLevel, subagentDefaultModel,
     auxiliaryModel, providerBackupModel, rlmMaxDepth, autoRefine, agentTraces}' \
  ~/.prime/agent/settings.json
```

Expected: `openai-codex` / `gpt-6-sol` / `high`, `gpt-5.1-codex-mini` for
`subagentDefaultModel` and `auxiliaryModel`, `zai/glm-5.3-flash` backup,
`rlmMaxDepth` 3, `autoRefine.enabled` true, `agentTraces.enabled` true.

Skills are discovered:

```bash
prime-agent prompt | grep -E 'godspeed|shokunin|ufo'
```

Expected: all three names appear in the skills inventory (plus the bundled
skills). If a name is missing, re-run `scripts/install-skills.sh` and
`/reload` or restart prime-agent.

## The three smoke tests

### Test 1 — one-shot prompt on the default model

```bash
prime-agent -p --no-session "Reply with exactly: routing-ok"
```

**Pass:** a non-empty response comes back. This exercises the full default
route: `defaultProvider` (`openai-codex`), `defaultModel` (`gpt-6-sol`),
`defaultThinkingLevel` (`high`), and working credentials. An auth or quota
error here is recorded verbatim — it is not a pass.

### Test 2 — RLM subagent spawn on the subagent model

```bash
prime-agent -p --no-session "Spawn a subagent with rlm.spawn(prompt='Reply \
with exactly: subagent-ok', name='smoke-probe'). Do not pass model or \
thinking. Then call rlm.collect(timeout_ms=120000) and print the child's \
reply verbatim, plus whatever the reply/session shows about which model the \
child ran on."
```

**Pass:** the child's reply arrives through the `agent_message` →
`rlm.collect` path (remember: `rlm.spawn` returns a handle, never results).
Because no `model=` was passed, the child resolves through `subagentDefaultModel`
→ `gpt-5.1-codex-mini` — this is exactly the volume-lane route missions
depend on. The depth-1 spawn also proves `rlmMaxDepth` ≥ 1 is in effect
(the template ships 3). An interactive-session equivalent: open
`prime-agent`, then give the same instruction in chat.

### Test 3 — the refine surface responds

```bash
prime-agent -p --no-session "Call refine.status() and print the returned \
object verbatim."
```

**Pass:** an object with `pending` and `in_flight` is returned (both may be
zero on a fresh machine — responding at all is the point). In an interactive
session the `/refine` command surface answers the same way. This proves the
continual-harness plumbing (`refine.run`, `/refine rollback`, autoRefine)
that both fleet skills rest on.

## Quota and provider failures — honest reporting

If a provider is quota-blocked or unavailable, record the **exact error
text** and which tier the run rerouted to — never fabricate or infer a pass:

- default route blocked → the run is failing on the primary route; record it.
- volume lane blocked → ufo's tier fallback sends volume lanes to
  `zai/glm-5.3-flash`; hard seats fall back to `zai/glm-5.3`, then the
  volume tier. A fallback hop is evidence of failover working — the blocked
  primary is still recorded.
- an invalid `thinking` level for a model fails the spawn as typed
  `effort_unsupported` telemetry; it is never silently clamped.

## How to read `verification/` output

A verification pass writes **`verification/smoke-test.log`** (the B0106
verification deliverable — until that lands, the directory may not exist; a
missing `verification/` means verification has not run or has not been
merged yet, not that it passed). The log carries one entry per check:

- the **full command** invoked,
- the **observed output** (not a summary),
- an explicit **pass/fail verdict** per item.

Reading it:

1. **Every check must end in an explicit verdict.** An entry with a command
   and output but no verdict is incomplete evidence — treat it as unverified,
   the same as a fail.
2. **A reroute note is not a hidden failure.** "quota-blocked, rerouted to
   `zai/glm-5.3-flash`" means the check passed on the fallback tier and the
   primary route is unavailable — plan capacity accordingly.
3. **A fail carries its error.** Verdicts of `fail` come with the exact
   provider/shell error; the fix is upstream of the log (credentials, quota,
   install step), and the failing check should be re-run after the fix.
4. **The log is generated evidence — do not edit it by hand.** To refresh it,
   re-run the checks above and record fresh output.

Everything in this file maps one-to-one to the checks a verification run
performs: the two install checks, the three smoke tests, and the
quota-failure reporting rule.
