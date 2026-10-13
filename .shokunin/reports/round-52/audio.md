# Audio round 52 — matched unsigned PCM8/signed PCM16 UI format check

Work commit `6f1a13172d86fe1c648dc1bc69da00fdd8ecfe02` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-52/r52-verifier.md`; Sol `.shokunin/audio/reports/round-52/r52-adjudicator.md`.

## Declared move and selected pair
At clean-before `36403d8d848b20ea48c15149f3138a94a77d530f`, the corpus had PCM24/PCM16 matched UI coverage but not a below-16-bit matched UI format check. One calibration move adds opt-in `--probe-ui-pcm8` / `--probe-ui-pcm16-r52`, preserving `format_failures`, `SPECS["ui"]`, thresholds, and 17 canonical WAVs. The original 5760-frame mono 48k pair constructs signed PCM16 integers as `(unsigned PCM8 - 128)*256` so project SoX-f32 decoded vectors match **by construction**, not as evidence of general conversion or fidelity.

| Probe | WAV SHA-256 | ffprobe codec / bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| PCM8 | `74dd0a3d7a5218e9ead995d14f118beb2118c0f163ce086d406415ce368efb37` | `pcm_u8` / 8 | `.3125` / `-14.699802598426999 dBFS` / `1581.8516662990894 Hz` | exit1, sole `format: expected PCM16` |
| PCM16 | `b09eb7e624813cd9734e6f4c3b373f7842fb44900737138d7c841c1ad2333344` | `pcm_s16le` / 16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`, mono 48000 Hz, all non-format UI gates pass. Fresh receipts: `.shokunin/audio/corpus/live/runs/20261013T110310426995Z-ui-pcm8/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T110311445143Z-ui-pcm16-r52/measurements.json`. Independent alternate original pair had different WAV hashes and the same format polarity.

## Independent replay and verdict
The non-author verifier executed **64 new unique serial runner commands**, receipts `20261013T110309403670Z`–`20261013T110414717079Z`: **28 exit0 / 36 expected validation exit1**. Prior62 subset retained exact raw JSON (27/35), canonical17 SHA/metrics, five generic `_alt` and four family comparisons, thresholds/sections/eight invalid classifications, and initial/final normal restoration. A ledger display joins two ambience failures with a semicolon; raw receipt lists both. An executor scratch-root exception was setup. Initial author receipts got the wrong `normal` suffix until routing was fixed; they were not credited. No receiptless verifier attempts, selected failed numeric fits, or corrected transcription.

Sol **admitted** this fixture-local move: depth, fixture-mode coverage, and calibration **improved locally**, with no demonstrated scoped harm. Canonical corpus stays 17; four SHONEN boxes remain checked without promotion. No arbitrary PCM8 acceptance, extra fidelity, audible/perceptual quality, production readiness, rights clearance, engine behavior, or publication claim. No push, merge, publishing, rights, engine/game/lore edit was made.
