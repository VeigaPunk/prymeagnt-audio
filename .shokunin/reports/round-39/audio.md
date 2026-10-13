# Audio round 39 — calibration: equal-duration ambience baseline orientation

Work commit `91e50c9ff7dd82f81aa9f31c2f19855361d39a62` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** that work commit. Named non-author `.shokunin/audio/reports/round-39/r39-verifier.md`; Sol `.shokunin/audio/reports/round-39/r39-adjudicator.md`.

## Work and selection
- Declared one calibration move before eight Luna LEAF lanes from clean-before `03fc02d386328742e6f7ae727d1c18d08c4a0b48` in `.shokunin/audio/LOG.md`; reports `r39-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `91e50c9ff7dd82f81aa9f31c2f19855361d39a62`. Selected independent alt's original equal-amplitude `.22` 108/114 Hz pair, each 2.0 seconds. Executor independently found a valid but less level-matched pair; critic first sampled an overwritten transient executor variant (forward .475587818471419 / reverse .3223039744012571) and then remeasured the SHA-pinned valid pair. The transient is a **numeric failed fit**, not evidence of stable candidate failure. Other numeric misses: alt 55/60 Hz and 65/75 Hz both orientations > .10; executor .085 variant both < .10 and .4 variant both > .10. Executor wrapper exit127 with no measurement and initial helper path exit1, plus scribe's helper path exit1, are **setup errors**, separate from numeric fits and gate results.
- Added deterministic source generation of `orientation_low.wav` and `orientation_high.wav` to one Round39 scratch directory. Two opt-in `--probe-ambience-orientation-forward`/`--probe-ambience-orientation-reverse` modes measure the **same exact two WAVs** with swapped `ambience_orientation` baseline and `ambience_orientation_alt` variant roles, using local `(2.0, 5, 200, True)` specs and unchanged generic `_alt` logic. No canonical WAV, `SPECS`, threshold, explicit family comparison or engine/game/lore change. The selected scratch WAV hashes are low `7f4cdfefa6e52a8ff44268396b5c09ea459a648a5ac4cad0f42722fe5fc29938` and high `24203978fe84384db6686e8cf065e1f06f2eb966e88e92578f5da1bb9c5b9482`.

## Before → after measurements
- Before `03fc02d`: looping ambience controls checked below/above centroid but did **not** reverse baseline for the same pair. After `91e50c9ff7dd82f81aa9f31c2f19855361d39a62`, named non-author forward command `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ambience-orientation-forward` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T044308048763Z-ambience-orientation-forward/measurements.json`: 17 canonical + 2 scratch, both 96,000 frames/2.0 s/48 kHz mono PCM16, ordinary and seam checks pass, low centroid `125.06515861511004 Hz` / high `138.2410529357038 Hz`, duration delta `0.0 s`, low-baseline relative centroid delta **`0.10535223771748284`** (`>.10`), generic `_alt` passes, failures empty. Reverse `--probe-ambience-orientation-reverse` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T044309164400Z-ambience-orientation-reverse/measurements.json`: same bytes/hashes and centroids swapped, zero duration delta, high-baseline relative **`0.09531100957920152`** (`<.10`), sole failure `ambience_orientation_alt: distinctness: duration < .020 s and centroid delta < 10%`. Integrated receipt floats are authoritative; independent scratch floats vary in last digits.
- `r39-verifier.md` at `91e50c9ff7dd82f81aa9f31c2f19855361d39a62` lists **38 serial commands/exits/receipts**: 15 exit0 / 23 expected fixture-validation exit1, no corrected-run setup errors. Prior36 subset (#1 plus #4–#38) remains 14 exit0/22 expected exit1. Old17 SHA and metrics, five generic `_alt` and four explicit family groups, thresholds/sections, eight invalid statuses and normal #1/#38 restoration held. Author `py_compile`/`git diff --check` passed. Work commit includes scoped source/LOG/SCORECARD, selected plus reported candidate scratch, author/non-author receipts, eight lane reports, named verifier and Sol. Replay-generated untracked Round27 WAVs were byte-matched to committed copies and removed. No push, merge, publish or rights clearance.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing centroid measurement and generic OR predicate, no new measurement dimension. |
| coverage | unchanged | Canonical corpus remains 17 WAVs; opt-in scratch modes are not canonical expansion. |
| calibration | **improved locally** | Same equal-duration pair flips outcome solely by baseline-relative centroid denominator under independent replay. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish exact-boundary or universal cutoff behavior, perceptual or spectral similarity, audible seamlessness, asset quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
