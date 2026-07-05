---
name: template-tco-cost-model-and-finops-plan
description: TCO/Cost Model + FinOps Plan — a cost model (today vs target, with bands), optimization-lever plan, tagging/showback scheme, cost-per-order unit economics, and a preventive+detective security-controls checklist for a cost-pressured cloud estate
phase: 3
lesson: 7
audience: customer | executive
---

# TCO/Cost Model + FinOps Plan — Template

> Fill this in for a customer whose cloud cost is a board-level issue and whose estate is spreading (multi-account / hybrid / multi-cloud). It is the cost-and-governance chapter of a cloud proposal: the CFO must trust the numbers, the CISO must trust the controls, and both must see stated assumptions, not magic numbers.

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`

**Hard facts (given — do NOT invent business numbers):** `<active users>` · `<sellers/accounts>` · `<orders or txns per day = the unit-economics denominator>` · `<peak multiplier, e.g. Nx for M hours>` · `<current placement: single/multi cloud + on-prem>` · `<residency constraint>`.
**Everything else below is a labelled `ASSUMPTION (confirm from the billing & usage export)` carried as a band.** Legend: CUR/usage export = the detailed billing export · SP = savings plan · CUD = committed-use discount · SCP = service control policy (org guardrail) · CSPM = cloud security posture management.

---

## How to use this template

1. **Inform** — decompose today's bill across the five drivers (§1). No tagging yet? That's your first finding.
2. **Model** — apply levers driver by driver; land a target **range**, not a promise (§2).
3. **Allocate** — define the tag set + showback scheme so every cost has an owner (§3).
4. **Commit** — rightsize and kill idle *first*, then commit the baseline, burst on spot (§4).
5. **Unit-economics** — convert the model into cost per `<order/txn>` for the CFO (§5).
6. **Secure** — map the guardrails (preventive) and CSPM (detective), incl. residency (§6).
7. **Assemble** — the one-line statement + carry-forward (§7–8).

---

## 1. Cost decomposition — where the money goes (Inform)

> Pull the usage export and allocate spend across the five drivers. State as a band to confirm.

| Driver | Share of today's bill (ASSUMPTION — confirm) | Band | Note |
|---|---|---|---|
| Compute (steady + peak) | `<~x%>` | `<a–b%>` | is peak capacity left always-on? |
| Managed-service premium | `<~x%>` | `<a–b%>` | which services earn their markup? |
| Data egress | `<~x%>` | `<a–b%>` | cross-region / cross-cloud / internet |
| Storage | `<~x%>` | `<a–b%>` | hot tier · snapshots · logs |
| Idle / over-provisioned | `<~x%>` | `<a–b%>` | the pure-waste line; grows without tagging |

*Findings to flag:* share of spend that is **un-attributable** (no tags) · the two fattest addressable lines.

## 2. Cost model — today vs target

> Every %/Δ is an ASSUMPTION to re-derive from the export. The method (driver → lever → range → unit metric) is the deliverable, not the digits.

```
COST MODEL — today (<placement>) vs <target>          [cost-units/month; 100 = today's bill]
 DRIVER                 TODAY   LEVER APPLIED                        TARGET   Δ
 ─────────────────────────────────────────────────────────────────────────────────────
 Compute — steady        <..>   commit (SP/CUD) + rightsize          <..>   <..%>
 Compute — peak/burst    <..>   autoscale + spot (not always-on)     <..>   <..%>
 Managed-service premium <..>   keep managed only where it pays      <..>   <..%>
 Data egress             <..>   CDN + in-region + fewer hops         <..>   <..%>
 Storage                 <..>   tiering hot→infrequent→archive       <..>   <..%>
 Idle / over-provisioned <..>   kill orphans · schedule off-hours    <..>   <..%>
 ─────────────────────────────────────────────────────────────────────────────────────
 TOTAL (cloud run-rate)  100                                         <..>   <..%>  (band <a–b%>)
 on-prem <finance/ERP>   —      unchanged (sunk) / migrated per §wave plan
```

*Biggest lever (name it):* `<usually peak elasticity: burst instead of always-on>`.

## 3. Tagging & showback scheme

| Tag | Values (example) | Serves |
|---|---|---|
| `owner` / `team` | `<team-a, team-b>` | FinOps showback **and** security ownership |
| `environment` | prod / staging / dev | off-hours scheduling; guardrail scope |
| `service` / `cost-center` | `<service-x>` | cost-per-service → unit-economics roll-up |
| `data-class` | `<payment/pii/public>` | drives residency + encryption guardrails |

- **Showback** (each team sees its cost) → introduce first.
- **Chargeback** (cost hits the team's budget) → mature end-state.
- Enforce the tag set with a **require-tags guardrail** (§6) — one control serving cost *and* security.

## 4. Rightsizing + commitment strategy

- **Rightsize & kill idle FIRST** — never commit to an oversized fleet.
- **Commit the baseline** — cover `<~60–80%, ASSUMPTION>` of the steady floor with SP/CUD; leave growth headroom.
- **Burst on spot/preemptible** — interruptible work (peak, batch, stateless workers).
- **On-demand** — the unpredictable middle only.

*Risk both ways:* under-commit → discount left on the table; over-commit → paying for unused capacity. State coverage as a band.

## 5. Unit economics — cost per `<order/txn>` (for the CFO)

```
cost per <order> = monthly cloud cost ÷ monthly <orders>     (<orders> is a GIVEN fact)
   today   index 1.00   (<100> units / <orders/mo>)
   target  index <..>   (<target> units / <orders/mo>)   → <..%> lower cost-to-serve
```

Present three ways: **today vs target** (efficiency), **month-over-month trend** (leak detector), **peak behavior** (elastic holds the per-unit cost during a spike; always-on inflates every unit all month).

## 6. Security-controls checklist (preventive guardrails × detective CSPM)

```
 CONTROL FAMILY          PREVENTS                         PREVENTIVE (guardrail/SCP)      DETECTIVE (CSPM)
 ──────────────────────────────────────────────────────────────────────────────────────────────────────
 Identity (IAM)          over-broad access · leaked keys  deny root · no long-lived keys   flag over-permissive roles
 Data residency          <data> leaving <country>         deny non-<country> regions       flag any resource off-region
 Public exposure         open buckets / DBs to internet   block public access              flag public storage / open SG
 Encryption at rest      readable disks/snapshots/backups deny unencrypted create           flag unencrypted volumes/keys
 Encryption in transit   sniffed traffic                  TLS-only endpoints                flag plaintext listeners
 Network segmentation    lateral movement                 per-env accounts + private links  flag cross-env / open egress
 Tagging & ownership     un-owned spend/risk              require owner + env tags          flag untagged resources
 Landing-zone baseline   drift from the <3.1> guardrails  org SCPs on every account         continuous conformance scan
```

- **Residency:** enforced preventively (region guardrail) **and** detectively (off-region CSPM alarm); keep KMS keys in-country.
- **Shared responsibility:** note what the provider secures vs what the customer secures — and that on-prem is *entirely* the customer's.
- Route CSPM findings like alerts: **page** the critical few, **ticket** the rest.

## 7. Assumptions & risks register

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | Cost composition | `<%/driver>` | `<bands>` | usage export (CUR/Cost Mgmt/BQ) | shifts which lever pays most |
| 2 | Lever effectiveness | `<Δ per driver>` | `<bands>` | pilot on one service | target range moves |
| 3 | Commitment coverage | `<~60–80%>` | `<a–b%>` | baseline-utilization report | over/under-commit |
| 4 | Peak multiplier / duration | `<Nx / M hrs>` | given ± | traffic history | burst savings change |
| 5 | Residency scope | `<which data classes>` | policy | legal / compliance team | guardrail scope changes |
| 6 | Tagging adoption | `<% tagged today>` | 0–100% | tag audit | showback accuracy |

**One-line cost & governance statement:**
> `<Customer>`'s cloud run-rate models to `<target>` cost-units (a `<band>` reduction) with the `<peak>` handled by autoscale + spot, giving a cost-per-`<order>` of index `<..>` (down `<..%>`); the estate stays safe and in-`<country>` via `<n>` preventive guardrails (residency, public-access, encryption, tagging) and continuous CSPM — the two dials the customer turns are `<commitment coverage>` and `<on-prem vs cloud baseline split>`.

## 8. Carry-forward → Capstone `<C>` (hybrid cloud proposal)

| Proposal chapter | From this plan | Confirm before commit |
|---|---|---|
| Cost model / TCO | §2 today-vs-target range | actual usage export |
| Commitment purchase | §4 baseline coverage | baseline stability + migration timing |
| Unit economics | §5 cost per `<order>` | orders denominator + billing period |
| Security posture | §6 guardrails + CSPM | residency scope with legal; CISO sign-off |
| FinOps operating model | §3 showback + ownership | centralized vs team-level ownership |

---

*Worked example: see `example-pasarkita-tco-and-finops.md` in this folder.*
