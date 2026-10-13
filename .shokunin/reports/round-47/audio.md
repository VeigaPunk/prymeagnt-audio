# Audio round 47 — calibration: ordinary UI centroid upper bound

Work commit `290b18c9d9716b649e08f0e06fe125efc25a326d` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-47/r47-verifier.md`; Sol `.shokunin/audio/reports/round-47/r47-adjudicator.md`.

## Work and selection
- One calibration move declared at clean-before `90c4aea8fe2c7ac4958d78b3d90c1206e6dc6004` in `.shokunin/audio/LOG.md` before eight Luna LEAF lanes. Reports `r47-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `290b18c9d9716b649e08f0e06fe125efc25a326d`. This tests ordinary absolute UI `250 <= centroid <= 4000` upper bound, separate from R46's lower250 and pairwise relative distinctness.
- Selected executor's original .12s/5760-frame 48k mono PCM16 pair: SHA below `b04d00164fc57a97a0cdd591a589a44792d0084ba66cdc2118989183ae22fc17`, above `8f6dd0411d240e46ea619c32e3c344b8c03491d860ebc6ab32b248cbd51e4383`. For nominal frequency f=3983 or 3984Hz, `t=arange(5760)/48000`, `x=.28*sin(2*pi*f*t)*hanning(5760)`, round clipped ×32767 to little-endian PCM16, mono 48k WAV. Integrated generated WAV SHA matches executor. **Nominal oscillator frequency is not measured centroid**: project SoX-f32 whole-wave magnitude-FFT centroids are **3999.922795974407/4000.427101452783Hz**. Independent alt original pair uses different SHA (`20668f7a9bd167479e185ac3ad9ec13b36380719cfcf6506775f6bc63294e69d` / `61e69e3041ff76db1d5b67a892b3b4723d2296ea51235511fc2de8edf6f41cfb`) and measures 3998.2575908677754/4000.5907358489767Hz, same polarity but not integrated. Only opt-in `--probe-ui-upper-centroid-below/above` builder/runner modes added; ordinary comparator, `SPECS`, thresholds/canonical WAVs unchanged.
- Executor initial nominal3950/4050 decoded3967.0910519284344/4066.3960394571586Hz and nominal3980/4020 decoded3996.0324472283264/4035.6751535337717Hz: both pairs were **valid but broader brackets**, not failed numeric fits. Wave1 helper relative-path errors were setup, not gate; executor's redundant absolute path correction was report text, not fixture outcome. No final pair numeric failed fit. A different oscillator frequency alters samples and full FFT; the result is **gate-level isolation, not causal single-variable spectral isolation**.

## Before → after, fresh independent replay
- Fresh non-author #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-upper-centroid-below` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T071531697506Z-ui-upper-centroid-below/measurements.json`: 17 canonical + scratch, decoded centroid **3999.922795974407Hz** (inside), peak `.279754638671875` (<.95), RMS `-18.327854015660773dBFS` (> .001 FS), .12s/48k mono PCM16, no failures.
- Fresh #3 `--probe-ui-upper-centroid-above` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T071532741662Z-ui-upper-centroid-above/measurements.json`: decoded centroid **4000.427101452783Hz** (>4000), peak `.2789306640625`, RMS `-18.32785200392649dBFS`, same duration/format, **sole `spectrum: centroid outside fixture band`**. No exact4000Hz equality fixture was measured; source comparator inclusivity is not proof of an equality run.
- `r47-verifier.md` at `290b18c9d9716b649e08f0e06fe125efc25a326d` lists **54 distinct fresh serial commands/exits/receipts**, `20261013T071530`–`071626`, **23 exit0/31 expected fixture-validation exit1**; parent independently checked paths exist/distinct, #2/#3 outcomes, counts, first/final normal JSON equality. Prior52 subset (#1 plus #4–#54) remains 22/30; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses and final normal restore held. `py_compile`/`git diff --check` passed. No replay setup errors. Untracked regenerated R27 scratch files byte-matched prior committed executor copies and were removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Ordinary spectrum comparator and whole-wave centroid computation unchanged. |
| coverage | unchanged | Canonical corpus remains 17; two scratch points do not broaden domain coverage. |
| calibration | **improved locally** | Project-decoded centroid upper4000 bracket with other gate checks passing under fresh replay. |

Sol admits one improved axis with zero demonstrated scoped harm. No exact4000 equality, timbre/perceptual quality, production fitness, rights, engine fitness or publication claim. No engine/game/lore, push, merge, publishing or rights edits.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. A next round must declare one falsifiable claim before work.
