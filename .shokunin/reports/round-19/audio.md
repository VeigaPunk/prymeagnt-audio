# Audio round 19 — local PCM16 slope-threshold bracket

Work commit `6648aae` by `audio-shokunin <audio@shokunin.local>`; this final report is committed **last**. Before `010f88b`. Independent replay `.shokunin/audio/reports/round-19/r19-verifier.md` and Sol per-axis decision `r19-adjudicator.md`; LOG, SCORECARD, worker reports, and JSON receipts preserve exact commands, exits, limitations, and setup telemetry.

## Measured move
- Added opt-in `--probe-layer-third-slope-edge-pass` and `--probe-layer-third-slope-edge-fail` only. The scratch WAVs copy canonical 200 Hz `stem_layer_third.wav` and change only zero-based PCM16 frame 96001 from 43 to 45 (+2) or 46 (+3). Full WAV SHA-256: canonical `3d2048e48a6a16ef2a669736ad1168c9368223fb3a0702478f874e4d2588d445`; pass `512b38026eb102fac4773bca1b61e7994261b6f6297e0ec544fb4b47b1104496`; fail `48e2167dd405d05dc66aab304fc7b3c4712d2734dca021fdfd92d15a3e8d2a38`. No canonical WAV, `.001` threshold, or strict `>` comparator changed.
- Independent runner receipts `corpus/live/runs/20261012T194314266885Z-layer-third-slope-edge-pass/measurements.json` (exit 0; no failures) and `20261012T194315116347Z-layer-third-slope-edge-fail/measurements.json` (exit 1; **sole** internal side-slope failure) show decoded slopes **32/32768 = `.0009765625`** and **33/32768 = `.001007080078125`** FS/sample around `.001`. Both internal gaps `.000396728515625` FS, 200Hz contrast, generic and outer gates pass. Section `passed` denotes contrast, not complete measurement status. Neither case tests equality.
- Non-author 16-mode serial replay exited `0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0`; prior negative failure sets held, all 13 canonical byte hashes matched `7083a3f`, all five `_alt` checks passed, and first/restored normal parsed receipts matched excluding path identity. `--probe-invalid` checks malformed inputs, not canonical WAVs. Verifier corrected a Markdown table formatting error without changing receipts.

## Axis decision and boundaries
| axis | Sol verdict |
|---|---|
| calibration | **improved narrowly** — complete runner pair discloses the local numeric resolution of the unchanged slope bound for this one-frame edit and SoX float32 decode. |
| depth | unchanged — no new detector or failure class. |
| coverage | unchanged — scratch controls are not canonical content. |

Admit with zero demonstrated scoped harm; no perceptual calibration, audible seamlessness, musical quality, engine behavior, rights, security, external JSON compatibility, or production assertion. Seven wave-1 reports settled; scribe produced no artifact and was cancelled, not counted as verification. Alternate relative-path and simplifier mistyped-path setup errors, parent child-deletion errors, and corrected executor hash/contrast values are telemetry, not passing tests. SHONEN box4 remains open pending historical review.

**paused by operator 2026-10-12, round 19 closed, no round 20.**
