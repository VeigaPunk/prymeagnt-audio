# Audio round 37 — calibration: equal-duration ambience negative

Work commit `da299003eae1912fd459b25708498790f89f17ba` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-37/r37-verifier.md`; Sol `.shokunin/audio/reports/round-37/r37-adjudicator.md`.

## Work performed
- Declared one calibration move before eight Luna LEAF lanes from clean-before `83395d1b4241582463d9d5fbdece619180610372` in `.shokunin/audio/LOG.md`. Reports `r37-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `da299003eae1912fd459b25708498790f89f17ba` map prior controls and two independent scratch fits. Executor's first SciPy import exited1 (dependency unavailable in project shell), corrected stdlib generator/helper exited0. Alt/critic first relative-path helper invocations exited1, corrected absolute paths exited0. Those are setup failures, not numeric fits or gate outcomes; no numeric fit failed.
- Selected executor's original deterministic .22-amplitude 60 Hz and 64 Hz two-second looping scratch WAVs. Added only `--probe-ambience-centroid-below` builder/runner mode with local `(2.0,5,200,True)` specs and `ambience_probe`/`ambience_probe_alt` names routed through unchanged generic `_alt` logic. No canonical WAV, `SPECS`, threshold, existing mode, or explicit family comparison changed.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in source, selected/alternate scratch, author/non-author receipts, eight wave-one reports plus named verifier and Sol at `da299003eae1912fd459b25708498790f89f17ba`. Four replay-generated untracked round-27 WAVs were byte-matched to committed copies and removed. Initial `git add` pathspec for nonexistent `20261013T041*` exited128; corrected scoped add and `git diff --cached --check` exited0 before work commit. This report is committed separately, last. No push, merge, publish, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `83395d1`: 17 canonical WAVs, but no opt-in equal-duration **nonidentical ambience** negative with both OR arms below cutoff and individual seam checks passing. After `da299003eae1912fd459b25708498790f89f17ba`, named non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ambience-centroid-below` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T040857198401Z-ambience-centroid-below/measurements.json`: **17 canonical + 2 scratch** measurements. Both scratch loops have 96,000 frames/`2.0 s`, 48 kHz mono PCM16, ordinary and seam checks pass. Baseline centroid `67.37182625964924 Hz`, variant `71.80863982343814 Hz`, measured duration delta **`0.0 s`**, baseline-relative centroid delta **`0.06585562259644766`** (`0 < delta < .10`), generic `_alt` `passed:false`. Only failure is variant `distinctness: duration < .020 s and centroid delta < 10%`. Scratch SHA baseline `281e9a25191825bd062f854de6f9b85f6a5902200e0cd1027e36a225422a901c`, variant `cd48ad3f1e4020c10225d65904358a1ea1e7f18d28050e858dec9a9b7feed8a9`.
- `r37-verifier.md` at `da299003eae1912fd459b25708498790f89f17ba` enumerates **35 serial commands/exits/receipts**: 13 exit0, 22 expected exit1, no replay setup failures. Prior34 (#1 plus #3–#35) stays 13 exit0/21 expected exit1; eight invalid statuses, 17 old canonical hashes/metrics, generic five `_alt`, four explicit family groups, thresholds/sections, and normal #1/#35 restoration held. No new canonical fixture was added.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | No new measurement dimension, full-spectrum comparison or audition. |
| coverage | unchanged | Corpus remains 17 canonical WAVs; scratch negative is not a family expansion. |
| calibration | **improved locally** | One equal-duration loop pair passes ordinary/seam checks and fails solely on both false numeric OR arms. |

Admitted: one improved axis, zero demonstrated scoped harm. This is not a universal cutoff calibration or a claim of perceived/spectral similarity, audible seamlessness, quality, production suitability, rights, engine or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
