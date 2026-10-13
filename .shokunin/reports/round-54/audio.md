# Audio round 54 — matched signed PCM32/PCM16 UI format check

Work commit `d651d292c4c9967df46e54918bddc61ccb13b131` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-54/r54-verifier.md`; Sol `.shokunin/audio/reports/round-54/r54-adjudicator.md`.

## Declared move and measured pair
At clean-before `b79c437250e615cec504b6042904b2a00c184b4d`, old `native24_probe` was `pcm_s24le`/24 despite `sample_fmt=s32`; no ordinary matched signed PCM32 UI pair existed. One calibration move adds opt-in `--probe-ui-pcm32/pcm16-r54` under unchanged `format_failures`, `SPECS["ui"]`, thresholds, canonical17, and prior66. Original mono48k/5760-frame signed16 integers are shifted into signed32 as `s16*65536`. Equal SoX-f32 decode is **by this construction**, not a test of extra 32-bit precision.

| Probe | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| PCM32 | `fcbdd5aa0862fddabad017388aba24bedc9e6c98202ccbc04a40125413de47c7` | `pcm_s32le` / 32 | `.31536865234375` / `-14.628519169868087dBFS` / `1123.322704293326Hz` | exit1, sole `format: expected PCM16` |
| PCM16 | `9ac26f38a7df9b1dd60c6130049d1e37056811fcd241f15a03559b5766bb4ba9` | `pcm_s16le` / 16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`, 48000 Hz mono; all other UI gates pass. Non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T114051495307Z-ui-pcm32/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T114052510730Z-ui-pcm16-r54/measurements.json`. Independent original alt pair with different hashes reproduced the polarity.

## Fresh replay and verdict
The verifier executed **68 new unique serial commands**, receipts `20261013T114050483669Z`–`20261013T114159371496Z`: 30 exit0/38 expected validation exit1. Prior66 raw JSON matched exactly (subset29/37); canonical17 SHA/metrics, five generic `_alt` and four family comparisons, thresholds/sections/eight invalid classifications and initial/final normal restoration remained intact. Wave1 scribe/guard source checks were pre-integration proposals/baselines, not replay results. No selected failed numeric fit, corrected transcription, or receiptless verifier attempt was reported.

Sol **admitted** this fixture-local move: depth, fixture-mode coverage and calibration **improved locally**, no demonstrated scoped harm. Canonical corpus remains 17 and four SHONEN boxes remain checked without promotion. No arbitrary PCM32 conversion, extra precision/fidelity, audibility/quality, production readiness, rights, engine/game/lore behavior or publishing inference. No push, merge, publication or rights action was taken.
