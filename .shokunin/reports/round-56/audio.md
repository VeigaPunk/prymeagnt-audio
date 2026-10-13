# Audio round 56 — extensible PCM16 mono mask `0x0`/`0x4` control

Work commit `84123c53bd556773e05253015ceededb0b2d10e2` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-56/r56-verifier.md`; Sol `.shokunin/audio/reports/round-56/r56-adjudicator.md`.

## Declared move and measured pair
Against clean-before `b4249b3c2037ad3e438e52d4abb0e5cd45a7c511`, R55 tested one extensible front-center mask `0x4`. One calibration move adds opt-in `--probe-ui-extensible-mask-zero/center` under unchanged PCM16/UI predicates and thresholds. Both matched 5760-frame mono48000 WAVs use tag0xfffe/fmt40, `cbSize=22`, valid bits16, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71` and identical signed16 payload. Only the mask differs: `0x0` means **unspecified speaker positions**, not front-center `0x4`.

| Mask | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| `0x0` | `3399ae3661b0ebd6eb4fe7c3a7cf6f4f97cd2d5ec259638164d93c810952a193` | `pcm_s16le`/16 | `.31536865234375` / `-14.628519169868087dBFS` / `1123.322704293326Hz` | exit0, clean |
| `0x4` | `bd7d95901935c0effe21fd64e44a47487372be9d0c80f86cc725380df0352f47` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`/48k mono with identical SoX-f32 decoded vectors. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T121758699860Z-ui-extensible-mask-zero/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T121759723986Z-ui-extensible-mask-center/measurements.json`. Independent alternate original pair had different WAV hashes and the same narrow positive outcome.

## Fresh replay and verdict
The verifier ran **72 new unique serial commands**, receipts `20261013T121757674626Z`–`20261013T121910955617Z`: 34 exit0/38 expected validation exit1. Prior70 raw JSON matched exactly (subset32/38), including canonical17 SHA/metrics, five generic `_alt`/four family comparisons, thresholds/sections/eight invalid classifications and initial/final normal restoration. A malformed shell-quote attempt before the replay produced **zero receipt** and was setup, not a gate result. Critic's malformed-GUID scratch negative was separate from the target pair. No selected numeric failed fit or corrected transcription.

Sol **admitted** the bounded local move: depth, fixture-mode coverage and calibration **improved locally**, no demonstrated scoped harm. Canonical corpus remains 17; four SHONEN boxes remain checked without promotion. No claim for other masks/layouts/GUIDs, universal extensible-header or standards conformance, general codec/fidelity, audible quality, production readiness, rights, engine/game/lore or publishing. No push, merge, publication or rights action.
