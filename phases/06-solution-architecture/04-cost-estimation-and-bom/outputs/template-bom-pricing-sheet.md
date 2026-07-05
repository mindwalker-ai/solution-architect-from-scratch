---
name: template-bom-pricing-sheet
description: BOM + Pricing Sheet — sizing inputs -> priced line items (assumption + formula + range) -> CapEx/OpEx split -> 3-yr run-rate -> ROI/payback check
phase: 6
lesson: 4
audience: internal | executive
---

# BOM + Pricing Sheet — Template

> Fill this in once sizing (6.3) is locked. Never write a bare number — every line carries an assumption, a formula, and a range. An executive should trust the total; procurement should be able to audit every line under it.

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`
**TCO horizon:** `<e.g. 3 years>`  ·  **Currency:** `<e.g. Rp, billions unless marked /yr or /mo>`
**Budget ceiling (if pinned):** `<range>`  ·  **Delivery window:** `<months>`

---

## How to use this template

1. **Recap sizing** — pull node counts, GPU/accelerator footprint, and data-platform scale straight from the sizing lesson's output. Do not re-derive them here; if a number looks wrong, send it back to sizing and re-price once confirmed.
2. **Price every line** — one row per cost driver, each with an assumption, a formula, an estimate, and a range. A number with no formula behind it does not belong in this sheet.
3. **Roll up + defend the band** — subtotal, add a risk-based (not blind-percentage) contingency, and state the board-level band as a portfolio range around the central total — not the sum of every line's own worst case.
4. **Split for the board** — CapEx/OpEx (accounting lens) and one-time/recurring (cash-flow lens). They will disagree in places; ship both.
5. **Show the run-rate** — how the recurring subtotal lands year over year as the platform ramps to full run-rate.
6. **ROI check** — a simple, explicitly-caveated payback screen against the customer's stated target, not a full NPV model.

Legend: **CapEx** = capitalized/depreciated · **OpEx** = expensed as incurred · **TCO** = total cost of ownership over the stated horizon.

---

## 1. Sizing inputs (recap, cited not re-derived)

> Pull directly from the sizing & capacity planning deliverable. List only what drives a cost line below.

```
<sizing input 1 — e.g. N mid-size compute nodes>
<sizing input 2 — e.g. GPU/accelerator footprint, if any>
<sizing input 3 — e.g. data platform scale/region>
<…>
```

## 2. Itemized line items (assumption + formula + range — never a bare number)

| # | Line item | Assumption | Formula | Estimate | Range |
|---|---|---|---|---|---|
| 1 | Infrastructure (hardware/hosting) | `<unit cost basis>` | `<qty × unit cost + fabric/storage ratio>` | `<Rp X>` | `<Rp X–Y>` |
| 2 | Cloud (public-cloud OpEx, `<horizon>`) | `<blended monthly run-rate, per BU if multiple>` | `<rate × months>` | `<Rp X>` | `<Rp X–Y>` |
| 3 | Data platform (`<horizon>`) | `<storage+compute+license, per year>` | `<rate × years>` | `<Rp X>` | `<Rp X–Y>` |
| 4 | AI (`<horizon>`, if in scope) | `<inference/orchestration/guardrails per year — hardware counted in line 1>` | `<rate × years>` | `<Rp X>` | `<Rp X–Y>` |
| 5 | Software licensing (`<horizon>`) | `<platform mgmt / event-bus / API-gateway / observability / security, blended per year>` | `<rate × years>` | `<Rp X>` | `<Rp X–Y>` |
| 6 | Professional services / implementation labor | `<blended FTE count × avg. months × blended rate/FTE-month>` | `<FTE × months × rate>` | `<Rp X>` | `<Rp X–Y>` |
| | **Subtotal (lines 1–6)** | | | **`<Rp X>`** | — |
| 7 | Contingency / risk buffer | Risk-based (see §3), not a blind percentage | `<sum of named risks>` | `<Rp X>` (`<~%>` of subtotal) | `<Rp X–Y>` |
| | **TOTAL (`<horizon>` TCO)** | | | **`<Rp X>`** | **`<Rp X–Y>`** |

*Sanity check at least the two largest/least-standard lines against an external quote (vendor list price, delivery bench rate card) before this goes to the board.*

*Board-level band note:* the total range above should be a **portfolio band** (e.g. ±10–15% around the central estimate) — not the naive sum of every line's own worst case, which overstates risk by assuming every line fails badly in the same year.

## 3. Contingency worksheet (risk-based, not a habit percentage)

> Name each risk. A contingency line with no named risk behind it cannot be defended, retired, or resized as the deal matures.

```
NAMED RISK                                                       BUFFER
─────────────────────────────────────────────────────────────────────
<e.g. FX exposure on imported hardware>                          <Rp X>
<e.g. integration unknowns across N systems/BUs>                 <Rp X>
<e.g. schedule compression risk>                                 <Rp X>
<e.g. licensing/cloud usage true-up at go-live>                  <Rp X>
─────────────────────────────────────────────────────────────────────
TOTAL CONTINGENCY                                                 <Rp X>
```

## 4. CapEx / OpEx split (accounting lens)

| View | Line items | Amount |
|---|---|---|
| **CapEx** (capitalizable) | `<which lines>` | `<Rp X>` |
| **OpEx** (expensed) | `<which lines>` | `<Rp X>` |
| **Total** | | `<Rp X>` |

## 5. One-time vs recurring split (cash-flow lens)

> This will not match §4 line-for-line — professional services is usually OpEx by accounting convention but one-time by cash timing. Ship both views; hand the customer's finance team whichever answers their actual question.

| View | Line items | Amount |
|---|---|---|
| **One-time** | `<which lines>` | `<Rp X>` |
| **Recurring** (`<horizon>` run-rate) | `<which lines>` | `<Rp X>` |
| **Total** | | `<Rp X>` |

## 6. `<horizon>`-year run-rate view

> The recurring subtotal rarely lands evenly — it ramps as the platform goes live partway through delivery.

```
YEAR      RECURRING LINES (ramping)                    CUMULATIVE
──────────────────────────────────────────────────────────────────
Year 1    <Rp X>   (<ramp stage>)                        <Rp X>
Year 2    <Rp X>   (<ramp stage>)                        <Rp X>
Year 3    <Rp X>   (<ramp stage>)                         <Rp X>
──────────────────────────────────────────────────────────────────
Sum should equal the recurring subtotal in §5.
```

## 7. ROI / payback check (simple screen, not a full TCO/NPV model)

> State this caveat explicitly whenever you present it. A full discount-rate-adjusted model is a heavier follow-on validation, not this sheet's job.

- **Baseline metric:** `<e.g. group revenue, or cost-to-serve baseline>` = `<value>`
- **Assumption — cost-to-serve baseline:** `<% of baseline, with range>` → **Formula:** `baseline × %` = `<Rp X/yr>` (range `<Rp X–Y/yr>`)
- **Target reduction:** `<e.g. 15–20%, pinned by the customer>` → **Formula:** `cost-to-serve baseline × reduction%` = `<Rp X–Y/yr>`, midpoint `<Rp X/yr>`
- **Naive payback** (no ramp): `Total BOM ÷ annualized saving` = `<X months>` — flag as unrealistic if it implies savings before go-live.
- **Ramp-adjusted payback:** assume savings ramp `<linearly / stepwise>` from 0 to full run-rate by month `<N>`. Solve cumulative-savings(T) = Total BOM for breakeven month `<T>`.
- **Reading it:** state where breakeven lands relative to the delivery window, and name the one heavier validation (full TCO/NPV) still owed to the board.

---

## 8. Findings & flags (what the pricing exercise surfaced)

| # | Finding | Line(s) affected | Implication | Severity |
|---|---|---|---|---|
| 1 | `<e.g. a sizing input looks stale>` | `<line #>` | `<send back to sizing before pricing final>` | `<H/M/L>` |
| 2 | `<e.g. one BU's cloud spend has no showback yet>` | `<line #>` | `<recommend tagging discipline before go-live>` | `<…>` |

**One-line scope statement (fill in):**
> `<Customer>`'s BOM lands at **`<Rp X>` (band `<Rp X–Y>`)** over `<horizon>`, `<Rp X>` of it CapEx, breaking even around month `<T>` against the `<%>` `<metric>` target — built from `<sizing lesson>`'s inputs, ready for risk review and LLD.

---

*Worked example: see `example-cakrawala-group-bom.md` in this folder.*
