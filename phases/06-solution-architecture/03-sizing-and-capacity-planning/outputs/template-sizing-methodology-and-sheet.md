---
name: template-sizing-methodology-and-sheet
description: Sizing Methodology + Sheet — turns a multi-BU transformation's workload inventory into a defensible node/GPU/storage count across four domains (infra/K8s, AI/GPU, data/lakehouse, network), stated as assumptions and ranges. Feeds the BOM (6.4) and the LLD (6.7).
phase: 6
lesson: 3
audience: customer | internal | executive
---

# Sizing Methodology + Sheet — Template

> Fill this in to answer "how much platform, and why?" for a multi-domain transformation spanning several business units, a bounded AI feature, and a shared data platform. Every number must trace to a **stated assumption** and land inside a **range** — never present a single magic figure. An executive should read the result table; an engineer should trust the math underneath it. This sheet feeds the compute/GPU/storage lines of the BOM (6.4) and the physical design of the LLD (6.7) — get it right once, cite it everywhere.

**Customer:** `<company>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement:** `<transformation / project>`  ·  **Business units in scope:** `<BU 1>` · `<BU 2>` · `<BU 3>` · …
**Budget ceiling:** `<Rp/USD X–Y, N-yr TCO>`  ·  **Delivery window:** `<N–M months>`  ·  **Cost-to-serve target:** `<X–Y%>`
**Version:** `<v0.1 draft>`

**Legend:** vCPU = virtual CPU (share of a physical core) · pCore = physical core · o/c = overcommit ratio (vCPU:pCore) · N+1 = one spare unit · KV = key/value cache (LLM serving) · ⛔ = never overcommit.

---

## 0. How to size (the method, once)

```
① WORKLOAD INVENTORY   list every workload, grouped into tiers, across every BU + shared services
                        — don't size site-by-site; group by tier, note overcommit character

② PER-DOMAIN ESTIMATE  for each of the four domains below, run its own formula:
   Infra/K8s:    Σ vCPU, Σ RAM per tier → apply overcommit → dual-constraint (cores vs RAM)
                 → node count = MAX(cores-driven, RAM-driven) on a stated node spec
   AI/GPU:       bounded concurrency (Little's Law: in-flight = arrival rate × service time)
                 → weights VRAM + KV-cache budget → GPUs per node → nodes + N+1
   Data/lake:    medallion sizing (bronze→silver→gold), row count × avg size ÷ compression
                 → new data/month → retention policy → cumulative footprint over the TCO horizon
   Network:      per-site bandwidth × site count + ingestion/burst headroom

③ CONSOLIDATE          decide which tiers may share a node pool and which must be isolated
                        (security/regulatory boundary) — isolation costs nodes, buys blast-radius
                        containment; state the isolation pools explicitly

④ HEADROOM             + steady-utilization ceiling (≤70–80%, never plan to 100%)
                        + N+1 per isolation pool (not once for the whole platform)
                        + growth reserve for the delivery-window rollout (not yet-live sites/users)

⑤ SIGN-OFF             a RANGE with a recommended point estimate + a sanity check, per domain
                        → this is what 6.4 prices and 6.7 turns into a physical design
```

The single most important decision on this page: **which workloads may share infrastructure and which must be isolated.** Get that wrong and every number downstream — node count, GPU count, storage footprint — is wrong no matter how neat the arithmetic.

---

## 1. Workload inventory (group into tiers, across every business unit)

| Tier | Business unit | What it does | Overcommit character (1:1 / light / high) |
|---|---|---|---|
| `<tier>` | `<BU>` | `<…>` | `<…>` |
| … | | | |

## 2. Domain ① — Infra/Kubernetes: per-tier vCPU/RAM (bands → midpoint)

> `ASSUMPTION (confirm in discovery)` — pod/VM counts and per-unit specs are bands until confirmed against a live workload profile. Compute the point estimate at the midpoint.

| # | Tier | Units (band → mid) | vCPU/unit | RAM/unit | Σ vCPU | Σ RAM |
|---|---|---|---|---|---|---|
| 1 | `<tier>` | `<a–b → m>` | `<n>` | `<n GB>` | `<Σ>` | `<Σ GB>` |
| … | | | | | | |
| | **Totals** | `<~N units>` | | | `<Σ vCPU>` | `<Σ RAM>` |

## 3. Overcommit policy → physical demand

> `ASSUMPTION` — ratios are policy choices, state each and who approved it. Tiers that cannot tolerate contention (regulator-facing ledgers, brokers, hard-SLA) run at 1:1 ⛔. RAM stays ~1:1 across all tiers.

| # | Tier | Σ vCPU | CPU o/c | **pCores** | Σ RAM (~1:1) |
|---|---|---|---|---|---|
| 1 | `<tier>` | `<Σ>` | `<1:1 ⛔ / 2:1 / 3:1>` | `<Σ/ratio>` | `<Σ GB>` |
| … | | | | | |
| | **Physical demand** | `<Σ vCPU>` | — | **`<total pCores>`** | **`<total RAM>`** |

## 4. Dual-constraint math (cores vs RAM) + headroom

```
SUBTOTAL DEMAND        <pCores>       <RAM GB>
  + headroom (÷ <util>%): cores <pCores/util>    RAM <RAM/util>
  node spec = <C> vCPU + <R> GB (mid-size — more, smaller nodes over few giant ones):
      cores-driven nodes = CEIL(<headroom cores> / <C>) = <n1>
      RAM-driven nodes   = CEIL(<headroom RAM> / <R>)   = <n2>
      WORKLOAD NODES = MAX(<n1>, <n2>)  ← state which is binding, and why
```

## 5. Isolation pools, N+1, control plane, growth reserve

```
<N>  workload nodes (Step 4 result)
+<x> isolation/fragmentation overhead (pools can't bin-pack across each other's slack)  ASSUMPTION
+<y> N+1 spare, one per isolation pool (list the pools)
+3   dedicated HA control plane (never fewer; etcd quorum kept intra-region)
+<z> growth/headroom reserve for the delivery-window rollout
──────────────────────────────────────────────────────────
= <TOTAL> NODES  (band <low>–<high>; point estimate <N>)
```

**Sanity check:** `<workload nodes>` × `<node RAM>` GB capacity vs `<headroom-inclusive demand>` GB ≈ `<%>` packed — should sit near the stated utilization ceiling, not far below it (over-provisioned) or above it (no room for N+1 to absorb a failure).

## 6. Domain ② — AI/GPU: sizing the AI feature honestly

> State the feature's actual bounded population first — named users, peak concurrent, task complexity — before reaching for a model size. A feature scoped to a specific team or workflow is not the same sizing problem as an enterprise AI platform; the same formula, run on the true numbers, should produce a different-sized answer.

```
Named users: <N>  ·  Peak concurrent (band → point): <a–b → p>  ·  Query cadence: <s> between queries
Target latency: <s>  ·  Model class + quantization: <e.g. 8–14B INT4, or 30B+/70B+ if scope demands it>

weights_VRAM = params × bytes/param (+~15% load overhead)
KV_per_token = 2 × layers × KV_heads × head_dim × 2 (FP16)
KV_per_request = resident tokens × KV_per_token
λ (arrival) = peak concurrent / cadence  ·  W (service) ≈ target latency
IN-FLIGHT = λ × W  (design target with burst headroom)
Per-GPU KV budget = VRAM − weights − overhead, ÷ KV_per_request = in-flight capacity per GPU
```

**Result:** `<N>` node(s), `<N>` × `<GPU class>` cards — state explicitly whether the count is driven by **raw concurrency** (KV-bound, like an enterprise serving tier) or by **availability/colocation** (a bounded feature where one card already clears the target with large headroom, and the second card buys N+1 or houses embeddings/reranker). Say which, out loud — it is the number the customer will ask to justify.

## 7. Domain ③ — Data/Lakehouse: medallion sizing, scaled to scope

```
Per source (repeat per BU / event stream):
  <source> = <events/day, band> × <avg event size> → raw GB/day → raw GB/month
             × columnar compression (~4–8×) → compressed GB/month (bronze+silver)
NEW DATA/MONTH (all sources, compressed) = Σ  →  band <lo>–<hi> GB/mo
Cumulative footprint over the TCO horizon = new-data rate × horizon, adjusted for the
  retention/lifecycle policy (hot → warm → cold tiering) and any regulatory retention floor.
```

**Result:** `<mid-size / large>`, `<single-region / multi-region>`, `<in-country / cloud>` lakehouse — state the residency driver (which data domain forces in-country placement) explicitly.

## 8. Domain ④ — Network

```
Per-site link (×<site count>): band <lo>–<hi> Mbps, driven by <what traffic>
Backhaul/ingestion headroom: 2–3× steady-state to absorb burst windows (state which: month-end,
  promo season, morning peak, …)
```

## 9. Result — the sheet, in one place

```
              WORKLOAD   +ISOLATION  +N+1  +CTRL-PLANE  +GROWTH        RESULT
Infra/K8s      <n>          <n>       <n>       <n>        <n>       <band> → <point> nodes
AI/GPU          —            —         —         —          —        <N> node(s), <N>× <GPU class>
Data/Lakehouse  —            —         —         —          —        <size/region/placement>
Network         —            —         —         —          —        <per-site band>
─────────────────────────────────────────────────────────────────────────────────────────
Recommended point estimate: <one line per domain, matching the table above>
```

## 10. Assumptions & risks register (the CFO will read this)

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | Workload unit counts per tier | `<mid>` | `<band>` | live workload/inventory export | ± nodes |
| 2 | Overcommit ratios | `<per tier>` | policy | platform team sign-off | under-buy → contention / over-buy → cost |
| 3 | Node spec (cores/RAM) | `<C/R>` | `<band>` | hardware/cloud SKU | changes node count |
| 4 | Steady-util headroom | `<util>%` | 70–85% | perf baseline | too tight → no N+1 landing room |
| 5 | AI feature population + concurrency | `<peak concurrent>` | `<band>` | discovery / usage analytics | ± GPU count |
| 6 | Model class / quantization | `<model>` | policy | quality eval on customer's corpus | swap model → recompute VRAM/KV |
| 7 | Data volume per source | `<GB/mo>` | `<band>` | source system row-count export | ± storage tier |
| 8 | Retention / residency policy | `<years, in-country?>` | regulatory | compliance/legal sign-off | changes cumulative footprint + placement |
| 9 | Isolation pools | `<list>` | security/regulatory sign-off | 6.2-style segmentation review | wrong isolation → security or contention risk |

**One-line sizing statement (fill in per domain):**
> `<Customer>`'s transformation sizes to **`<N>` nodes (band `<low>`–`<high>`)** for the shared infra/K8s platform, **`<N>` GPU node(s) with `<N>`× `<GPU class>`** for `<the AI feature>`, and **`<a size/region/placement>` lakehouse** for the group data platform; the infra estate is **`<core / RAM>`-bound** because `<the binding decision>`, and the AI footprint is sized to `<the feature's actual bounded population>`, not the total workforce. The cost dials are `<list 2–3, e.g. isolation-pool count, N+1 vs N+0, model size>` — each priced, none assumed.

---

*Worked example: see `example-cakrawala-group-sizing-sheet.md` in this folder.*
