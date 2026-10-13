# Audio round 53 — matched IEEE-float32/PCM16 UI format check

Work commit `f25470e8cd0ac9dbd0d3fa67c87c6eedf4f117f9` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Non-author `.shokunin/audio/reports/round-53/r53-verifier.md`; Sol `.shokunin/audio/reports/round-53/r53-adjudicator.md`.

## Declared move and measured pair
Against clean-before `45407aee21f52b68dc747c55feba4de65fa8748a`, one calibration move adds opt-in `--probe-ui-float32/pcm16-r53` while preserving existing `format_failures`, `SPECS["ui"]`, thresholds, canonical17 and prior64 modes. The original 5760-frame mono 48000 Hz signal is quantized once to signed PCM16. Float samples are `s16/32768`, so the SoX-f32 decoded vectors are equal **for this constructed PCM16-grid pair**, not arbitrary float content.

| Probe | WAV SHA-256 | ffprobe codec / bits | Project peak / RMS / centroid | Fresh exit/failure |
|---|---|---|---|---|
| IEEE float32 | `1a1d9ec23e0a9cc7fdd62f1bfb30c51260b6847c879467317783d744c774deef` | `pcm_f32le` / 32 | `.315399169921875` / `-14.628083420045229 dBFS` / `1123.8154138173777 Hz` | 1, sole `format: expected PCM16` |
| PCM16 | `2d201f849ecb416401b15c88e172527f9beec852c8998123f5f06131c712fee0` | `pcm_s16le` / 16 | identical decoded metrics | 0, clean |

Both `.120000s`, mono 48000 Hz; all other UI gates pass. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T112146820645Z-ui-float32/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T112147855585Z-ui-pcm16-r53/measurements.json`. An independent alternate original pair gave the same polarity with different WAV hashes.

## Independent replay and verdict
The verifier ran **66 new unique serial commands**, receipts `20261013T112145780214Z`–`20261013T112258344842Z`: 29 exit0 / 37 expected validation exit1. Prior64 raw JSON matched exactly (28/36 subset), as did canonical17 SHA/metrics, generic five `_alt` and four family comparisons, thresholds/sections/eight invalid classifications and initial/final normal restoration. SoX emitted `WARN wav: wave header missing extended part of fmt chunk` for the simple float header, yet decoded with exit0; no extensible-header/general float compatibility claim follows. Executor's path, simplifier's quoting and scout's ffprobe errors were setup, not audio gates. No selected numeric failed fit or corrected transcription.

Sol **admitted** the fixture-local move: depth, fixture-mode coverage and calibration **improved locally**, with no demonstrated scoped harm. Canonical corpus remains 17; four SHONEN boxes checked without promotion. No general conversion, precision/fidelity, audibility/quality, production readiness, rights clearance, engine/game/lore behavior or publishing inference. No push, merge, publication or rights action was taken.
