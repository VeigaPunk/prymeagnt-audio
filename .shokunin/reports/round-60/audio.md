# Audio round 60 — malformed extensible PCM16 valid-bits-0 control

Work commit `347407c539ef6b72b96476bb466ca12be3b7c7f3` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Non-author `.shokunin/audio/reports/round-60/r60-verifier.md`; Sol `.shokunin/audio/reports/round-60/r60-adjudicator.md`.

## Declared move and measured pair
Against clean-before `4894d074b29b6585bafc71682cbde1e0048b906c`, prior controls compared conforming left-aligned valid bits 15/14/13 against valid16. One calibration move adds opt-in `--probe-ui-extensible-valid-0-r60/16-r60` to ask whether a **malformed/unspecified** valid-bits-zero declaration is rejected or accepted through this host's unchanged decoder/UI path. The matched original 5760-frame mono48000 signed16 payload is identical (SHA-256 `6e76d877b1e153b636b883f06dea7d3fd7f43374a72fa2cba678c8f4560c9711`). Both headers have tag0xfffe/fmt40, `cbSize=22`, 16-bit container, mask0x4, PCM subtype GUID `00000001-0000-0010-8000-00aa00389b71`; only WAV byte38 differs (`wValidBitsPerSample=0` versus 16). The zero case is **not a conforming positive format example**.

| Declared valid bits | WAV SHA-256 | ffprobe codec/bits | Project peak / RMS / centroid | Fresh result |
|---|---|---|---|---|
| 0, malformed | `5ab169fc3f43b29c0bb17cc86e6b76fb424e590b7d788a503a002501c8a2f394` | `pcm_s16le`/16 | `.082489013671875` / `-26.87354274685677dBFS` / `2139.5871109211243Hz` | exit0, clean |
| 16 control | `d7f08d659b608e003e5ef2aaccf325dae3bd4e961caeaa450bd933c406b4cc46` | `pcm_s16le`/16 | identical project-decoded metrics | exit0, clean |

Both `.120000s`; SoX-f32 decoded vectors equal **for this payload**. Fresh non-author receipts: `.shokunin/audio/corpus/live/runs/20261013T133203624235Z-ui-extensible-valid-0-r60/measurements.json` and `.shokunin/audio/corpus/live/runs/20261013T133204718244Z-ui-extensible-valid-16-r60/measurements.json`. Independent alt/scout scratch pairs corroborate bounded direct behavior, not integrated replay.

## Fresh replay and verdict
Non-author verifier executed **80 new unique serial commands once**, receipts `20261013T133202557584Z`–`20261013T133328973523Z`: 42 exit0/38 expected validation exit1. R59 **designated** prior78 complete parsed JSON matches exactly (subset40/38), canonical17 SHA/metrics and generic/family/threshold/section/eight-invalid controls retained, initial/final normal equal. No verifier receiptless attempt, extra run, selected decode rejection or numeric failed fit. Critic's pre-integration unknown flag exit2 generated no receipt; simplifier's scratch script `inspect.py` shadowed stdlib, corrected by `python3 -I`; both were **setup**, not gate evidence.

Sol **admitted** the fixture-local malformed-input move: depth, opt-in coverage and calibration **improved locally**, no demonstrated scoped harm. The existing predicate does **not parse valid-bit metadata**. This acceptance establishes only local non-rejection, not a valid zero-bit signal, standards conformance, universal header/decoder/codec support, precision/fidelity, audible quality, production, rights, engine/game/lore or publishing. Four SHONEN boxes remain checked without promotion. No push, merge, publication or rights action.
