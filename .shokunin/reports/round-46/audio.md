# Audio round 46 — calibration: ordinary UI centroid lower bound

Work commit `e9a18127921c391f71a257b1a870dd6f97f860f3` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-46/r46-verifier.md`; Sol `.shokunin/audio/reports/round-46/r46-adjudicator.md`.

## Work and selection
- One calibration move declared at clean-before `803c5fbbc19576d980acc5578138522f91e644b0` in `.shokunin/audio/LOG.md` before eight Luna LEAF lanes. Reports `r46-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md` at `e9a18127921c391f71a257b1a870dd6f97f860f3`. This tests ordinary absolute UI `250 <= centroid <= 4000`, **not** R29 pairwise `.10` relative distinctness.
- Selected executor's original 5760-frame/.12s 48k mono PCM16 pair: SHA below `fff9d981fe76c9163ba6a0db851e498b15fe193a1597427c8b73993b4666bfdf`, above `6e453ff6cdf02e3fb72e0ebb0734f39a566a823841da8949187ad73d74a90a2a`. Synthesis for nominal frequency f=225 or 226 Hz: `t=arange(5760)/48000`, `x=.28*sin(2*pi*f*t)*hanning(5760)`, round clipped ×32767 to little-endian PCM16, mono 48k WAV. Integrated source WAVs SHA-identical. **Nominal frequencies are not measured centroids.** The project SoX-f32/whole-wave magnitude-FFT decoder measured 249.71389590882862 and 250.3250670185918Hz. Independent alt original constant-amplitude 200/300 nominal pair had different SHA (`e2d85d3828bb139f8d7a6a459f34f88d3f2498b9135c105995717fe071184723` / `2f9e9228b5cdcf7652ecfc8e1df54f4bc3647f8b303df63edd5e7f013b83af88`) and broader measured 202.48468234677034/302.47893043755806Hz, same gate polarity but not integrated. Added only two opt-in `--probe-ui-absolute-centroid-below/above` builder/runner modes; ordinary comparator, `SPECS`, thresholds and canonical WAVs unchanged.
- Initial executor nominal 230/270 trial decoded 253.80451803986455/293.3534382718592Hz—both in band, so a **failed numeric bracket fit** rather than gate/setup failure. Additional candidate fits are in executor/reviewer reports. Alt initial decaying 180/300 and 60/300 pairs also decoded both in-band, failed numeric fits; its first relative-path helper call raised a setup error, corrected. Reviewer first draft below peak `.279754150390625` was **transcription** error; parent corrected to `.279754638671875` against executor/critic measurements before integration. These errors and iterations do not become replay evidence.

## Before → after, fresh independent replay
- Fresh non-author #2 `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-absolute-centroid-below` exit **1**, receipt `.shokunin/audio/corpus/live/runs/20261013T065601381736Z-ui-absolute-centroid-below/measurements.json`: 17 canonical + scratch, decoded centroid **249.71389590882862Hz** (<250), sole `spectrum: centroid outside fixture band`; peak `.279754638671875` (<.95), RMS `-18.327838866709165dBFS` (> .001 FS), .12s/48k mono PCM16.
- Fresh #3 `--probe-ui-absolute-centroid-above` exit **0**, receipt `.shokunin/audio/corpus/live/runs/20261013T065602421400Z-ui-absolute-centroid-above/measurements.json`: centroid **250.3250670185918Hz** (within 250–4000), peak `.27984619140625`, RMS `-18.32783946042307dBFS`, same duration/format, no failures. The two waveforms differ in frequency, samples and full FFT distribution; this is **gate-level isolation, not causal single-variable spectral isolation**, and no equality at exactly 250Hz was measured.
- `r46-verifier.md` at `e9a18127921c391f71a257b1a870dd6f97f860f3` lists **52 distinct fresh serial commands/exits/receipts**, `20261013T065600`–`065654`, **22 exit0/30 expected fixture-validation exit1**; parent independently checked paths exist/distinct, #2/#3 outcomes, counts and first/final normal JSON equality. Prior50 subset (#1 plus #4–#52) remains 21/29; old17 SHA/metrics, five generic `_alt`, four family groups, thresholds/sections, eight invalid statuses and final normal restore held. `py_compile`/`git diff --check` passed. No replay setup errors. Untracked regenerated R27 scratch files byte-matched prior committed executor copies and were removed.

## Per-axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| depth | unchanged | Ordinary spectrum comparator and whole-wave centroid computation unchanged. |
| coverage | unchanged | Canonical corpus remains 17; two scratch points are not broad coverage. |
| calibration | **improved locally** | Project-decoded centroid bracket around 250Hz, other gate checks passing, independently replayed. |

Sol admits one improved axis with zero demonstrated scoped harm. No exact-250 equality, timbre/perceptual quality, production fitness, rights, engine fitness or publication claim. No engine/game/lore, push, merge, publishing or rights edits.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

Four boxes checked; **no promotion**. A next round must declare one falsifiable claim before work.
