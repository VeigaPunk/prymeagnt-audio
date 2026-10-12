# Audio round 7 — odd section-count regression control

Work commit `fff5a7f` by `audio-shokunin <audio@shokunin.local>`; final report written/committed after work. Before-state `cba2748`; historical checker source `3b02c31`. Non-author replay `.shokunin/audio/reports/round-7/r7-verifier.md`; Sol per-axis review `r7-adjudicator.md`.

## Claim, work and before → after evidence
- Declared one depth move in LOG before eight disjoint Luna leaf roles. The round-6 144000-frame short probe is even, so it did not reproduce the old split exception. `r7-odd` created a fresh 101-frame mono PCM16/48 kHz `corpus/live/round-7/odd_sections.wav` (SHA-256 `81c7ba97bfc8f68a9ad48403a6b102bf4d5f573963f5d8f74a9697bd09aa72d8`). `r7-baseline` extracted only `section_contrast()` from Git `3b02c31`, ran it on that file, and got exit **1** with `ValueError: array split does not result in an equal division` at old `np.split`. Its first setup attempt exited 1 with `NameError` because NumPy was omitted; this failed attempt is documented, not counted. Direct old function behavior does **not** prove the old CLI processed arbitrary scratch paths.
- Parent extended the existing `--probe-invalid` builder/list, not the count guard or numeric thresholds. Non-author verifier independently repeated the old exception (exit 1) and current invalid mode (exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261012T171718939143Z-invalid/measurements.json`): `odd_sections` has `actual_samples: 101` vs exact 192000 and `observed_failure: section count`, `status: expected_failure`, no traceback. The prior short/corrupt/wrong-format cases retain `section count`/`decode`/`format`. Builder regenerated the odd scratch byte-identically.
- Non-author corrected commands `python3 .shokunin/audio/corpus/fixtures/measure_audio.py` with flags none/`--probe-flat`/`--probe-slope`/`--probe-failing`/none exited **0/1/1/1/0**, receipts `20261012T171605486878Z-normal`, `171613915489Z-flat`, `171614543341Z-slope`, `171615125782Z-failing`, `171615709159Z-normal` under `corpus/live/runs/` (`measurements.json`). Ten canonical hashes match `cba2748`; all four alternate distinctness checks pass. Verifier records **nine** initial misquoted-command exits **127** and excludes them; correct replay is the evidence. Wave reports/scopes and parent receipt `171439794703Z-invalid` are in LOG and `.shokunin/audio/reports/round-7/`.

## Per-axis decision
| axis | verdict | reason |
|---|---|---|
| depth | **improved narrowly** | directly replayed old isolated-function odd split exception versus new named structured receipt; count-before-split guard was already added in round 6, not a new universal fix |
| coverage | **unchanged** | same ten canonical WAVs/four variants; odd scratch is a negative structural control, not new SFX/stem category |
| calibration | **unchanged** | existing thresholds and proxy caveats retained, no LUFS acceptance window added |

Admit: at least one improved and none harmed per `r7-adjudicator.md`; no scalar score. Evidence applies only to named input/installed toolchain, not arbitrary malformed files, codec security, perceptual quality or production suitability. SHONEN box 4 remains **open** pending whole-lane historical review. Only `.shokunin/audio/**` and `.shokunin/reports/**` changed; no MANIFEST edit, push, merge or publication.
