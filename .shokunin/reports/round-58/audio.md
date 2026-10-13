# Audio round 58 — extensible PCM16 valid-bits 14/16 control

Work commit `75b4bd531d032eedd8da2b95e36ce895f2d535a2` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-58/r58-verifier.md`; Sol `.shokunin/audio/reports/round-58/r58-adjudicator.md`.

## Declared move and selected pair
Against clean-before `0e7a31f7645a8d4c8094612047a6f89d74d69bdb`, R57 established only a selected 15/16-valid-bit, all-even PCM16 pair. One calibration move adds opt-in `--probe-ui-extensible-valid-14-r58/16-r58` without changing PCM16/UI predicate, thresholds or canonical17. Selected original 5760-frame mono48000 signed16 payload is identical across files (SHA-256 `0b40e3c0f28aa6a50937f87c0fa260b2100f97572dbc8fdf517cea981e79b4fc`); **every value is divisible by four**, left-aligned for 14 valid bits. Both use tag0xfffe/fmt40, `cbSize=22`, 16-bit container, mask0x4, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71`. Only `wValidBitsPerSample` differs at WAV byte38.

| Valid bits | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| 14 | `6b4b07d1eee022f99116a043b444821914acc68110544a644ba7204f3a63fb26` | `pcm_s16le`/16 | `.3153076171875` / `-14.629479252569332dBFS` / `1129.9910331085607Hz` | exit0, clean |
| 16 | `738263969d226d31a0525bbad1c7dda8609b270dd3ec8fa82645905d4667a7f2` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`; SoX-f32 5760 decoded vectors equal **for this payload**. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T125322047317Z-ui-extensible-valid-14-r58/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T125323076433Z-ui-extensible-valid-16-r58/measurements.json`. Independent alt and critic scratch pairs corroborate bounded observations, not the integrated runner result.

## Fresh replay and verdict
The verifier executed **76 new unique serial commands**, receipts `20261013T125321021838Z`–`20261013T125439182373Z`: 38 exit0/38 expected validation exit1. Prior74 complete parsed JSON matches exactly (subset36/38), including canonical17 SHA/metrics, generic/family, thresholds/sections/eight invalid and initial/final normal restoration. No verifier receiptless attempt, decoder rejection, or selected numeric failed fit. Executor relative-path direct-measure exits1 and alt malformed inspection were **setup**, not selected gate evidence. Scout's wrong R57 SHA/sample-alignment attribution was corrected as **report transcription**.

Sol **admitted** the fixture-local move: depth, opt-in coverage and calibration **improved locally**, no demonstrated scoped harm. The existing predicate does **not parse valid-bit metadata**. This does not establish 14-bit precision/fidelity or general valid-bit enforcement, arbitrary extensible headers/codecs/decoders, audible quality, production, rights, engine/game/lore or publishing. Four SHONEN boxes remain checked without promotion. No push, merge, publication or rights action.
