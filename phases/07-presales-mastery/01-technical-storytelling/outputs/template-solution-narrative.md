---
name: template-solution-narrative
description: Fill-in-the-blank template for a 4-part solution narrative (Situation-Complication-Resolution-Payoff) plus an audience message map, built on top of an existing HLD, BOM, and risk register
phase: 7
lesson: 1
audience: executive | customer
---

# Solution Narrative — Template

> This is the reusable arc you fill in for any deal that already has an HLD, a BOM, and a risk register behind it. The narrative does not replace those documents — it is a second rendering of the same facts, reordered and reframed for a room that hears the story once. Never invent a fact here that isn't traceable to the artifacts it's built from.

**Customer:** `<customer name>`  ·  **Engagement:** `<engagement name>`
**Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`  ·  **Version:** `<vX.Y>`
**Presented to:** `<board | steering committee | CFO 1:1 | …>`

**Source artifacts this narrative is built from (fill in before writing a single sentence):**

| Source document | What it contributes to this narrative |
|---|---|
| `<HLD file>` | Target architecture (Resolution), business context (Situation), recommendation (the Ask) |
| `<BOM / pricing sheet>` | Investment figure, payback, cost-to-serve translation (Payoff) |
| `<Risk register / migration plan>` | Top-scored risks (Complication), migration sequencing (Resolution), mitigations (message map) |

---

## 1. The four-part arc

### Situation — the world as they already agree it is

_State scale, structure, and what's currently working, in the customer's own facts — not your opinion. Name any known competitor/rival explicitly if one is in the deal; naming it yourself buys more trust than letting the room discover it._

> `<2-4 sentences. Pull numbers verbatim from the HLD's business-context section — do not recompute or round differently than the source.>`

### Complication — the cost of doing nothing, led by the correct priority

_Pull directly from the risk register. Lead with the **highest-scored risk**, even if it isn't the most dramatic-sounding one. If you lead with a lower-scored risk because it's more vivid, you have written a mis-weighted narrative — flag it and fix the order before shipping._

> `<3-5 sentences. State the #1 risk by name and score, its mitigation, then the #2 risk, then the compounding cost of inaction (e.g. a fragmentation tax, a competitive gap, a rising compliance bar).>`

### Resolution — the architecture as a sequence of decisions, not a diagram

_Narrate the **order** decisions were made and **why**, using the HLD's target architecture and the migration plan's wave sequence. Every architectural noun you use (a pattern, a security control, a phase) must already exist in the source HLD — this section adds no new design, only a narrated order._

> `<4-6 sentences, chronological: what moves first and why it's lowest-risk, what follows, what's gated and on what condition, and how the security model bounds risk throughout.>`

### Payoff — the outcome, in the customer's own units, never a lone KPI

_Take the raw percentage/KPI from the BOM and translate it into money, time, or competitive position, exactly as the BOM's own ROI section already did the math. Do not perform new arithmetic here — cite the source calculation._

> `<2-4 sentences: the number in absolute terms, the payback period, and the "so what" for the specific decision this audience must make today.>`

---

## 2. The three nested lengths

Fill in shortest first — if you can't compress to 20 seconds, the arc above isn't tight enough yet.

**Elevator (~20 seconds, one breath):**
> `<One sentence: Situation clause, Resolution clause, Payoff clause. No slides, no jargon a non-technical listener can't repeat.>`

**15-minute version (the board-meeting slot):**
```
Situation (__ min) → Complication, led by the correct top risk (__ min)
→ Resolution as a journey, not a diagram (__ min) → Payoff in outcome
terms (__ min) → the ask, one sentence (__ min)
```

**Written proposal version:**
> `<Reference to the full HLD/proposal document — the artifact "prove it" questions get answered from. Confirm every figure in the two versions above matches it exactly.>`

---

## 3. Audience message map

Fill one row per fact that's load-bearing to the deal. Reframe, never re-fact — every cell in a row must trace back to the same source figure.

| Fact (source) | CFO frame (cost / risk-adjusted return) | COO frame (operational continuity) | CIO frame (technical credibility) | CEO frame (competitive position) |
|---|---|---|---|---|
| `<investment figure, source>` | | | | |
| `<sizing figure, source>` | | | | |
| `<migration sequencing, source>` | | | | |
| `<security/risk control, source>` | | | | |

---

## 4. Pressure-test checklist (run before you present)

- [ ] **Recap check** — read only the Situation + Complication sections aloud; can a listener recite the top 3 risks from the register afterward, unprompted?
- [ ] **Hostile-question check** — write the single toughest question a rival's SA would ask, and confirm the narrative already answers it.
- [ ] **Consistency check** — do the elevator, 15-minute, and written versions agree on every number (investment, payback, timeline)? A mismatch here is the first thing a sharp questioner will find.
- [ ] **No buried risk check** — is every gate/condition in the risk register (e.g. a compliance sign-off) named as a *feature* of the design in the Resolution, not omitted or left as a footnote?
- [ ] **Hero check** — read the draft and count first-person plural ("we built…") vs customer-centered framing ("you get…"). If "we" dominates the Resolution, the customer has stopped being the hero of their own story.

---

## Worked example

See [`example-cakrawala-group-solution-narrative.md`](./example-cakrawala-group-solution-narrative.md) for this template fully filled in against Cakrawala Group, citing the exact BOM and risk-register figures from Phase 6.
