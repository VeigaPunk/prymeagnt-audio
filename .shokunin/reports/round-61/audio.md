# audio — round 61 (devin host)

**ADMIT — depth/coverage/calibration each improved locally** (Sol
`r61-adjudicator.md`, non-author `r61-verifier.md`, author `r61-author.md`).

Matched `WAVE_FORMAT_EXTENSIBLE` pair differing only in `wValidBitsPerSample`
(17 vs 16): ffprobe reclassifies valid17 → `pcm_s24le`/24-bit; SoX decodes
3,839 vs 5,760 samples; project runner exits 1 with receipt naming the exact
4 failing gates; valid16 clean. 82-command serial ledger, prior-80
complete-JSON exact; three-way reproduction (author/verifier/adjudicator).

Bounded: local reader/gate behavior only — no conformance, enforcement,
fidelity or production claim. UNKNOWN retained: SoX one-frame gap.
Commits: work `1b35faaa`, report-last this.
