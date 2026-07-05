---
name: example-cakrawala-executive-deck-and-negotiation-plan
description: Worked Executive Deck + Negotiation Plan for the fictional Cakrawala Group board — the capstone artifact closing the deal and the track
phase: 7
lesson: 7
audience: executive
---

# Executive Deck + Negotiation Plan — Cakrawala Group

> This is `template-executive-deck-and-negotiation-plan.md` filled in for the fictional Cakrawala Group board close. Every figure below is **cited from the Phase 6 HLD, not recalculated** — this document exists to compress and defend those figures in the room, not to re-derive them.

**Customer:** Cakrawala Group (fictional)  ·  **Meeting:** Board decision session — Group Technology Platform Modernization
**Slot length:** 45 min
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-05  ·  **Status:** For board decision

---

## Part 1 — The 12-Slide Deck Outline

| # | Slide | Content |
|---|---|---|
| 1 | **The Ask** | "Approve **~Rp 52 billion** (banded **Rp 48–58 billion**, within the board's approved Rp 45–65 billion ceiling) to modernize Retail, Logistics, and Finance & Leasing onto one shared platform over **12–18 months**, in **three migration waves**, targeting a **15–20% reduction in cost-to-serve**." |
| 2 | Why now | Three siloed technology stacks (~350 retail outlets, ~40 logistics hubs, 1 finance/leasing back office; ~18,000 employees; ~Rp 8 trillion annual revenue) pay a fragmentation tax every quarter. The regulatory window for the Finance & Leasing compliance gate favors acting within this cycle, not the next. |
| 3 | The cost of "do nothing" | Current cost-to-serve trend held against the 15–20% target; the rival global systems integrator is already in the account with a like-for-like migration that does not unify the three business units and does not close this gap. |
| 4 | Target architecture (the money diagram) | One slide: strangler-fig incrementally replacing legacy POS/WMS in Retail and Logistics; an anti-corruption layer and segmented zero-trust enclave protecting the Finance & Leasing core; a shared platform underneath — API gateway, event bus, ~40 Kubernetes nodes plus 1 GPU node (2× cards), one lakehouse. |
| 5 | Investment & ROI | **~Rp 52 billion (band Rp 48–58 billion)**, inside the board's Rp 45–65 billion ceiling. Target outcome: **15–20% cost-to-serve reduction**, reachable only once all three business units share the platform. |
| 6-7 | The 3-wave plan | Wave 1 — Retail. Wave 2 — Logistics. Wave 3 — Finance & Leasing, which does not cut over until it clears a dedicated compliance gate. Sequenced by risk (service outage vs regulatory event), not by convenience. |
| 8-9 | Risk containment + the AI copilot | Zero-trust posture means a Retail incident cannot become a Finance & Leasing incident. The platform's GPU node carries an AI copilot for frontline Retail and Logistics staff, piloted on a subset of stores in wave 1 as the safest, most visible proof point. |
| 10 | Why us — competitive edge | Unlike the rival integrator's like-for-like lift-and-shift, this design unifies cost-to-serve across all three business units and includes native AI capability rather than bolting one on later — the difference between hitting 15–20% and hitting nothing. |
| 11 | Objections pre-empted | **"Why not go faster?"** — the compliance gate is a regulatory control, not a scheduling choice. **"Why the AI copilot at all?"** — it rides the same GPU capacity already sized into the platform; piloting it in wave 1 costs nothing structural to defer or shrink. |
| 12 | The ask, restated + next step | Identical to slide 1, verbatim, plus the decision date: requested board decision within 2 weeks; wave 1 discovery kickoff within 2 weeks of signature. |

### Time budget for the 45-minute slot

| Slides | Minutes | Cumulative | Note |
|---|---|---|---|
| 1 | 2 | 2 | State the ask once, cleanly |
| 2-3 | 5 | 7 | The board already knows their own fragmentation tax |
| 4 | 4 | 11 | One pass on the architecture, no LLD detour |
| 5 | 5 | 16 | Slow down — expect the first hard question right here |
| 6-7 | 5 | 21 | The compliance gate earns its own minute — it's the risk story |
| 8-9 | 6 | 27 | Don't rush the AI copilot or the "why us" |
| 10 | 4 | 31 | State the edge once, no rival trash-talk |
| 11 | 2 | 33 | Pre-empt, don't relitigate |
| 12 | 2 | 35 | Restate the ask verbatim + next step |
| Q&A buffer | 10 | 45 | Protected — never borrowed to save an earlier slide |

---

## Part 2 — Negotiation Levers

```
   FLEXIBLE (can be traded)                   WHY IT'S SAFE TO FLEX
   ══════════════════════════════════════════════════════════════════
   Wave sequencing within Retail/Logistics    Rollback there is a service
   (which stores/hubs go in wave 1 vs 2)      outage, not a regulatory event
   ──────────────────────────────────────────────────────────────────
   AI copilot pilot scope (# of pilot         A smaller pilot still proves
   stores, feature set at go-live)            the concept; full rollout can
                                              follow wave 1 without it
   ──────────────────────────────────────────────────────────────────
   Delivery cadence / steering rhythm         Process, not architecture —
   (weekly vs biweekly reporting)             costs nothing to adjust
   ══════════════════════════════════════════════════════════════════
   PROTECTED (never traded for free)          WHY IT CANNOT FLEX
   ──────────────────────────────────────────────────────────────────
   Zero-trust security posture                Removing it reopens the exact
                                              cross-BU blast-radius risk the
                                              architecture exists to close
   ──────────────────────────────────────────────────────────────────
   Compliance gate before Finance &           A regulatory control, not a
   Leasing cutover                            schedule preference — skipping
                                              it exposes the group, not us
   ──────────────────────────────────────────────────────────────────
   The 3-wave sequence itself (order,         Removing waves ≠ compression;
   not just timing, of BU migration)          it re-introduces the exact
                                              risk the sequencing avoids
   ══════════════════════════════════════════════════════════════════
```

---

## Part 3 — Likely-Asks Worksheet

| Likely ask (their position) | The real interest behind it | What you trade (the lever) | What you ask for in return | Lane |
|---|---|---|---|---|
| "Cut the AI copilot's scope for a lower price." | Nervousness about paying for the newest, least-proven piece of the platform. | Shrink wave 1's AI copilot pilot to fewer stores; keep the whole platform's zero-trust and integration integrity intact. | A faster wave 1 sign-off, since the reduced pilot lowers their perceived first-year risk. | **SA** |
| "Compress 12–18 months to 9." | Wanting to show the market/board a faster win. | Combine waves 1+2 (Retail + Logistics) under a tighter cadence; the compliance gate before Finance & Leasing stays fixed regardless. | A named executive sponsor for the combined wave, to keep the tighter cadence realistic. | **SA** |
| "Match the rival GSI's price." | Wanting assurance they aren't overpaying — not necessarily the lowest number in the room. | Not an SA trade — hand the AE the technical differentiation (native AI capability, unified cost-to-serve across all 3 BUs) that justifies the band. | Commercial terms (payment schedule, contract length, reference clause) — the AE's trade to hold the number. | **AE** |

**Stacked-ask handling:** if the board raises more than one of these in the same conversation, separate them out loud — *"let's take those one at a time"* — before responding to any of them. A stacked ask answered as one collapses into unplanned concessions.

---

## Part 4 — Reading the Room

| Role | Who | Likely behavior | Your move |
|---|---|---|---|
| Economic buyer | CFO / board chair | Asks about the number and the downside; speaks last, decides | Answer with the investment slide (5), not the architecture slide (4) |
| Champion | CTO | Pre-briefed; may pre-empt a technical objection before you're asked | Let them field the deepest technical follow-ups |
| Skeptic / detractor | A COO wary of operational disruption during migration | Asks the hardest question early, to test composure | Answer directly and briefly on slides 6-7 (sequencing/risk); don't get defensive |
| Influencer | Group risk officer | Quiet; the CFO will check their face on the risk slide | Watch their reaction during slides 6-9, not slide 4 |

---

## Part 5 — Pre-Flight Checklist

- [x] The ask ("~Rp 52B, band Rp 48–58B, 12–18 months, 3 waves, 15–20% cost-to-serve") is memorized verbatim for slides 1 and 12.
- [x] The CFO is confirmed as the economic buyer; 16 of the 45 minutes are budgeted toward slides 5-9, the section they'll weight most.
- [x] Every figure on slide 5 traces to the Phase 6 HLD's cost estimation and sizing work — no number on this deck is recalculated live.
- [x] The levers table (Part 2) is shared with the account executive before the meeting, so price/terms asks route to them instantly.
- [x] The SA's hand-off line for any price ask is agreed with the AE in advance: *"That's a commercial question — let me bring in [AE] on the terms while I confirm the technical scope holds."*

---

## Closing Signal Log (illustrative)

| Signal observed | Justification or implementation question? | Response given |
|---|---|---|
| CFO asks "who's our point of contact during wave 1 discovery?" | Implementation | Confirmed: discovery kickoff within 2 weeks of signature; handed board to AE for next steps and paper. |
| Group risk officer asks "what happens if the compliance gate isn't ready on schedule?" | Justification (testing the control, not yet asking about execution) | Answered directly: Finance & Leasing simply does not cut over until the gate clears — the wave 3 date is not fixed, the gate is. |

The CFO's shift to an implementation question, late in the meeting, was the signal the ask had effectively been approved — the SA confirmed technical readiness and handed the room to the AE for the decision date and paper, closing both the deal and the track this artifact belongs to.
