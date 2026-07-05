---
name: template-compute-sizing-note
description: Compute Sizing Note — turns a workload inventory into a defensible physical-host count per data center (overcommit + N+1/N+2 + DR), stated as assumptions and a range. Feeds a private-cloud BOM.
phase: 2
lesson: 1
audience: customer | internal | executive
---

# Compute Sizing Note — Template

> Fill this in to answer "how many physical hosts, and why?" for a virtualization or private-cloud engagement. Every number must trace to a **stated assumption** and land inside a **range** — never present a single magic figure. An executive should read the summary; an engineer should trust the math. This note feeds the compute lines of the bill of materials.

**Customer:** `<company>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement:** `<deal / project>`  ·  **Sites:** `<primary DC>` (primary) · `<second DC>` (DR: active-passive / active-active)  ·  **Version:** `<v0.1 draft>`

**Legend:** vCPU = virtual CPU (share of a physical core) · pCore = physical core · o/c = overcommit ratio (vCPU : pCore) · N+1 = one spare host · ⛔ = never overcommit.

---

## 0. How to size (the method, once)

```
per tier:  Σ vCPU , Σ RAM
           ── divide vCPU by the tier's OVERCOMMIT ratio  →  physical cores
           ── keep RAM at ~1:1 (memory starvation is a hard failure)
sum tiers: total pCores , total RAM
add headroom:  divide each by target max utilization (e.g. ÷ 0.80)
host count(cores) = CEIL(headroom cores / cores-per-host)
host count(RAM)   = CEIL(headroom RAM   / RAM-per-host)
WORKLOAD HOSTS    = MAX(host count cores , host count RAM)   ← dual constraint
+ REDUNDANCY:     N+1 (survive one host) or N+2 (survive two, e.g. failure during patch)
DR SITE:          full mirror  OR  critical-tiers-only (accept degraded non-critical)
RESULT:           a RANGE with a recommended point estimate + a sanity check
```

The single most important decision on this page: **which tiers you refuse to overcommit** (payments, ledger, hard-SLA). Get that wrong and the number is wrong no matter how neat the arithmetic.

---

## 1. Workload inventory (group into tiers, don't size 200 VMs by hand)

| Tier | What it does | Overcommit character (1:1 / light / high) |
|---|---|---|
| `<core / payments>` | `<…>` | **1:1 ⛔** |
| `<line-of-business app>` | `<…>` | light |
| `<customer-facing / API>` | `<…>` | light–moderate |
| `<batch / reporting / analytics>` | `<…>` | high |
| `<platform / K8s / mgmt / security>` | `<…>` | mixed |

## 2. Per-tier vCPU / RAM assumptions (bands → midpoint)

> `ASSUMPTION (confirm in discovery)` — VM counts and per-VM specs are bands until confirmed against the live hypervisor inventory export (VM list with configured vCPU/RAM). Compute the point estimate at the **midpoint**.

| # | Tier component | VMs (band → mid) | vCPU/VM | RAM/VM | Σ vCPU | Σ RAM |
|---|---|---|---|---|---|---|
| 1 | `<component>` | `<a–b → m>` | `<n>` | `<n GB>` | `<Σ>` | `<Σ GB>` |
| 2 | `<component>` | | | | | |
| … | | | | | | |
| | **Totals** | `<~N VMs>` | | | `<Σ vCPU>` | `<Σ RAM>` |

## 3. Overcommit policy → physical demand

> `ASSUMPTION` — ratios are policy choices, not physics. State each and who approved it. Payments/DB at 1:1 is deliberate. RAM sized ~1:1 across all tiers.

| # | Tier component | Σ vCPU | CPU o/c | **pCores** | Σ RAM (~1:1) |
|---|---|---|---|---|---|
| 1 | `<component>` | `<Σ>` | `<1:1 ⛔ / 2:1 / 4:1>` | `<Σ/ratio>` | `<Σ GB>` |
| … | | | | | |
| | **Physical demand** | `<Σ vCPU>` | — | **`<total pCores>`** | **`<total RAM>`** |

## 4. Dual-constraint math (cores vs RAM) — the summary table

```
WORKLOAD TIER          Σ vCPU    Σ RAM      CPU o/c     → pCORES     RAM (~1:1)
──────────────────────────────────────────────────────────────────────────────
<tier 1 (payments)>    <..>      <.. GB>    1:1  ⛔      <..>         <.. GB>
<tier 2>               <..>      <.. GB>    <..:1>       <..>         <.. GB>
<tier 3>               <..>      <.. GB>    <..:1>       <..>         <.. GB>
<tier 4>               <..>      <.. GB>    <..:1>       <..>         <.. GB>
──────────────────────────────────────────────────────────────────────────────
SUBTOTAL               <..>      <.. GB>                 <pCores>     <RAM GB>
  + headroom (÷ <util>):  cores <pCores/util>        RAM <RAM/util>
  host spec = <C> pCores + <R> GB:  cores need <x>  ·  RAM need <y>  →  MAX = <N>
  + N+1 spare:  →  <N+1> hosts   (primary cluster)
──────────────────────────────────────────────────────────────────────────────
RULE  host count = CEIL( MAX(cores-driven, RAM-driven) )  THEN add N+1.
      Is this estate CORE-bound or RAM-bound?  <state which, and why>
```

> `ASSUMPTION` — **host spec** `<dual-socket, C cores/host, R GB RAM>` (band `<…>`). **Headroom** targets ≤ `<util>`% steady utilization; never plan a host to 100% — the N+1 spare must have room to absorb a failed host's VMs.

## 5. Redundancy — primary site

- **N+1 → `<N+1>` hosts** — baseline, survives one host failure with zero capacity loss.
- **N+2 → `<N+2>` hosts** — priced upgrade if the critical cluster must survive a second loss (e.g. a failure *during* a patch window). Present as an option, not a surprise.

**Primary site (`<DC>`): `<N+1>` hosts (N+1), or `<N+2>` (N+2).**

## 6. DR site sizing (active-passive lever)

Active-passive DR need not mirror 1:1. Run the service that **cannot** degrade at full capacity; let tolerant tiers run degraded/delayed during failover if the BCP permits.

- Critical-only DR (`<list critical tiers>`) ≈ `<pCores>` → `<hosts + N+1>`. Lowest cost; accepts degraded `<non-critical tiers>` during a DC failover.
- Full-mirror DR (all tiers) = `<hosts>`. Highest cost, simplest ops, strictest RTO.

**DR site (`<DC>`): `<low>`–`<high>` hosts** — an RTO/RPO + cost decision to make *with* the customer.

## 7. Result — the range and the recommendation

```
              WORKLOAD   +N+1   +N+2      DR (critical→full)
<primary>       <N>      <..>   <..>           —
<DR site>        —        —      —          <lo>–<hi>
─────────────────────────────────────────────────────────────
ESTATE TOTAL = <primary band> + <DR band> = <LOW>–<HIGH> hosts
Recommended point estimate: <primary N+1> + <DR critical> = <N> hosts
Sanity check: <~N VMs> / <workload hosts> ≈ <VMs/host> VMs per host  (normal ~4–25)
```

## 8. Assumptions & risks register (the CFO will read this)

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | VM counts per tier | `<mid>` | `<band>` | hypervisor inventory export | ± hosts |
| 2 | Overcommit ratios | `<per tier>` | policy | platform team sign-off | under-buy → contention / over-buy → cost |
| 3 | Host spec (cores/RAM) | `<C/R>` | `<band>` | hardware partner SKU | changes host count |
| 4 | Steady-util headroom | `<util>%` | 70–85% | perf baseline | too tight → no N+1 landing room |
| 5 | DR posture | `<critical/full>` | — | RTO/RPO + BCP owner | DR cost + failover capacity |
| 6 | Redundancy level | `<N+1 / N+2>` | — | risk appetite / regulator | outage tolerance |

**One-line sizing statement (fill in):**
> `<Customer>`'s compute sizes to **`<N>` hosts (band `<LOW>`–`<HIGH>`)** across `<primary>` and `<DR>`, computed at `<overcommit summary>` with RAM at 1:1 and `<N+1/N+2>` redundancy; the estate is **`<core / RAM>`-bound** because `<the binding decision>`. The two cost dials are `<N+2 on primary>` and `<full-mirror DR>`.

---

*Worked example: see `example-garuda-finance-compute-sizing.md` in this folder.*
