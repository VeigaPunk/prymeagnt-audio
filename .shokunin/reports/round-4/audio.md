# Audio round 4 — coverage: second soundtrack loop with measured sections

Work commit `ff0f9fc` by `audio-shokunin <audio@shokunin.local>`; named non-author evidence `.shokunin/audio/reports/round-4/r4-verifier-replay.md`, hard review `r4-adjudicator.md` (in work commit). Final report written afterward.

## Work performed
- Declared one coverage move before wave dispatch in `.shokunin/audio/LOG.md` at `ff0f9fc`. Eight Luna wave-1 scoped reports (`audio/reports/round-4/r4-{composer,motif,loop,critic,structure,failure,simplifier,scribe}.md`) and scratch WAVs cite source and limits.
- Synthesized new original mono PCM16/48k `audio/corpus/artifacts/stem_sections.wav`, 4 s, shared analytic 220/330 Hz terms plus 30 Hz component with changing amplitude across exact 2 s halves. Source `.shokunin/audio/corpus/fixtures/build_artifacts.py` and worker `r4-composer.md` at `ff0f9fc`.
- Extended existing decoded-PCM battery `.shokunin/audio/corpus/fixtures/measure_audio.py` and knowledge decision table at `ff0f9fc`: measure 30 Hz component amplitudes and 6 dB signed energy contrast, nonzero amplitude/RMS floors, old endpoint/slope and category checks; `--probe-flat` isolates a matched constant-30-Hz control.
- Initial `r4-verifier` did not produce a report or receipt despite steering and was removed; this is a failed lane. Replacement `r4-verifier-replay` independently ran normal/flat/slope/old-failing/restore exits **0/1/1/1/0** with durable receipts and hash checks. Sol `r4-adjudicator` reviewed raw receipts; neither failed lane nor worker's mismatched 440 Hz `flat_probe.wav` counted as a pass. LOG records full context.

## Landed changes
- `ff0f9fc`: fixture/source/decision table, matched flat30 control, scoped reports/receipts, LOG closure and SCORECARD. This final report lands in the subsequent report-only commit.

## Before → after measurements
- Before `68a3c3c`: eight SFX and one 2 s soundtrack stem (nine WAVs). After `ff0f9fc`: same eight SFX and original stem plus a new 4 s two-section soundtrack loop (ten WAVs). Counting command: `python3 -c "from pathlib import Path; print(sorted(p.stem for p in Path('.shokunin/audio/corpus/artifacts').glob('*.wav')))"`. All nine original SHA-256s match before (`r4-verifier-replay.md`); new builder WAV matches composer scratch hash `49ca24fb325c372c370db07c6ce182865b7fe84abe56037e5a1c8bd3196e6702`.
- Decoded section-1/2 30 Hz peak amplitudes .0119994651/.0599980712 FS yield **13.979508 dB** energy contrast >=6 dB. New loop endpoint .00427246 <.03 and slope .000152588 <.001 FS/sample; all ten pass in `audio/corpus/live/runs/20261012T164320494590Z-normal/measurements.json`. Matched flat30 probe yields nonzero equal amplitudes .0359986155 FS, 0 dB and **only** section failure (`20261012T164318673149Z-flat`). Existing slope and broken-amplitude controls still fail as intended (`164319311023Z-slope`, `164319899564Z-failing`). Four SFX distinctness checks pass.
- Per-axis (`r4-adjudicator.md`): **coverage improved narrowly**, **depth unchanged**, **calibration unchanged**, none harmed. Admit; no scalar score. This establishes analytic section-component contrast, **not** musical motif identity, perceptual development, audible quality, engine adaptation, codec seams or rights clearance. The 440 Hz worker flat probe was failed-fit telemetry.

## SHONEN
- [x] Decision tables/error patterns/checklists with cited sources: `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end domain task executed/logged: `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Fixture workflow executable without oral context: `r3-adjudicator`/`r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [ ] No cross-domain bleed/accurate broad province: still open; no promotion claimed.

Only `.shokunin/audio/**` and `.shokunin/reports/**` written. `MANIFEST.json` outside allowed scope; no push or merge.
