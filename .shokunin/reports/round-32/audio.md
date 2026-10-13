# Audio round 32 — depth: mixed duration-below / centroid-above pass

Work commit `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-32/r32-verifier.md`; Sol `.shokunin/audio/reports/round-32/r32-adjudicator.md`.

## Work performed
- Declared one depth move and clean before-state `ae9c941aeda44b29718ab97edb252ef1ed12e637` in `.shokunin/audio/LOG.md` before eight Luna leaf lanes. Eight reports `r32-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643` include direct candidate fits, confounds, prospective review and historical guard. Executor coefficient attempts k=1.0855/.09/.10 failed the requested centroid arm; a relative-path helper mistake was setup-only. Neither is counted as runner evidence.
- Selected original k=1.14 source-generated chirp on 6,719 frames against k=1 baseline on 5,760 frames, then added one opt-in `--probe-ui-mixed-pass` builder/runner path at `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643`. Baseline measures against unchanged canonical `SPECS["ui"]`; longer alternate measures against a separately declared scratch expected duration `6719/48000` while retaining the same UI band/format/level checks. The alternate **does not** meet canonical `.120 s ±.001 s` UI duration. Existing `.020 s OR .10` distinctness rule and thresholds unchanged.

## Landed changes
- Scoped `.shokunin/audio/**` LOG/SCORECARD, opt-in builder/runner, original scratch/scripts and author/non-author receipts, ten wave/verifier/Sol reports at `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643`. Four replay-generated untracked round-27 WAVs were byte-matched to committed executor WAVs then removed. Final report is separate report-last commit. No push, merge, publication, rights clearance or engine/game/lore mutation.

## Before → after measurements
- Before `ae9c941`: round-31 joint nonzero-below negative, separate one-arm positives, but no integrated joint duration-below/centroid-above positive. After `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643`, non-author `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-mixed-pass` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T030246117183Z-ui-mixed-pass/measurements.json`: baseline 5,760 frames `.120000 s`, centroid `966.8966593379727 Hz`; alternate 6,719 frames `.139979 s`, centroid `1069.352782328027 Hz`. Actual ffprobe-float duration delta **`0.019978999999999997`** (nonzero, `<.020`); centroid-relative delta **`0.1059638814557548`** (nonzero, `>=.10`); duration arm false, centroid arm true, `passed:true`, no failures under declared specs.
- `r32-verifier.md` at `9d4b2ee7fcff7b610d31f3f355c34f6d527b2643` lists corrected **30 serial runner commands/exits/receipts** (9 exit0, 21 expected exit1, no runner exit2); prior29 subset (#1 and #3–#30), eight invalid statuses, thirteen canonical hashes, five existing variants, thresholds and normal restoration held. First **30 exit-2 mistyped-script-path setup attempts produced no receipts**, excluded from runner evidence.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | **improved narrowly** | One measured mixed-input pair passes unchanged OR only via centroid arm. |
| coverage | unchanged | Opt-in scratch only; no canonical asset/category. |
| calibration | unchanged | Existing bounds/spec and OR unchanged; no equality/retune. |

Admitted: one improved axis, zero demonstrated scoped harm. Both sample support and phase changed; no causal independence, general OR proof, perception, production, codec, rights or engine claim.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes remain checked; **no promotion**. Next round must declare its own claim before work.
