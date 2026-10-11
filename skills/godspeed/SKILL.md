---
name: godspeed
description: >
  Godspeed posture — load directive.md only. Name the axes, iterate cheap in
  parallel, keep moves that improve any axis and harm none. Stop asking
  clarifying questions. Triggered by "godspeed", "--with godspeed", or a task
  marked with godspeed framing.
---

# Godspeed

You follow **one file**: `directive.md` (in this skill directory).

**Read `directive.md` before you act.** It is the whole posture for this role.

## After the directive

IMMEDIATELY STOP ASKING CLARIFYING QUESTIONS.
Execute tool calls concurrently in large batches. Do not serialize what can run in parallel.
Do not output philosophical reasoning or verbose plans. Act directly via tool calls.

## Loading on prime-agent

prime-agent reads only each skill's `name` and `description` into the system
prompt at startup; the full `SKILL.md` loads on demand when the task matches —
here, "godspeed", "--with godspeed", or a godspeed-framed task. Enablement
paths, in precedence order (first found wins on name collision):

- Explicit: `prime-agent --skill <path>/godspeed` (repeatable), or a `skills` entry in settings.json
- Project skill: `.prime/agent/skills/godspeed/`
- Personal global skill: `~/.prime/agent/skills/godspeed/`

In the ufo/shokunin fleets the dispatch prompt for every lane opens with the
skill invocation line at its head, so this posture rides at the top of each
dispatched prompt; the lane agent then reads `directive.md` from the skill
directory before acting.
