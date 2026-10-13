# Audio round 36 — coverage: third analytic looping ambience fixture

Work commit `67b2d2dc16726e6908beafee677b0231797c9c50` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-36/r36-verifier.md`; Sol `.shokunin/audio/reports/round-36/r36-adjudicator.md`.

## Work performed
- Declared one coverage move before eight Luna LEAF lanes from clean-before `1fdccc41e936772150fae74131bda1a1ef7e3520` in `.shokunin/audio/LOG.md`. Reports `r36-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `67b2d2dc16726e6908beafee677b0231797c9c50` map the old loop family, independent fits and numeric-proxy limits. Executor's first relative-path project-helper attempt exited1, corrected exit0; no candidate-fit failure. The verifier's first 34 misquoted wrapper attempts exited127 and produced **no receipts**; they are disclosed setup errors and excluded from gate evidence, followed by a corrected serial 34-run replay.
- Selected alt's original deterministic two-tone .20*90 Hz + .025*130 Hz two-second analytic loop; added builder save, `SPECS["ambience_third"]=(2.0,5,200,True)` and separate `ambience_family_comparisons` against `ambience` and `ambience_alt`. Generic `_alt` loop, `.020 s OR .10` cutoffs and sixteen pre-existing canonical WAVs unchanged.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, source/spec, canonical `ambience_third.wav`, selected/alternate scratch, author/non-author receipts, eight wave-one reports plus named verifier and Sol at `67b2d2dc16726e6908beafee677b0231797c9c50`. Replay-generated untracked round-27 WAVs were byte-matched to committed copies and removed. One initial `git add` pathspec for nonexistent `20261013T040*` failed exit128; corrected scoped `git add` and `git diff --cached --check` exited0 before the work commit. This report is committed separately, last. No push, merge, publish, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `1fdccc4`: 16 canonical WAVs, two 2.0-second ambience fixtures. After `67b2d2dc16726e6908beafee677b0231797c9c50`, named non-author normal `python3 .shokunin/audio/corpus/fixtures/measure_audio.py` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T035441105253Z-normal/measurements.json`: **17** canonical measurement entries. New `ambience_third`: 96,000 frames, exactly `2.0 s`, 48 kHz mono PCM16, peak `0.225006103515625` FS, RMS `-16.92261930553234 dBFS`, centroid `112.03210352691181 Hz`, loop endpoint delta `0.002777099609375` FS and slope mismatch `0.0` FS/sample, ordinary failures `[]`, SHA-256 `c2c8e0bb2385bc93b39c70b719d0f56553c771969986ef1f732d24af5677d404`; exact selected alt scratch hash.
- `ambience`→third: duration delta **`0.0 s`**, baseline-relative centroid delta `2.059614818322321`; `ambience_alt`→third: **`0.0 s`** / `.9309488765840295`. Both explicit comparisons pass **centroid alone**; duration arms are false. Five generic `_alt`, two UI, two impact and two movement family records unchanged. The critic showed a same-duration changed-line-spectrum pair whose centroid delta falls below the gate; this limits interpretation, not the passing candidate.
- `r36-verifier.md` at `67b2d2dc16726e6908beafee677b0231797c9c50` enumerates **34 corrected serial runner commands, exits and receipts** (13 exit0, 21 expected exit1, zero corrected-run setup errors). Prior33 (#1–#33) retained, eight invalid statuses and sixteen old canonical hashes/metrics held, thresholds unchanged, normals #1/#30/#31/#32/#33/#34 restored equal excluding receipt paths.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Same measured checks, no new dimension or audition. |
| coverage | **improved narrowly** | One additional original analytic looping ambience point, 16→17. |
| calibration | unchanged | Existing thresholds/limits unchanged, no numeric boundary calibration. |

Admitted: one improved axis, zero demonstrated scoped harm. No audible seamlessness, perceived distinction, full-spectrum novelty, subjective quality, production suitability, rights, engine or publication claim.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
