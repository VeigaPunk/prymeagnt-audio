# Audio round 22 — depth: native PCM16 format check

Work commit: `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc` by `audio-shokunin <audio@shokunin.local>`. Named non-author replay: `.shokunin/audio/reports/round-22/r22-verifier.md`; Sol per-axis judgment: `r22-adjudicator.md`. This report is written only after the work commit and cites its hash.

## Work performed
- Declared one depth axis-move with before-state at `14cf9861ca19041ddb25c322facc5ace9271a146` and eight disjoint Luna scopes in `.shokunin/audio/LOG.md` at `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`. Eight scoped wave-1 reports at `.shokunin/audio/reports/round-22/r22-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` describe before-state/failed fits and commands/exits.
- Built original 48 kHz mono analytic PCM16/PCM24 paired scratch and added a shared encoded-format predicate (`codec_name == pcm_s16le` and `bits_per_sample == 16`, plus original rate/channel) in `.shokunin/audio/corpus/fixtures/{build_artifacts,measure_audio}.py` at `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`. Both `measure()` and opt-in invalid controls use the same predicate. No sample_fmt bit-depth inference or canonical WAV edit.
- Non-author `r22-verifier.md` independently replayed 19 serialized modes, with exact commands/exits/receipt paths and matched direct measurements at `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`. No replay exit 2; two preliminary path-serialization exits 1 are identified as invalid setups, then corrected absolute-path invocations exited 0.

## Landed changes
- Scoped builder/checker, scratch, author/verifier JSON receipts, eight wave-1 reports, verifier, adjudicator, LOG and SCORECARD in `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`. `git diff 14cf9861ca19041ddb25c322facc5ace9271a146 291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc -- .shokunin/audio/corpus/artifacts/` shows no canonical changes. The separate final report is the report-last commit; no push, merge, publication, sample clearance or runtime mutation.

## Before → after measurements
- Before `14cf9861ca19041ddb25c322facc5ace9271a146`, matched 48k mono 4s native PCM16 **and PCM24** each passed original `measure()` with `failures: []` using spec `(4.0,100,1000,True)`; executor/alternate/critic evidence is under `.shokunin/audio/reports/round-22/` at `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`. Original ffprobe query checked rate/channels only.
- After `291fa33a14db37b3b6b1ccf32eecbc5b0996d0cc`, the non-author exact `python3 -c ... m.measure(..., Path(...).resolve())` commands and output in `r22-verifier.md` exited 0: native PCM16 `failures: []` with `pcm_s16le`/16 bits; native PCM24 **only** `format: expected PCM16` with `pcm_s24le`/24 bits. Both are 48k mono; this isolates the encoded-width rule rather than sample rate, channels, peak or centroid. `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-invalid` exited expected 1 with receipt `.shokunin/audio/corpus/live/runs/20261013T010824568740Z-invalid/measurements.json`: four original invalid outcomes, new native16 expected pass, new native24 expected format failure. An exit 1 here is intentional rejection, not a runner crash.
- Non-author 19-execution exit vector `[0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0]`; all old kinds held. Counting/check commands `git show 14cf986:<canonical path>` with SHA-256 and `python3 .../measure_audio.py` for each mode are recorded in `r22-verifier.md`; 13/13 canonical hashes, five `_alt` distinctions, thresholds, normal/restore equality modulo receipt paths held. This establishes tested native PCM16 vs PCM24, **not** a general WAV validator or external JSON compatibility.

## Axis verdict
| Axis | Verdict | Evidence |
|---|---|---|
| depth | **improved narrowly** | Before permissive PCM24 → after format-only PCM24 rejection, matched PCM16 pass; `r22-verifier.md`, `r22-adjudicator.md`. |
| coverage | **unchanged** | No new canonical sound/category; old fixture and mode outcomes preserved. |
| calibration | **unchanged** | Existing numerical audio thresholds unchanged; no audibility study. |

Admitted: >=1 axis improved, zero demonstrated scoped harm. Unknown strict JSON consumers could be affected by added fields/`expected_pass`; WAVE_FORMAT_EXTENSIBLE valid bits, arbitrary codec/container/multistream handling, security, perception, production, engine and rights are unproven. Do not infer support for those cases.

## SHONEN
- [x] Real decision tables/checklists with cited sources — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end fixture task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [ ] No cross-domain bleed / PROVINCE remains accurate — no separate whole-lane non-author review. **Box 4 open.**

Next falsifiable move: assess province boundary and missing box 4 as a single narrowly declared axis move with independent whole-lane verifier; do not auto-promote.
