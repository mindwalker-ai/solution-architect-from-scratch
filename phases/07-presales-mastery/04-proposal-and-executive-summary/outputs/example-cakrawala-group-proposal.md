---
name: example-cakrawala-group-proposal
description: Worked Proposal + standalone Executive Summary for Cakrawala Group — cites 6.4's exact BOM (~Rp 52.0B, band Rp 48.0-58.0B) and 6.5's three-wave migration plan verbatim; forwarded alongside (not instead of) the 6.6 HLD ahead of the board vote
phase: 7
lesson: 4
audience: executive | customer
---

# Proposal + Executive Summary — Cakrawala Group (Worked Example)

> This is `template-proposal-and-executive-summary.md` filled in for the running Phase 6/7 customer. It is the document the board actually votes on — shorter than the 6.6 HLD, unambiguously sales-forward, and traceable at every line to 6.4's BOM and 6.5's migration plan. No number below is re-derived; every one is cited from the deliverable that produced it.

**Customer:** Cakrawala Group (fictional)  ·  **Industry:** Diversified conglomerate (retail, logistics, finance-leasing)  ·  **Prepared by:** SA — Presales  ·  **Date:** 2026-07-05
**Engagement / opportunity:** "Shared Platform Consolidation" transformation program  ·  **Version:** v1.0  ·  **Status:** For board review
**Competitive context:** A rival global systems integrator has also submitted a proposal for this board meeting — referenced internally in §7 by decision criteria only, never named in the customer-facing document.

---

## PART A — THE FULL PROPOSAL

### 1. Cover

```
Cakrawala Group
Shared Platform Consolidation — Group Technology Modernization
Proposal for Board Approval
2026-07-05  ·  Version v1.0  ·  Prepared by SA — Presales
```

### 2. The Ask

> **Approve an investment of ~Rp 52 billion (band Rp 48–58 billion) — inside the board's approved Rp 45–65 billion ceiling — to modernize Cakrawala Group's shared technology platform across Retail, Logistics, and Finance & Leasing, delivered over a 12–18 month window in three migration waves, targeting a 15–20% reduction in group cost-to-serve.**

| Figure in the ask | Cited from |
|---|---|
| ~Rp 52 billion / band Rp 48–58 billion | 6.4 Cost Estimation & BOM — TOTAL (3-yr TCO) |
| 12–18 month delivery window | 6.4's pinned delivery window; confirmed by 6.5's wave plan |
| 15–20% cost-to-serve reduction | 6.4 §7 ROI check — pinned target |
| ~40 Kubernetes nodes + 1 GPU node + 1 lakehouse | 6.3 Sizing & Capacity Planning (referenced in §4 below) |

### 3. Problem / Opportunity

Cakrawala Group runs **~350 retail outlets**, **~40 logistics hubs**, and **one finance/leasing back office**, employing **~18,000 people** and generating **~Rp 8 trillion** in annual revenue — on three technology estates that do not talk to each other. Every quarter the group operates three siloed platforms instead of one shared platform is a quarter the group's **15–20% cost-to-serve opportunity** (worth an estimated **Rp 144–192 billion per year at full run-rate**, midpoint ~Rp 168 billion/year — 6.4 §7) goes uncaptured. The cost of waiting compounds in a second way: Finance & Leasing's regulatory exposure gets harder to de-risk the longer it remains on legacy infrastructure, not easier. A rival global systems integrator has also proposed a path forward for this same board meeting — the group does not have the luxury of an indefinite comparison period while both estates keep aging.

### 4. The Solution — one page

A shared, zero-trust platform migrates Retail and Logistics off legacy using a **strangler-fig** pattern — replacing capability by capability while legacy stays the rollback safety net until proven stable — connected through a shared **event bus** for cross-business-unit integration. **Finance & Leasing** keeps its legacy core in place behind an **anti-corruption layer** until its own dedicated wave, so the group's most regulated business unit is never the one absorbing early migration risk. The platform is sized at **~40 Kubernetes nodes** plus **one GPU node (2× GPU-class cards)** supporting a deliberately bounded AI ops-copilot, plus **one shared lakehouse** for analytics across all three business units.

```
THE SOLUTION, ONE PAGE
─────────────────────────────────────────────────────────────────────────
Strangler-fig connects Retail and Logistics to a shared event bus.
Finance & Leasing stays behind an anti-corruption layer until Wave 3.
Sized at ~40 Kubernetes nodes + 1 GPU node (2x cards, bounded AI
ops-copilot) + 1 shared lakehouse. Zero-trust throughout; Finance &
Leasing sits in a segmented enclave.
```

### 5. Investment — reproduced from 6.4's BOM, exactly

```
INVESTMENT (3-year TCO, cited from 6.4's BOM — not re-derived)
─────────────────────────────────────────────────────────────────────────
 Infrastructure (hardware)                                    Rp 14.0B
 Cloud (Retail + Logistics, 3-yr)                              Rp 9.0B
 Data platform (lakehouse, 3-yr)                                Rp 6.0B
 AI (bounded ops-copilot, 3-yr)                                 Rp 3.0B
 Software licensing (3-yr)                                      Rp 5.0B
 Professional services / labor                                Rp 11.0B
 ───────────────────────────────────────────────────────────────────────
 Subtotal                                                      Rp 48.0B
 Contingency / risk buffer (~8.3%)                               Rp 4.0B
 ───────────────────────────────────────────────────────────────────────
 TOTAL (3-year TCO)                              ~Rp 52.0B (band Rp 48.0-58.0B)

 CapEx: Rp 14.0B      OpEx: Rp 38.0B      Board ceiling: Rp 45-65B (clears with room)
```

- **Payback:** ramp-adjusted payback lands at **~month 13** (6.4 §7) — inside the 12–18 month delivery window, not merely close to it.
- **Why the AI line is small:** the AI line is **~6% of the total** by design — the ops-copilot is bounded to one node, two cards, one use case, deliberately scoped smaller than a headline-grabbing group-wide AI ambition would be (6.4's own finding). This is a discipline choice, not a limitation of the platform.

### 6. Timeline — compressed from 6.5's migration plan

The migration runs in three waves, sequenced by **risk**, not by convenience:

```
WAVE 1: Retail (~350 outlets)  ->  WAVE 2: Logistics (~40 hubs)  ->  WAVE 3: Finance & Leasing
(lowest regulatory risk,             (same proven pattern,              (compliance gate clears
 proves the pattern first,           second business unit)               FIRST, then cutover,
 months 3-8)                         (months 7-12)                       months 11-17/18)
```

Retail and Logistics move first because a rollback there is a service outage, not a regulatory event. **Finance & Leasing moves last, and only after clearing a dedicated compliance gate** (6.5) — so the group's most tightly regulated business unit is never the one carrying early-wave migration risk.

### 7. Why Us

```
WHY US                                        A LARGE GENERALIST SI TYPICALLY BRINGS…
─────────────────────────────────────────────────────────────────────────────────────
Solution sized to THIS deal (~40 nodes,       A reference architecture sized for a
 1 GPU node, 1 lakehouse) - not a template     larger deal, then scoped down - AI and
                                                infra lines often priced larger than needed
Every figure traceable to a named BOM line     Bundled pricing, harder for your procurement
 and sizing input, auditable line by line       team to audit against your own cost model
Risk-sequenced migration - the regulated       Migration order often follows the
 unit moves last, behind a named compliance    integrator's own staffing calendar, not
 gate (6.5)                                     your organization's risk profile
AI scoped to one bounded use case, ~6% of      AI frequently positioned as the headline,
 the total investment - not the headline       inflating both cost and delivery risk
```

### 8. Next Steps

```
NEXT STEPS
─────────────────────────────────────────────────────────────────────────
We ask the board to:
  1. Approve the ~Rp 52 billion investment (band Rp 48-58 billion).
  2. Authorize the CIO to execute the Statement of Work by 2026-08-01.
  3. Confirm Wave 1 (Retail) kicks off within 30 days of approval.

Decision owner: the board, this meeting. Not a follow-up call.
```

---

## PART B — STANDALONE EXECUTIVE SUMMARY

> Tested: read only what's below, with every other section deleted. The ask, the cost, the timeline, and the outcome are all present without needing another page.

```
CAKRAWALA GROUP — EXECUTIVE SUMMARY
─────────────────────────────────────────────────────────────────────────
THE ASK:        ~Rp 52 billion (band Rp 48-58 billion), 12-18 months,
                 targeting a 15-20% reduction in group cost-to-serve.

THE PROBLEM:    Three siloed technology estates across Retail, Logistics,
                 and Finance & Leasing are costing the group an estimated
                 Rp 144-192 billion/year in uncaptured efficiency, and
                 Finance & Leasing's regulatory exposure only grows the
                 longer it stays on legacy infrastructure.

THE SOLUTION:   A shared, zero-trust platform (~40 Kubernetes nodes + 1
                 GPU node + 1 lakehouse) migrates Retail and Logistics via
                 strangler-fig and a shared event bus; Finance & Leasing
                 stays protected behind an anti-corruption layer until its
                 own dedicated, compliance-gated wave.

THE TIMELINE:   3 waves - Retail first (lowest risk, proves the pattern),
                 Logistics second, Finance & Leasing last behind a
                 dedicated compliance gate.

THE INVESTMENT: ~Rp 52.0 billion total (band Rp 48.0-58.0 billion),
                 Rp 14.0 billion of it CapEx, payback around month 13,
                 inside the board's Rp 45-65 billion ceiling.

WHY US:         Sized to this deal and traceable line by line, with the
                 group's most regulated business unit sequenced to
                 migrate last, behind a named compliance gate.

NEXT STEP:      Board approves the investment and authorizes the CIO to
                 execute the SOW by 2026-08-01; Wave 1 starts within 30
                 days of approval.
─────────────────────────────────────────────────────────────────────────
```

---

## Findings & flags (what the compression exercise surfaced)

| # | Finding | Section affected | Implication | Severity |
|---|---|---|---|---|
| 1 | The board ceiling (Rp 45–65B) sits wider than the BOM's own band (Rp 48–58B) | §2, §5 | Worth stating explicitly in both the ask and the investment section — it shows the estimate clears the ceiling with room, not just barely | L |
| 2 | The rival SI's exact figures are unconfirmed at time of writing (only a verbal signal that one exists) | §7 | Keep "Why Us" framed as decision-criteria contrast, not a claim about the rival's actual numbers, until their proposal is confirmed in writing | M |
| 3 | The executive summary repeats the Rp 144–192B/year opportunity figure from 6.4 §7 but not the full ROI derivation | Standalone summary | Acceptable by design — the full derivation lives in 6.4 §7 and the HLD's appendix; the summary cites the outcome, not the formula | L |

**One-line scope statement:**
> Cakrawala Group's proposal asks the board to approve **~Rp 52.0 billion (band Rp 48.0–58.0 billion)** over a 3-year TCO, delivered in **3 migration waves** across a **12–18 month** window, targeting a **15–20% cost-to-serve reduction** — every figure cited from 6.4's BOM and 6.5's migration plan, ready to forward alongside (not instead of) the 6.6 HLD ahead of the board vote.
