# Absolute-Human Board — Solution Architect From Scratch

**Status:** in-progress  (ALL 53 LESSONS COMPLETE (100%) · only capstone briefs + quiz-bank/site cleanup remain)
**Started:** 2026-07-04

## Project Conventions
- Content repo: Markdown lessons + Node `site/build.js` (Vercel static site). Node v22.
- **Not a git repo** → no git rollback point. Recoverable baseline = current on-disk state. **Now genuinely overdue** — 53 lessons, zero version history.
- No test framework. Verify = `node site/build.js` clean + independent evaluator + consistency checks (no `(TODO)`, no leaked tool tags `</content>`/`</invoke>`, balanced ```mermaid fences, running-customer continuity incl. cross-lesson number consistency).
- Lesson schema: `phases/NN-name/NN-lesson/{docs/en.md, outputs/, optional lab/}`. Arc: Problem → Concept → Design It → Compare It → Ship It → Exercises → Key Terms → Further Reading. Architect altitude. English.
- **Per-phase running customers (all 6):** P1 Nusantara Sehat (hospital, →Capstone A) · P2 Garuda Finance (financial services, →B) · P3 PasarKita (e-commerce, →C) · P4 Kirim Cepat (logistics, →D) · P5 Bumi Energi (energy/AI, →E) · P6+P7 Cakrawala Group (conglomerate, →F and G — the only customer spanning two phases, deliberately, since P7 sells what P6 designed).
- **Anti-drift technique, fully matured across 8 phases:**
  1. Identical canonical facts + "invent no new numbers" + "no trailing XML-like tags" to every parallel agent.
  2. Pre-evaluator sweep: build + leaked-tag grep + fence-balance + explicit cross-lesson number spot-check BEFORE dispatching the evaluator.
  3. **Pre-pin any figure a later "closer" lesson must cite** (the decisive fix — P5's closer drifted without this; P6 and P7's closers held perfectly with it). Standard practice now for any lesson chain with a synthesis/closer lesson.
  4. Evaluator explicitly interrogates the highest-risk citation points (the closer lesson) every time, not just spot-checks.

## All 8 wave sets — COMPLETE

| Wave Set | Phase | Lessons | Customer | Evaluator result |
|---|---|:-:|---|---|
| WS1 | 0 Foundations | 6 | — | PASS |
| WS2 | 1 Business & Consulting | 6 | Nusantara Sehat | PASS |
| WS3 | 2 Infrastructure | 7 | Garuda Finance | PASS, all 5.0 |
| WS4 | 3 Cloud Architecture | 7 | PasarKita | PASS, six 5.0 / one 4.5 |
| WS5 | 4 Data Platform | 6 | Kirim Cepat | PASS (fixed a derived-figure drift) |
| WS6 | 5 AI Platform | 7 | Bumi Energi | NEEDS-WORK→fixed→PASS (closer-lesson drift, fixed) |
| WS7 | 6 Solution Architecture | 7 | Cakrawala Group | PASS, all 7 = 5.0, zero defects |
| WS8 | 7 Presales Mastery | 7 | Cakrawala Group (cont.) | PASS, six 5.0 / one 4.0 (fixed a slide-count nit) |

**TOTAL: 53/53 lessons · 106 deliverables (template + worked example × 53) · 8/8 quiz banks authored.**

**Final verification:** `node site/build.js` → 8 phases · 53 lessons · **53 complete (100%)** · 46 glossary terms. Zero leaked tool tags, zero `(TODO)` markers, all Mermaid balanced, anywhere in `phases/`. Every `outputs/` directory populated.

## Remaining (the track is content-complete; this is polish/packaging)
1. **7 capstone briefs** (`projects/*/README.md`, currently stubs) — each capstone now has a real, fully-authored source deal to draw from:
   - A (Discovery Simulation) ← Nusantara Sehat's Phase 1 discovery pack
   - B (On-Prem Private Cloud) ← Garuda Finance's Phase 2 HLD/BOM
   - C (Hybrid Cloud) ← PasarKita's Phase 3 multi-cloud + migration plan
   - D (Enterprise Data Platform) ← Kirim Cepat's Phase 4 lakehouse design
   - E (Private AI Platform) ← Bumi Energi's Phase 5 RAG+GPU sizing
   - F (AI Transformation Proposal) ← Cakrawala Group's Phase 6 HLD/LLD/BOM
   - G (Executive Presales Demo) ← Cakrawala Group's Phase 7 deck/negotiation — the full lifecycle capstone
2. Replace the OpenStack quiz banks still embedded in `site/lesson.html` (~129 lines) — the last non-lesson content cleanup.
3. **Not a git repo** — recommend `git init` + an initial commit now that all lesson content exists, before any further work risks loss.

## Log
- 2026-07-04: Board + Stage 1 scaffold/site; WS1 P0; WS2 P1; WS3 P2.
- 2026-07-05: WS4 P3 (PasarKita); WS5 P4 (Kirim Cepat); WS6 P5 (Bumi Energi, fixed closer drift); WS7 P6 (Cakrawala Group, clean 7/7 via pre-pinning).
- 2026-07-05 (4th session): **WS8 — Phase 7 (7 lessons + 14 deliverables, Cakrawala Group continued)**, the FINAL content phase. Evaluator PASS (six 5.0, one 4.0 — a slide-count/time-budget nit in 7.7's worked example); fixed; re-verified. **All 53 lessons now complete (100%).** Track is content-complete; remaining work is the 7 capstone briefs + site quiz-bank cleanup, both packaging tasks rather than authoring.
