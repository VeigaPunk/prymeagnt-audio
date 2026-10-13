# Audio round 26 — depth: exact duplicate variant negative

Work commit `826010cfd3dfcda550d86bc3c6771155d0f4ce96` by `audio-shokunin <audio@shokunin.local>`. Final report written **after** the work commit. Named non-author `.shokunin/audio/reports/round-26/r26-verifier.md`; Sol per-axis judgment `.shokunin/audio/reports/round-26/r26-adjudicator.md`.

## Work performed
- Declared the single depth move and before-state `7c3241dd98709aa250f100612cbecd6e21568d9c` in `.shokunin/audio/LOG.md` before eight Luna leaf dispatches. Eight disjoint reports under `.shokunin/audio/reports/round-26/r26-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `826010cfd3dfcda550d86bc3c6771155d0f4ce96` map suffix lookup, direct candidate fit, confounds, source review and baseline hashes.
- Added one opt-in `--probe-ui-clone` route in `.shokunin/audio/corpus/fixtures/{build_artifacts,measure_audio}.py` at `826010cfd3dfcda550d86bc3c6771155d0f4ce96`. It synthesizes two original byte-identical, 0.12 s, 48 kHz mono PCM16 UI scratch WAVs, measures each using existing `SPECS["ui"]`, and applies the unchanged `>= .020 s OR >= .10` distinctness predicate. It does not add a canonical asset, new gate, threshold, or arbitrary duplicate-detection subsystem.
- Named non-author `r26-verifier` serially ran twenty modes; commands/exits/receipts in its report at `826010cfd3dfcda550d86bc3c6771155d0f4ce96`. New clone mode exit **1** is measured rejection, with no setup errors or runner exit 2. Existing nineteen executions preserve prior outcomes, eight invalid records and normal restoration.

## Landed changes
- Audio-only LOG/SCORECARD, builder/runner opt-in branch, generated scratch and candidate scripts, twenty author/verifier receipt directories, ten role/verifier/Sol reports in `826010cfd3dfcda550d86bc3c6771155d0f4ce96`. `git diff 7c3241dd98709aa250f100612cbecd6e21568d9c 826010cfd3dfcda550d86bc3c6771155d0f4ce96 -- .shokunin/audio/corpus/artifacts/` is empty. Final report is this separate report-last commit. No push, merge, publishing, rights clearance, engine/game/narrative change.

## Before → after measurements
- Before `7c3241d`: five `_alt` canonical comparisons passed, no matched exact-duplicate negative. After `826010cfd3dfcda550d86bc3c6771155d0f4ce96`, independent `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-clone` exit **1** receipt `.shokunin/audio/corpus/live/runs/20261013T015341619139Z-ui-clone/measurements.json`: `ui_clone` and `ui_clone_alt` have identical SHA-256 `57b3061d6a1b3ea7d94dcf4ea9c1bf6638d22e5284adaff37d3caf3d07b59ce1`, duration `.12` s, centroid `971.86422306315` Hz, ordinary UI check failures `[]`; recorded baseline `ui_clone`, duration delta `0`, relative centroid delta `0`, `passed: false`; **only** variant failure `distinctness: duration < .020 s and centroid delta < 10%`. Counting/measurement command and exit from non-author `r26-verifier.md` at `826010cfd3dfcda550d86bc3c6771155d0f4ce96`.
- Verifier's twenty-mode exits `[0,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0]` in its table, including clone insertion; prior nineteen outcomes retained. All thirteen canonical byte hashes match before, five existing `_alt` variants pass, eight invalid records unchanged, thresholds unchanged; first/restored normal JSON equal excluding paths. This is exact numerical duplicate negative at **zero/zero**, not edge behavior at `.020/.10` or auditory similarity.

## Axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | **improved narrowly** | Existing distinctness rule now has a matched duplicate negative, independently replayed. |
| coverage | **unchanged** | Noncanonical scratch, no playable asset/category addition. |
| calibration | **unchanged** | OR thresholds unchanged; no numeric edge or perception study. |

Admitted: >=1 improved, zero demonstrated scoped harm. No perceptual deduplication, universal codec/production/engine/rights or publication claim.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes remain checked, **no promotion**. Next round needs its own declared claim before work.
