# Audio round 20 — 200 Hz internal-gap mode

Work commit `67add2997fd1b8fa5d81c1432525ac490a19d078` by `audio-shokunin <audio@shokunin.local>`; this final report is committed **last**. Before `a905a26`. Independent replay `.shokunin/audio/reports/round-20/r20-verifier.md` and Sol per-axis decision `r20-adjudicator.md`. LOG, SCORECARD, worker reports, and JSON receipts keep the commands, exits, and the failed first fit.

Operator dispatch `shk47-audio-r20` supersedes the round-19 pause line. That line is not rewritten.

## Work performed
- Read the r19 verifier table (`.shokunin/audio/reports/round-19/r19-verifier.md`): 16 mode rows, no 200 Hz internal-gap route. Guard `r20-guard.md` hashed 13/13 canonical WAVs against `a905a26` and `7083a3f` before any edit; status was clean.
- Spawned eight grok-4.5 thinking-low lanes in one turn (`r20-scout`, `r20-executor`, `r20-alt`, `r20-critic`, `r20-reviewer`, `r20-simplifier`, `r20-scribe`, `r20-guard`). Reports: `.shokunin/audio/reports/round-20/r20-*.md`. Scout confirmed the missing flag by search. Critic required one new CLI whose gap failure is the paired negative, not an 18th mode.
- First builder path copied canonical `stem_layer_third.wav` and added 984 counts to frames 96000 and 96001. Author command `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-layer-third-join` wrote `corpus/live/runs/20261012T231846536176Z-layer-third-join/measurements.json` and failed **both** centroid (2195.8477376682094 Hz, band 100–2000) and the gap. Failed fit. Not selected. No threshold was changed.
- Selected builder follows the round-14 180 Hz join: stepped 200 Hz layer plus the original `.08*sin(2π220t)+.04*sin(2π330t)` bed, then `frames[96000]=839` and `frames[96001]` set to keep the left step. 839 is the smallest integer with gap `> .03` given bedded `s[95999]=-145`. Author rerun exit 1, receipt `20261012T231917625985Z-layer-third-join`: sole gap failure.
- Non-author `r20-verifier` replayed 17 modes serially. Exits `0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0`. No exit 2. Sol `r20-adjudicator.md` admits coverage narrowly.

## Landed changes
- `--probe-layer-third-join` in `.shokunin/audio/corpus/fixtures/build_artifacts.py` and `measure_audio.py`, exclusive-mode sum included, measurement name `join200_probe`, 200 Hz section routing, existing gap and slope name tuples. LOG.md round-20 entries. SCORECARD.md round-20 verdict. Commit `67add2997fd1b8fa5d81c1432525ac490a19d078`.
- Scratch `corpus/live/round-20/join200_probe.wav` SHA-256 `5194bd8e2cc9929d5287d3ddd910d32b3c24aa2f76ba66f267d83dbbe84d97fd`. Not a 14th canonical WAV. Trial and failed-fit files stay in the commit so the rejected path is auditable.
- No canonical WAV write. No `.03`, `.001`, or `6 dB` edit. No MANIFEST edit.

## Before → after measurements
- Mode count. Before: 16 rows in `.shokunin/audio/reports/round-19/r19-verifier.md` at r19 work commit `6648aae` (tree `a905a26`). After: 17 rows in `.shokunin/audio/reports/round-20/r20-verifier.md`, measured on the files committed in `67add2997fd1b8fa5d81c1432525ac490a19d078`. Counting command is that serial replay, not a file glob.
- New mode. Command `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-layer-third-join` exit 1. Selected receipt `corpus/live/runs/20261012T232009162006Z-layer-third-join/measurements.json`: sole `join200_probe` failure `sections: internal join adjacent sample gap > .03 full scale`; gap `0.030029296875` FS; side-slope `0.0`; 200 Hz contrast `10.457519263296449` dB; centroid `1209.6397189190805` Hz (inside 100–2000); generic and outer pass. `section.passed: true` means contrast only.
- Canonical hashes. After replay, all 13 `corpus/artifacts/*.wav` SHA-256 values match `git show a905a26` and `7083a3f`. Third-layer hash remains `3d2048e48a6a16ef2a669736ad1168c9368223fb3a0702478f874e4d2588d445`. Five `_alt` distinctness records pass. Previous failure kinds held. First and restored normal parsed JSON match excluding path identity.
- `--probe-invalid` still checks malformed inputs only. It does not measure the 13 canonical WAVs.

## SHONEN
- [x] Real decision tables/error patterns/checklists with cited sources. Verified by named non-author `audio-r1-verifier`; evidence: `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end domain task executed and logged. Verified by named non-author `r2-verifier`; evidence: `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Fixture-battery instructions executable without oral context. Verified by named non-author `r3-adjudicator` with `r3-verifier` replay; evidence: `.shokunin/audio/reports/round-3/r3-adjudicator.md` and `r3-verifier.md`. Scope is the checked-in fixture workflow, not all future audio tasks.
- [ ] No cross-domain bleed; PROVINCE remains accurate.

## Axis decision and boundaries
| axis | Sol verdict |
|---|---|
| coverage | **improved narrowly** — 17th route binds the existing gap gate to the 200 Hz cell the r19 table left as slope and slope-edge only. |
| depth | unchanged — same `.03` predicate, no new detector. |
| calibration | unchanged — no threshold edit. Target count 839 is fixture geometry, not a retuned bound. |

Admit with zero demonstrated scoped harm. The selected scratch is **not** a waveform-identical corruption of `stem_layer_third.wav`: it adds the 220/330 Hz bed, then edits two join frames. No audible click, musical quality, engine behavior, rights, security, external JSON compatibility, or production claim. The first canonical-copy receipt remains a failed fit. SHONEN box 4 stays open.
