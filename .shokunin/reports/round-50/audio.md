# Audio round 50 — calibration: matched UI stereo/mono format check

Work commit `f7a2eadf36e3c0d4e080322f0055708228c8fc65` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-50/r50-verifier.md`; Sol `.shokunin/audio/reports/round-50/r50-adjudicator.md`.

## Declared move and selection
- At clean-before `048449d7809f06100f2c2307eb5c44508033cb4e`, the historical invalid `stereo48_probe` had indicated format failure under a broad invalid-fixture spec, **not** an ordinary matched UI pair. One calibration move was declared in `.shokunin/audio/LOG.md` before eight Luna LEAF reports `r50-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md`. The exact sample-rate/mono format predicate and `SPECS["ui"]` duration/level/centroid gates remained unchanged. Two opt-in `--probe-ui-channel-stereo/mono` modes retain all prior58 modes and canonical17.
- Executor generated original **5760-frame** 48000 Hz PCM16 mono and stereo (L=R=mono integer sample sequence). Recipe: `t=arange(5760)/48000`; `x=(.18*sin(2π440t)+.10*sin(2π1200t+.2)+.06*sin(2π2600t+.7))*exp(-8t)`, clip to ±.95, round ×32767 to little-endian signed16, duplicate each integer into left and right for stereo. WAV SHA mono `93223ee4df8c027d6efaa12d9eca47af3de4fba1eba90c27f29c49ab0086a54a`, stereo `59e508f1b30d17eef5f00951434915bc7974e02d6988faf07a557270611e950e`; integrated files match. Independent alt original pair (different signal) SHA mono `c9f705a030771fc583ea9321625fa8cb456f3e9ae83c9ba8ad1c8e883c5c1049`, stereo `f55b5fa90ec546af9c60985b292c8ec16adca0f77ca815c3c47baed958d85ec6`, same gate polarity.
- **Measurement caveat:** SoX decoded mono has 5760 float values; stereo has 11520 interleaved float values. The project computes a single whole-vector FFT. Its stereo centroid is **not** a per-channel FFT, and the two centroids are not equal; no channel-agnostic or general stereo/downmix claim follows.

## Fresh non-author evidence
| Exact runner command | Exit | Fresh receipt | ffprobe and project SoX-f32 measurement | Failure |
|---|---:|---|---|---|
| `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-channel-stereo` | 1 | `.shokunin/audio/corpus/live/runs/20261013T081329361782Z-ui-channel-stereo/measurements.json` | 48000 Hz, **2** channels, pcm_s16le/16, 5760 frames, `.120000s`; flattened 11520 values; peak `.3160400390625`, RMS `-19.902100515581505dBFS`, centroid `2019.8445020922231Hz` | Sole `format: expected 48kHz mono` |
| `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-channel-mono` | 0 | `.shokunin/audio/corpus/live/runs/20261013T081330436427Z-ui-channel-mono/measurements.json` | 48000 Hz, **1** channel, pcm_s16le/16, 5760 frames, `.120000s`; decoded 5760 values; same peak/RMS, centroid `1928.2134621890698Hz` | None |

Both satisfy UI duration `.12s ±.001`, peak <.95, RMS >=.001, and decoded whole-stream centroid 250–4000 Hz. Named non-author corrected **60 serial fresh unique receipt** replay `20261013T081328234481Z`–`20261013T081432750910Z`: **26 exit0/34 expected fixture-validation exit1**, prior58 subset #1+#4–#60 **25/33**. Parent inspected all 60 distinct existing paths, all old mode/failure maps including invalid statuses, and equality of first/final normal and R49 normal (17 clean). Verifier and Sol checked old17 canonical SHA/metrics, five generic `_alt`, four family groups/eight comparisons, thresholds/sections/eight invalid outcomes, normal restore. `py_compile` and `git diff --check` passed.

**Setup disclosures:** One verifier discarded 60-invocation command-wrapper attempt exited 127 throughout **before Python**, generating **zero receipts**. Executor’s first string rather than `Path` and alt’s string/relative-Path helper exceptions were also **setup**, never format outcomes. No failed numeric fitting or corrected transcription for the selected pair.

## Sol per-axis verdict
| Axis | Verdict | Local basis |
|---|---|---|
| depth | **improved** | Matched ordinary UI channel contrast controls other gates unlike historical broad invalid stereo48. |
| coverage | **improved** | Two opt-in modes appended, full prior58 preserved; not general multichannel coverage. |
| calibration | **improved** | Fresh stereo sole-format failure paired with mono clean, same per-channel PCM. |

Sol admits this **one declared move** with zero demonstrated scoped harm. Four SHONEN boxes remain checked **without promotion**. No claim of audibility, perceptual quality, general stereo/downmix, production fitness, rights, engine fitness or publication. No engine/game/lore, push, merge, rights or publishing edits.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

No promotion. A next round must declare one falsifiable claim before work.
