# Audio round 38 — calibration: equal-duration ambience positive

Work commit `b6e23b39b67e4e31a28f7156e948e330bb2ecaf8` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-38/r38-verifier.md`; Sol `.shokunin/audio/reports/round-38/r38-adjudicator.md`.

## Work performed
- Declared one calibration move before eight Luna LEAF lanes from clean-before `c713fb62a195da947cc3f06e6b0f3a101afd0f23` in `.shokunin/audio/LOG.md`. Reports `r38-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `b6e23b39b67e4e31a28f7156e948e330bb2ecaf8` distinguish independent fit, exploratory misses and setup. Independent alt first relative-path helper call failed before fit, corrected measurement passed. Executor's initial Round37-like 60/64 Hz pair measured `.0658556` (below new target); single-tone and multi-tone sweeps missed the strict `>.10, <.13` target until the selected alternative `.1264765508`; a `.070` added-tone variant measured `.14123783252085534` above the preferred interval. These are **numeric failed fits**, not setup or runner outcomes. One verifier shell wrapper typo exited127 before replay/no receipt, excluded.
- Selected independent alt's original deterministic .22-amplitude 65 Hz baseline and 75 Hz variant, each 2.0 s; added one `--probe-ambience-centroid-above` builder/runner mode with local `(2.0,5,200,True)` scratch specs and unchanged generic `_alt` comparison. No canonical WAV, `SPECS`, threshold or explicit family record changed.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in source, selected alt scratch, retained executor generator/selected fit/explicit miss/representative tones, author/non-author receipts, eight wave-one reports plus named verifier and Sol at `b6e23b39b67e4e31a28f7156e948e330bb2ecaf8`. Parent removed 188 unselected exploratory executor WAVs (~36 MB) before commit; their numeric attempt reports remain, but deleted scratch is not claimed as retained gate evidence. Replay-generated untracked round-27 WAVs were byte-matched to committed copies and removed. `git diff --cached --check` exited0 before the work commit. This report is committed separately, last. No push, merge, publish, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `c713fb6`: Round37 equal-duration negative at centroid-relative `.06585562259644766`, no integrated above-.10 equal-duration ambience positive. After `b6e23b39b67e4e31a28f7156e948e330bb2ecaf8`, named non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ambience-centroid-above` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T042524821658Z-ambience-centroid-above/measurements.json`: **17 canonical + 2 scratch**. Both scratch loops have 96,000 frames/`2.0 s`, 48 kHz mono PCM16, ordinary and seam checks pass. Baseline centroid `91.03372963003302 Hz`, variant `81.6243985667145 Hz`, measured duration delta **`0.0 s`**, baseline-relative centroid delta **`0.10336093117966988`** (`>.10`, `<.13`), generic `_alt` `passed:true` by centroid alone, failures empty. WAV SHA baseline `04d8d334553ecb0c155a4be37397edda8f01cfbe992df4bd2e9b3e474d1189e0`, variant `7bd6ae805a6a5ff2c15ba14470ba1d312c40768c97c1704629382ed76292bd77`. Scratch helper's earlier `0.10336093117979261` differs in last digits; the integrated receipt float is authoritative.
- `r38-verifier.md` at `b6e23b39b67e4e31a28f7156e948e330bb2ecaf8` enumerates **36 serial commands/exits/receipts**: 14 exit0, 22 expected exit1, no replay runner setup failures. Prior35 (#1 plus #3–#36) stays 13 exit0/22 expected exit1, eight invalid statuses, 17 old canonical hashes/metrics, five generic `_alt`, four explicit family groups, thresholds/sections and normal #1/#36 restoration held. Prior below control (#3) still exits1 with sole distinctness and `.06585562259644766`.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | No new measurement dimension, full-spectrum comparison or audition. |
| coverage | unchanged | Corpus remains 17 canonical WAVs; scratch positive is not a family expansion. |
| calibration | **improved locally** | Equal-duration clean loop passes at measured `.10336093117966988` beside R37's `.06585562259644766` negative. |

Admitted: one improved axis, zero demonstrated scoped harm. This is not exact-boundary or universal threshold calibration, perceived/spectral novelty or similarity, audible seamlessness, quality, production suitability, rights, engine or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. Any next round must declare one falsifiable claim before work.
