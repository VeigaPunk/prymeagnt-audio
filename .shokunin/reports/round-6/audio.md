# Audio round 6 — named invalid-input receipts

Work commit `f338604` by `audio-shokunin <audio@shokunin.local>`; this final report is written and committed **after** the work. Before-state `3b02c31`. Non-author replay: `.shokunin/audio/reports/round-6/r6-verifier.md`; non-author Sol verdict: `r6-adjudicator.md`.

## Declared move and waves
- Claimed one depth improvement: make three named generated invalid-input cases produce structured JSON failure receipts without an unhandled traceback, while keeping clean assets and controls stable. `.shokunin/audio/LOG.md` declared before-state and disjoint eight-leaf Luna wave before spawn. Wave-1 scout/executors/critic/reviewer/simplifier/scribe reports are in `.shokunin/audio/reports/round-6/`. Wave-2 Luna verifier and wave-3 Sol adjudicator settled sequentially; LOG records scopes, paths and receipts.
- Integrated `--probe-invalid` in `corpus/fixtures/build_artifacts.py` and `measure_audio.py`, an exact section-count guard before split/FFT, and a bounded knowledge extension. Scratch files are three original WAV inputs in `corpus/live/round-6/`; no canonical WAVs or old numeric thresholds were changed. Only the named corrupt probe catches ffprobe `CalledProcessError`; unrelated exceptions remain visible.

## Evidence and before → after
- Before: no dedicated invalid-input mode. `section_contrast()` checked the count after split/FFT, which could raise on some odd/tiny lengths. After: `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-invalid` exits **1** with persisted `corpus/live/runs/20261012T170607093097Z-invalid/measurements.json`: `short_sections` 144000 vs 192000 samples → `section count`; `corrupt` 16-byte incomplete RIFF → ffprobe exit 1, `decode`; `wrong_format` 44100 Hz/stereo → `format`. All three entries say `status: expected_failure`; no traceback. Builder regenerated the three worker scratch hashes exactly. **The 144000-sample file is even and would reach the old count predicate; it does not demonstrate the old exception.** The precheck's exception-path value is source-order evidence, not an exercised regression.
- Non-author serial replay ran the same script with invalid/normal/flat/slope/failing/normal flags; exits **1/0/1/1/1/0**, receipts `20261012T170607093097Z-invalid`, `170607675436Z-normal`, `170608325807Z-flat`, `170608960610Z-slope`, `170609548702Z-failing`, `170610141133Z-normal`, each under `.shokunin/audio/corpus/live/runs/` with `measurements.json`. Ten canonical SHA-256 hashes match `3b02c31`; clean normal and restore receipts have ten passing measurements and all four variant checks passing. Flat30, slope and broken ambience controls retain their specific failures. See verifier report for exact commands, scratch hashes and receipt outcomes; author runs are separately listed in LOG.

## Adjudication and limits
| axis | verdict | basis |
|---|---|---|
| depth | **improved narrowly** | new dedicated structured failure receipt for three named inputs under installed toolchain; section precheck ordering corrected but odd/tiny exception rescue not directly replayed |
| coverage | **unchanged** | ten canonical WAVs hash-identical; scratch negatives are not new production categories |
| calibration | **unchanged** | existing numeric thresholds and controls unchanged; no threshold was tuned |

Admit: at least one axis improved and none harmed, per `.shokunin/audio/reports/round-6/r6-adjudicator.md`. No scalar score. The results do not establish general malformed-file handling, codec security, audible quality or production readiness. SHONEN boxes 1–3 retain earlier scoped evidence; box 4 remains **open** pending whole-lane independent review. Only `.shokunin/audio/**` and `.shokunin/reports/**` changed; no MANIFEST edit, push, merge or publication.
