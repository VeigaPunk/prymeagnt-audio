# Audio round 23 — calibration: current 13-file decision table

Work commit: `71b082a1aed6bb4430b2018297970eebe061d87f` by `audio-shokunin <audio@shokunin.local>`. This final report was written only **after** the work commit. Named non-author `.shokunin/audio/reports/round-23/r23-verifier.md` includes initial FAIL and dated follow-up PASS after correction. Sol `.shokunin/audio/reports/round-23/r23-adjudicator.md` provides per-axis verdict.

## Work performed
- Declared one calibration-disclosure claim before wave dispatch in `.shokunin/audio/LOG.md` at `71b082a1aed6bb4430b2018297970eebe061d87f`. Eight Luna leaf reports under `.shokunin/audio/reports/round-23/` independently inventoried gates, clean distribution, controls, comparator polarity, critique, minimal scope and hashes. No source, threshold, or canonical WAV mutation.
- Appended a dated **current** 13-file decision table in `.shokunin/audio/corpus/knowledge/2026-10-12-threshold-calibration.md` at `71b082a1aed6bb4430b2018297970eebe061d87f`. Retained the older round-5 ten-file table as historical. New table cites current code, non-author round-22 raw clean/negative receipts, eligible subsets and exact comparator polarity; loudness is descriptive, without an acceptance window.
- Non-author `r23-verifier.md` independently recomputed the rows and replayed normal, six-record invalid, 200Hz gap/slope pass/fail, restored normal, exact commands/exits and raw receipts at `71b082a1aed6bb4430b2018297970eebe061d87f`. It **initially failed** the whole document because the older text incorrectly said section length is checked after split/FFT. The old paragraph is preserved; a clearly labeled correction was appended, citing current code and short/odd raw controls. The same verifier rechecked the corrected artifact and appended a dated PASS. This correction is part of this round's work, not a silent re-roll of the original failure.

## Landed changes
- `.shokunin/audio/corpus/knowledge/2026-10-12-threshold-calibration.md`, `.shokunin/audio/LOG.md`, `SCORECARD.md`, eight wave-1 reports, verifier, Sol report and seven fresh serial receipt directories in work commit `71b082a1aed6bb4430b2018297970eebe061d87f`. `git diff 64e6088794371769e31e0a6fc9ae0f2f2e0c91dd 71b082a1aed6bb4430b2018297970eebe061d87f -- .shokunin/audio/corpus/fixtures/ .shokunin/audio/corpus/artifacts/` is empty. This separate report cites the work hash and is committed last. No push/merge/publishing/sample clearance/engine mutation.

## Before → after measurements
- Before `64e6088794371769e31e0a6fc9ae0f2f2e0c91dd`: historical round-5 table described ten authored files and one section record; current non-author normal receipt had 13 canonical measurements, seven outer-loop checks, four sections, three gated internal joins and five variant pairs, plus a stale historical sentence about section count. After `71b082a1aed6bb4430b2018297970eebe061d87f`: a dated table reports each scope, comparator, clean extrema and nearest arithmetic margin with isolated/confounded/not-exercised controls; historical correction names the false sentence and current count-precheck behavior. Counting command `python3 -c "from pathlib import Path; print(len(list(Path('.shokunin/audio/corpus/artifacts').glob('*.wav'))))"` → 13 at both commits. `r23-distribution.md` and non-author `r23-verifier.md` give per-file values, recomputation and byte hash method.
- Independent seven-mode exits `[0,1,0,1,0,1,0]`, exact commands/receipt paths in `r23-verifier.md`: fresh invalid `corpus/live/runs/20261013T011828577717Z-invalid/measurements.json` confirms 144000/101-sample structured `section count`, 200Hz gap/slope edge controls retain polarity and sole failure, first/restored normal JSON equal excluding paths. Thirteen canonical SHA-256s and builder/checker hashes match `64e6088`, five `_alt` records pass. Four preliminary shell-wrapper exit 127 attempts are excluded from audio evidence. No threshold was retuned.

## Axis verdict
| Axis | Verdict | Scope |
|---|---|---|
| calibration | **improved narrowly** | Current fixture-local numerical auditability and correction of stale documentation, **not** perceptual calibration. |
| depth | **unchanged** | No new detector, comparator or source code. |
| coverage | **unchanged** | No new playable WAV or fixture category. |

Admitted after correction: >=1 improved, none demonstrated harmed. Margins are arithmetic distances on source-generated fixtures, not probability or listening data. No claim of audible seamlessness, mastering quality, valid-bit support, external JSON compatibility, rights, engine integration or production readiness.

## SHONEN
- [x] Cited decision tables/checklists — named non-author `audio-r1-verifier`, `.shokunin/reports/audio-r1-verifier.md`.
- [x] End-to-end fixture task — named non-author `r2-verifier`, `.shokunin/audio/reports/round-2/r2-verifier.md`.
- [x] Executable fixture workflow — named non-author `r3-adjudicator` with `r3-verifier`, `.shokunin/audio/reports/round-3/`.
- [ ] No cross-domain bleed / PROVINCE remains accurate — no separate whole-lane non-author review. **Box 4 open.**

Next falsifiable move: independent whole-lane province-boundary audit, declared as one axis-move with evidence before any box-4 decision or promotion. No automatic rank change.
