# Audio round 3 — depth: loop slope-join measurement

Work commit: `27d91ec` by `audio-shokunin <audio@shokunin.local>`. Non-author verifier `.shokunin/audio/reports/round-3/r3-verifier.md`; independent Sol adjudication `.shokunin/audio/reports/round-3/r3-adjudicator.md` (both in work commit).

## Work performed
- Declared one depth move before dispatch in `.shokunin/audio/LOG.md` at `27d91ec`; eight leaf Luna reports in `.shokunin/audio/reports/round-3/r3-{slope-scout,metric,probe,fixture,calibration,regression,simplifier,scribe}.md` and separate sequential verifier/adjudicator reports.
- Added a decoded-PCM local slope gap alongside the existing loop endpoint jump in `.shokunin/audio/corpus/fixtures/measure_audio.py` at `27d91ec`; clean values and bound derivation in `r3-metric.md`, `r3-calibration.md`, and `.shokunin/audio/corpus/knowledge/2026-10-12-fixture-battery.md`.
- Added a deterministic equal-endpoint/slope-discontinuous scratch control in `.shokunin/audio/corpus/fixtures/build_artifacts.py` and `corpus/live/round-3/slope_probe.wav`; source recipe `r3-probe.md` and SHA-256 `91b4a324124ef8a54b0dc25eea584f3e08f1451090e1413b15d7325ec8bde99f`.
- Named non-author `r3-verifier` replayed normal/slope/broken-amplitude/restore with exact command/exit/receipt details in `r3-verifier.md`; malformed wrapper exit 127 is logged as telemetry. Named non-author Sol `r3-adjudicator` repeated slope exit 1, restore exit 0 and compared nine before hashes.

## Landed changes
- `27d91ec`: builder, battery, probe, knowledge, round log/scorecard/SHONEN and all scoped receipts/reports. LOG round-3 declaration and closure link the change. This final report is written after `27d91ec`, in a report-only commit.

## Before → after measurements
- Before `ef2dc58`: endpoint jump only on three loop WAVs, no slope-gap check. After `27d91ec`: clean ambience/ambience_alt/stem slope gaps 0.000030517578125/0/0.000030517578125 FS/sample, all <= local 0.001 bound; endpoints unchanged. Isolated slope control has endpoint delta **0**, slope gap **0.469970703125**, only slope failure (`.shokunin/audio/corpus/live/runs/20261012T162835463500Z-slope/measurements.json`). Broken-amplitude control still fails endpoint plus centroid (`20261012T162835970021Z-failing`), not slope. Normal/restore nine-file receipts `20261012T162822089971Z-normal` and `162836475076Z-normal` pass; `r3-verifier.md` shows all nine canonical SHA-256s unchanged versus `ef2dc58` and all four variant comparisons still pass.
- Counting command for unchanged coverage: `python3 -c "from pathlib import Path; print(sorted(p.stem for p in Path('.shokunin/audio/corpus/artifacts').glob('*.wav')))"`. Eight SFX plus stem before and after, no replacement.
- Axis verdicts (`r3-adjudicator.md`): **depth improved**, **coverage unchanged**, **calibration unchanged**, none harmed. Admit. One-sample slope mismatch is a fixture-local numeric proxy; no listening, production-ready, codec/runtime-seam, sample-rights or publishing claim. No scalar rating.

## SHONEN
- [x] Decision tables/error patterns/checklists with cited sources: `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end domain task executed and logged: `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Fixture workflow instructions executable without oral context: named non-author `r3-adjudicator` and `r3-verifier`, `.shokunin/audio/reports/round-3/`; limited to this workflow.
- [ ] No cross-domain bleed / accurate province broadly: non-author says not established; remains open.

Only permitted `.shokunin/audio/**` and `.shokunin/reports/**` written. `MANIFEST.json` not touched because outside allowed paths. No push or merge.
