# Audio round 27 — calibration: adjacent-frame duration polarity

Work commit `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e` by `audio-shokunin <audio@shokunin.local>`. This final report is written **after** the work commit. Named non-author `.shokunin/audio/reports/round-27/r27-verifier.md`; Sol per-axis `.shokunin/audio/reports/round-27/r27-adjudicator.md`.

## Work performed
- Declared one calibration move and before-state `666688827adc3bcf0e4c67b481fc827d900ae2e7` in `.shokunin/audio/LOG.md` before eight parallel Luna leaf lanes. Wave-one reports `r27-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e` include candidate direct measurements, a second independent waveform fit, float-rounding and ordinary-duration-gate cautions. An alternate fit script initially failed on a relative-path setup error (exit1); corrected run exit0; it is not counted as evidence.
- Added opt-in `--probe-ui-duration-below` and `--probe-ui-duration-at` branches to fixture builder and runner at `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e`. Each makes an original 5760-frame UI-shaped baseline and a 6719- or 6720-frame variant at 48 kHz mono PCM16. Each longer variant uses a **separately declared scratch expected duration** (`6719/48000` or `6720/48000`) to isolate the existing distinctness predicate; it does **not** satisfy canonical UI `.120 s ±.001 s` duration. Existing format, level, UI centroid band and `.020 s OR .10` distinctness constants stay unchanged.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in builder/runner, source-generated scratch scripts/WAVs and author/non-author receipts, ten wave/verifier/Sol reports in `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e`. Thirteen canonical hashes held; no tracked canonical artifact diff. Final report is this separate report-last commit. No push, merge, publish, rights clearance, engine/game/lore mutation.

## Before → after measurement
- Before `6666888`: exact-clone zero/zero negative and five positive canonical variants, no adjacent-frame duration-branch polarity. After `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e`, independently replayed `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-duration-below` exit **1** receipt `.shokunin/audio/corpus/live/runs/20261013T020339743260Z-ui-duration-below/measurements.json`: baseline `.120000` and variant `.139979` ffprobe seconds, stored duration delta `0.019978999999999997`, centroid relative `0.026103720992748162`, sole `ui_duration_below_alt` failure `distinctness: duration < .020 s and centroid delta < 10%`.
- Independently replayed `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-duration-at` exit **0** receipt `.shokunin/audio/corpus/live/runs/20261013T020340636504Z-ui-duration-at/measurements.json`: baseline `.120000`, variant `.140000`, stored duration delta `0.020000000000000018`, centroid relative `0.028427598871782873`; both per-file failure lists empty, distinctness passes on duration arm, centroid arm false. The nominal 960-frame rational difference is `.020 s` but **the observed binary float comparator input exceeds `.020`**. No exact floating-point equality proof; this is a 6719/6720 adjacent-frame transition in this toolchain only.
- Non-author 22-execution replay records exact commands/exits/receipts in `r27-verifier.md` at `9fdd4d4caf413e7080f75b0c69ded71e3e61df7e`. Prior 20 executions (#1 and #4–#22), five existing `_alt` comparisons, eight invalid statuses, 13 canonical SHA-256 values and thresholds preserved; initial/restored normal equal excluding path fields. No setup failures in that replay.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | No new semantic/audio validation. |
| coverage | unchanged | Scratch only; no new canonical asset/category. |
| calibration | **improved narrowly** | Observed two-point adjacent-frame duration comparator polarity with centroid arm false. |

Admitted: one improved axis, zero demonstrated scoped harm. No perceptual distinctness, broad codec/rate, production, engine, rights, publication or clearance claim.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four checked boxes remain; **no promotion**. The next round needs its own declared claim before work.
