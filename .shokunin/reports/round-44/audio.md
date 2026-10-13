# Audio round 44 — calibration: ordinary UI duration tolerance

Work commit `085d816946251c1bea797d921a717f4379fd52d2` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-44/r44-verifier.md`; Sol `.shokunin/audio/reports/round-44/r44-adjudicator.md`.

## Work and selection
- One calibration move declared at clean-before `8009269ade6fff69c95de3cbde6a2cd653c33dc9` in `.shokunin/audio/LOG.md` before eight Luna LEAF lanes. Wave1 reports `r44-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `085d816946251c1bea797d921a717f4379fd52d2`. This tests ordinary per-file UI duration `abs(ffprobe_duration - .12) > .001 s`, **not** R27's pairwise `.020 s` distinctness rule.
- Executor original 48k mono PCM16 pair: 5807 frames SHA `17890e483de91075569283a2bcfbada6a6402e1cd87ab52da53bdfbc605cf934` and 5809 SHA `c0552b983ecd9230b16d6ac3441eb8be7b43e80130bbd413fb62272752d7d510`. For N in (5807,5809), t=`arange(N)/48000`, samples=`.28*sin(2*pi*(700*t+700*t*t))*exp(-5*t)`, quantize rounded clipped samples ×32767 to little-endian PCM16, write mono 48k WAV. Source-generated files are SHA-identical to executor's pair; independent alt generated a different original SHA pair (`a8da540da39f0a803213401ff6133f2b29cd50eba331c3e044d8d3524c22ecaf`/`c39a25850b638fd842981180e7d996a5a37e2de140fd746afcb3550a50529372`) with same duration-only polarity. Selected executor's pair; alt is corroboration, not the integrated pair. Added only `--probe-ui-tolerance-5807/5809` opt-in builder/runner modes with unchanged `SPECS['ui']`, ordinary comparator and all prior gates. No canonical changes or engine/game/lore, push, merge, publication, rights edits.
- Ideal frame increments 47/48000 `.0009791666666666666 s` and 49/48000 `.0010208333333333334 s`; **actual ffprobe decimals and parsed float deltas govern**. Critic's disposable unintegrated 5808 frames reports `.121000`, parsed `abs(.121-.12)=.0010000000000000009` and **fails** strict `>.001`, so no exact-equality pass/claim. This round brackets two interior measured points, not exact mathematical 1ms semantics.

## Before → after, fresh independent replay
- Named non-author fresh #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-tolerance-5807` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T060508841398Z-ui-tolerance-5807/measurements.json`: 17 canonical + scratch, ffprobe `.120979s`, actual parsed delta `.0009790000000000076s` (inside .001); decoded peak `.27947998046875` (<.95), RMS `-16.431537076901346dBFS` (> .001 FS), centroid `1132.7351495568296Hz` in UI 250–4000Hz, no failures.
- Fresh #3 `--probe-ui-tolerance-5809` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T060509860666Z-ui-tolerance-5809/measurements.json`: ffprobe `.121021s`, parsed delta `.001021000000000008s` (outside .001), peak `.27947998046875`, RMS `-16.432818198672756dBFS`, centroid `936.6642301482127Hz`, sole `duration: outside ±1 ms`. Both 48k mono PCM16; no level, centroid or format failures.
- `r44-verifier.md` at `085d816946251c1bea797d921a717f4379fd52d2` lists **48 distinct fresh serial commands/exits/receipts** dated `20261013T060507`–`060556`, **20 exit0/28 expected fixture-validation exit1**; parent independently verified all paths exist and are distinct, counts, #2/#3 failures, and first/final normal receipt JSON equality. Prior46 subset (#1 plus #4–#48) stays 19/27; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections/eight invalid statuses and final normal restore held. `py_compile` and `git diff --check` passed. No replay setup errors or failed final-pair numeric fits; wave1 scout's malformed shell exit127 and alt/guard relative-path helper exceptions were **setup**, not gate. Untracked R27 regenerated scratch files were byte-matched to prior committed executor copies and removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Existing ordinary comparator and threshold remain. |
| coverage | unchanged | Seventeen canonical WAVs; two scratch points do not establish broad coverage. |
| calibration | **improved locally** | Inside/outside `.001s` ffprobe-derived UI durations, with unrelated checks passing and fresh replay. |

Sol admits one improved axis with zero demonstrated scoped harm. It does **not** establish exactly-1ms equality, other rates/ffprobe versions, perceptual duration, audio quality, production fitness, rights, engine fitness, or publication.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. A next round must declare one falsifiable claim before work.
