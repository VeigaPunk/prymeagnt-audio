# Audio round 41 — calibration: outer neighboring side-slope bracket

Work commit `79effbef72277b7580cd1682ede9b5754aebe5b8` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Named non-author `.shokunin/audio/reports/round-41/r41-verifier.md`; Sol `.shokunin/audio/reports/round-41/r41-adjudicator.md`.

## Work and selection
- One calibration move was declared before eight Luna LEAF lanes from clean-before `d1a1a4df70a53cf2f778aa97688226e0e829dd8d` in `.shokunin/audio/LOG.md`; reports `r41-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `79effbef72277b7580cd1682ede9b5754aebe5b8`. R3's **outer** neighboring side-slope comparator `abs((last-penultimate)-(second-first)) > .001` had only a far-above failing control; R21 tested an internal section join, while R40 bracketed the outer **endpoint** check. Selected executor's original sine pair because it holds both endpoint samples fixed. Alt independently found a pass/sole-fail pair but varied the last sample and used a higher DC offset. No audible quality follows from either synthetic fixture.
- Source-generate `rint(.15*sin(2*pi*120*n/96000)*32768)` for `n=0..95999`, then set only sample `[1]` to `6` or `5`, write mono signed PCM16 little-endian WAV at 48kHz. The distinct 2.0s/96,000-frame generated files match the executor final SHA: slope32 `0bc9c6f07b53b13336b253db069cc57702e9520634106eabf85fc27e329b4547`; slope33 `b86a34d343a57e943ab4289cb67b992b8597d93002f3b4a7ef9981e6b30952fb`. Added only opt-in `--probe-outer-slope-32/33` builder/runner modes with local `(2.0,5,200,True)` spec. Existing slope `>.001`, endpoint `>.03`, other thresholds, canonical `SPECS`, five generic `_alt` and four family groups unchanged. No engine/game/lore, push, merge, publish or rights clearance.
- **Numeric failed fits:** transient executor files `b1c7c420...`/`c42ce738...` decoded by the project helper to 0/1-count slope mismatch rather than target 32/33; early executor `[1]+=32/33` and `[1]=38/39` missed target. Alt's first low-DC pair had centroids ~2801.8Hz outside 5–200. Parent's first integrated `t=n/RATE` instead of `n/96000` gave centroid **296.04646400437895Hz** and slope **.002166748046875** on a purported 32 probe, with a runner **exit1** and both centroid/slope failures at `corpus/live/runs/20261013T051350076413Z-outer-slope-32/measurements.json`; correction reproduced the executor SHA exactly. These measured failures are **not** successful bracket receipts. Executor/alt helper relative-path/str invocation errors were **setup errors**, not measured numeric fits or gate evidence. Scribe's transient executor conclusion was corrected in its report before replay.

## Before → after measurements
- Named non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-outer-slope-32` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T051645488524Z-outer-slope-32/measurements.json`: 17 canonical + one scratch, signed decoded boundary counts **0,6,-77,-39**, side-slope mismatch **32/32768 = .0009765625 FS/sample**, endpoint **39/32768 = .001190185546875 FS**, centroid `150.16139474032187Hz` within 5–200, failures empty. `--probe-outer-slope-33` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T051646547685Z-outer-slope-33/measurements.json`: signed boundary **0,5,-77,-39**, mismatch **33/32768 = .001007080078125 FS/sample**, **same endpoint 39/32768**, centroid `152.54369633957694Hz` within band; **sole** `slope_33_probe: loop seam: slope mismatch > .001 full scale per sample`. Both clear duration/format/level/centroid/endpoint checks. `.001*32768 = 32.768`, so neither tests equality exactly `.001`.
- `r41-verifier.md` at `79effbef72277b7580cd1682ede9b5754aebe5b8` lists **42 actual serial commands/exits/receipts**: 17 exit0 / 25 expected fixture-validation exit1, no replay setup errors. Prior40 subset (#1 plus #4–#42) is 16 exit0 / 24 expected exit1; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses, and final normal #42 restore held. Author `py_compile`/`git diff --check` passed; staging diff check passed. Runner-generated old R27 scratch files were byte-matched to committed executor copies and removed; no canonical source or assets changed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing outer slope/endpoint detectors; no added detector or application behavior. |
| coverage | unchanged | Canonical corpus remains 17; two opt-in scratch controls do not establish general coverage. |
| calibration | **improved locally** | Adjacent decoded PCM16 counts bracket strict `>.001` outer neighboring slope in independent replay, with endpoint fixed and all other checks passing. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish an exactly-`.001` result, universal or perceptual/audible loop smoothness, quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
