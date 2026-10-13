# Audio round 43 — calibration: decoded RMS near-silence branch

Work commit `6274bfac9c6e69b6c161d4c48bf89ec083de554a` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Named non-author `.shokunin/audio/reports/round-43/r43-verifier.md`; Sol `.shokunin/audio/reports/round-43/r43-adjudicator.md`.

## Work and selection
- One calibration move declared before eight Luna LEAF lanes from clean-before `fc638d9d133c7dc2e4d77d44036181d52675eb00` in `.shokunin/audio/LOG.md`; reports `r43-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `6274bfac9c6e69b6c161d4c48bf89ec083de554a`. R42 bracketed the peak side of `peak >= .95 or rms < .001`, leaving the near-`.001 FS` **RMS** branch unbracketed with peak false. Executor and alt independently generated **SHA-identical** original source PCM16 pairs. The 46 crest file fails only the combined level label with RMS below floor; 47 passes with RMS above floor, both peaks far below `.95`. Synthetic fixtures are not a sound-quality or perceptual-silence result.
- Recipe for each integer crest `c` in `(46,47)`: 5760 signed samples `rint(c*cos(2*pi*1000*n/48000))`, write little-endian PCM16 mono WAV at 48kHz. Source-generated SHA46 `869d1e5ada618a3c9daaa7be3100c9a01dc1342df63d732355a23a306130adfc` and SHA47 `4c8c67a08558f14ad0642cac99563056407eeeecdc6b05e974f7b24cf74804b3`, matching both scratch lanes. Added only opt-in `--probe-ui-crest-46/47` builder/runner modes with `SPECS['ui']=(.12,250,4000,False)`; combined predicate, thresholds, canonical `SPECS`, five generic `_alt` and four family groups unchanged. No engine/game/lore, push, merge, publishing or rights clearance.
- No final-pair numeric failed fit. Executor/alt/critic helper relative-path/API calls had setup errors (exit1), corrected before measurement; these do **not** count as gate outcomes. The nominal synthesis frequency is 1000Hz, but measured centroids **1333.1671762128612/2221.1801421740442Hz** because tiny-count PCM quantization adds strong spectral content. Both centroids stay in UI band; neither is a faithful measured 1kHz centroid or a quality proxy. The two *crest* counts are adjacent; the RMS values are **not proved adjacent attainable RMS values**.

## Before → after measurements
- Named non-author fresh #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-crest-46` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T054928098413Z-ui-crest-46/measurements.json`: 17 canonical + one scratch; decoded peak **46/32768 = .00140380859375** (<.95), decoded RMS **.0009918604133909925 FS** / `-60.07098885448798dBFS` (<.001); centroid `1333.1671762128612Hz` inside UI band, sole `ui_crest_46_probe: level: clipping headroom or near silence`. Fresh #3 `--probe-ui-crest-47` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T054929142645Z-ui-crest-47/measurements.json`: peak **47/32768 = .001434326171875** (<.95), RMS **.0010130695326051166 FS** / `-59.88721491134572dBFS` (>.001), centroid `2221.1801421740442Hz` inside band, failures empty. Both .12s/5760 frames/48k mono PCM16. The emitted label is combined; numeric peaks isolate the RMS branch. Neither fixture is an equality-at-`.001` test.
- `r43-verifier.md` at `6274bfac9c6e69b6c161d4c48bf89ec083de554a` lists **46 distinct fresh serial commands/exits/receipts** dated `20261013T054919`–`055014`: **19 exit0 / 27 expected fixture-validation exit1**, no replay setup errors. Parent independently checked every path unique/existing, outcome counts and initial/final normal JSON equality. Prior44 subset (#1 plus #4–#46) remains 18 exit0/26 expected exit1; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses and final normal restore held. Author `py_compile`/`git diff --check` passed; staged diff check found one verifier trailing blank line, which parent removed before work commit. Replayed untracked R27 scratch WAVs were byte-matched to committed executor copies and removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Combined peak/RMS detector and thresholds unchanged. |
| coverage | unchanged | Canonical corpus remains 17; scratch controls do not establish general coverage. |
| calibration | **improved locally** | Below/above `.001 FS` decoded RMS under independent replay with peak arm false in both. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish exact `.001` equality, an adjacent RMS grid, audible silence, quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
