# Audio round 29 — depth: lower-centroid absolute distinctness

Work commit `cb275947c4f4cf1ec2a754955de7e52173fc0618` by `audio-shokunin <audio@shokunin.local>`. This report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-29/r29-verifier.md`; Sol axis verdict `.shokunin/audio/reports/round-29/r29-adjudicator.md`.

## Work performed
- Declared one depth move and clean before-state `99b6c0afb121fd7f1a85623a3a5854493c38ccf8` in `.shokunin/audio/LOG.md` before eight Luna leaf lanes. Their reports at `cb275947c4f4cf1ec2a754955de7e52173fc0618` include independent selected k=.95/.94 fits, critic's separate k=.89/.90 numeric check, limits, nonmonotonic failed-side candidates, one corrected alternative path/setup failure, historical guard. Failed fits/setup are not counted as runner evidence.
- Integrated only two opt-in `--probe-ui-lower-centroid-below`/`--probe-ui-lower-centroid-above` modes in `.shokunin/audio/corpus/fixtures/{build_artifacts,measure_audio}.py` at `cb275947c4f4cf1ec2a754955de7e52173fc0618`. Original analytical chirp pair: `x=.38*sin(2π*k*(700*t+800*t²))*exp(-30*t)`, `t=arange(5760)/48000`; baseline k=1, below k=.95, above k=.94, 48 kHz mono PCM16. Both baseline and variants pass unchanged canonical `SPECS["ui"]` `.120 s` ordinary checks. The original `abs(variant_centroid-base_centroid)/base_centroid`, `.020 s OR .10` rule, canonical artifacts and thresholds were not changed.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in builder/runner, scratch and 26 runner receipts, ten wave/verifier/Sol reports in `cb275947c4f4cf1ec2a754955de7e52173fc0618`. Four regenerated untracked round-27 duration WAVs were byte-matched to already committed executor WAVs before removal, keeping work scope round29. Final report is separate report-last commit. No push/merge/publishing/rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `99b6c0a`: tested higher-centroid polarity only. After `cb275947c4f4cf1ec2a754955de7e52173fc0618`, independent `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-lower-centroid-below` exit **1** receipt `.shokunin/audio/corpus/live/runs/20261013T022558239794Z-ui-lower-centroid-below/measurements.json`: baseline centroid `966.8966593379727 Hz` > variant `871.155504521436 Hz`, duration delta `0`, absolute relative centroid delta `0.09901901500217196`; sole `ui_lower_centroid_below_alt` distinctness failure. `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-lower-centroid-above` exit **0** receipt `.shokunin/audio/corpus/live/runs/20261013T022559154018Z-ui-lower-centroid-above/measurements.json`: variant `862.0264574403602 Hz` below same baseline, duration delta `0`, absolute relative delta `0.1084606104331939`; no failures. A signed variant-minus-baseline delta would be negative in both cases and miss the positive distinctness.
- Named non-author `r29-verifier.md` at `cb275947c4f4cf1ec2a754955de7e52173fc0618` enumerates corrected **26 actual serial runner commands/exits/receipts**, prior 24 outcomes (#1 and #4–#26), eight invalid statuses, thirteen canonical byte hashes, five original variants, thresholds and normal restoration. An earlier command-wrapper error produced **26 exit-127 setup attempts with no receipts**, excluded from gate evidence. No corrected runner setup failures.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | **improved narrowly** | Existing abs comparison now tested on lower-centroid variants across numeric .10 at zero duration. |
| coverage | unchanged | Scratch only; no canonical asset/category. |
| calibration | unchanged | Existing bounds unchanged; no equality/monotonic/smooth cutoff result. |

Admitted: one improved axis, zero demonstrated scoped harm. Whole-waveform FFT centroid is a numeric proxy, not audibility, quality, engine, rights, publication, or clearance evidence.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes remain checked; **no promotion**. Next round must declare its own claim before work.
