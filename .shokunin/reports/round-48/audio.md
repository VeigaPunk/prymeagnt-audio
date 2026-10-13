# Audio round 48 — calibration: adjacent UI sample-rate format boundary

Work commit `50c6f973f1f25125e64e9f4b43cdcaaeeee60e2a` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-48/r48-verifier.md`; Sol `.shokunin/audio/reports/round-48/r48-adjudicator.md`.

## Work and selection
- One calibration move declared at clean-before `2c05aa0ca49bcaa4c53b06c52f6d0c51fe66388f` in `.shokunin/audio/LOG.md` before eight Luna LEAF lanes. Reports `r48-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `50c6f973f1f25125e64e9f4b43cdcaaeeee60e2a`. `format_failures(stream)` checks exact ffprobe integer `sample_rate == 48000` and mono; R25's `mono441_probe` was a broad 44.1k mismatch, not adjacent 47999/48000.
- Selected executor's original same-sample 5760-frame mono PCM16 pair: WAV SHA 47999 `71551e200633e62b1b9db4ee5a582f8d4d996cd693f2e4a040a96023b130a210`, 48000 `387500a620fbfdfb38e044ebb1ec8e0a82be14be9dc71e2bd18e45ec9625ed8c`. Generate once at 48k time grid `t=arange(5760)/48000`, `x=.28*sin(2*pi*1000*t)*hanning(5760)`, round clipped ×32767 to PCM16; write identical PCM payload as mono WAV with header rate 47999 or 48000. Integrated source WAVs have the executor's hashes; SoX-f32 decoded byte outputs are identical (SHA `4497c82d9bd1fb000455081a5f477af7756e7c035bbe1e81ad295f0b32805c7f`). Different rate headers produce `.120003/.120000s` duration and slightly different FFT frequency-axis centroids **despite identical sample bytes**. Independent alt original same-sample pair with different WAV hashes (`256180fac93dfdee9ccacff516d56509468da03a8897bb09b09057df6e2bac54`/`263b5ceaf021d0aeba60007fa82b326c71856c0ff72d1ad870a3e6c80e6cbb03`) confirms polarity but was not integrated. Only opt-in `--probe-ui-rate-47999/48000` modes added; format predicate, ordinary gates, canonical WAVs unchanged.
- No numeric failed fit or final report transcription. Alt helper relative-path errors, scout direct-SoX issue, guard shell-quoting error were **setup**, not gate. Critic notes same discrete PCM sequence is **not** the same physical-time playback; no conversion/resampling test or claim.

## Before → after, fresh independent replay
- Fresh non-author #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-rate-47999` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T073438393360Z-ui-rate-47999/measurements.json`: 17 canonical + scratch, ffprobe `47999 Hz, 1 channel, pcm_s16le/16`, `.120003s` within UI ±.001s; decoded peak `.27996826171875`, RMS `-18.327858226717105dBFS`, centroid `1022.5148421151724Hz` in UI band, sole `format: expected 48kHz mono`.
- Fresh #3 `--probe-ui-rate-48000` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T073439440343Z-ui-rate-48000/measurements.json`: ffprobe `48000 Hz, 1 channel, pcm_s16le/16`, `.120000s`; identical decoded peak/RMS, centroid `1022.536144951523Hz` on the rate-dependent FFT grid, no failures. Both pass duration/level/centroid checks; only exact rate metadata differs for format.
- `r48-verifier.md` at `50c6f973f1f25125e64e9f4b43cdcaaeeee60e2a` lists **56 distinct fresh serial commands/exits/receipts**, `20261013T073437`–`073543`, **24 exit0/32 expected fixture-validation exit1**; parent independently checked paths exist/distinct, #2/#3 outcomes, counts, first/final normal JSON equality. Prior54 subset (#1 plus #4–#56) remains 23/31; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses and final normal restore held. `py_compile`/`git diff --check` passed. No replay setup errors; regenerated untracked R27 scratch files byte-matched prior committed executor copies and were removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Exact-rate metadata format check unchanged. |
| coverage | unchanged | Canonical corpus remains 17; scratch pair does not broaden domain coverage. |
| calibration | **improved locally** | Adjacent integer-rate format boundary reproduced with same decoded sample bytes and other gates passing. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish arbitrary-rate handling, resampling, identical physical-time playback, perceptual quality, production fitness, rights, engine fitness or publication. No engine/game/lore, push, merge, publishing or rights edits.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. A next round must declare one falsifiable claim before work.
