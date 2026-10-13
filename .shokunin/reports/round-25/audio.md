# Audio round 25 — depth: isolated rate/channel format controls

Work commit: `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4` by `audio-shokunin <audio@shokunin.local>`. Named non-author `.shokunin/audio/reports/round-25/r25-verifier.md` replayed raw artifacts; Sol `.shokunin/audio/reports/round-25/r25-adjudicator.md` judged the axes. This final report was written after the work commit.

## Work performed
- Declared one depth claim and eight Luna leaf scopes in `.shokunin/audio/LOG.md` at `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4` before dispatch. Eight disjoint reports under `.shokunin/audio/reports/round-25/r25-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` record candidate source synthesis, metadata, numeric fits, confounds and commands/exits.
- Generated original four-second 440 Hz PCM16 scratch `stereo48_probe.wav` (48k, two channels) and `mono441_probe.wav` (44.1k, one channel) by opt-in `--probe-invalid` in `.shokunin/audio/corpus/fixtures/build_artifacts.py`; added two named records to existing invalid control route in `measure_audio.py`. Existing `format_failures()` and all numeric thresholds are untouched. These are not canonical content or a new acceptance predicate.
- Non-author verifier serially replayed 19 runner invocations; exact commands/exits, receipt paths and SHA-256s at `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4` in `r25-verifier.md`. Initial 19 malformed shell-wrapper exits 127 made no receipts and are excluded. Successful vector `[0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0]` with no runner setup exit 2.

## Landed changes
- `.shokunin/audio/LOG.md`, `SCORECARD.md`, source builder/runner, generated scratch and candidate scripts, author+verifier receipts and ten round-25 role/verifier/Sol reports in `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4`. `git diff 30530e17a4f20ba28d7f81cda41c8949f4652697 bcfa81ef4e510247e97d088cbc8faf626b3c4cf4 -- .shokunin/audio/corpus/artifacts/` is empty; no canonical WAV changed. This separate final report cites the preceding work commit and lands last. No push/merge/publishing, rights clearance or engine mutation.

## Before → after measurements
- Before `30530e17a4f20ba28d7f81cda41c8949f4652697`: one `wrong_format` control had 44.1k **and** stereo PCM16, co-violating rate and channels. After `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4`: non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-invalid` exit **1 expected**, receipt `.shokunin/audio/corpus/live/runs/20261013T014025494866Z-invalid/measurements.json` has eight records (six old unchanged plus stereo48 and mono441 expected-format failures). Against existing native16 positive 48k mono PCM16, stereo48 changes only channels; mono441 changes only rate. Both 4.0 s PCM16, and `r25-verifier.md`'s direct `measure()` commands with `(4.0,100,1000,False)` exited **0** and returned **only** `format: expected 48kHz mono` for each. The checker flattens stereo decoded samples, so centroid 563.262 Hz and sample-count semantics are not mono acoustic equivalence. The claim is metadata-predicate isolation for these synthetic controls only.
- All 13 canonical byte hashes match before commit; five `_alt` distinctness records pass; old 19 mode exits/failure kinds and threshold objects held; first/restored normal equal excluding measurement path. Counting and measurement commands and actual outputs in `r25-verifier.md` at `bcfa81ef4e510247e97d088cbc8faf626b3c4cf4`. Regeneration preserved the new stereo48 hash `1a71090267d97dc07c14f4a057e2b14a433b45086a424cb99128f55831328987` and mono441 hash `1bd9aac91baecffb03cb667c7e4116806eb149aa1c39b5cc787e1b861c965e69`.

## Axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | **improved narrowly** | Separate existing rate/channel format rejections with two source-generated controls. |
| coverage | **unchanged** | No new codec/asset category or canonical audio. |
| calibration | **unchanged** | Same predicate/thresholds; numeric fit only excludes other failures under stated custom spec. |

Admitted: >=1 improved, zero demonstrated scoped harm. No universal WAV handling, perceptual quality, mastering, production, rights, engine or publishing claim.

## SHONEN
- [x] Cited decision tables/checklists — `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end fixture task — `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — `r3-adjudicator`/`r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

SHONEN boxes remain checked; **no rank/promotion change**. A subsequent round needs a new one-axis claim and before-state.
