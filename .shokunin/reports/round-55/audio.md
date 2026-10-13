# Audio round 55 — positive standard/extensible PCM16 header control

Work commit `8d058c9cd25c50c77489c5bf0d9bf2e82ccfe046` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-55/r55-verifier.md`; Sol `.shokunin/audio/reports/round-55/r55-adjudicator.md`.

## Declared move and measured pair
At clean-before `b432fab936eea3dbf24a0b7a6c015d66771c0031`, a historical extensible 24-bit/20-valid-bit probe did not provide a matched ordinary PCM16 header comparison. One calibration move adds opt-in `--probe-ui-extensible-pcm16/standard-pcm16-r55` under unchanged format predicate, UI spec, thresholds and canonical17. Both WAVs share the exact 5760-frame signed PCM16 payload at 48000 Hz mono. Conventional header has tag1/fmt16; extensible header has tag0xfffe/fmt40, `cbSize=22`, valid bits16, front-center channel mask `0x4`, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71`.

| Header | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| Extensible | `bd7d95901935c0effe21fd64e44a47487372be9d0c80f86cc725380df0352f47` | `pcm_s16le`/16 | `.31536865234375` / `-14.628519169868087dBFS` / `1123.322704293326Hz` | exit0, clean |
| Standard | `9ac26f38a7df9b1dd60c6130049d1e37056811fcd241f15a03559b5766bb4ba9` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s` and pass all UI gates; project SoX-f32 decoded vectors are identical. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T115709281095Z-ui-extensible-pcm16/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T115710311368Z-ui-standard-pcm16-r55/measurements.json`. Independent alternate original pair had different hashes and the same positive result.

## Fresh replay and verdict
The verifier executed **70 new unique serial commands**, receipts `20261013T115708252275Z`–`20261013T115818883316Z`: 32 exit0/38 expected validation exit1. Prior68 full parsed JSON matched exactly (subset30/38), with canonical17 SHA/metrics, five generic `_alt`/four family comparisons, thresholds/sections/eight invalid classifications and first/final normal restoration intact. The guard report misstated the extensible scratch WAV hash; this was **report transcription**, not a gate result. Executor/integrated hash and independent verifier agree on the SHA above. No selected numeric failed fit or receiptless verifier attempt.

Sol **admitted** this fixture-local positive control: depth, fixture-mode coverage and calibration **improved locally**, no demonstrated scoped harm. One valid16/mono/front-center/PCM-subtype example cannot establish general WAVE_FORMAT_EXTENSIBLE handling or other masks, GUIDs, valid-bit/container-bit combinations, codecs or decoders. Canonical corpus remains 17, four SHONEN boxes remain checked without promotion. No audible/perceptual quality, production, rights, engine/game/lore or publishing inference; no push, merge, publication or rights action.
