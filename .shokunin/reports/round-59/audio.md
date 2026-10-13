# Audio round 59 — extensible PCM16 valid-bits 13/16 control

Work commit `fe4317369f23b0ebf3775d8689ee803cb8f95f49` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-59/r59-verifier.md`; Sol `.shokunin/audio/reports/round-59/r59-adjudicator.md`.

## Declared move and selected pair
Against clean-before `fe96f1b1948360cb089aad0a23b69864406453d1`, left-aligned matched valid15/16 and valid14/16 controls existed, but no valid13/16 case. One calibration move adds opt-in `--probe-ui-extensible-valid-13-r59/16-r59` under unchanged PCM16/UI predicate, thresholds and canonical17. Selected original 5760-frame mono48000 signed16 payload is identical across WAVs (SHA-256 `88cac2a0475a0fdbedc4be3758a2215b3937219f13a5c8ff0515a10f1e09ccd1`); **all samples are divisible by eight**, left-aligned for 13 valid bits. Both use tag0xfffe/fmt40, `cbSize=22`, 16-bit container, mask0x4, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71`. Only `wValidBitsPerSample` differs at WAV byte38.

| Valid bits | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| 13 | `873485d5dd0d5108f0523ab974cbba6ce792e715861d481db0ad68ea35f2f2e0` | `pcm_s16le`/16 | `.659912109375` / `-8.811743007017897dBFS` / `2139.5871109211243Hz` | exit0, clean |
| 16 | `c8f327e38f34125a15bfe3e490905852a228ba26436b0a3b1633a6f58a4a1f3b` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`; SoX-f32 5760 decoded vectors equal **for this payload**. Fresh designated non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T131242584048Z-ui-extensible-valid-13-r59/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T131243646181Z-ui-extensible-valid-16-r59/measurements.json`. Distinct alt and scout scratch pairs corroborate bounded direct observations, not runner results.

## Fresh replay, extra run, and verdict
The designated verifier ledger is **78 unique serial receipts**, `20261013T131241531728Z`–`20261013T131403651634Z`: 40 exit0/38 expected validation exit1. Prior76 complete parsed JSON matches exactly (subset38/38), canonical17 SHA/metrics and generic/family/threshold/section/eight-invalid controls retained, initial/final normal equal. An **earlier extra 78-receipt run**, `20261013T131110133069Z`–`20261013T131231893990Z`, produced distinct paths and exact corresponding JSON, but is not double-counted in the designated ledger. The verifier reported that a mistaken belief its first in-memory results were lost led to the unnecessary second run. Its original “after” chronology was **report transcription**, corrected; Sol's adjudicator treated the reason as unknown from what it inspected. A preliminary malformed shell-quote command exited127 with **zero receipt** (setup, not gate). No selected numeric fit failure or decode rejection.

Sol **admitted** the fixture-local move: depth, opt-in coverage and calibration **improved locally**, no demonstrated scoped harm. The existing predicate does **not parse valid-bit metadata**. No actual 13-bit precision/fidelity, general valid-bit enforcement, arbitrary extensible headers/codecs/decoders, audible quality, production, rights, engine/game/lore or publishing follows. Four SHONEN boxes remain checked without promotion. No push, merge, publication or rights action.
