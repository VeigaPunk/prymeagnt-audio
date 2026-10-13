# Audio round 40 — calibration: outer-loop decoded endpoint bracket

Work commit `a0449ec682f5639e833da3ce9f6fc5317fc6ac6e` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Named non-author `.shokunin/audio/reports/round-40/r40-verifier.md`; Sol `.shokunin/audio/reports/round-40/r40-adjudicator.md`.

## Work and selection
- Declared one calibration move before eight Luna LEAF lanes from clean-before `9b212354fc1525a52b08209f8c4d26171d9a4c9f` in `.shokunin/audio/LOG.md`; reports `r40-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `a0449ec682f5639e833da3ce9f6fc5317fc6ac6e`. Selected executor's final original 30 Hz cosine plus synthetic `.7` DC offset and gradual endpoint correction; nearest-even PCM16 quantization. This is a measurement fixture, **not** playable/production sound design. Source-generated pair matches selected scratch SHA exactly: 983 `2f7dd5517ff2cfe380cc6710e6ac99d0939d95dece81d0cdedaddcee95b20286`; 984 `c5ca108680557a584cca19dead3a900a382ed8dfa1252ab994196624c0eb94c6`. WAVs are distinct, each 2.0 s/96,000 frames/48 kHz mono PCM16.
- The first executor and alt pairs hit endpoint counts but missed ambience centroid 5–200 Hz (~293 and ~823–824 Hz): **failed numeric fits**, not gates. Other executor frequency/amplitude sweeps missed band or headroom. Helper string/relative-path attempts exited1: **setup errors**, not numeric fits or gate outcomes. The executor's first report incorrectly transcribed first/last counts as 25165→26148/26149; its corrected report, independent decode and SHA-identical reproduction establish **24248→25231/25232** before non-author replay. The WAV bytes were not changed by this correction.
- Added only opt-in `--probe-outer-endpoint-983`/`--probe-outer-endpoint-984` builder/runner modes using local `(2.0,5,200,True)`. Existing outer comparator `seam_delta > .03`, independent slope bound `.001`, canonical `SPECS`, generic `_alt`, thresholds and family logic remain unchanged. No engine/game/lore, push, merge, publish or rights clearance.

## Before → after measurements
- Before `9b21235`: R21 bracketed an **internal** section join, not the outer first/last loop endpoint. After `a0449ec682f5639e833da3ce9f6fc5317fc6ac6e`, named non-author 983 command `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-outer-endpoint-983` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T045931363311Z-outer-endpoint-983/measurements.json`: 17 canonical + one scratch, first/last signed PCM16 counts **24248→25231**, delta **983/32768 = .029998779296875 FS** (< .03), slope mismatch **0**, centroid `170.56815710368392 Hz` within 5–200, ordinary and seam checks pass, failures empty. 984 `--probe-outer-endpoint-984` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T045932445314Z-outer-endpoint-984/measurements.json`: same first **24248**, last **25232**, delta **984/32768 = .030029296875 FS** (> .03), slope **0**, centroid `170.73676058919554 Hz` in band; **sole** `endpoint_984_probe: loop seam: endpoint jump > .03 full scale` failure. Exactly `.03` is not representable as this integer PCM16 delta (`.03*32768 = 983.04`); these observations do not test equality at `.03`.
- `r40-verifier.md` at `a0449ec682f5639e833da3ce9f6fc5317fc6ac6e` enumerates **40 serial commands/exits/receipts**: 16 exit0 / 24 expected fixture-validation exit1, no corrected-replay setup errors. Prior38 subset (#1 plus #4–#40) remains 15 exit0/23 expected exit1. Old17 SHA/metrics, generic five `_alt`, four family groups, thresholds/sections, eight invalid statuses and normal #1/#40 restoration held. Author `py_compile`/`git diff --check` passed; staged diff check found one report trailing blank line, which parent removed before commit. Work commit includes scoped source/LOG/SCORECARD, selected and failed-fit scratch, author/non-author receipts, eight lane reports, named verifier and Sol. Replay-generated untracked Round27 WAVs were byte-matched to committed copies and removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing outer endpoint/slope detector, no added measurement behavior. |
| coverage | unchanged | Canonical corpus remains 17; two opt-in scratch controls do not establish general coverage. |
| calibration | **improved locally** | Adjacent decoded PCM16 counts bracket strict `>.03` outer loop endpoint in independent replay. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish an exactly-`.03` result, universal or perceptual/audible seam threshold, quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
