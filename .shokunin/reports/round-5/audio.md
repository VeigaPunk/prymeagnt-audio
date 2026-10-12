# Audio round 5 — calibration disclosure and threshold audit

Work commit `2db3466` by `audio-shokunin <audio@shokunin.local>`; non-author replay `.shokunin/audio/reports/round-5/r5-verifier.md`; Sol per-axis review `r5-adjudicator.md`. This final report is written after work commit.

## Work performed
- Declared one calibration move before wave dispatch in `.shokunin/audio/LOG.md` at `2db3466`; eight disjoint Luna reports `audio/reports/round-5/r5-{thresholds,distribution,controls,loudness,critic,coverage,simplifier,scribe}.md` inventoried rules, observed values, controls and uncertainty.
- Wrote one consolidated `.shokunin/audio/corpus/knowledge/2026-10-12-threshold-calibration.md` at `2db3466`: every enforced threshold's exact inequality, eligible fixture subset, observed ten-clean range/nearest arithmetic margin, named control or “not exercised,” local rationale and limitation. FFmpeg ebur128 nulls are reported but no LUFS acceptance window exists. No thresholds or canonical WAVs were edited.
- Non-author `r5-verifier` replayed normal/flat/slope/broken-amplitude/restore (`python3 .shokunin/audio/corpus/fixtures/measure_audio.py` with respective flags; exits **0/1/1/1/0**). Receipts in `audio/corpus/live/runs/20261012T{165559423568Z-normal,165600065823Z-flat,165600690434Z-slope,165601269726Z-failing,165601852330Z-normal}/measurements.json` at `2db3466`. It recomputed table figures and compared ten canonical hashes to `358f625`. Sol `r5-adjudicator` checked exact polarity and found the section-count malformed-input caveat, which the table states.

## Landed changes
- `2db3466`: LOG/SCORECARD, consolidated calibration table and all scoped reports/receipts; the round-5 LOG closure links them. This report lands separately and last.

## Before → after measurements
- Before `358f625`: local bounds described across existing fixture notes, with RMS prose `>.001` but code accepting **`>=.001`**; receipt key `rms_min_exclusive` remains misleading. After `2db3466`: one table states code polarity and mismatch, plus ten clean fixture ranges (peak .172363–.808777 FS; RMS .064715–.180272 FS; four loop endpoint .000671–.011383 FS; slope 0–.000152588 FS/sample), nearest arithmetic margins and exact control isolation. Six SFX LUFS are null; four finite values −30.7/−24.7/−15.8/−24.7 LUFS are descriptive, **not** an acceptance window. Counting command for unchanged ten assets: `python3 -c "from pathlib import Path; print(sorted(p.stem for p in Path('.shokunin/audio/corpus/artifacts').glob('*.wav')))"`; verifier reports ten unchanged hashes and all four SFX OR checks passing.
- Flat30 control isolates contrast at 0 dB; slope control isolates .4699707 FS/sample gap despite equal endpoints; broken ambience trips centroid **and** endpoint and isolates neither. Wrong-format, duration, peak/RMS edge, centroid edge, distinctness boundary, section floor and malformed-count failures remain unexercised. `section_contrast()` may raise before producing JSON on odd/very short input; only exact count is required for a pass. Ten constructed fixtures do not form a production distribution.
- Per-axis (`r5-adjudicator.md`): **calibration improved narrowly in disclosure/auditability only**, **depth unchanged**, **coverage unchanged**, none harmed. Admit; no scalar score, numeric bounds not empirically tuned or validated for audibility/mastering.

## SHONEN
- [x] Decision tables/error patterns/checklists with citations: `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end domain task executed: `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Fixture instructions executable without oral context: `r3-adjudicator`/`r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [ ] Whole-lane no-cross-domain-bleed/province accuracy: bounded round-5 review is not a full historical promotion review; remains open.

Only `.shokunin/audio/**` and `.shokunin/reports/**` written. No MANIFEST edit, push or merge.
