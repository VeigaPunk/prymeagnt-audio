# Audio round 1 independent verification

Verifier: non-author audio-r1-verifier. Worktree: `lanes/audio/r1`. Re-ran the checked-in measurement entry point, which rebuilds all five WAVs from `build_artifacts.py` before measuring; no sound server or `soundfile` dependency was used.

## Results

- Normal run exited **0** and emitted `corpus/live/runs/20261012T155752390616Z-normal/measurements.json`; all five fixture failure lists were empty.
- `--probe-failing` exited **1** and emitted `corpus/live/runs/20261012T155752784838Z-failing/measurements.json`. Ambience endpoint delta was `0.4993286` against max `0.03`; centroid was `2690.19 Hz` against its 5–200 Hz band. Other assets passed. This positively rejects the intentionally corrupted loop fixture.
- Restoring normal mode exited **0**, receipt `corpus/live/runs/20261012T155753181244Z-normal/measurements.json`.
- Artifact SHA-256s before normal, after normal, and after restore were identical. The probe changed only `ambience.wav` (`b18c8170…` clean to `bb7b72fd…` broken), and restore returned it to `b18c8170…`. Hashes for impact, movement, stem, and UI were unchanged throughout. This verifies deterministic clean outputs and restoration from the raw builder.

Normal measured values (duration, RMS dBFS, centroid Hz, endpoint delta where applicable):

| fixture | duration | RMS dBFS | centroid Hz | seam delta | integrated LUFS |
|---|---:|---:|---:|---:|---:|
| ui | 0.12 s | -19.99 | 966.90 | n/a | null |
| impact | 0.32 s | -20.40 | 10843.13 | n/a | null |
| movement | 0.24 s | -23.78 | 11934.48 | n/a | null |
| ambience | 2.00 s | -18.15 | 36.62 | 0.000671 | -30.7 |
| stem | 2.00 s | -14.88 | 272.68 | 0.011383 | -15.8 |

All were mono 48 kHz, with declared durations and peak/RMS checks passing. Null LUFS for three short SFX is consistent with the documented gated-floor handling; it is not a failed test.

## Scope and source review

The battery covers the declared four SFX plus one stem, headless duration/format, level, whole-file magnitude-weighted FFT centroid (and recorded bandwidth), and an endpoint sample-delta proxy for ambience/stem. The decision table cites ffprobe documentation for stream/duration, SoX format docs for decoded PCM, NumPy `rfft` docs for spectral calculation, FFmpeg ebur128 and EBU R128 for loudness measurement. The table explicitly labels the thresholds as round-local fixture bounds, not universal mastering standards. The ledger accurately states that fixtures use generated analytic waveforms/seeded noise and no external recordings.

The province boundary is respected: this is audio asset generation and measurable headless audio validation; no engine/game-mechanics or publishing claim was introduced. No perceptual-quality or production-readiness claim follows from these measurements.

## Limitations / decision

The seam check is only the absolute difference between the first and last decoded samples; it does not establish slope/phase continuity, codec or runtime loop behavior, or perceptual seamlessness. Whole-file centroid/bandwidth are coarse summaries and cannot validate timbre over time. The probe intentionally trips both centroid and seam, with the seam failure clearly present. I found no run, JSON, determinism, scope, or cited-table error. Independent evidence supports the round's declared fixture-battery claim and supports box 1's decision-table/error-pattern evidence; it does not independently establish perceptual quality.
