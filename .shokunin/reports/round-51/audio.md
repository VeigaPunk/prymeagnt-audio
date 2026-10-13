# Audio round 51 — matched PCM24/PCM16 UI format check

Work commit `dc8270afe2c332949e64f23d5f45ef6149b52bb1` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Independent non-author `.shokunin/audio/reports/round-51/r51-verifier.md`; Sol `.shokunin/audio/reports/round-51/r51-adjudicator.md`.

## Declared move and evidence
At clean-before `97badf4cbfbc2d7d0304f9f15175c57a3113fb0a`, historical `native24_probe` was a broad invalid fixture rather than a matched ordinary UI pair. One calibration move adds opt-in `--probe-ui-pcm24/pcm16` using original mono 48000 Hz, 5760-frame WAVs through unchanged `measure(..., SPECS["ui"])`. Their quantized PCM16 integers are scaled by 256 into PCM24, so the project SoX-f32 decoded vectors are exactly equal **by construction**, not a full-precision 24-bit test.

| Probe | WAV SHA-256 | ffprobe codec/bits | Duration | Peak / RMS / centroid | Fresh exit/failure |
|---|---|---|---|---|---|
| PCM24 | `6d3f804579124af4fb14f8d7313b25fb87231ca9729a434661475939cae601c8` | `pcm_s24le`/24 | `.120000s` | `.315399169921875` / `-14.628083420045229 dBFS` / `1123.8154138173777 Hz` | 1, solely `format: expected PCM16` |
| PCM16 | `2d201f849ecb416401b15c88e172527f9beec852c8998123f5f06131c712fee0` | `pcm_s16le`/16 | `.120000s` | identical project-decoded metrics | 0, clean |

Both are mono, 48000 Hz; all non-format UI checks pass. Non-author receipts: `corpus/live/runs/20261013T102815806651Z-ui-pcm24/measurements.json` and `corpus/live/runs/20261013T102816849885Z-ui-pcm16/measurements.json`. The independent alt original pair had different WAV hashes and the same polarity.

## Fresh replay and axis verdict
The replacement verifier executed **62 serial commands with 62 new unique receipts**, `20261013T102814760288Z`–`20261013T102917940108Z`: 27 exit0 / 35 expected fixture-validation exit1. The prior60 subset is 26/34 with exact retained modes, exits and failure maps. Canonical17 hashes and measurements, five generic `_alt` and four family comparisons, thresholds, sections, eight invalid classifications, and initial/final normal restoration remained intact. The first verifier stalled without a completed report. Seven older receipts were visible at the replacement's pre-replay snapshot; a later inspection found 62 `083353`–`083459` older receipt files. **None is counted in the replacement ledger.** Wave1 helper/path/shell-quoting errors are setup, not gate outcomes; no receiptless replacement attempt, selected failed numeric fit, or corrected transcription is reported.

Sol **admitted** the declared move with no demonstrated scoped harm: depth **improved locally**, coverage **improved locally** (two opt-in fixture modes, canonical corpus still 17), and calibration **improved locally**. The result supports this generated pair and current runner only. It does not establish general PCM24 handling, extra precision or fidelity, audible/perceptual quality, production readiness, rights, engine behavior, publishing, or promotion. Four SHONEN boxes remain checked without promotion. No push, merge, publication, or rights action was taken.
