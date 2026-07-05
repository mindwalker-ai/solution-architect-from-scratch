---
name: example-cakrawala-group-bom
description: Worked BOM + Pricing Sheet for Cakrawala Group — lands on ~Rp 52.0B (board band Rp 48.0-58.0B) 3-year TCO; cited verbatim by 6.7 (Writing the LLD)
phase: 6
lesson: 4
audience: internal | executive
---

# BOM + Pricing Sheet — Cakrawala Group (Worked Example)

> The template from `template-bom-pricing-sheet.md`, fully worked. This is the number 6.7 (LLD) cites when it needs exact figures — don't drift from it downstream without re-running this sheet.

**Customer:** Cakrawala Group  ·  **Industry:** Diversified conglomerate (retail, logistics, finance-leasing)  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** Group-wide digital transformation — shared K8s platform, bounded AI ops-copilot, in-country lakehouse
**Version:** v1.0 — priced off 6.3's sizing output
**TCO horizon:** 3 years  ·  **Currency:** Indonesian Rupiah (Rp), billions unless marked `/yr` or `/mo`
**Budget ceiling (pinned):** ~Rp 45–65 billion  ·  **Delivery window (pinned):** 12–18 months

---

## 1. Sizing inputs (recap from 6.3 — not re-derived here)

```
~40 mid-size Kubernetes nodes — shared platform underneath all 3 BUs
1 on-prem GPU node, 2x GPU-class cards (L40S-class) — bounded AI ops-copilot only
1 mid-size, single-region, in-country lakehouse — shared analytics/data platform
```

These three facts drive every priced line below. If 6.3 revises any of them, re-run this sheet from Step 2 of the lesson — do not hand-adjust a total.

## 2. Itemized line items (assumption + formula + range)

| # | Line item | Assumption | Formula | Estimate | Range |
|---|---|---|---|---|---|
| 1 | Infrastructure (hardware) | 40 nodes @ ~Rp 220M installed (compute/RAM/NVMe, rack+network amortized) · GPU node (2× L40S-class + host) @ ~Rp 1.2B · shared fabric/storage/racking @ ~40% of compute HW | (40×220M) + 1.2B + 0.40×(8.8B+1.2B) | **Rp 14.0B** | Rp 13.0–15.4B |
| 2 | Cloud (retail + logistics public-cloud, 3-yr) | Retail ~Rp 140M/mo (web/mobile/edge) + Logistics ~Rp 110M/mo (tracking, routing, DR); finance-leasing runs on the private shared platform, not counted here | (140M+110M)×36mo | **Rp 9.0B** (Retail 5.0B + Logistics 4.0B) | Rp 7.0–11.0B |
| 3 | Data platform (lakehouse, 3-yr) | Mid-size single-region lakehouse: storage + compute + platform licensing ~Rp 2.0B/yr average | Rp 2.0B × 3 | **Rp 6.0B** | Rp 5.0–7.0B |
| 4 | AI (bounded ops-copilot, 3-yr) | Inference/orchestration software, vector store, guardrails, token spend ~Rp 1.0B/yr — GPU hardware already in line 1 | Rp 1.0B × 3 | **Rp 3.0B** | Rp 2.0–4.0B |
| 5 | Software licensing (3-yr) | Platform management, event-bus + API-gateway licensing, observability/security tooling, blended across shared platform + 3 BUs ~Rp 1.67B/yr | Rp 1.67B × 3 | **Rp 5.0B** | Rp 4.0–6.0B |
| 6 | Professional services / labor (12–18mo build) | ~25 FTE blended team (architects, platform/data/AI engineers, PM) × 14-month average tenure × ~Rp 31M/FTE-month blended rate | 25 × 14 × 31M | **Rp 11.0B** | Rp 9.0–13.0B |
| | **Subtotal (lines 1–6)** | | | **Rp 48.0B** | — |
| 7 | Contingency / risk buffer | Risk-based — see §3 | sum of named risks | **Rp 4.0B** (~8.3% of subtotal) | Rp 3.0–5.0B |
| | **TOTAL (3-yr TCO)** | | | **~Rp 52.0B** | **Rp 48.0–58.0B** |

**Sanity check performed:** the 40-node hardware assumption was cross-checked against a server OEM's list-price quote for comparable dual-socket, 512–768GB RAM configurations; the blended FTE-month rate was cross-checked against the delivery bench's own rate card for a mixed onshore/specialist team. Both landed inside the stated ranges.

**Board-level band, honestly:** summing every line's own worst case (15.4+11+7+4+6+13+5 ≈ Rp 61.4B) would overstate risk — it assumes FX, scope creep, and cloud overage all land badly in the same year. **Rp 48.0–58.0B is a ±12% portfolio band around the Rp 52.0B central estimate**, and it comfortably clears the pinned Rp 45–65B ceiling with room for one round of scope negotiation.

**Why the AI line stays small:** contrasted against a hypothetical Bumi-Energi-scale deployment (multi-site industrial computer vision + predictive maintenance across dozens of plants, needing a multi-node GPU cluster), that AI line alone could plausibly run Rp 25–40B — several times Cakrawala's entire contingency budget. Cakrawala's copilot is deliberately bounded to one node, two cards, one use case, which is why AI is ~6% of this BOM, not its headline.

## 3. Contingency worksheet (risk-based)

```
NAMED RISK                                                       BUFFER
─────────────────────────────────────────────────────────────────────
FX exposure — imported GPU/hardware, procurement-window swing      Rp 1.2B
Integration unknowns — legacy systems across 3 BUs (6.1/6.2)       Rp 1.5B
Delivery-window compression — 12mo vs the full 18mo window         Rp 0.8B
Licensing/cloud true-up — usage-based overage at go-live           Rp 0.5B
─────────────────────────────────────────────────────────────────────
TOTAL CONTINGENCY                                                   Rp 4.0B
```

## 4. CapEx / OpEx split (accounting lens)

| View | Line items | Amount |
|---|---|---|
| **CapEx** (capitalizable hardware) | Infrastructure (#1) | **Rp 14.0B** |
| **OpEx** (expensed) | Cloud + Data + AI + Licensing + Services + Contingency (#2–7) | **Rp 38.0B** |
| **Total** | | **Rp 52.0B** |

## 5. One-time vs recurring split (cash-flow lens)

| View | Line items | Amount |
|---|---|---|
| **One-time** (Year-1-weighted cash out) | Infrastructure (14.0) + Services/labor (11.0) + Contingency (4.0) | **Rp 29.0B** |
| **Recurring** (3-yr OpEx run-rate) | Cloud (9.0) + Data platform (6.0) + AI (3.0) + Licensing (5.0) | **Rp 23.0B** |
| **Total** | | **Rp 52.0B** |

## 6. 3-year run-rate view

```
YEAR     RECURRING LINES (ramping)                       CUMULATIVE
────────────────────────────────────────────────────────────────────
Year 1   Rp 4.0B    (partial — systems land mid-build)      Rp 4.0B
Year 2   Rp 9.0B    (near-full run-rate)                    Rp 13.0B
Year 3   Rp 10.0B   (full run-rate + normal growth)         Rp 23.0B
────────────────────────────────────────────────────────────────────
Sum = Rp 23.0B, matches the recurring subtotal in §5.
```

## 7. ROI / payback check

> Simple payback screen — not a full discount-rate-adjusted TCO/NPV model. That heavier validation is follow-on work for the board, protected in the interim by the contingency line above and by 6.5's risk register.

- **Group revenue:** ~Rp 8 trillion/year (deal discovery baseline).
- **Cost-to-serve baseline (assumption):** ~12% of group revenue, range 10–14%.
  **Formula:** Rp 8T × 12% = **Rp 960B/yr** (range Rp 800B–1.12T/yr).
- **Target reduction (pinned):** 15–20%.
  **Formula:** Rp 960B × 15% = Rp 144B/yr; Rp 960B × 20% = Rp 192B/yr; **midpoint ~Rp 168B/yr**.
- **Naive payback** (no ramp): Rp 52.0B ÷ Rp 168B/yr ≈ 0.31 yr (~4 months) — **rejected**, assumes savings from day one.
- **Ramp-adjusted payback:** savings ramp linearly from 0% at kickoff to full run-rate by month 24. Cumulative saving(T years, T≤2) ≈ Rp 168B × T²/4. Solve `168×T²/4 = 52` → `T² ≈ 1.24` → **T ≈ 1.11 years ≈ 13 months.**
- **Reading it:** breakeven lands inside the 12–18 month delivery window — a credible payback story, achieved because AI and infra spend were kept bounded rather than gold-plated.

---

## 8. Findings & flags

| # | Finding | Line(s) affected | Implication | Severity |
|---|---|---|---|---|
| 1 | Finance-leasing BU carries no public-cloud spend in this BOM | Line 2 (Cloud) | Confirm it stays fully on the shared private platform through delivery; if it later needs cloud burst capacity, re-price Line 2 | M |
| 2 | Contingency assumes FX and integration risk are independent | Line 7 | If both materialize in the same quarter, the Rp 4.0B buffer will not cover both — feed this into 6.5's risk register as a correlated-risk flag | M |
| 3 | ROI ramp assumes adoption completes by month 24 | §7 | If adoption lags (common with an ops-copilot), payback shifts past month 13 — track adoption as a leading indicator, not just go-live | L |

**One-line scope statement:**
> Cakrawala Group's transformation BOM lands at **~Rp 52.0 billion (board band Rp 48.0–58.0 billion)** over a 3-year TCO, **Rp 14.0B of it CapEx**, breaking even around **month 13** against the 15–20% cost-to-serve target — built from 6.3's sizing inputs (40 K8s nodes, 1 GPU node with 2× L40S-class cards, 1 mid-size lakehouse), ready for 6.5's risk review and the exact figure 6.7's LLD builds against.
