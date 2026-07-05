---
name: example-pasarkita-tco-and-finops
description: Worked TCO/Cost Model + FinOps Plan for PasarKita — an Indonesian marketplace whose cloud bill is the CFO's #1 issue. Models today's single-cloud run-rate to a hybrid target (index 100 → ~58, band 25–45%), with flash-sale peaks on autoscale+spot, cost-per-order down ~42%, and residency enforced by guardrail + CSPM. Feeds Capstone C.
phase: 3
lesson: 7
audience: customer | executive
---

# TCO/Cost Model + FinOps Plan — PasarKita (Worked Example)

> This is the [TCO/Cost Model + FinOps Plan template](./template-tco-cost-model-and-finops-plan.md) filled in for **PasarKita** (fictional): an Indonesian e-commerce marketplace, ~15M active buyers, ~200,000 sellers, ~2M orders/day, flash sales that spike traffic ~10× for a few hours. It runs on a **single public cloud** plus an **on-prem finance/ERP** estate and is moving to **hybrid**; **payment data must stay in Indonesia**. The cloud bill is the CFO's #1 issue. This plan answers her three questions — *why did the bill outgrow orders, what does an order cost, and are we paying for flash sales all month* — and feeds Capstone C.

**Customer:** PasarKita  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement:** Hybrid cloud program — cost control + security posture  ·  **Version:** v0.1 draft

**Hard facts (given):** ~15M active buyers · ~200,000 sellers · ~2M orders/day · flash sale ~10× for a few hours · single public cloud + on-prem finance/ERP · moving to hybrid · payment data stays in Indonesia.
**Everything else below is a labelled `ASSUMPTION (confirm from the billing & usage export)` carried as a band.** The percentages illustrate the *method*; re-derive them from PasarKita's actual Cost & Usage Report before quoting.

---

## 1. Cost decomposition — where the money goes (Inform)

PasarKita has **no tagging today**, so the first finding writes itself: a large share of spend is un-attributable — the CFO can't see which team or service caused the growth. Allocating the export across the five drivers (as bands to confirm):

| Driver | Share of today's bill (ASSUMPTION) | Band | Note |
|---|---|---|---|
| Compute (steady + peak) | ~45% | 40–55% | **flash-sale capacity left always-on** — the fat target |
| Managed-service premium | ~20% | 15–25% | managed DB / search / queue / LB markup |
| Data egress | ~15% | 10–20% | cross-region analytics pulls + internet delivery |
| Storage | ~12% | 8–15% | hot tier + un-lifecycled snapshots & logs |
| Idle / over-provisioned | ~8% | 5–15% | dev/staging 24/7, oversized fleets, orphaned disks/IPs |

**Two fattest addressable lines:** compute provisioned for a peak that lasts hours, and idle nobody owns. Everything downstream attacks these.

## 2. Cost model — today (single cloud) vs hybrid target

The move that carries the story: today's always-on flash-sale capacity (~15 units) collapses to ~5 when the 10× spike rides **autoscaling + spot** for the few hours it exists, instead of renting the peak all month.

```
COST MODEL — today (single cloud) vs hybrid target     [cost-units/month; 100 = today's bill]
                                          all composition %/Δ are ASSUMPTIONS — confirm from the export
 DRIVER                 TODAY   LEVER APPLIED                              TARGET   Δ
 ───────────────────────────────────────────────────────────────────────────────────────────
 Compute — steady         30    commit (savings plan / CUD) + rightsize      18    −40%
 Compute — flash-sale     15    autoscale + spot (not always-on 10×)          5    −67%
 Managed-service premium  20    keep managed only where it earns its keep     16    −20%
 Data egress              15    CDN + keep traffic in-region + fewer hops      9    −40%
 Storage                  12    tiering hot→infrequent→archive + cleanup       8    −33%
 Idle / over-provisioned   8    kill orphans · schedule dev-test off           2    −75%
 ───────────────────────────────────────────────────────────────────────────────────────────
 TOTAL (cloud run-rate)  100                                                  58    −42%  (band 25–45%)
 on-prem finance/ERP      —     unchanged (sunk); hybrid adds burst headroom, not a second estate
```

```
                       AUTOSCALE + SPOT  vs  ALWAYS-ON PEAK  (illustrative capacity over a day)

 capacity                    ┌──flash sale──┐                     always-on peak line ($$$ 24h)
   10× ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┤              ├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
                             ╱                ╲
    1× ─────────────────────╱                  ╲────────────────  committed / on-prem baseline
        00:00      elastic burst scales WITH demand           23:59
        pay for the shaded spike only  ◀── this is the saving ──▶  not the whole rectangle
```

**Modeled result:** cloud run-rate **~58 units (band 55–75) — a 25–45% reduction**, with the committed baseline optionally shifting to on-prem in the hybrid target. Biggest lever: **flash-sale elasticity.** The on-prem finance/ERP is a *sunk* estate, not a second bill.

## 3. Tagging & showback scheme

| Tag | Values (PasarKita) | Serves |
|---|---|---|
| `owner` / `team` | payments, search, catalog, seller-portal, checkout | FinOps showback **and** security ownership |
| `environment` | prod / staging / dev | schedule dev+staging off-hours (attacks the idle line) |
| `service` / `cost-center` | checkout, catalog, ledger, recommendations | cost-per-service → cost-per-order roll-up |
| `data-class` | **payment** / pii / public | drives the residency + encryption guardrails (§6) |

Start with **showback** — each team sees the cost it caused, no billing fight — and move to **chargeback** once the culture holds. Enforce the tag set with a **require-tags guardrail** (§6): one control feeding both the FinOps roll-up and security ownership.

## 4. Rightsizing + commitment strategy (the elasticity design)

- **Rightsize & kill idle first** — right-size the oversized steady fleet and turn off dev/staging out-of-hours **before** buying any commitment, so waste isn't locked in.
- **Commit the baseline** — cover ~60–80% (ASSUMPTION) of the steady floor with **savings plans / committed-use discounts**, headroom left for buyer growth.
- **Burst on spot** — flash-sale workers, batch, recommendations pre-compute, and stateless API tiers ride **spot/preemptible**; the 10× spike becomes a variable cost, not a capital decision. Keep the **payment/ledger core on-demand or committed** — never spot (it must not be reclaimed mid-transaction).
- **On-demand** — the unpredictable middle only.

*Risk both ways:* under-commit → discount left on the table; over-commit → paying for capacity a migration is about to reshape (see the Capstone C wave plan before committing).

## 5. Cost per order — the unit metric for the CFO

Orders are a **given** fact: ~2M/day → **~60M/month**.

```
cost per order = monthly cloud cost ÷ monthly orders
   today    index 1.00   (100 cost-units / 60M orders)
   target   index 0.58   (58 cost-units / 60M orders)   →  ~42% lower cost-to-serve per order
```

Answering the CFO's three questions:

1. **"Why did the bill outgrow orders?"** — Because ~8% is pure idle waste and ~15% is flash-sale capacity billed 24/7; both scale with *time*, not orders. Fix them and spend re-couples to orders.
2. **"What does an order cost?"** — Index 1.00 today, modeled to 0.58 — **and now it's a tracked metric**, not a mystery. Month-over-month trend becomes the leak detector.
3. **"Are we paying for flash sales all month?"** — Today, yes (always-on). In the target, the sale's capacity exists only during the sale, so per-order cost **holds flat through a spike** instead of the sale's idle capacity inflating *every* order all month.

## 6. Security guardrails, CSPM & residency (Operate)

Cost governance and security share the same landing zone (from 3.1), so they're designed together.

```
 SECURITY POSTURE — PasarKita — control × what it prevents × enforcement (preventive | detective)
 ──────────────────────────────────────────────────────────────────────────────────────────────────────
 CONTROL FAMILY          PREVENTS                          PREVENTIVE (guardrail/SCP)      DETECTIVE (CSPM)
 ──────────────────────────────────────────────────────────────────────────────────────────────────────
 Identity (IAM)          over-broad access · leaked keys   deny root · no long-lived keys   flag over-permissive roles
 Data residency          payment data leaving Indonesia    deny non-Indonesia regions       flag any resource off-region
 Public exposure         open buckets / DBs to internet    block public access              flag public storage / open SG
 Encryption at rest      readable disks/snapshots/backups  deny unencrypted create           flag unencrypted volumes/keys
 Encryption in transit   sniffed traffic                   TLS-only endpoints                flag plaintext listeners
 Network segmentation    lateral movement                  per-env accounts + private links  flag cross-env / open egress
 Tagging & ownership     un-owned spend/risk               require owner + env tags          flag untagged resources
 Landing-zone baseline   drift from the 3.1 guardrails     org SCPs on every account         continuous conformance scan
```

- **Residency (the non-negotiable):** payment/PII accounts get an SCP that **denies resource creation outside Indonesian regions** — an engineer *cannot* place payment data in the wrong region — and CSPM raises a **residency alarm** on any drift. KMS keys are held in-country.
- **IAM:** SSO-federated roles, **no long-lived access keys**, scoped policies, monitored break-glass — no standing `*:*`.
- **Network & encryption:** per-environment account/VPC separation with **private links** (which also trims the egress cost line), TLS/mTLS in transit, encryption at rest via in-country KMS.
- **CSPM routing:** page on the critical few (public payment store, off-region payment data, root-key use); ticket the rest.
- **Cost×security fusion:** the **require-tags** guardrail and **egress/region** controls each serve both budgets — one design, two problems solved.

## 7. Assumptions & risks register

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | Cost composition | 45/20/15/12/8 by driver | see §1 bands | usage export (CUR) | shifts which lever pays most |
| 2 | Lever effectiveness | Δ per driver in §2 | ±10–15pp | pilot on checkout service | target 58 → band 55–75 |
| 3 | Commitment coverage | ~70% of baseline | 60–80% | baseline-utilization report | over/under-commit |
| 4 | Flash-sale duration | "a few hours" (given) | as given | traffic history | burst savings change |
| 5 | Residency scope | payment data (given) | + PII? confirm | legal / compliance | guardrail scope widens |
| 6 | Tagging adoption | ~0% today | 0→100% | tag audit | showback accuracy |
| 7 | On-prem baseline split | steady stays cloud (committed) | cloud ↔ on-prem | Capstone C hybrid design | shifts committed vs sunk |

**One-line cost & governance statement:**
> PasarKita's single-cloud run-rate models to **~58 cost-units (a 25–45% reduction)** with the ~10× flash-sale peak handled by **autoscale + spot** instead of always-on capacity, giving a **cost-per-order of index 0.58 (down ~42%)** that stays flat through a sale; the estate stays safe and **in-Indonesia** via preventive guardrails (residency, public-access, encryption, required tags) plus continuous CSPM. The two dials the customer turns: **commitment coverage** (60–80%) and the **cloud-vs-on-prem baseline split**.

## Why this beats the guess

PasarKita's instinct — "the cloud is elastic, it'll sort itself out" — is exactly how the bill outran orders: elastic *up* is automatic, elastic *down* is a design decision nobody made, so flash-sale capacity stayed on and idle dev never turned off. By decomposing the bill, moving the peak onto autoscale + spot, committing only the *rightsized* baseline, and exposing **cost per order** as a tracked metric, this plan turns an unexplained invoice into a governed, falling per-unit cost the CFO can defend to the board — while the same landing zone's guardrails keep payment data in-country and the attack surface mapped. That is the cost-and-governance chapter that keeps the Capstone C program funded.

## Carry-forward → Capstone C (hybrid cloud proposal)

| Proposal chapter | From this plan | Confirm before commit |
|---|---|---|
| Cost model / TCO | §2 today-vs-target (index 100 → 58, band 25–45%) | actual usage export |
| Commitment purchase | §4 ~70% baseline coverage | baseline stability + migration timing (don't commit a fleet you're reshaping) |
| Unit economics | §5 cost per order (index 0.58) | orders denominator + billing period |
| Security posture | §6 guardrails + CSPM + residency | residency scope with legal; CISO sign-off |
| FinOps operating model | §3 showback → chargeback | central guardrails + team-level optimization |
