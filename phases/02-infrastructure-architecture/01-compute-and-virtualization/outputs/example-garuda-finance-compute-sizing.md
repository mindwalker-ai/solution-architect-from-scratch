---
name: example-garuda-finance-compute-sizing
description: Worked Compute Sizing Note for Garuda Finance's on-prem private cloud — a 10-row workload inventory sized with per-tier overcommit + N+1, landing on 12 hosts (band 12–15) across Jakarta and Surabaya. Feeds the Capstone B BOM.
phase: 2
lesson: 1
audience: customer | executive
---

# Compute Sizing Note — Garuda Finance (Worked Example)

> This is the [Compute Sizing Note template](./template-compute-sizing-note.md) filled in for **Garuda Finance** (fictional): an Indonesian multifinance + digital-banking firm, ~600 branches/agent outlets, ~8 million customers, mobile app peaking ~4,000 transactions/minute, migrating off an aging VMware estate onto an **on-prem private cloud** across two owned data centers. It answers the board's question — *how many hosts, and why* — and feeds Capstone B's private-cloud BOM.

**Customer:** Garuda Finance  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement:** Private-cloud build (VMware exit + cloud repatriation)  ·  **Sites:** Jakarta (primary) · Surabaya (DR, active-passive)  ·  **Version:** v0.1 draft

**Hard facts (given):** ~600 branches/agent outlets · ~8M customers · mobile peak ~4,000 tx/min · 2 DCs (Jakarta primary, Surabaya DR).
**Everything else below is a labelled `ASSUMPTION (confirm in discovery)` carried as a band.** Legend: vCPU = virtual CPU · pCore = physical core · o/c = overcommit (vCPU : pCore) · ⛔ = never overcommit.

---

## 1. Workload inventory (tiers)

| Tier | What it does | Overcommit character |
|---|---|---|
| **Core banking** | Accounts, ledger, payment switch — the transactional heart | **1:1 ⛔** (always busy, correlated peaks, outage is OJK-reportable) |
| **Loan origination** | Application intake, underwriting, decisioning | light (business-hours bursty) |
| **Mobile backend** | API/app tier behind the ~4,000 tx/min app | light–moderate (peaky, smoothable across many VMs) |
| **Batch / reporting** | Overnight batch, OJK regulatory reporting, analytics | high (time-shifted, idle most of the day) |
| **Platform / shared** | Kubernetes nodes (new container platform), monitoring, security, backup, LBs, AD | mixed |

## 2. Per-tier vCPU / RAM assumptions (bands → midpoint)

> `ASSUMPTION (confirm in discovery)` — illustrative bands for a bank of Garuda's size; confirm against the current vSphere inventory export. Point estimate uses the **midpoint**.

| # | Tier component | VMs (band → mid) | vCPU/VM | RAM/VM | Σ vCPU | Σ RAM |
|---|---|---|---|---|---|---|
| 1 | Core banking app | 8–12 → **10** | 8 | 32 GB | 80 | 320 GB |
| 2 | Core banking DB | 2–4 → **3** | 16 | 128 GB | 48 | 384 GB |
| 3 | Payment switch/gateway | 4–6 → **5** | 4 | 16 GB | 20 | 80 GB |
| 4 | Loan origination app | 6–10 → **8** | 4 | 16 GB | 32 | 128 GB |
| 5 | Loan origination DB | 2 → **2** | 8 | 64 GB | 16 | 128 GB |
| 6 | Mobile backend API | 8–12 → **10** | 4 | 16 GB | 40 | 160 GB |
| 7 | Mobile cache/session | 3–4 → **4** | 4 | 32 GB | 16 | 128 GB |
| 8 | Batch / reporting | 6–10 → **8** | 6 | 32 GB | 48 | 256 GB |
| 9 | Kubernetes platform nodes | 6–9 → **8** | 8 | 32 GB | 64 | 256 GB |
| 10 | Mgmt / monitoring / security | 10–15 → **12** | 4 | 16 GB | 48 | 192 GB |
| | **Totals** | **~70 VMs** | | | **412 vCPU** | **2032 GB** |

## 3. Overcommit policy → physical demand

> `ASSUMPTION` — payments and databases at 1:1 is deliberate and non-negotiable; general tiers at 2:1, batch at 4:1 are conservative mid-market defaults. RAM sized 1:1 (memory starvation is a hard failure). Confirm ratios with the platform team before the BOM.

| # | Tier component | Σ vCPU | CPU o/c | **pCores** | Σ RAM (~1:1) |
|---|---|---|---|---|---|
| 1 | Core banking app | 80 | 1:1 ⛔ | 80 | 320 GB |
| 2 | Core banking DB | 48 | 1:1 ⛔ | 48 | 384 GB |
| 3 | Payment switch | 20 | 1:1 ⛔ | 20 | 80 GB |
| 4 | Loan origination app | 32 | 2:1 | 16 | 128 GB |
| 5 | Loan origination DB | 16 | 1:1 | 16 | 128 GB |
| 6 | Mobile backend API | 40 | 2:1 | 20 | 160 GB |
| 7 | Mobile cache/session | 16 | 2:1 | 8 | 128 GB |
| 8 | Batch / reporting | 48 | 4:1 | 12 | 256 GB |
| 9 | Kubernetes platform | 64 | 2:1 | 32 | 256 GB |
| 10 | Mgmt / monitoring | 48 | 3:1 | 16 | 192 GB |
| | **Physical demand** | 412 | — | **268 pCores** | **2032 GB** |

## 4. Dual-constraint math (cores vs RAM)

```
WORKLOAD TIER              Σ vCPU   Σ RAM     CPU o/c    → pCORES    RAM (~1:1)
────────────────────────────────────────────────────────────────────────────
Core banking (payments)      148    784 GB     1:1  ⛔      148        784 GB
Loan origination              48    256 GB   ~1.5:1         32        256 GB
Mobile backend                56    288 GB     2:1          28        288 GB
Batch / reporting             48    256 GB     4:1          12        256 GB
Platform (K8s + mgmt)        112    448 GB   ~2.3:1         48        448 GB
────────────────────────────────────────────────────────────────────────────
SUBTOTAL                     412   2032 GB                 268       2032 GB
   + headroom (plan to 80% steady):  cores 268 / 0.80 ≈ 335    RAM 2032 / 0.80 ≈ 2540 GB
   host spec = 64 pCores + 1024 GB:  cores need 6  ·  RAM needs 3  →  MAX = 6 hosts
   + N+1 spare:                       →  7 physical hosts  (Jakarta primary cluster)
────────────────────────────────────────────────────────────────────────────
RULE  host count = CEIL( MAX(cores-driven, RAM-driven) )  THEN add N+1.
      Garuda is CORE-bound: refusing to overcommit payments makes cores the
      binding constraint (6 by cores vs 3 by RAM). RAM-heavy hosts would waste money.
      ⛔ = never overcommit: month-end payment latency is an OJK-reportable outage.
```

> `ASSUMPTION` — **host spec**: dual-socket, **32 pCores/socket = 64 pCores**, **1024 GB (1 TB) RAM**; band 48–64 cores, 768 GB–1.5 TB. **Headroom** targets ≤ 80% steady utilization (the N+1 spare needs room to absorb a failed host's VMs). Confirm the reference server SKU with the hardware partner.

## 5. Redundancy — Jakarta primary

- **N+1 → 7 hosts** — baseline; survives one host failure with zero capacity loss.
- **N+2 → 8 hosts** — priced upgrade if OJK BCP posture requires surviving a host failure *during* a patch window on the payments cluster.

**Jakarta primary: 7 hosts (N+1), or 8 (N+2) for the payments-critical posture.**

## 6. DR site sizing — Surabaya (active-passive)

Active-passive lets DR run the service Garuda **cannot** degrade at full capacity, while tolerant tiers run degraded/delayed during a failover.

- Critical-only DR (core banking + payments + mobile + reduced mgmt) ≈ **184 pCores** → ÷ 0.80 ≈ 230 → **4 hosts + N+1 = 5 hosts**. Lowest cost; accepts degraded batch/reporting and loan origination during a DC failover.
- Full-mirror DR (every tier, identical to Jakarta) = **7 hosts**. Highest cost, simplest ops, strictest RTO.

**Surabaya DR: 5 hosts (critical-only) to 7 hosts (full mirror)** — an RTO/RPO + cost decision to confirm with Garuda's BCP owner and OJK obligations.

## 7. Result — the range and the recommendation

```
              WORKLOAD   +N+1   +N+2      DR (critical→full)
Jakarta (P)      6         7      8              —
Surabaya (DR)    —         —      —            5 – 7
─────────────────────────────────────────────────────────────
ESTATE TOTAL = Jakarta (7–8) + Surabaya (5–7) = 12 – 15 hosts
Recommended point estimate: 7 (Jakarta N+1) + 5 (DR critical-only) = 12 hosts
Sanity check: ~70 VMs / 6 workload hosts ≈ 11–12 VMs per host — a sane
consolidation ratio for mixed enterprise tiers (red flag would be <4 or >25).
```

**Recommendation: 12 hosts as the point estimate in a 12–15 band**, split 7 (Jakarta, N+1) + 5 (Surabaya, critical-only DR). The two cost dials are the customer's to turn: **N+2 on Jakarta** (+1 host) and **full-mirror Surabaya** (+2 hosts) — each priced, neither assumed.

## 8. Assumptions & risks register

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | VM counts per tier | ~70 VMs (midpoints) | 60–85 | vSphere inventory export | ±2–3 hosts |
| 2 | Overcommit ratios | 1:1 payments, 2:1 gen, 4:1 batch | policy | platform-team sign-off | under-buy → payment contention / over-buy → capital |
| 3 | Host spec | 64 pCores + 1 TB RAM | 48–64 c, 768 GB–1.5 TB | hardware partner SKU | fewer cores → more hosts |
| 4 | Steady-util headroom | 80% | 70–85% | perf baseline of current estate | too tight → no N+1 landing room |
| 5 | DR posture | critical-only | critical ↔ full | RTO/RPO + BCP owner + OJK | DR host count 5↔7 |
| 6 | Redundancy | N+1 (Jakarta) | N+1 ↔ N+2 | risk appetite / regulator | +1 host for N+2 |
| 7 | Cloud repatriation scope | folded into tiers above | — | which workloads return on-shore | may add a tier |

**One-line sizing statement:**
> Garuda Finance's private-cloud compute sizes to **12 hosts (band 12–15)** across Jakarta (7, N+1) and Surabaya (5, critical-only DR), computed at 1:1 for payments/DB and 2:1–4:1 for general/batch tiers with RAM at 1:1; the estate is **core-bound** because payments are never overcommitted. The two cost dials are N+2 on Jakarta (+1) and full-mirror DR on Surabaya (+2).

## Why this beats the guess

Garuda's incumbent instinct — size every VM to its peak and mirror the whole estate in Surabaya — would have produced roughly **double** the hosts (peak-everywhere inflates the core-banking and mobile tiers, and full-mirror DR adds two more hosts than the critical-only posture needs). By stating overcommit per tier, refusing to overcommit payments, sizing RAM at 1:1, and treating DR as a lever rather than a copy, the note lands on a number the CFO can interrogate and the platform team can build — and it exposes the *right* levers (N+2, full-mirror DR) instead of burying them. That is the compute line item that carries straight into the Capstone B bill of materials.

## Carry-forward → Capstone B (private-cloud BOM)

| BOM line | From this note | Confirm before purchase |
|---|---|---|
| Physical hosts — Jakarta | 7 (N+1) → 8 if N+2 | final overcommit sign-off; host SKU |
| Physical hosts — Surabaya | 5 (critical-only) → 7 if full-mirror | DR posture with BCP owner + OJK |
| Cores/RAM per host | 64 pCores / 1 TB (band 48–64 / 768 GB–1.5 TB) | hardware partner quote |
| Hypervisor platform | see the Compare It decision memo (Exercise 3) | licensing model + in-house skills |
| Cluster count / resource pools | payments in a 1:1-reserved pool | isolation vs cost trade-off |
