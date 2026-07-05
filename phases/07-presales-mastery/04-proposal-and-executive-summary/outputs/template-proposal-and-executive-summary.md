---
name: template-proposal-and-executive-summary
description: Proposal + standalone Executive Summary template — ask stated first, problem/opportunity, one-page solution, investment (cited from the BOM), timeline (cited from the migration plan), why us, and a single votable call to action
phase: 7
lesson: 4
audience: executive | customer
---

# Proposal + Executive Summary — Template

> Fill this in only after the HLD (6.6) and the underlying sizing (6.3), BOM (6.4), and migration plan (6.5) are locked. This document does no new arithmetic — its only job is compression and framing. Every number below must be a citation, never a re-derivation. If a figure needs to change, change it at the source deliverable first, then update this document from that single source of truth.

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`  ·  **Status:** `<for board review / final>`
**Competitive context (if any):** `<e.g. a rival SI is also proposing — name internally, never in the customer-facing document>`

---

## How to use this template

1. **State the ask first.** Before writing anything else, write the one paragraph that names the investment, the timeline, and the target outcome. Everything else in the document defends that paragraph — it does not build up to it.
2. **Cite, never re-derive.** Every number (investment, timeline, sizing, target outcome) must come from an existing deliverable — the BOM, the sizing sheet, the migration plan. If you're doing arithmetic while writing this document, stop; that work belongs upstream.
3. **Compress the solution to one page.** Name the patterns and the sizing; do not re-explain how they work. That belongs in the HLD, referenced but not reproduced here.
4. **Reproduce the investment section's line items verbatim** from the BOM — do not summarize into a single number, and do not round differently than the source document.
5. **Close with one decision, one owner, one date.** A call to action a reader could actually vote on in the meeting where it's presented — not an invitation to a follow-up conversation.
6. **Extract a standalone executive summary last.** Once the full proposal is drafted, pull the ask, the one-page solution, the investment total, the timeline, and the CTA into one page with zero references to "see §4" or "see the BOM." Test it: could a reader who saw *only* this page still vote?

Legend: **TCO** = total cost of ownership over the stated horizon · **CTA** = call to action · **BU** = business unit.

---

## PART A — THE FULL PROPOSAL

### 1. Cover

```
<Customer name>
<Engagement / program name>
Proposal for Board Approval
<Date>  ·  Version <v0.1>  ·  Prepared by <SA name / firm>
```

### 2. The Ask (paragraph one — no preamble)

> `<Approve an investment of <total> (band <range>) — inside the board's approved <ceiling> — to <one-sentence description of the transformation>, delivered over a <window> in <N> migration/delivery waves, targeting <target outcome, e.g. a %  reduction in cost-to-serve>.>`

Every figure in this paragraph must trace to a named source deliverable:

| Figure in the ask | Cited from |
|---|---|
| `<total investment / band>` | `<BOM lesson, e.g. 6.4>` |
| `<delivery window>` | `<BOM + migration plan, e.g. 6.4 / 6.5>` |
| `<target outcome>` | `<BOM's ROI check, e.g. 6.4 §7>` |
| `<sizing footprint, if mentioned>` | `<sizing lesson, e.g. 6.3>` |

### 3. Problem / Opportunity — cost of inaction, not a technical gap

> `<Reframe the business context as urgency: scale facts (employees, sites, revenue), what fragmentation/legacy is costing every quarter it continues, and why the target outcome gets harder to capture the longer the group waits. Do not restate the HLD's architecture-first framing — restate it as a clock that is running.>`

### 4. The Solution — one page

> `<Name the patterns selected (not re-explained) and the sizing footprint (cited, not re-derived). One paragraph. A board reader needs to know THAT the risk is engineered down and the platform is sized appropriately, not HOW the mechanism works.>`

```
THE SOLUTION, ONE PAGE
─────────────────────────────────────────────────────────────────────────
<pattern 1 — e.g. strangler-fig> connects <BU/system> to <BU/system> via
<integration pattern — e.g. event bus>. <Regulated/sensitive unit, if any>
stays behind <protective pattern — e.g. anti-corruption layer> until its
own dedicated wave. Sized at <sizing footprint from 6.3-equivalent>.
```

### 5. Investment — reproduced from the BOM, exactly

```
INVESTMENT (<horizon> TCO, cited from <BOM lesson> — not re-derived)
─────────────────────────────────────────────────────────────────────────
 <line item 1>                                                <Rp X>
 <line item 2>                                                 <Rp X>
 <line item 3>                                                  <Rp X>
 <line item 4>                                                   <Rp X>
 <line item 5>                                                    <Rp X>
 <line item 6>                                                  <Rp X>
 ───────────────────────────────────────────────────────────────────────
 Subtotal                                                       <Rp X>
 Contingency / risk buffer (~<%>)                                <Rp X>
 ───────────────────────────────────────────────────────────────────────
 TOTAL (<horizon> TCO)                          ~<Rp X> (band <Rp X-Y>)

 CapEx: <Rp X>      OpEx: <Rp X>      Board ceiling: <range> (<clears/at risk>)
```

State the payback and any "why a line is smaller/larger than expected" finding here, cited from the BOM's own ROI check — do not recompute it:

- **Payback:** `<ramp-adjusted payback month, cited from BOM §7>`, inside the `<delivery window>`.
- **Notable line explained:** `<e.g. why the AI line is small / why services is the largest line>` — cited from the BOM's own findings, not reasoned fresh here.

### 6. Timeline — compressed from the migration plan

> `<A wave summary, not the full Gantt/risk register/RACI — those live in the HLD's appendix. State the wave order and the one-sentence "why this order.">`

```
WAVE 1: <BU/scope>        ->  WAVE 2: <BU/scope>       ->  WAVE 3: <BU/scope, most sensitive>
(<why this goes first>)         (<why this goes second>)       (<gate that must clear first, if any>)
```

### 7. Why Us — contrast decision criteria, never the competitor's name

```
WHY US                                        A COMPETING BIDDER TYPICALLY BRINGS…
─────────────────────────────────────────────────────────────────────────────────────
<criterion 1 — e.g. sized to this deal,        <likely competing approach — e.g. a
 not a template>                                template reference architecture>
<criterion 2 — e.g. every figure traceable>    <likely competing approach — e.g. bundled,
                                                 harder-to-audit pricing>
<criterion 3 — e.g. risk-sequenced delivery>   <likely competing approach — e.g. sequencing
                                                 driven by the bidder's staffing, not risk>
```

### 8. Next Steps — one decision, one owner, one date

```
NEXT STEPS
─────────────────────────────────────────────────────────────────────────
We ask the board to:
  1. Approve the <total investment> (band <range>).
  2. Authorize <named role, e.g. the CIO> to execute the <SOW/contract> by <date>.
  3. Confirm <first wave/milestone> kicks off within <N> days of approval.

Decision owner: <the board / named approver>, <this meeting / by this date>.
Not a follow-up call.
```

---

## PART B — STANDALONE EXECUTIVE SUMMARY

> Test before shipping: delete every other section of this document and read only what's below. A reader who saw *only* this page must be able to vote. If voting requires flipping to another page, this summary has failed its one job — fix it before adding it back to the full proposal as its cover.

```
<CUSTOMER NAME> — EXECUTIVE SUMMARY
─────────────────────────────────────────────────────────────────────────
THE ASK:        <total investment> (band <range>), <delivery window>,
                 targeting <target outcome>.

THE PROBLEM:    <one sentence — cost of inaction / opportunity size>.

THE SOLUTION:   <one sentence — pattern names + sizing footprint, no
                 architecture explanation>.

THE TIMELINE:   <N>-wave delivery, <wave order + one-line why>.

THE INVESTMENT: ~<Rp X> total (band <Rp X-Y>), <Rp X> of it CapEx,
                payback around month <T>, inside the <ceiling>.

WHY US:         <one sentence, decision-criteria contrast, no competitor
                 name>.

NEXT STEP:      <named decision, named owner, named date>.
─────────────────────────────────────────────────────────────────────────
```

---

## Findings & flags (what the compression exercise surfaced)

| # | Finding | Section affected | Implication | Severity |
|---|---|---|---|---|
| 1 | `<e.g. a figure in the proposal doesn't match the source BOM/sizing sheet>` | `<section>` | `<fix at the source, then re-copy into this document>` | `<H/M/L>` |
| 2 | `<e.g. the CTA is still phrased as an invitation to discuss>` | `<§8>` | `<rewrite as a named decision, owner, and date>` | `<…>` |

**One-line scope statement (fill in):**
> `<Customer>`'s proposal asks the board to approve **`<Rp X>` (band `<Rp X-Y>`)** over `<horizon>`, delivered in `<N>` waves, targeting `<%>` `<outcome>` — every figure cited from `<BOM lesson>` and `<sizing lesson>`, ready to forward alongside (not instead of) the HLD.

---

*Worked example: see `example-cakrawala-group-proposal.md` in this folder.*
