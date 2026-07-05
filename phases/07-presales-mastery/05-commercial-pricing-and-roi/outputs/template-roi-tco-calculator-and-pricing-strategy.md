---
name: template-roi-tco-calculator-and-pricing-strategy
description: ROI/TCO Calculator + Pricing Strategy — pinned inputs (cited, not re-derived) -> pricing structure decision -> milestone/payment schedule -> ROI sensitivity grid -> negotiation levers -> one-page commercial summary
phase: 7
lesson: 5
audience: internal | executive
---

# ROI/TCO Calculator + Pricing Strategy — Template

> Fill this in once a priced BOM (cost-estimation lesson) and a staged delivery/migration plan (risk & migration lesson) both exist. Every input here is **cited from those upstream deliverables, never re-derived** — if a number looks wrong, send it back upstream and re-price there, don't quietly adjust it in this sheet. Never present a single ROI number; always present the sensitivity grid it comes from.

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`
**Competitive context:** `<e.g. a rival bidder is also pricing this deal — name them or note "none">`

---

## How to use this template

1. **Recap the pinned inputs** — copy the exact investment total/band, delivery window, and ROI target straight from the BOM and risk/migration deliverables. Do not recompute them.
2. **Choose the pricing structure** — match it to how the delivery plan is staged (fixed / T&M / milestone-based / outcome-based-gainshare). Most multi-wave transformations should default to milestone-based.
3. **Build the milestone/payment schedule** — one row per delivery gate, tied to the migration plan's own exit criteria, percentages summing to 100%.
4. **Build the ROI/TCO sensitivity grid** — the same payback formula applied across both the investment band *and* the savings-target range at once. Never ship a single point estimate.
5. **Add negotiation levers** — contingency-inclusive vs. contingency-separate framing, and (if the outcome is genuinely measurable) a capped gainshare kicker.
6. **Roll it into a one-page commercial summary** — the single artifact a steering committee approves in one sitting.

Legend: **T&M** = time & materials · **TCO** = total cost of ownership · **Gate** = a named, verifiable delivery event that triggers payment · **Grid** = a sensitivity table varying two or more pinned uncertainty ranges at once.

---

## 1. Pinned inputs (cited from the BOM + risk/migration deliverables — not re-derived)

```
Investment (TCO, pinned) ................. <Rp X>          (board band <Rp X-Y>)
Delivery window (pinned) .................. <N-M months>
Baseline metric (e.g. revenue) ............ <value>
Cost-to-serve / target-metric baseline .... <assumption: % of baseline, range>
  -> <Rp X/yr>  (range <Rp X-Y/yr>)
Target reduction (pinned) ................. <X-Y%>
  -> <Rp X/yr @ low%> ... <Rp Y/yr @ high%> ... midpoint <Rp Z/yr>
Upstream lesson's own central-case payback . <T months>   (the number you are about to extend into a grid, not replace)
```

## 2. Pricing structure decision

| Structure | Who bears schedule/scope risk | Fits this deal when… | Chosen? |
|---|---|---|---|
| Fixed-price | Vendor | Scope is genuinely stable, low change risk | `<Y/N>` |
| Time & materials (T&M) | Customer | Scope is deliberately exploratory | `<Y/N>` |
| Milestone-based | Shared, tied to verifiable gates | Delivery is already staged into waves with named exit criteria | `<Y/N>` |
| Outcome-based / gainshare | Vendor, offset by upside | The target outcome is independently measurable | `<Y/N — usually a layer on top, not primary>` |

**Decision + one-line rationale:** `<state the chosen structure and why, referencing the delivery plan's own staging>`

## 3. Milestone / payment schedule (if milestone-based)

```
GATE   TRIGGER (from the migration/delivery plan)              %       Amount (of central estimate)
────────────────────────────────────────────────────────────────────────────────────────────────
<M0>   <e.g. signature / mobilization>                          <X%>    <Rp X>
<M1>   <e.g. foundation wave exit>                               <X%>    <Rp X>
<M2>   <e.g. wave 1 exit — named exit criteria>                  <X%>    <Rp X>
<M3>   <e.g. wave 2 exit — named exit criteria>                  <X%>    <Rp X>
<M4>   <e.g. compliance/regulatory gate, if any>                 <X%>    <Rp X>
<M5>   <e.g. final wave exit + acceptance>                       <X%>    <Rp X>
<Retention>  <released at formal sign-off>                       <X%>    <Rp X>
────────────────────────────────────────────────────────────────────────────────────────────────
TOTAL                                                            100%    <Rp X>
```

**Formula:** `milestone payment = gate % x central estimate`. **Range:** percentages are the pinned commercial agreement; rupiah figures rescale if the final contract prices at the band's edges. **Rationale for the weighting:** `<state which gates carry the most risk per the risk register, and why payment is weighted there>`.

## 4. ROI/TCO sensitivity grid

```
FORMULAS
  Annual saving           = baseline x target reduction%
  Cumulative saving(T)    = Annual saving x T^2 / 4     for T <= 2 years   (linear-ramp assumption — restate the
                                                                             ramp shape/horizon if different)
  Payback period T (yrs)  = 2 x SQRT( Investment / Annual saving )

SENSITIVITY GRID — payback period (months)
                              Savings @ low%           Savings @ high%
                              (<Rp X/yr>)              (<Rp Y/yr>)
────────────────────────────────────────────────────────────────────
  Investment <low band>        <T months>               <T months>
  Investment <central>         <T months>               <T months>   <- upstream lesson's own
                                                                         point should land in this cell
  Investment <high band>       <T months>               <T months>
────────────────────────────────────────────────────────────────────
ILLUSTRATIVE PAYBACK RANGE: <low>-<high> months. Present the range, or the
grid itself — never the central cell alone.
```

## 5. Negotiation levers

**Contingency treatment:**

| | Contingency-inclusive | Contingency-separate |
|---|---|---|
| Headline number | `<Rp X, all-in>` | `<Rp X base>` + a capped `<Rp Y>` reserve |
| When to use | Simple negotiation, customer values one number | Competitive bid situation where a lower headline matters |

**Gainshare kicker (optional, only if the outcome is independently measurable):** `<describe the trigger, cap, and payment gate>`

## 6. One-page commercial summary

```
COMMERCIAL SUMMARY — <Customer>
─────────────────────────────────────────────────────────────────────────
INVESTMENT (cited, not re-derived)      <Rp X>  (band <Rp X-Y>)
DELIVERY WINDOW (cited)                 <N-M months>, <N> waves/stages
PRICING STRUCTURE                       <structure>, <N> gates + retention
CONTINGENCY TREATMENT                   <inclusive / separate — state which>
PAYBACK (illustrative, full grid)       <low>-<high> months
UPSIDE MECHANISM                        <gainshare kicker, or "none">
─────────────────────────────────────────────────────────────────────────
ONE LINE: <one-sentence commercial pitch tying structure + range + upside>
```

---

*Worked example: see `example-cakrawala-group-roi-and-pricing-strategy.md` in this folder.*
