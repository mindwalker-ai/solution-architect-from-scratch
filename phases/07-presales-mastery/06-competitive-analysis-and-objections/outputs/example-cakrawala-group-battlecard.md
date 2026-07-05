---
name: example-cakrawala-group-battlecard
description: Worked battlecard for Cakrawala Group vs. a global systems integrator rival — objection matrix pulls directly from 6.5's top-scored risks (organizational skills-gap risk #1, OJK-style regulatory risk #2, delivery-schedule risk #3); feeds 7.7's executive pitch
phase: 7
lesson: 6
audience: internal | executive
---

# Battlecard + Objection Matrix — Cakrawala Group vs. a Global Systems Integrator (worked example)

> This is `template-battlecard-and-objection-matrix.md` filled in for the running Phase 6/7 customer. Every objection row traces to a numbered, scored row in **6.5's actual risk register** (`05-risk-compliance-and-migration/outputs/example-cakrawala-group-risk-and-migration-plan.md`) or to a specific, nameable competitive claim — nothing here was invented for the exercise. This is the card the deal team carries into the room, and the artifact **7.7 (Executive Presentation & Negotiation)** builds its live objection-handling on.

**Customer:** Cakrawala Group  ·  **Opportunity:** "Shared Platform Consolidation" transformation program  ·  **Prepared by:** SA — Presales  ·  **Date:** 2026-07-05
**Competitor:** A global systems integrator (brand-name, multi-continent reference base, standardized transformation accelerator)  ·  **Version:** v0.1  ·  **Last refreshed against:** 6.5 risk register v0.2

Legend: **A→R→E→C** = Acknowledge → Reframe → Evidence → Check · **L/M/H** = Likelihood/Impact carried verbatim from 6.5's register · **score** = 6.5's own Likelihood × Impact figure (1–9), not re-scored here.

---

## 1. Competitor profile

| Field | Detail |
|---|---|
| Who they are | A large, brand-name systems integrator with delivery presence across multiple continents and a standardized "digital transformation accelerator" package |
| What they've won before | Platform consolidations at conglomerates of comparable or larger scale (inferred from their public market position, not confidential intelligence) |
| Their standard offer | A pre-built, reusable platform accelerator, re-skinned per customer, backed by a large delivery bench for fast staffing |
| How this is known | Cakrawala's procurement process confirmed a two-bidder shortlist; the competitor's own public case studies and methodology pages describe the accelerator pattern. No confidential material informs this card — see the lesson's note on where competitive intelligence legitimately comes from (RFP disclosures, procurement debriefs, public materials, and the customer's own shifting language in later discovery sessions). |

## 2. Their likely pitch

- *"We've delivered platform consolidations at conglomerates twice this size — you're buying certainty, not a bet on a smaller partner."*
- *"Our accelerator gives you a proven, pre-built platform on day one instead of a bespoke build."*
- *"With our global bench, staffing and skills-transfer are solved — we bring the people, you don't have to grow them."*

**Flag:** the third talking point targets 6.5's risk #1 (skills gap, score 9) directly. A competent global SI knows a skills-gap concern is the easiest lever to pull on a board already nervous about it — which is exactly why it is the top pre-emption candidate in §6, not a coincidence to be surprised by.

## 3. Where they're genuinely strong

Stated plainly, without qualification, because a battlecard that pretends the rival has no strengths loses credibility on every other row:

- Brand recognition that reassures a board evaluating an unfamiliar-scale transformation
- Breadth of managed-services capability spanning every business unit at once
- Delivery headcount large enough that staffing risk is, for them, structurally a non-issue

## 4. Where you win — with evidence

| Where you win | Why (grounded evidence) |
|---|---|
| **Right-sized, not oversized** | 6.3's sizing sheet bounds the AI ops-copilot to **1 GPU node, 2× L40S-class cards** for ~50 concurrent users on an 8–14B model — a deliberately narrow feature, not a platform reset. That same sheet (§6) contrasts this against a Bumi-Energi-scale oversized deployment costing $260k–400k in GPU compute alone, versus Cakrawala's $30k–45k. A standardized accelerator built to be reused across every customer is structurally biased toward the bigger, more generic footprint — this is a prediction about their business model, not a guess about their intentions. |
| **Cost discipline, not just a lower number** | 6.4's BOM lands at **~Rp 52.0B (board band Rp 48.0–58.0B)**, itemized line-by-line off 6.3's sizing, with a risk-based (not padded) ~8.3% contingency (6.4 §2–3). A "bigger brand premium" is the arithmetic consequence of pricing a bigger, less-bounded platform — the itemization is the proof, not the price alone. |
| **Local presence and regulatory fluency** | Finance-leasing's OJK-style residency requirement (6.2's zero-trust segmentation) was designed into the migration path from day one — in-country-only routing, at rest and in transit (6.5 risk #2's mitigation). A global SI's home playbook was not written around this domestic regulatory reality. |
| **The risk is already found and mitigated, not discovered live** | 6.5's own register — scored, dated, owned, before the board ever asked — already carries the mitigation for the program's two highest-scored risks. A rival walking in cold builds this analysis from scratch, in the room, under questioning. |

## 5. Objection matrix

| # | Objection (board's likely phrasing) | Source | Response (A→R→E→C) | Proof point |
|---|---|---|---|---|
| 1 | "Can our own people actually run this once you leave?" | **6.5 risk register row #1** — organizational, L:H/I:H, **score 9 (highest in the register)** | **A:** the single biggest risk in the whole program, not a side concern. **R:** the mitigation is the delivery model itself, not a training slide. **E:** staged SI-partner-led delivery with named knowledge-transfer exit criteria, and a day-2 operations RACI assigned before Wave 0 starts (6.5 §4). **C:** does that match the operating-model concern, or is there a specific role you're worried we haven't covered? | 6.5 risk register row #1 + program RACI (§4) |
| 2 | "How do you guarantee the finance-leasing data never leaves the country during migration?" | **6.5 risk register row #2** — regulatory/compliance, L:M/I:H, **score 6** | **A:** regulator-facing data during a live migration is exactly where residency risk hides. **R:** the migration path was designed around this constraint from day one, not bolted on. **E:** migration routed exclusively through in-country infrastructure, with a residency audit report as a mandatory gate before Wave 3 begins (6.5 §3, check 1). **C:** does that satisfy the compliance concern, or do you need to see the audit evidence format itself? | 6.5 risk register row #2 + compliance sign-off gate (§3) |
| 3 | "A global name has done this at bigger scale — why trust a smaller, local-scoped design?" | Competitive — brand/scale claim | **A:** their scale and reference base are real, and bigger programs are real experience. **R:** scale at their customers doesn't mean the right size for this one — Cakrawala's AI feature is bounded by design, not by capability limits. **E:** 6.3's sizing sheet derived the ~50-concurrent, 8–14B-model footprint from Cakrawala's actual usage inputs, contrasted against what an oversized deployment would cost (6.3 §6). **C:** is the concern about scale specifically, or about whether the design has been sized rigorously? | 6.3 sizing sheet §6 (bounded vs. oversized contrast) |
| 4 | "Won't their bundled platform work out cheaper once everything's included?" | Competitive — pricing/bundling claim | **A:** a bundled accelerator can look cheaper on a slide before it's priced against this customer's actual workload. **R:** a standardized platform prices for its average customer, not this one — bigger footprints don't shrink to fit smaller sized needs. **E:** 6.4's BOM is itemized line-by-line off 6.3's sizing, ~Rp 52.0B (band Rp 48.0–58.0B), with contingency scored against named risks rather than padded generically (6.4 §2–3). **C:** would it help to walk through where a bundled quote would diverge from these line items? | 6.4 BOM §2 (itemized lines) + §3 (risk-based contingency) |
| 5 | "What if the 12–18 month timeline slips like these programs always do?" | **6.5 risk register row #3** — delivery, L:M/I:H, **score 6** | **A:** schedule slip is the most common way transformation programs actually fail. **R:** the wave plan was built with slack against 6.3's actual build effort, not a hopeful guess. **E:** Wave 0's foundation sizing is priced against 6.3's real node/GPU/lakehouse build effort, and wave overlap (Wave 2 starting once Wave 1 is stable, not once its rollback window fully closes) is deliberate schedule slack (6.5 §2). **C:** is the concern the overall window, or a specific wave you'd like walked through? | 6.5 risk register row #3 + wave table (§2) |

**Reading the matrix:** rows 1–2 are the register's two highest-scored risks — the objections raised *before* the board asks. Rows 3–4 are the predictable competitive claims. Row 5 shows the pattern extends past the two headline risks to any scored register row.

## 6. Pre-emption decision

| Objection # | Pre-empt live? | Why |
|---|---|---|
| 1 | **YES — open the meeting with it** | Highest-scored risk in the register; owning it first reads as competence, not confession |
| 2 | **YES — raise early** | Second-highest score; unresolved doubt here stalls the entire finance-leasing wave |
| 3 | NO — wait for it | Pre-empting a competitor comparison unprompted can read as defensive; answer well when it lands |
| 4 | NO — wait for it | Same reasoning; let the board ask, then show the itemized BOM |
| 5 | NO — answer if raised | Real risk, but lower stakes than 1–2 as a meeting opener |

## 7. Rehearsal record

| Date rehearsed | Rehearsed against | Gaps found | Closed before live pitch? |
|---|---|---|---|
| *(fill in ahead of the actual pitch)* | Internal colleague playing a skeptical board member, firing all five rows out of order plus the layered follow-up on row 1 | *(record any row where the "evidence" step went vague under pressure)* | *(Y/N)* |

## 8. One-line battlecard summary

> Against the global systems integrator, Cakrawala Group wins on right-sizing (6.3), cost discipline (6.4), and local regulatory fluency (6.2) — but the meeting opens by naming the register's own top two risks (6.5 #1 skills gap, #2 residency) before the board does, because a risk found and mitigated first is a strength, and a risk the board finds first is a doubt.
