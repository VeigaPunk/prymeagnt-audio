# Audio round 21 — calibration: decoded internal-gap boundary

Work commit: `9fea1c60346ba5005cfd059a6313f76833b14a09` by `audio-shokunin <audio@shokunin.local>`. This final report is written **after** the work commit. Named non-author verification: `.shokunin/audio/reports/round-21/r21-verifier.md`; Sol axis verdict: `.shokunin/audio/reports/round-21/r21-adjudicator.md`.

## Work performed
- Declared one calibration claim and eight Luna leaf scopes before dispatch in `.shokunin/audio/LOG.md` at `9fea1c60346ba5005cfd059a6313f76833b14a09`. All eight scoped reports and non-author replay are at `.shokunin/audio/reports/round-21/` in that commit. Two syntax/cleanup errors and their repairs remain logged; scratch candidate provenance was regenerated with original hashes.
- Added only opt-in 200 Hz paired scratch modes in `.shokunin/audio/corpus/fixtures/build_artifacts.py` and `measure_audio.py` at `9fea1c60346ba5005cfd059a6313f76833b14a09`. The strict `> .03` gate, other thresholds, and 13 canonical WAVs remain unchanged. This is source synthesis, not external sampling or engine work.
- Independent `r21-verifier` replayed 19 runner executions from raw regenerated artifacts; exact commands/exits and receipts are in its report at `9fea1c60346ba5005cfd059a6313f76833b14a09`. Exits `[0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0]`; no setup exit 2. Five `_alt` records pass and all 13 canonical SHA-256 hashes match before commit `b1af040b3cca2e70dabaafa982c5261c971d03a9`.

## Landed changes
- `.shokunin/audio/LOG.md`, `SCORECARD.md`, source builder/runner, generated paired scratch, restored independent candidate scratch and 21 author/verifier receipt directories, plus ten role/verifier/adjudicator reports are carried by work commit `9fea1c60346ba5005cfd059a6313f76833b14a09`. Count via `git ls-tree -r --name-only 9fea1c60346ba5005cfd059a6313f76833b14a09 .shokunin/audio/reports/round-21` and `git ls-tree -r --name-only 9fea1c60346ba5005cfd059a6313f76833b14a09 .shokunin/audio/corpus/live/runs/20261013T*`. No modification outside `.shokunin/audio/**` in the work commit.
- This report is the separate report-last commit and cites the preceding work hash, not itself. No push, merge, publication, clearance, or game/runtime mutation.

## Before → after measurements
- Before `b1af040b3cca2e70dabaafa982c5261c971d03a9`: selected round-20 984-count negative existed but no adjacent integrated 983-count positive. After `9fea1c60346ba5005cfd059a6313f76833b14a09`: `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-layer-third-join-edge-pass` exit **0**, verifier receipt `.shokunin/audio/corpus/live/runs/20261013T005820541153Z-layer-third-join-edge-pass/measurements.json` measures 983/32768 = `.029998779296875` FS, no failures. `--probe-layer-third-join-edge-fail` exit **1** as expected, receipt `20261013T005821409013Z-layer-third-join-edge-fail/measurements.json` measures 984/32768 = `.030029296875` FS, sole internal-gap failure. Both side slopes are 0 FS/sample; 200 Hz contrasts ~10.457519 dB; generic/spectral/outer gates pass. `section.passed` means contrast/validity only; complete failures govern result. Counting/measurement command and precise per-mode exits: `.shokunin/audio/reports/round-21/r21-verifier.md` at `9fea1c60346ba5005cfd059a6313f76833b14a09`.
- Other 15 historical flag outcomes and normal/restored normal held; hash count command and SHA-256 table: `r21-verifier.md`. Fail 984 WAV hash `5194bd8e…` is the already selected round-20 negative, *not* its rejected centroid+gap failed fit. `git diff b1af040b3cca2e70dabaafa982c5261c971d03a9 9fea1c60346ba5005cfd059a6313f76833b14a09 -- .shokunin/audio/corpus/artifacts/` is empty; comparator and all existing thresholds unchanged.

## Axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| calibration | **improved narrowly** | Independent adjacent-grid bracket of existing strict numeric threshold in this PCM16/SoX path. |
| depth | **unchanged** | No new detector or acoustic validation. |
| coverage | **unchanged** | No new canonical content; two scratch modes only. |

Admitted: at least one improved, none demonstrated harmed. This does **not** establish an audible seam criterion, production suitability, external compatibility, engine behavior, sample-rights clearance or publishing authority. `.shokunin/audio/SCORECARD.md` and Sol review at `9fea1c60346ba5005cfd059a6313f76833b14a09` carry the complete scope.

## SHONEN
- [x] Real decision tables/checklists with cited sources — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture instructions — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [ ] No cross-domain bleed / PROVINCE still accurate — **not** independently reviewed as a whole; remains open. Round-21 verifier/adjudicator did not check this box.

Next falsifiable move: one independent whole-lane boundary review for box 4, or isolate another numeric acceptance rule, only after declaring its own axis-move and before-state. No implied operator approval or rank promotion.
