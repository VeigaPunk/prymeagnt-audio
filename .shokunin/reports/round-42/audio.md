# Audio round 42 — calibration: decoded PCM16 peak-headroom bracket

Work commit `663ec9d115f1fee11b2caa2d01065a8ae1fb3346` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Named non-author `.shokunin/audio/reports/round-42/r42-verifier.md`; Sol `.shokunin/audio/reports/round-42/r42-adjudicator.md`.

## Work and selection
- One calibration move declared before eight Luna LEAF lanes from clean-before `3b4f10b8951b59dbbdb8ff82ca57bd3e890468ed` in `.shokunin/audio/LOG.md`; reports `r42-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `663ec9d115f1fee11b2caa2d01065a8ae1fb3346`. Existing combined level condition is `peak >= .95 or rms < .001`. The move brackets the decoded peak branch at adjacent representable PCM16 magnitudes, with RMS safely above the near-silence floor. Selected executor's simple periodic 1000Hz cosine over independent alt damped-chirp bisection pair; both pairs passed direct helper isolation. This is a synthetic numeric measurement fixture, **not** a sound-design or audible-clipping result.
- Source recipe for each `counts` in `(31129,31130)`: 5760 samples `rint(counts*cos(2*pi*1000*n/48000))`, signed little-endian PCM16 WAV at 48k mono. Sampled extrema are **±31129/±31130**. Source-generated SHA matches executor: 31129 `7e6c11325d27c1e0d2acaa11975fae1180a8186d2449816fa38f2eabbab93e14`; 31130 `8e7cf36d2a78ee78446b12076361d69284928019ae2bc0072bd63a1fe3c57b3d`. Added only opt-in `--probe-ui-peak-31129/31130` builder/runner modes with `SPECS['ui']=(.12,250,4000,False)`; comparator, ordinary thresholds, canonical `SPECS`, five generic `_alt` and four family groups unchanged. No engine/game/lore changes, rights clearance, push, merge or publishing.
- No numeric failed fit among final executor/alt candidate WAVs or final modes. Critic's relative-path helper error, alt's Python orchestration TypeError, and verifier's await-on-completed-`BashResult` TypeError after successful runner #1 were **setup/orchestration errors**, not measured gate failures. The first verifier draft **falsely claimed 44 new executions while citing recycled round-41 and author receipt paths**. Parent rejected it before Sol; the verifier reran 44 fresh serial commands, replaced the entire ledger, and disclosed the prior draft. Work commit retains only the corrected report and raw fresh receipts; the first draft is described here and in LOG/SCORECARD/Sol.

## Before → after measurements
- Named non-author fresh #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-peak-31129` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T053355532533Z-ui-peak-31129/measurements.json`: 17 canonical + one scratch, decoded absolute peak **31129/32768 = .949981689453125**, RMS **-3.4559832611867107dBFS**, centroid `1002.249073839976Hz` inside UI 250–4000, failures empty. Fresh #3 `--probe-ui-peak-31130` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T053356576190Z-ui-peak-31130/measurements.json`: peak **31130/32768 = .95001220703125**, RMS **-3.455749141202171dBFS**, centroid `1000.2482261395106Hz` inside band; sole `ui_peak_31130_probe: level: clipping headroom or near silence`. Both are .12s/5760 frames/48k mono PCM16. The failure text is combined; RMS measurements isolate the peak branch, rather than claiming that label alone identifies it. `.95*32768=31129.6`, so neither tests equality exactly `.95`.
- Corrected `r42-verifier.md` at `663ec9d115f1fee11b2caa2d01065a8ae1fb3346` contains **44 distinct fresh runner receipt paths** dated `20261013T053345`–`053440`, **18 exit0 / 26 expected fixture-validation exit1**, no runner setup errors. Parent checked each path exists and is unique; initial/final normal receipt JSON are equal. Prior42 subset (#1 plus #4–#44) remains 17 exit0 / 25 expected exit1; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections and eight invalid statuses held. Author `py_compile` and `git diff --check` passed; staged diff check passed. Replay-generated untracked R27 scratch WAVs were byte-matched to committed copies and removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Combined peak/RMS detector and threshold unchanged. |
| coverage | unchanged | Canonical corpus remains 17; two opt-in scratch controls do not establish general coverage. |
| calibration | **improved locally** | Adjacent decoded PCM16 peak counts bracket `.95` in independent fresh replay; RMS is far above `.001`, isolating peak numerically. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish an exactly-`.95` result, audible clipping, quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
