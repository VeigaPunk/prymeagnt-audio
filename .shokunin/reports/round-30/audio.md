# Audio round 30 — calibration: baseline-denominator orientation

Work commit `cd6959c5ac77d7908f25ff9a224e5fd662fca70c` by `audio-shokunin <audio@shokunin.local>`. This final report is written **after** the work commit. Named non-author `.shokunin/audio/reports/round-30/r30-verifier.md`; Sol `.shokunin/audio/reports/round-30/r30-adjudicator.md`.

## Work performed
- Declared one calibration move and clean before-state `6a3696822741388d862243745f653a76eec21d1f` in `.shokunin/audio/LOG.md` before eight Luna leaf lanes. Their reports in `cd6959c5ac77d7908f25ff9a224e5fd662fca70c` distinguish direct scratch fit, source review, historical guard and pending integration. Critic first wrote to typo `.shokhin/`; that report was moved to the authorized `.shokunin/audio/reports/round-30/r30-critic.md`, stray directory removed. Executor first direct measurement had a relative-path setup exit1, corrected exit0; not gate evidence.
- Integrated only `--probe-ui-orientation-forward` and `--probe-ui-orientation-reverse` in fixture builder/runner at `cd6959c5ac77d7908f25ff9a224e5fd662fca70c`. They generate **the same two original 5,760-frame, 48 kHz mono PCM16 WAV byte strings**, with baseline/alternate roles swapped. Both roles use unchanged canonical `SPECS["ui"]` `.120 s` ordinary checks. Existing `_alt` pairing and `abs(variant_centroid−base_centroid)/base_centroid`, duration `.020 s OR` centroid `.10` thresholds unchanged. No canonical artifacts, thresholds or normalization policy changed.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, two opt-in modes, scratch/direct measurements, author/non-author receipts and ten wave/verifier/Sol reports in `cd6959c5ac77d7908f25ff9a224e5fd662fca70c`. Four replay-generated untracked round-27 WAVs were byte-checked against already committed copies and removed. Final report is this separate report-last commit. No push, merge, publishing, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `6a36968`, forward k=1.0→.95 failed at baseline-denominator relative centroid `0.09901901500217196`; no swapped-role runner comparison. After `cd6959c5ac77d7908f25ff9a224e5fd662fca70c`, independent `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-orientation-forward` exit **1** receipt `.shokunin/audio/corpus/live/runs/20261013T023818100104Z-ui-orientation-forward/measurements.json`: sole `ui_orientation_forward_alt` distinctness failure. `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-orientation-reverse` exit **0** receipt `.shokunin/audio/corpus/live/runs/20261013T023818983830Z-ui-orientation-reverse/measurements.json`: no failures, relative centroid `0.10990133715464667`. Both duration deltas 0; both baseline/variant ordinary UI checks pass. Absolute centroid gap `95.7411548165367 Hz` is divided by baseline `966.8966593379727 Hz` forward vs `871.155504521436 Hz` reverse. Whole-file SHA forward base == reverse alt `4bb56ddf502e0d0249f191e90a57ebe0adff7bee7649efa2c402c905c4c53af9`; forward alt == reverse base `6e626b9b5b177cd6f7ba986758b12ec612cf003f9947bd170b766f1652d9bac2`.
- Named non-author `r30-verifier.md` at `cd6959c5ac77d7908f25ff9a224e5fd662fca70c` enumerates corrected **28 serial runner commands/exits/receipts**; prior 26 subset (#1 and #4–#28), eight invalid statuses, thirteen canonical hashes, five original variants, thresholds and normal restoration held. Its first **28 exit-127 wrapper mistakes produced no receipts**; setup errors excluded from runner evidence.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing numeric checks preserved, no new semantic/auditory validation. |
| coverage | unchanged | Opt-in scratch orientations, no canonical/category expansion. |
| calibration | **improved narrowly** | Identical WAVs swapped roles cross existing baseline-denominator ratio cutoff. |

Admitted: one improved axis, zero demonstrated scoped harm. This is numeric orientation sensitivity, **not** a normative demand for symmetric audio similarity, exact equality, sound quality, production/engine, rights or publication evidence.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four checked boxes remain; **no promotion**. Next round needs its own declared claim before work.
