# Audio round 45 — calibration: lower-side ordinary UI duration

Work commit `bd60dde2cb56c9f051368e6d780b1907541c69bb` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-45/r45-verifier.md`; Sol `.shokunin/audio/reports/round-45/r45-adjudicator.md`.

## Work and selection
- One calibration move declared at clean-before `4de93bf829f539d77c0ebc4706dfe95903ab2f17` in `.shokunin/audio/LOG.md` before eight Luna LEAF lanes. Wave1 reports `r45-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `bd60dde2cb56c9f051368e6d780b1907541c69bb`. R44 bracketed the positive side of ordinary UI `abs(ffprobe_duration-.12) > .001s`; this round tests the negative side, distinct from R27 pairwise `.020s` rule.
- Selected executor original 48k mono PCM16 pair: 5713 frames SHA `94f1ad9459fbfc06120668e3ebe5743a2d8690c66238d586f05006102811dd99`, 5711 SHA `2b4b0323f040a65b431a984e4fde5866f5c412754206c928e1fa21358adb9ab8`. For N in (5713,5711), t=`arange(N)/48000`, samples=`.28*sin(2*pi*(700*t+700*t*t))*exp(-5*t)`, quantize rounded clipped ×32767 to little-endian PCM16, write mono 48k WAV. Integrated source-generated files have the same SHA pair. Independent alt original WAVs (`745bb3dffb2cce371765e9abbe45613266a1e32c9489fe7af5c6dcda15c01620` / `e23080bce71c97780b0760f413926decf9925fa76e9c11bdf39ea7be39e4818e`) independently produce the same duration-only polarity but are not integrated. Only opt-in `--probe-ui-lower-tolerance-5713/5711` builder/runner modes added; canonical UI spec, comparator and prior gates unchanged. No engine/game/lore, push, merge, publication or rights edits.
- Ideal signed frame offsets −47/48000 and −49/48000 differ from actual ffprobe-decimal parsed float deltas. Executor's first report draft **transcribed four signed/absolute cells using R44's positive-side float magnitudes**. Parent corrected those four text cells from unchanged `.119021/.118979` ffprobe values before integration, documenting the transcription error separately from numerical fit and setup. Critic's disposable **5712** reports `.119000`; Python parsed `abs(.119-.12)=.0010000000000000009` and **fails** strict `>.001`. It was not integrated; no exact equality proof/pass.

## Before → after, fresh independent replay
- Fresh non-author #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-lower-tolerance-5713` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T063748725989Z-ui-lower-tolerance-5713/measurements.json`: 17 canonical + scratch, ffprobe `.119021s`, actual parsed signed `-.0009789999999999938s`, abs `.0009789999999999938s` (<.001); peak `.27947998046875` (<.95), RMS `-16.399347369151716dBFS` (> .001 FS), centroid `1663.1001045998237Hz` in UI 250–4000Hz, no failures.
- Fresh #3 `--probe-ui-lower-tolerance-5711` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T063749795923Z-ui-lower-tolerance-5711/measurements.json`: ffprobe `.118979s`, parsed signed `-.0010209999999999941s`, abs `.0010209999999999941s` (>.001), peak `.27947998046875`, RMS `-16.3992750775437dBFS`, centroid `1627.5978467387597Hz`, **sole `duration: outside ±1 ms`**. Both 48k mono PCM16, level/centroid/format passing.
- `r45-verifier.md` at `bd60dde2cb56c9f051368e6d780b1907541c69bb` records **50 distinct fresh serial commands/exits/receipts**, `20261013T063747`–`063840`, **21 exit0/29 expected fixture-validation exit1**; parent independently checked paths exist/distinct, #2/#3 outcomes, counts, first/final normal JSON equality. Prior48 subset (#1 plus #4–#50) remains 20/28; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses and final normal restore held. `py_compile`/`git diff --check` passed. No replay setup errors or missed final-pair numeric fit; alt helper's initial relative-path exception was setup, not gate. Untracked regenerated R27 scratch WAVs byte-matched committed executor copies and removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing ordinary duration comparator/threshold unchanged. |
| coverage | unchanged | Seventeen canonical WAVs; two opt-in scratch points are not broad coverage. |
| calibration | **improved locally** | Negative-side inside/outside `.001s` ffprobe-derived durations, unrelated checks passing under fresh replay. |

Sol admits one improved axis with zero demonstrated scoped harm. This does **not** establish exact ±1ms equality, other rates/ffprobe versions, perceptual duration, audio quality, production suitability, rights, engine suitability or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. A next round must declare one falsifiable claim before work.
