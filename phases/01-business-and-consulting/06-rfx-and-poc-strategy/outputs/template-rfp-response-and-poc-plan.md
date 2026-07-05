---
name: template-rfp-response-and-poc-plan
description: RFP Response Outline + PoC Plan — a win-theme-driven response skeleton plus a one-page PoC contract, produced when a real RFP lands
phase: 1
lesson: 6
audience: customer | internal | executive
---

# RFP Response Outline + PoC Plan — Template

> Fill this in the day an RFP drops. Part A shapes the *response*; Part B scopes the *proof*. The rule that governs both: lead with win themes, not a wall of compliance, and never start the PoC before the customer signs the success criteria.

**Customer:** `<company>`  ·  **Opportunity:** `<deal / RFP name>`  ·  **Prepared by:** `<SA name>`
**RFx type:** `<RFI / RFP / RFQ>`  ·  **Response due:** `<YYYY-MM-DD>`  ·  **Version:** `<v0.1 draft>`
**Did we shape this RFx?** `<yes / partly / no — if "no", check for column-fodder before investing>`

Legend: **Win theme** = (a customer pain) × (a differentiator only you offer) × (proof the buyer can verify) · **SoR** = system of record · **DPIA** = Data Protection Impact Assessment · **BAFO** = Best And Final Offer.

---

## Part A — RFP Response Outline

### A0. Deal snapshot (pull from your MEDDICC sheet, Lesson 1.5)

| MEDDICC element | This deal |
|---|---|
| **M**etrics (the number that prices it) | `<the measurable outcome / saving>` |
| **E**conomic buyer | `<who signs — the exec-summary audience>` |
| **D**ecision **c**riteria | `<the 3–5 things they'll actually judge on>` |
| **D**ecision **p**rocess | `<shortlist? PoC? BAFO? award date?>` |
| **I**dentify pain | `<top 2–3 pains — these become win themes>` |
| **C**hampion | `<who carries your themes when you're not in the room>` |
| **C**ompetition | `<named rival(s) + "do nothing">` |

### A1. Win themes (do this BEFORE writing any section)

> 2–4 only. Each must have all three factors, and each must map to a decision criterion. If you can't name the proof, it isn't a win theme — cut it.

| # | Customer pain / decision criterion | Your differentiator | Proof the buyer can verify | Targets (who) |
|---|-------------------------------------|---------------------|-----------------------------|----------------|
| WT1 | `<pain>` | `<what only you do>` | `<PoC result / reference / arch>` | `<buyer role>` |
| WT2 | `<pain>` | `<differentiator>` | `<proof>` | `<buyer role>` |
| WT3 | `<pain>` | `<differentiator>` | `<proof>` | `<buyer role>` |

```
   PAIN / DECISION CRITERION        →   DIFFERENTIATOR            →   PROOF (verifiable)          TARGETS
   ────────────────────────────────────────────────────────────────────────────────────────────────────
   <pain 1>                         →   <only-you capability>     →   <PoC / reference>           <role>
   <pain 2>                         →   <only-you capability>     →   <PoC / reference>           <role>
   <pain 3>                         →   <only-you capability>     →   <PoC / reference>           <role>
   ────────────────────────────────────────────────────────────────────────────────────────────────────
   Thread every theme through §A2 (exec summary), §A4 (solution), §A5 (proof), §A6 (commercials).
```

### A2. Executive summary (1 page — write LAST, place FIRST)

- **Their goal, in their words:** `<one sentence, quoting the RFP>`
- **The win themes:** `<WT1 · WT2 · WT3 in one line each>`
- **The outcome:** `<the measurable result they get>`
- **The ask:** `<what you want them to decide / the next step>`

### A3. Response section map (fill the skeleton)

| # | Section | Fill in | Which win theme(s) it carries |
|---|---------|---------|-------------------------------|
| 1 | Executive Summary | `<see §A2>` | all |
| 2 | Win Themes / Value Proposition | `<see §A1>` | all |
| 3 | Understanding of Requirements | `<restate their problem — proves you listened>` | — |
| 4 | Solution (HLD altitude) | `<boxes & arrows organised by THEIR pain, not your catalogue>` | `<WT#>` |
| 5 | Proof | `<PoC plan (Part B) · references · DPIA/security approach>` | `<WT#>` |
| 6 | Commercials | `<pricing NARRATIVE: phased, TCO vs. do-nothing cost, ROI>` | `<WT#>` |
| 7 | Compliance Matrix | `<line-by-line — see §A4; fast + accurate, zero mandatory misses>` | supports |
| 8 | Delivery, Risk & Team | `<phasing, governance, key CVs>` | — |

### A4. Compliance matrix (table stakes — accurate but fast)

> Necessary to be shortlisted, insufficient to win. A single "Non-comply" on a *mandatory* requirement can disqualify you — flag those first.

| Req # | Requirement (verbatim) | Response | How / where met | Win-theme hook? |
|-------|------------------------|----------|-----------------|-----------------|
| `<id>` | `<text>` | `<Comply / Partial / Alternative / Exception>` | `<section / product / note>` | `<WT# or —>` |
| `<id>` | `<…>` | `<…>` | `<…>` | `<…>` |

*Response key:* **Comply** = fully meet as stated · **Partial** = meet with caveat · **Alternative** = meet a better way · **Exception** = cannot / will not (state why + mitigation).

---

## Part B — PoC Plan (the contract)

> Sign this with the customer BEFORE any build work. It answers ONE doubt, on their terms, in a bounded time-box. The discipline is in the OUT list and the pre-agreed thresholds.

```
   THE PoC CONTRACT
   ┌───────────────────────────────────────────────────────────────────────────────┐
   │ OBJECTIVE    <the ONE doubt this proves — a top decision criterion>             │
   ├───────────────────────────────────────────────────────────────────────────────┤
   │ SUCCESS      # | criterion            | how measured        | PASS threshold     │
   │ CRITERIA     1 | <what must be true>  | <the measurement>   | <the number>       │
   │ (signed)     2 | ...                  | ...                 | ...                │
   │              3 | ...                  | ...                 | ...                │
   ├───────────────────────────────────────────────────────────────────────────────┤
   │ SCOPE  IN:   <data · systems · users · environment included>                    │
   │ GUARD  OUT:  <the boil-the-ocean list you refuse to add>                        │
   ├───────────────────────────────────────────────────────────────────────────────┤
   │ TIMELINE     <4–6 weeks, time-boxed, fixed readout date>                        │
   │ RESOURCING   <paid? whose data / env / people? who does what?>                  │
   │ EXIT         PASS → <advance>          FAIL → <walk / paid remedy>              │
   └───────────────────────────────────────────────────────────────────────────────┘
```

### B1. Objective

> One sentence. The single question the customer's technical evaluator most needs answered before they'll commit. Not "show the product."

`<objective>`

### B2. Success criteria (pre-agreed, measurable, signed off)

| # | Criterion | How measured | Pass threshold | Gate or leading indicator? |
|---|-----------|--------------|----------------|----------------------------|
| 1 | `<what must be true>` | `<the measurement / audit>` | `<the number>` | `<gate / indicator>` |
| 2 | `<…>` | `<…>` | `<…>` | `<…>` |
| 3 | `<…>` | `<…>` | `<…>` | `<…>` |

> Anti-pattern check: reject any criterion you can't measure, and any "95% of everything" promise. Bound the cohort, the data, and the environment so each number is provable.

### B3. Scope guardrails

- **IN:** `<named systems · bounded data cohort · # users · environment>`
- **OUT:** `<other sites · write-back · prod HA/DR + security accreditation · full migration · everything the customer might ask to add mid-PoC>`

### B4. Timeline (time-boxed)

| Week | Milestone |
|------|-----------|
| W1–2 | `<connect / access / foundation>` |
| W3–4 | `<core proof + controls>` |
| W5 | `<secondary criteria + demo>` |
| W6 | `<measure vs criteria + joint readout>` |

### B5. Resourcing & commercial model

- **Paid or free?** `<paid fixed-fee is the default; free only if small, bounded, high-win, reference-worthy>`
- **Customer provides:** `<data access · environment · SMEs · sign-off authority (e.g. DPO)>`
- **We provide:** `<SA · data/platform engineer · domain advisor>`

### B6. Exit

- **PASS →** `<advance to full proposal / production phase 1; carry learnings into HLD + BOM>`
- **FAIL →** `<documented findings the customer keeps; scoped paid remediation OR clean walk — no open-ended drift>`

---

*Worked example: see `example-nusantara-sehat-rfp-poc.md` in this folder.*
