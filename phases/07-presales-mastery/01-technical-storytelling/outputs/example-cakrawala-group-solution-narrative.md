---
name: example-cakrawala-group-solution-narrative
description: Worked Solution Narrative for the fictional Cakrawala Group — the 4-part arc plus audience message map, built on 6.6's HLD, 6.4's BOM, and 6.5's risk register
phase: 7
lesson: 1
audience: executive | customer
---

# Solution Narrative — Cakrawala Group

> This is `template-solution-narrative.md` filled in for the running Phase 6/7 customer. Every figure below is cited, not recalculated — this narrative is a second rendering of the HLD, BOM, and risk register, reordered and reframed for a board that hears it once.

**Customer:** Cakrawala Group (fictional)  ·  **Engagement:** Group Technology Platform Modernization — Capstone F/G
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-05  ·  **Version:** v1.0
**Presented to:** Cakrawala Group board of directors, ahead of a rival global systems integrator's own pitch

**Source artifacts this narrative is built from:**

| Source document | What it contributes to this narrative |
|---|---|
| 6.6 `example-cakrawala-hld.md` | Business context, target architecture, security posture, recommendation |
| 6.4 `example-cakrawala-group-bom.md` | ~Rp 52B investment, band Rp 48–58B, 13-month ramp-adjusted payback |
| 6.5 `example-cakrawala-group-risk-and-migration-plan.md` | Top-scored risk (organizational, 9/9), 3-wave migration, compliance gate |

---

## 1. The four-part arc

### Situation — the world as they already agree it is

> Cakrawala Group runs ~350 retail outlets, ~40 logistics hubs, and one finance-and-leasing back office — roughly 18,000 people generating about Rp 8 trillion a year. Three business units, three technology estates, each working fine on its own and none of them talking to the others. A global systems integrator is already in this process, pitching a way to close that gap. That's the world as it stands today, before we've said a word about our own architecture.

*(Verbatim source: 6.6 HLD §2 — ~350 outlets, ~40 hubs, ~18,000 employees, ~Rp 8T revenue; the rival is a pinned engagement fact.)*

### Complication — the cost of doing nothing, led by the correct priority

> The hardest risk in this program isn't the regulator — it's us. Your own team, operating a platform of this size for the first time, is the single highest-scored risk in the register we built for this deal: a 9-out-of-9 organizational risk, higher than the finance-leasing compliance exposure most vendors would lead with. That's why our delivery model stages a knowledge-transfer exit *before* we hand your team the keys — not a training slide bolted on at the end. Second: every quarter the group runs three siloed estates instead of one is a quarter the fragmentation tax gets paid again, and it compounds, because the rival in this room is already unifying theirs.

*(Verbatim source: 6.5 risk register #1 — Likelihood H × Impact H = 9, "mixed-skill team can't operate the new K8s/lakehouse platform at required pace post-cutover," mitigated by "staged SI-partner-led delivery with a named knowledge-transfer period and exit criteria." Fragmentation framing: 6.6 HLD §2.)*

### Resolution — the architecture as a sequence of decisions, not a diagram

> We don't touch everything at once. Retail moves first — 350 outlets, but the lowest regulatory exposure in the group — because it's the best place to prove the pattern: a strangler-fig cutover that replaces legacy piece by piece behind a facade, so if anything goes wrong, a rollback is a service event, not a headline. Once that wave is stable, logistics follows the same pattern, proving the event bus under real cross-business-unit traffic for the first time. Finance and leasing goes last, and it does not go at all until a dedicated compliance gate clears — data residency confirmed in-country, an unbroken audit trail across the cutover window, and a rollback that's been rehearsed, not just designed. Underneath all three waves, the whole platform sits behind a zero-trust boundary, so even mid-migration, an incident in retail can never reach the finance-leasing core.

*(Verbatim source: 6.5 risk-and-migration plan §2 — Wave 0/1/2/3 sequencing, retail first "lowest regulatory exposure," finance-leasing gated on the compliance sign-off in §3 (residency audit, reconciliation report, regulatory-reporting continuity, rehearsed rollback drill); 6.6 HLD §3/§4 — strangler-fig, event bus, anti-corruption layer, zero trust, segmented enclave.)*

### Payoff — the outcome, in the customer's own units

> Fifteen to twenty percent of cost-to-serve, on your Rp 8 trillion revenue base, is worth roughly Rp 144 to 192 billion a year — call it Rp 168 billion at the midpoint. Against a ~Rp 52 billion investment, that lands the payback around month 13, comfortably inside the 12-to-18-month delivery window itself. You are not waiting years to feel this, and you keep the group's most regulated business unit insulated behind the compliance gate the entire time you're realizing it.

*(Verbatim source: 6.4 BOM §7 — cost-to-serve baseline ~12% of Rp 8T revenue = Rp 960B/yr; 15% → Rp 144B/yr, 20% → Rp 192B/yr, midpoint ~Rp 168B/yr; ramp-adjusted payback ≈ 1.11 years ≈ 13 months; total investment ~Rp 52.0B, band Rp 48.0–58.0B.)*

---

## 2. The three nested lengths

**Elevator (~20 seconds):**
> "Cakrawala runs three technology estates that don't talk to each other, and a rival is already unifying theirs. We migrate all three onto one zero-trust platform in 12–18 months for ~Rp 52 billion, breaking even around month 13, without ever putting the regulated finance-leasing core at early-wave risk."

**15-minute version (the board-meeting slot):**
```
Situation (2 min) — scale, three siloed estates, the rival already in the room
Complication (3 min) — lead with risk #1 (9/9, organizational), then the
                        fragmentation tax; NOT led with the regulatory risk
Resolution (6 min) — retail first (proving ground) -> logistics (proven at
                       scale) -> finance-leasing gated on compliance sign-off,
                       all wrapped in zero trust
Payoff (2 min) — ~Rp 168B/yr midpoint saving, ~13-month payback, inside the
                  12-18 month window, regulated core insulated throughout
The ask (2 min) — approve ~Rp 52B (band Rp 48-58B), inside the Rp 45-65B
                    ceiling, three-wave sequence, gate before Wave 3
```

**Written proposal version:**
> The full 6.6 HLD (`example-cakrawala-hld.md`) — all seven sections and four appendices, every figure in this narrative traceable back to it, the document "prove it" questions get answered from once the board has agreed in principle.

*Consistency check performed: the investment figure (~Rp 52B), the payback (~13 months), and the delivery window (12–18 months) are identical across the elevator, 15-minute, and written versions above — no drift.*

---

## 3. Audience message map

| Fact (source) | CFO frame | COO frame | CIO frame | CEO frame |
|---|---|---|---|---|
| ~Rp 52B, band Rp 48–58B (6.4 §2, §7) | "Inside the Rp 45–65B board ceiling, with a ~13-month payback — this pays for itself before the delivery window even closes." | "One shared build funds all three business units at once — you're not competing with Retail and Logistics for separate platform budgets next year." | "Priced with a contingency line tied directly to the risk register (6.5), not a padded number — Rp 4.0B of buffer against ten named, scored risks." | "This is the investment that closes the gap with the rival who's already unifying their own three estates." |
| ~40 K8s nodes + 1 GPU node, 2× cards (6.3, 6.6 §5) | "One platform sized once — not sized, bought, and run three separate times, once per business unit." | "Shared compute capacity means Logistics and Retail aren't waiting on separate hardware refresh cycles to get capability." | "A right-sized footprint — 40 nodes and one bounded GPU node for one real use case — your team can actually operate, not a science project scaled for a use case you don't have yet." | "Enough capacity to run the whole group on day one, not a pilot you'll have to re-justify funding for next year." |
| 3-wave migration, compliance gate before Wave 3 (6.5 §2–3) | "Contingency is banded by wave — Wave 3, the regulated one, carries the widest buffer, so risk-adjusted cost is already reflected in the ~Rp 52B figure." | "Retail and Logistics prove the cutover pattern works, under real load, before Finance & Leasing — the business unit with the least tolerance for disruption — is ever touched." | "The rollback mechanism — the strangler-fig facade — gets rehearsed during Wave 2, on a non-production replica, so the first real finance-leasing rollback, if one is ever needed, isn't the first time anyone's tried it." | "We move fast where it's safe (Retail, Logistics) and carefully where it's regulated (Finance & Leasing) — not slow everywhere, which is how a competitor gets a year's head start." |
| Zero trust, segmented finance-leasing enclave (6.2, 6.6 §4) | "Bounds the group's downside — a Retail incident during migration cannot cascade into a Finance & Leasing compliance incident, which is what actually moves the group's risk-adjusted cost of capital." | "No new blanket network access for anyone — the security model is invisible to day-to-day store and hub operations; it only matters at the boundaries you'd want protected anyway." | "A defensible, audit-ready architecture — this is the version of 'zero trust' a real external audit holds up, not a marketing label." | "Protects the one business unit the regulator, and the market, watches most closely — which protects the group's reputation, not just its data." |

---

## 4. Pressure-test checklist — results

- [x] **Recap check** — Situation + Complication above name risk #1 (organizational, 9/9) explicitly by score; a listener can recite it back without reading the appendix.
- [x] **Hostile-question check** — "why should the board trust your delivery model over the rival's?" is pre-answered in the Complication: staged SI-partner-led delivery with named knowledge-transfer exit criteria (6.5 RACI, "Training / knowledge transfer" row).
- [x] **Consistency check** — investment (~Rp 52B), payback (~13 months), and window (12–18 months) match across all three nested lengths.
- [x] **No buried risk check** — the Wave 3 compliance gate is named as a design feature in the Resolution ("does not go at all until a dedicated compliance gate clears"), not a footnote.
- [x] **Hero check** — the Resolution's subject throughout is "the platform," "your team," and "the group" — Cakrawala remains the actor; the vendor appears only as the entity staging the knowledge-transfer exit.

---

**Next step:** this narrative, once rehearsed against the checklist above, is the spine of the live session in **7.2 Whiteboarding & Architecture Communication**, and the artifact defended in **Capstone G**'s mock-board Q&A.
