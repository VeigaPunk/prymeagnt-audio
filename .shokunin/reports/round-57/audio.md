# Audio round 57 — extensible PCM16 valid-bits 15/16 control

Work commit `77c1d3918f7309c02c67fa5ad61f0470a11210d7` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-57/r57-verifier.md`; Sol `.shokunin/audio/reports/round-57/r57-adjudicator.md`.

## Declared move and selected pair
Against clean-before `ae1bf461acd11e3ababc82a89a49792ff10d1e61`, no matched extensible PCM16 valid15 versus valid16 control had established the local decoder/UI outcome. One calibration move adds opt-in `--probe-ui-extensible-valid-15/16` with unchanged PCM16/UI predicate, thresholds and canonical17. Selected independently generated pair contains identical **all-even (left-aligned)** 5760-frame mono48000 signed16 payload (SHA-256 `a6ec402df430818fd02a8437a85af7ab335e51084ca7e224f2b1b15cc2d2b89a`). Both use tag0xfffe/fmt40, `cbSize=22`, 16-bit container, mask0x4, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71`; only `wValidBitsPerSample` differs, at WAV offset38.

| Valid bits | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| 15 | `4f41ace3a386c78217c991dae6972be49f3be4a9fa918211c58e3a019af47b2b` | `pcm_s16le`/16 | `.2098388671875` / `-18.84202236105824dBFS` / `2153.742616905067Hz` | exit0, clean |
| 16 | `95d180f4c894751924317eb9b7add4d5c84e714a7807eeb14d1319a6ff1f785f` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`; the SoX-f32 decoded vectors are identical **for this payload**. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T123611346028Z-ui-extensible-valid-15/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T123612364862Z-ui-extensible-valid-16/measurements.json`. The executor’s first candidate had **2520/5760 odd sample values** in the valid15 file, so it was rejected for a left-aligned 15-bit claim; its successful decoding is only a decoder observation, not the integrated evidence.

## Fresh replay, setup, and verdict
The verifier ran **74 new unique serial commands**, receipts `20261013T123610325039Z`–`20261013T123725806532Z`: 36 exit0/38 expected validation exit1. Prior72 full parsed JSON matched exactly (subset34/38), canonical17 SHA/metrics and generic/family/threshold/section/eight-invalid controls retained, initial/final normal equal. Its preliminary malformed shell-quote command exited127 with **zero receipt** (setup, not decode or fixture validation). Wave-one setup attempts are documented separately in lane reports. No selected numeric failed fit or decode rejection.

Sol **admitted** the fixture-local move: depth, opt-in coverage and calibration **improved locally**, no demonstrated scoped harm. The existing predicate does **not parse valid-bit metadata**. The outcome does not establish universal valid-bit/header/codec support, extra resolution or precision, arbitrary conversion/fidelity, audible quality, production, rights, engine/game/lore or publishing. Four SHONEN boxes remain checked without promotion. No push, merge, publication or rights action.
