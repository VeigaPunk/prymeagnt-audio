# Audio round 31 — calibration: joint nonzero sub-threshold negative

Work commit `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-31/r31-verifier.md`; Sol `.shokunin/audio/reports/round-31/r31-adjudicator.md`.

## Work performed
- Declared one calibration move and clean before-state `c1c6c965e7a347597caea0f4ddeab42dd7fdcff2` in `.shokunin/audio/LOG.md` before eight Luna leaf lanes. Reports `r31-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd` distinguish alternate and executor fits, a failed initial k=1.0 centroid fit (~.1353, above target), corrected relative-path setup errors and checker evidence. Neither failed fit nor setup counts as a gate negative.
- Selected independent alt k=.88 analytical chirp fit, then integrated **one** opt-in `--probe-ui-joint-below` in fixture builder/runner at `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd`. Baseline k=1 has 5760 frames / canonical UI `.120 s` spec; alternate k=.88 has 6719 frames / separately declared scratch duration `6719/48000`. Both are source-generated 48 kHz mono PCM16 with same UI band, level and format checks. The alternate does **not** pass or claim the canonical UI `.120 s ±.001 s` duration gate. Existing `_alt` comparison and `.020 s OR .10` thresholds unchanged.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in builder/runner, generated candidate scripts/WAVs and author/non-author receipts, ten wave/verifier/Sol reports in `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd`. Four replay-generated untracked round-27 WAVs were checked byte-for-byte against committed executor WAVs and removed. Final report is this separate report-last commit. No push, merge, publication, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `c1c6c96`: zero/zero exact duplicate, separate near-duration and near-centroid controls, but no integrated pair with both signals nonzero and simultaneously below cutoffs. After `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd`, non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-joint-below` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T025133084611Z-ui-joint-below/measurements.json`: baseline 5760 frames `.120000 s` / centroid `966.8966593379727 Hz`; alternate 6719 frames `.139979 s` / centroid `870.5547231776728 Hz`. Actual ffprobe-float duration delta **`0.019978999999999997`**, centroid relative delta **`0.09964036511023265`**: both nonzero, both strictly below their cutoffs. Only `ui_joint_below_alt` distinctness fails; no ordinary spec failure under its separately declared scratch duration. Exact rational frame delta is not substituted for the measured comparator float.
- `r31-verifier.md` at `348f1406a67e66d3e401b2f3c75ed9b33f4ec7bd` lists 29 actual serial commands/exits/receipt paths (8 exit0, 21 expected exit1, no exit2/setup error); previous 28 outcomes (#1 and #3–#29), eight invalid controls, thirteen canonical hashes, five original `_alt` variants, threshold objects and normal restoration held.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | No semantic or perceptual validation added. |
| coverage | unchanged | One opt-in scratch pair, no canonical asset/category expansion. |
| calibration | **improved narrowly** | Both existing OR inputs measurably nonzero and below their minima; joint negative. |

Admitted: one improved axis, zero demonstrated scoped harm. Both duration and analytic phase changed, so no causal isolation, universal OR proof, exact cutoff equality, auditory quality, production, rights or engine claim.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes remain checked; **no promotion**. Next round must declare its claim before work.
