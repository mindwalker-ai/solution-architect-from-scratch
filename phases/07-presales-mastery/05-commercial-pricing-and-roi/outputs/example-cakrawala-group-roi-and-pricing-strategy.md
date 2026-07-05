---
name: example-cakrawala-group-roi-and-pricing-strategy
description: Worked ROI/TCO Calculator + Pricing Strategy for Cakrawala Group — built on 6.4's cited ~Rp 52.0B (band 48.0-58.0B) BOM, 12-18 month window, and 15-20% cost-to-serve target; milestone pricing tied to 6.5's 3 waves; closes the business case for Capstone G
phase: 7
lesson: 5
audience: internal | executive
---

# ROI/TCO Calculator + Pricing Strategy — Cakrawala Group (Worked Example)

> The template from `template-roi-tco-calculator-and-pricing-strategy.md`, fully worked. Every pinned input below is **cited verbatim from 6.4 (BOM) and 6.5 (risk & migration plan) — none of it is re-derived here.** This is the artifact that closes the commercial case for Capstone G, the Executive Presales Demo.

**Customer:** Cakrawala Group  ·  **Industry:** Diversified conglomerate (retail, logistics, finance-leasing)  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** Group-wide digital transformation — shared K8s platform, bounded AI ops-copilot, in-country lakehouse
**Competitive context:** A rival global systems integrator is pricing a competing bid for the same program.

---

## 1. Pinned inputs (cited from 6.4 and 6.5 — not re-derived)

```
Investment (3-yr TCO, pinned) ............ ~Rp 52.0B          (board band Rp 48.0-58.0B)      [6.4]
Delivery window (pinned) ................... 12-18 months, 3 migration waves                    [6.4, 6.5]
Group revenue (baseline metric) ............ ~Rp 8 trillion / year                                [6.4]
Cost-to-serve baseline (assumption) ........ ~12% of group revenue, range 10-14%
  -> Rp 960B/yr  (range Rp 800B-1.12T/yr)                                                          [6.4 Step 6]
Target cost-to-serve reduction (pinned) .... 15-20%
  -> Rp 144B/yr @ 15%  ...  Rp 192B/yr @ 20%  ...  midpoint ~Rp 168B/yr                             [6.4 Step 6]
6.4's own ramp-adjusted central-case payback  ~13 months                                           [6.4 Step 6]
```

**These figures are fixed.** If any looks wrong from this side of the engagement, the correct action is to flag it back to 6.4/6.5 and re-price there — not to adjust it here. This sheet's job is to build the pricing structure and the fuller sensitivity grid on top of these exact numbers.

## 2. Pricing structure decision

| Structure | Who bears schedule/scope risk | Fits this deal when… | Chosen? |
|---|---|---|---|
| Fixed-price | Vendor | Scope is genuinely stable, low change risk | **N** — 6.5's own risk register (risks #3, #4, #6, #7) shows real integration and schedule uncertainty across 3 BUs; fixed-price would turn every legitimate discovery into an adversarial change order |
| Time & materials (T&M) | Customer | Scope is deliberately exploratory | **N** — the board has a pinned ceiling (Rp 45–65B); it cannot approve an open tab |
| **Milestone-based** | Shared, tied to verifiable gates | Delivery is already staged into waves with named exit criteria | **Y — primary structure** |
| Outcome-based / gainshare | Vendor, offset by upside | The target outcome is independently measurable | **Y — secondary layer only** (capped kicker on top of the milestone structure, tied to the 15–20% cost-to-serve range 6.4 already defined) |

**Decision + rationale:** Cakrawala's delivery is already staged into three waves with named, verifiable exit criteria (6.5: Wave 0 Foundation, Wave 1 Retail, Wave 2 Logistics, Wave 3 Finance-leasing behind a compliance gate). Milestone-based pricing makes the commercial schedule and the delivery schedule the *same* document — the customer never pays ahead of verified progress, and delivery is never asked to keep funding work past a stage nobody has accepted. A capped gainshare kicker is layered on top because the outcome metric (cost-to-serve reduction) is already independently measurable per 6.4's own baseline and target — it costs nothing if the outcome lands at 15% and rewards the vendor only if it tracks toward 20%.

## 3. Milestone / payment schedule

```
GATE   TRIGGER (from 6.5's wave exit criteria)                    %       Amount (of Rp 52.0B central estimate)
────────────────────────────────────────────────────────────────────────────────────────────────────────────
M0     Contract signature, team mobilized                          15%    Rp 7.8B
M1     Wave 0 exit — platform live (40 nodes, GPU node, lakehouse); 15%    Rp 7.8B
       event bus + ACL smoke-tested; security baseline (6.2) verified
M2     Wave 1 exit — Retail: SLO stable 30 consecutive days,        20%    Rp 10.4B
       reconciliation matches legacy
M3     Wave 2 exit — Logistics: same bar as Wave 1, PLUS event bus  20%    Rp 10.4B
       proven stable under a second BU's traffic shape
M4     Wave 3 compliance sign-off gate cleared (all 4 checks:       10%    Rp 5.2B
       residency, audit trail, regulatory reporting, rollback
       drill) — BEFORE finance-leasing cutover starts
M5     Wave 3 exit — finance-leasing cutover stable, extended       15%    Rp 7.8B
       3-month parallel-run window closed; final acceptance
Retention   Released at formal program sign-off                     5%    Rp 2.6B
────────────────────────────────────────────────────────────────────────────────────────────────────────────
TOTAL                                                               100%   Rp 52.0B
────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

**Formula:** `milestone payment = gate % x Rp 52.0B central estimate`. **Range:** if the contract prices at the band's edges (Rp 48.0B or Rp 58.0B) instead of the central Rp 52.0B, every milestone rescales proportionally — the percentages are the pinned agreement, not the rupiah amounts.

**Rationale for the weighting:** M2 and M3 (retail and logistics wave exits) carry the two largest shares because 6.5's risk register scores its highest technical/delivery risks there (risk #3 — schedule; risk #4 — ACL mistranslation; risk #6 — event-bus message loss; risk #7 — wave-to-wave cascade). Paying the vendor as those specific risks retire, rather than on a flat calendar schedule, keeps the commercial incentive aligned with the risk register the whole program is managed against. M4, the compliance gate, is deliberately its own smaller line — a regulatory go/no-go control, not a delivery milestone, so nobody is incentivized to rush a sign-off (per 6.5 risk #2) for a payment.

**Cash-flow view against 6.5's wave calendar:**

```
CASH-FLOW VIEW — milestone payments against 6.5's wave calendar (months)
──────────────────────────────────────────────────────────────────────────────
Month:      1        3            8              12            17/18
Wave:     [Wave 0: Foundation][Wave 1: Retail][Wave 2: Logistics][Wave 3: Fin-leasing]
Payment:    M0       M1           M2             M3        M4  M5
            (sign,   (foundation  (retail        (logistics (gate)(final,
            mobil-   live)        stable 30d)    stable)          extended
            ize)                                                  parallel-
                                                                    run closed)
% of Rp52.0B: 15%      15%          20%            20%      10% 15% (+5% retention)
──────────────────────────────────────────────────────────────────────────────
```

## 4. ROI/TCO sensitivity grid

```
ROI / TCO CALCULATOR — built on 6.4's pinned inputs, not new assumptions
═══════════════════════════════════════════════════════════════════════
INPUTS (cited from 6.4, verbatim)
  Cost-to-serve baseline .......... ~Rp 960B/yr  (range Rp 800B-1.12T/yr)
  Target reduction (pinned) ....... 15-20%
  Investment / BOM (pinned) ....... ~Rp 52.0B    (band Rp 48.0-58.0B)
  Adoption ramp (from 6.4) ........ linear, 0% at kickoff -> full run-rate by month 24

FORMULAS
  Annual saving          = cost-to-serve baseline x target reduction%
  Cumulative saving(T)   = Annual saving x T^2 / 4        for T <= 2 years  [6.4's ramp curve]
  Payback period T (yrs) = 2 x SQRT( BOM / Annual saving )

SENSITIVITY GRID — payback period (months), BOM band x savings range
                                Savings @ 15%           Savings @ 20%
                                (Rp 144B/yr)             (Rp 192B/yr)
─────────────────────────────────────────────────────────────────────
  BOM Rp 48.0B (low band)         13.9 months             12.0 months
  BOM Rp 52.0B (central)          14.4 months             12.5 months  <- 6.4's own
                                                                          midpoint case
                                                                          (168B/yr) landed
                                                                          at ~13 months,
                                                                          inside this cell
  BOM Rp 58.0B (high band)        15.2 months             13.2 months
─────────────────────────────────────────────────────────────────────
ILLUSTRATIVE PAYBACK RANGE: ~12-15 months across the full grid.
BOARD HEADLINE: present as "12-16 months" to leave honest margin at the edges.
NEVER present the 13-month central figure alone.
```

**Reading it for the room:** even the grid's worst case (Rp 58.0B invested, only 15% of the cost-to-serve target achieved) breaks even at ~15.2 months — still inside the 18-month delivery window, with roughly 20+ months of the 3-year TCO horizon still ahead to keep capturing savings. The best case breaks even at 12 months. Every cell in the grid is a genuine payback inside the program's own delivery window — that is the commercial argument, delivered as a grid the CFO's own team can recompute, not a number they're asked to trust.

## 5. Negotiation levers

**Contingency treatment — chosen: contingency-separate**, for use against the competing global-SI bid:

| | Contingency-inclusive | **Contingency-separate (chosen)** |
|---|---|---|
| Headline number | Rp 52.0B, all-in | **Rp 48.0B base** + a capped **Rp 4.0B** contingency reserve |
| How contingency is drawn | Bundled, no separate approval | Drawn only against a *named, occurring* risk from 6.5's register (FX, integration, schedule compression, licensing true-up — the same four risks 6.4 already priced), billed as it fires |
| Why chosen here | — | A rival GSI bid is in play; leading with Rp 48.0B is 6.4's own honest subtotal, gives the customer's finance team visible control over the Rp 4.0B reserve, and is not a discount — the floor is still ~Rp 48.0B either way |

**Gainshare kicker:** if measured cost-to-serve reduction at the 18-month mark, per BU, exceeds 15% and tracks toward the 20% end of the pinned range, a capped single-digit-percentage bonus of contract value pays out at the M5 gate. Costs nothing if the outcome lands at 15%; answers the board's "what if it works even better than promised" question that a purely milestone-priced competitor bid leaves open.

## 6. One-page commercial summary

```
COMMERCIAL SUMMARY — Cakrawala Group Transformation Program
─────────────────────────────────────────────────────────────────────────
INVESTMENT (cited from 6.4, not re-derived)   ~Rp 52.0B  (band Rp 48.0-58.0B)
DELIVERY WINDOW (cited from 6.4/6.5)          12-18 months, 3 waves
PRICING STRUCTURE                             Milestone-based, 6 gates + retention,
                                               tied 1:1 to 6.5's wave exit criteria
CONTINGENCY TREATMENT                         Contingency-separate:
                                               Rp 48.0B base + capped Rp 4.0B reserve
                                               (drawn only against 6.5's named risks)
PAYBACK (illustrative, full sensitivity grid) ~12-15 months; board headline:
                                               "12-16 months" across the pinned BOM
                                               band x 15-20% savings range
UPSIDE MECHANISM                              Capped gainshare kicker if measured
                                               reduction tracks toward 20% by month 18
─────────────────────────────────────────────────────────────────────────
ONE LINE: staged payment against 6.5's own verified wave gates, an honest
12-16 month payback range instead of a single guessed number, and upside
shared with the vendor only if the outcome overshoots — approvable by the
steering committee in one meeting.
```

---

## 7. Findings & flags

| # | Finding | Section affected | Implication | Severity |
|---|---|---|---|---|
| 1 | Payback grid assumes the 24-month adoption-ramp horizon holds even if a wave's timeline compresses (per 6.4 Exercise 3's schedule-compression logic) | §4 | If delivery compresses to 9–10 months, the ramp horizon does not automatically compress with it — track adoption as its own leading indicator, not a proxy for delivery speed | M |
| 2 | Gainshare kicker requires a measurement mechanism for cost-to-serve reduction per BU that does not yet exist in the architecture | §5 | Add a metering/observability requirement to the HLD (6.6) before this clause is contractually binding | M |
| 3 | Contingency-separate framing is a genuine concession only if the customer's risk appetite is real, not just negotiating posture | §5 | If the rival GSI bid is a flat number with no equivalent transparency, this lever should win the room; confirm before relying on it as the primary competitive differentiator | L |

**One-line scope statement:**
> Cakrawala Group's commercial package prices milestone payments 1:1 against 6.5's three wave exit gates, presents a **12–16 month illustrative payback range** built on 6.4's exact **~Rp 52.0B (band Rp 48.0–58.0B)**, **12–18 month**, and **15–20% cost-to-serve reduction** figures — cited verbatim, not re-derived — and adds a contingency-separate quote plus a capped gainshare kicker as the two levers to win against a competing global-SI bid.
