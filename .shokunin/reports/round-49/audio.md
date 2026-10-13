# Audio round 49 — calibration: upper-adjacent UI sample-rate format boundary

Work commit `6302997d448ef0fa97b216f75444e34baeee16be` by `audio-shokunin <audio@shokunin.local>`. This final report was written **after** the work commit. Named non-author `.shokunin/audio/reports/round-49/r49-verifier.md`; Sol `.shokunin/audio/reports/round-49/r49-adjudicator.md`.

## Declared move and scope
- At clean-before `3293f3872521bce56f83240cb3575df10ff952b9`, R48 had tested the lower 47999/48000 Hz metadata-rate neighbor but not the immediate **upper** 48001/48000 neighbor. One R49 calibration move was declared in `.shokunin/audio/LOG.md` before eight parallel Luna LEAF reports `r49-{scout,executor,alt,critic,reviewer,simplifier,scribe,guard}.md`. The exact integer `sample_rate == 48000` ffprobe format predicate, UI target/thresholds and canonical17 remain unchanged. Two new opt-in modes `--probe-ui-rate-48001` and `--probe-ui-rate-48000-r49` retain both prior R48 modes. The latter new mode uses the **round-49** source WAV rather than silently counting the R48 48000 receipt.
- Executor's original deterministic 5760-frame mono PCM16 pair writes the same `.28*sin(2*pi*1000*arange(5760)/48000)*hanning(5760)` quantized samples under rate headers 48001/48000. WAV SHA `92b22d8749c5f02d4f68d9a8daa32b935404f1d7cdbc31bca55af2f9adf4cb5a` / `387500a620fbfdfb38e044ebb1ec8e0a82be14be9dc71e2bd18e45ec9625ed8c`; SoX-f32 decoded byte SHA identical `4497c82d9bd1fb000455081a5f477af7756e7c035bbe1e81ad295f0b32805c7f` (same R48 48000 payload). Alt independently generated another original shared-payload pair SHA `271e160bc8bc00bd4dfade5d3412185fea9482007a8067b4e5d2fe3f84aa826e`/`f63c9f23f79694bfce44d0d946ade66ef121e58cf1b58a6b989ee35991a4e72a` and found the same polarity; it was not integrated. Same discrete samples are **not** identical physical-time signal: changing rate metadata changes duration and FFT frequency grid.

## Actual independent replay
| New mode, exact runner command | Exit | Receipt | Metadata and project decoded metrics | Failure |
|---|---:|---|---|---|
| `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-rate-48001` | 1 | `.shokunin/audio/corpus/live/runs/20261013T075311862926Z-ui-rate-48001/measurements.json` | 48001 Hz, mono pcm_s16le/16, 5760 frames, ffprobe `.119998s`, peak `.27996826171875`, RMS `-18.327858226717105dBFS`, centroid `1022.557447787877Hz` | Sole `format: expected 48kHz mono` |
| `python3 .shokunin/audio/corpus/fixtures/measure_audio.py --probe-ui-rate-48000-r49` | 0 | `.shokunin/audio/corpus/live/runs/20261013T075312898673Z-ui-rate-48000-r49/measurements.json` | 48000 Hz, mono pcm_s16le/16, 5760 frames, ffprobe `.120000s`, same peak/RMS, centroid `1022.536144951523Hz` | None |

Both duration deltas fall within UI ±.001s; peak <.95, RMS >=.001, centroid 250–4000Hz. Slight centroid difference reflects the rate-dependent FFT grid. Named non-author corrected replay actually executed **58 fresh unique serial runner receipts** `20261013T075310807497Z`–`20261013T075411088201Z`: **25 exit0/33 expected fixture-validation exit1**, including prior56 subset #1+#4–#58 **24/32**. Parent independently checked all 58 paths exist/distinct and receipt mode/failures for all 56 preserved modes, and first/final normal equal with 17 clean measurements. Verifier and Sol checked old17 SHA/metrics, five generic `_alt`, four family groups/eight comparisons, thresholds/sections, eight invalid outcomes, and normal restoration. `py_compile` and `git diff --check` exit0.

**Setup disclosures:** Before corrected replay, the verifier made **two separate 58-invocation shell-wrapper attempts**: both sets exited 127 **before Python** with **zero receipts**. They do not count as 116 gate failures or fresh receipts. Alt helper-path/SoX and critic pre-integration CLI/path errors were also setup, not gates. The selected pair had no unsuccessful numeric fit or corrected report transcription. An incidental extra verifier normal receipt not in the ledger was excluded, not counted; corrected 58 unique paths were independently inspected.

## Sol per-axis verdict
| Axis | Verdict | Local basis |
|---|---|---|
| depth | **improved** | New reproducible upper neighbor complements R48 lower, other UI gates passing. |
| coverage | **improved** | Two new opt-in modes; full 58-command replay preserves prior56 and old17. This is not general rate coverage. |
| calibration | **improved** | Same PCM payload, 48001 sole format failure versus 48000 pass in fresh independent receipts. |

Sol admits the **one declared move** with zero demonstrated scoped harm; four SHONEN boxes remain checked without promotion. This is numerical metadata-rate fixture evidence, **not** arbitrary-rate handling, conversion/resampling, physical-time equivalence, audible or perceptual quality, production fitness, rights, engine fitness, or publishing. No engine/game/lore, push, merge, publishing or rights edits.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [x] Bounded province/no-cross-domain review — named non-author `r24-verifier`, `.shokunin/audio/reports/round-24/r24-verifier.md`.

No promotion. Any next round must first declare one falsifiable claim.
