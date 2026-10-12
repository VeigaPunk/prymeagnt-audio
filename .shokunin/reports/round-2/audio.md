# Audio round 2 — coverage: SFX variants

Work commit: `a391132` by `audio-shokunin <audio@shokunin.local>`. Non-author verification: `.shokunin/audio/reports/round-2/r2-verifier.md`; final axis review: `.shokunin/audio/reports/round-2/r2-adjudicator.md`.

## Work performed
- Declared one coverage move and before-state before wave dispatch; wave specs, clarification, telemetry, closure and next candidate appear in `.shokunin/audio/LOG.md` at `a391132`.
- Synthesized original deterministic UI, impact, movement and ambience variants (`.shokunin/audio/corpus/artifacts/*_alt.wav`), with recipes and worker evidence in `.shokunin/audio/reports/round-2/r2-{ui,impact,movement,ambience}.md` at `a391132`.
- Extended existing builder and headless measurement entry point (`.shokunin/audio/corpus/fixtures/{build_artifacts,measure_audio}.py` at `a391132`) to regenerate and check nine fixtures and record four numeric distinctness comparisons. No external audio samples or engine edits.
- Non-author `r2-verifier` replayed normal/normal/broken/restore via `python3 .shokunin/audio/corpus/fixtures/measure_audio.py` (exits 0, 0, 1, 0), compared nine raw WAV hashes across clean runs and five originals to `31d8e9e`, and documented a malformed invocation exit 127; receipts under `.shokunin/audio/corpus/live/runs/20261012T161{812132927,815632474,822938808,825061249}Z-*` at `a391132`.

## Landed changes
- `a391132`: four SFX variants, nine-file builder/battery, receipt and source documentation; declared and closed in `.shokunin/audio/LOG.md` round 2. The final report is this subsequent report-only commit, written after `a391132`.
- Wave 1 scoped executor/reviewer/critic/simplifier/scout reports and wave 2/3 verifier/adjudicator reports are included in `a391132`; no wave output silently omitted.

## Before → after measurements
- Counting command: `python3 -c "from pathlib import Path; print(sorted(p.stem for p in Path('.shokunin/audio/corpus/artifacts').glob('*.wav')))"`. Before `31d8e9e`: one per UI, impact, movement, ambience (four SFX) plus one stem. At `a391132`: two per SFX category (eight SFX), plus unchanged stem; original five SHA-256s remain identical to before (`r2-verifier.md`).
- Nine fixture failure lists empty in `.shokunin/audio/corpus/live/runs/20261012T161825061249Z-normal/measurements.json` at `a391132`. Measured variant duration delta/centroid relative delta: UI .040 s/47.19%; impact 0/95.63%; movement .120 s/.75%; ambience 0/58.45%. Each passes >=.020 s duration OR >=10% centroid; ambience endpoint delta .001892 <.03. The broken ambience control fails seam and centroid, and restore passes.
- Axis verdicts (`r2-adjudicator.md`): **coverage improved**, **depth unchanged**, **calibration improved narrowly** by clarifying the duration threshold before integration. None harmed. Round admitted; no scalar rating. Whole-waveform centroid and endpoint jump are limited numeric proxies, not proof of audible differences, seamless playback or production quality. Duplicate-base control was not executed. Current ffprobe query does not directly verify bit depth.

## SHONEN
- [x] Decision tables/error patterns/checklists with cited sources: named `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end domain task executed and logged: named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [ ] Instructions executable without oral context: not independently verified for promotion.
- [ ] No cross-domain bleed and accurate province: not independently verified for promotion.

Only `.shokunin/audio/**` and `.shokunin/reports/**` were written. No publishing, sample-rights clearance, push or merge. `MANIFEST.json` was not edited because it is outside the brief's allowed write paths.
