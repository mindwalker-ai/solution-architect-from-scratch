---
name: example-cakrawala-group-sizing-sheet
description: Worked Sizing Methodology + Sheet for Cakrawala Group — a shared K8s platform across retail/logistics/finance-leasing sized to ~40 nodes, a bounded AI ops-copilot sized to 1 GPU node (2× L40S-class), and a mid-size single-region in-country lakehouse. Pinned figures cited verbatim by 6.4's BOM and 6.7's LLD.
phase: 6
lesson: 3
audience: customer | executive
---

# Sizing Methodology + Sheet — Cakrawala Group (Worked Example)

> This is the [Sizing Methodology + Sheet template](./template-sizing-methodology-and-sheet.md) filled in for **Cakrawala Group** (fictional): an Indonesian conglomerate — ~350 retail outlets, ~40 logistics hubs, 1 finance/leasing back office, ~18,000 employees — consolidating onto a **shared Kubernetes platform + event bus**, a **lightweight AI ops-copilot** (bounded RAG feature for store/ops staff), and a **group data lakehouse** (finance-leasing data in-country). It answers the board's question — *how much platform, and why* — and the figures below are cited **verbatim** by 6.4's BOM and 6.7's LLD.

**Customer:** Cakrawala Group  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement:** Group technology transformation (shared platform + bounded AI + data platform)  ·  **Business units in scope:** Retail (~350 outlets) · Logistics (~40 hubs) · Finance-leasing (1 back office)
**Budget ceiling:** Rp 45–65B (3-yr TCO)  ·  **Delivery window:** 12–18 months  ·  **Cost-to-serve target:** 15–20%
**Version:** v0.1 draft

**Pinned facts (given — do not soften):** ~350 retail outlets, ~40 logistics hubs, 1 finance/leasing back office, ~18,000 employees, Rp 45–65B 3-yr TCO, 12–18 month window, 15–20% cost-to-serve target.
**Everything else below is a labelled `ASSUMPTION` carried as a band.** Legend: vCPU = virtual CPU · pCore = physical core · o/c = overcommit (vCPU:pCore) · N+1 = one spare · KV = key/value cache · ⛔ = never overcommit.

---

## 0. Method recap

Workload inventory across 3 BUs + shared services → per-domain estimate (infra/K8s, AI/GPU, data/lakehouse, network) → consolidate into isolation pools (retail+logistics shared · finance-leasing dedicated · platform dedicated, per 6.2's zero-trust segmentation) → headroom (N+1 per pool, control plane, growth reserve) → sign-off.

## 1. Workload inventory

| Tier | Business unit | What it does | Overcommit character |
|---|---|---|---|
| Retail POS/inventory sync | Retail (~350 outlets) | Transaction sync, stock-on-hand, local cache invalidation | light–moderate |
| Retail catalog/pricing/promo | Retail | Central catalog, pricing, promotion rules | light–moderate |
| Logistics dispatch & route optimization | Logistics (~40 hubs) | Dispatch assignment, route planning | moderate (compute-heavier) |
| Logistics tracking/telemetry ingestion | Logistics | GPS/status events, hub scan events | moderate (event-driven) |
| Finance-leasing core ledger/app | Finance-leasing (1 back office) | Loan/lease origination, servicing, core ledger | **1:1 ⛔** |
| Finance-leasing DB | Finance-leasing | Ledger and contract database | **1:1 ⛔** |
| Group event bus | Shared, cross-BU | Kafka-class brokers, group-wide events | 1:1 (throughput/latency-sensitive) |
| AI ops-copilot orchestration | Shared, bounded feature | RAG API, vector store, gateway (non-GPU) | light–moderate |
| Shared platform services | Shared | K8s mgmt/ingress, observability, zero-trust PDP/PEP, CI/CD | light–moderate |

No per-outlet or per-hub node lines: retail and logistics are centralized backend tiers reached by every site over the network (§8), not a node-per-site topology.

## 2. Domain ① Infra/K8s — per-tier vCPU/RAM

| # | Tier | Pods (band → mid) | vCPU/pod | RAM/pod | Σ vCPU | Σ RAM |
|---|---|---|---|---|---|---|
| 1 | Retail POS/inventory sync | 40–60 → **50** | 2 | 4 GB | 100 | 200 GB |
| 2 | Retail catalog/pricing/promo | 20–30 → **25** | 2 | 4 GB | 50 | 100 GB |
| 3 | Logistics dispatch & route opt. | 20–30 → **24** | 4 | 8 GB | 96 | 192 GB |
| 4 | Logistics tracking/telemetry | 15–20 → **18** | 2 | 4 GB | 36 | 72 GB |
| 5 | Finance-leasing core ledger/app | 10–14 → **12** | 4 | 16 GB | 48 | 192 GB |
| 6 | Finance-leasing DB | 4–6 → **5** | 8 | 64 GB | 40 | 320 GB |
| 7 | Group event bus (brokers) | 6–9 → **6** | 4 | 16 GB | 24 | 96 GB |
| 8 | AI copilot orchestration (non-GPU) | 10–14 → **12** | 2 | 8 GB | 24 | 96 GB |
| 9 | Shared platform services | 20–30 → **24** | 2 | 4 GB | 48 | 96 GB |
| | **Totals** | **~176 pods** | | | **466 vCPU** | **1,364 GB** |

## 3. Overcommit policy → physical demand

| # | Tier | Σ vCPU | CPU o/c | **pCores** |
|---|---|---|---|---|
| 1 | Retail POS/inventory sync | 100 | 3:1 | 34 |
| 2 | Retail catalog/pricing/promo | 50 | 3:1 | 17 |
| 3 | Logistics dispatch & route opt. | 96 | 2:1 | 48 |
| 4 | Logistics tracking/telemetry | 36 | 2:1 | 18 |
| 5 | Finance-leasing core ledger/app | 48 | 1:1 ⛔ | 48 |
| 6 | Finance-leasing DB | 40 | 1:1 ⛔ | 40 |
| 7 | Group event bus | 24 | 1:1 | 24 |
| 8 | AI copilot orchestration | 24 | 2:1 | 12 |
| 9 | Shared platform services | 48 | 2:1 | 24 |
| | **Physical demand** | 466 | — | **265 pCores** |

> `ASSUMPTION` — finance-leasing at 1:1 is non-negotiable (regulator-facing ledger); the event bus at 1:1 because broker throughput/latency degrades under CPU contention. Confirm all ratios with the platform team before the BOM.

## 4. Dual-constraint math + headroom

```
SUBTOTAL DEMAND        265 pCores      1,364 GB RAM
  + headroom (≤75% steady utilization):
        cores: 265 / 0.75 ≈ 354 pCores        RAM: 1,364 / 0.75 ≈ 1,819 GB
```

> `ASSUMPTION` — node spec **16 vCPU / 64 GB RAM** (band 12–16 vCPU / 48–64 GB), a deliberately mid-size worker node (more, smaller nodes spread pods across more failure domains than few giant hosts).

```
cores-driven nodes = CEIL(354 / 16)  = 23
RAM-driven nodes   = CEIL(1,819 / 64) = 29   ← binding constraint
WORKLOAD NODES (RAM-bound) = 29
```

Cakrawala is **RAM-bound**: the finance-leasing 1:1 tiers plus the memory-heavy DB tier push RAM demand ahead of CPU demand.

## 5. Isolation pools, N+1, control plane, growth reserve

```
29  workload nodes (Step 4)
+3  isolation/fragmentation overhead — 3 pools can't bin-pack across each other's slack   ASSUMPTION ~10%
+3  N+1 spare, one per pool (retail+logistics shared · finance-leasing dedicated · platform dedicated)
+3  dedicated HA control plane (3 nodes; etcd quorum kept intra-region)
+2  growth/headroom reserve for the 12–18 month rollout (phase-2 sites not yet live)
──────────────────────────────────────────────────────────────────────
= 40 NODES  (band 36–44; point estimate 40)
```

**Sanity check:** 29 workload nodes × 64 GB = 1,856 GB capacity vs 1,819 GB headroom-inclusive demand ≈ 98% packed — tight by design; the ≤75% steady-state target is already built into the 1,819 GB figure.

## 6. Domain ② AI/GPU — the bounded ops-copilot

**Inputs:** ~1,000–1,500 named users (store ops leads across 350 outlets, hub supervisors across 40 hubs, finance-leasing ops staff — a slice of the ~18,000 employees, not the workforce). Peak concurrent `ASSUMPTION` ~40–60, point **50**. Query cadence `ASSUMPTION` ~90 s (band 60–120 s). Target latency `ASSUMPTION` ~3–6 s. Model: **8–14B open-weight instruct** (e.g. Qwen2.5-14B-Instruct class) at INT4/AWQ — narrow SOP/inventory corpus, not Bumi Energi's deep technical/regulatory corpus.

```
weights_VRAM = 14e9 × 0.5 bytes (INT4) = 7 GB → +~15% overhead ≈ 8 GB          band 4–9 GB (8–14B class)

KV_per_token   ≈ 2 × 32 layers × 8 KV-heads × 128 head_dim × 2 (FP16) ≈ 0.125 MB/token
KV_per_request = ~1,500 tok (band 1,000–2,500) × 0.125 MB ≈ 0.18 GB/request

λ = 50 users / 90 s ≈ 0.56 req/s        band 0.33 (120s) – 0.83 (60s)
W ≈ 4.5 s (mid of 3–6 s SLA)
IN-FLIGHT = λ × W ≈ 2.5 requests         band ~1.2–4
Design target (burst headroom): ~6 in-flight slots.
```

**Per-GPU capacity, 1× L40S-class (48 GB):**

```
48 − 8 (weights) − ~5 (overhead) ≈ 35 GB KV budget / 0.18 GB per request ≈ 194 in-flight capacity
```

One card clears the ~6 in-flight target with ~30× headroom. The second card is bought for:

- **Colocating embeddings + reranker** (small models, ~1–2 GB VRAM each) off the LLM's card, avoiding latency competition during retrieval.
- **N+1 availability** — a feature embedded in daily operations across ~390 sites must survive one GPU/driver fault without an outage during business hours.
- **Growth margin** for the 12–18 month rollout as adoption grows past ~1,000–1,500 named users.

**Result: 1 GPU node, 2× GPU-class cards (L40S-class, 48 GB each)** — one active on LLM serving, one active on embeddings/reranker and overflow/failover.

**Contrast with Phase 5's Bumi Energi:** that engagement sized a *dedicated* AI platform (6–8× H100 across 2 nodes) for 200 concurrent / 2,000 named users on a 72B model — concurrency, not weights, forced the GPU count up. Cakrawala's copilot, at ~50 concurrent on a right-sized 8–14B model, clears its target on one card; the second card is availability and colocation, not throughput. Cost: `ASSUMPTION — confirm with hardware partner` 2× L40S-class ~$7k–9k/card + a modest server ≈ **$30k–45k total**, versus Bumi Energi's $260k–400k GPU compute layer — the number the "bounded feature" framing predicts.

## 7. Domain ③ Data/Lakehouse

```
Retail:     350 outlets × ~800 tx/day (band 500–1,200) ≈ 280,000 tx/day ≈ 8.4M/mo
            × ~2 KB/tx ≈ 16.8 GB/day raw ≈ 500 GB/mo raw → ~5–7× compression → ~85 GB/mo compressed

Logistics:  ~2,500 vehicles/couriers × 720 pings/day (60s cadence, ~12h ops) ≈ 1.8M events/day
            ≈ 54M/mo × ~300 B ≈ 16.2 GB/mo raw → ~4 GB/mo compressed
            + 40 hubs × ~2,000 scans/day ≈ 2.4 GB/mo raw → ~1 GB/mo compressed

Finance-leasing: ~50,000–80,000 active contracts, ~5,000–10,000 ledger events/day × ~1.5 KB
            ≈ 12 GB/mo raw → ~3 GB/mo compressed (retention length, not rate, dominates footprint)

NEW DATA/MONTH (bronze+silver, compressed) ≈ 85 + 5 + 3 ≈ 93 GB/mo     band 70–120 GB/mo
→ ≈ 1–1.5 TB/year new data
```

Over the 3-year TCO horizon, with bronze raw hot ~1 year then cold-tiered and silver/gold retained longer, cumulative hot+warm footprint ≈ **3–5 TB**. Ingestion/orchestration run in Step 2's shared/AI-copilot tiers; the elastic BI query engine bursts into the platform's growth reserve rather than pinning dedicated query nodes.

**Result: one mid-size, single-region, in-country lakehouse** — single region (no pinned fact requires multi-region analytics DR), in-country specifically for the finance-leasing data domain per 6.2's residency posture.

## 8. Domain ④ Network

```
Per-outlet link (350):  ASSUMPTION 10–50 Mbps (POS sync + catalog pulls + copilot queries)
Per-hub link (40):      ASSUMPTION 50–100 Mbps (dispatch, tracking telemetry, higher burst)
Backhaul + event-bus ingestion headroom: 2–3× steady-state (Monday-morning / month-end bursts)
```

## 9. Result — the sheet

```
              WORKLOAD   +ISOLATION  +N+1  +CTRL-PLANE  +GROWTH        RESULT
Infra/K8s        29           32       35        38          40      36–44 → 40 nodes
AI/GPU            —            —        —          —           —      1 node, 2× L40S-class
Data/Lakehouse    —            —        —          —           —      mid-size, 1 region, in-country
Network           —            —        —          —           —      per-site band (§8)
─────────────────────────────────────────────────────────────────────────────────────────
Recommended point estimate:
  Infra/K8s      — 40 nodes (band 36–44), 3 isolation pools + shared 3-node control plane
  AI/GPU         — 1 GPU node, 2× L40S-class (48 GB), 1 active LLM + 1 active embed/rerank+N+1
  Data/Lakehouse — 1 mid-size, single-region, in-country lakehouse (~1–1.5 TB/yr new data)
  Network        — per-site WAN bands above; confirmed in 6.7's LLD against a site survey
```

## 10. Assumptions & risks register

| # | Assumption / risk | Value used | Band | How to confirm | If wrong → impact |
|---|---|---|---|---|---|
| 1 | Pod counts per tier | midpoints (Step 2) | see Step 2 | live workload profiling | ± nodes |
| 2 | Overcommit ratios | 1:1 finance/bus, 2:1–3:1 elsewhere | policy | platform team sign-off | under-buy → contention / over-buy → cost |
| 3 | Node spec | 16 vCPU / 64 GB | 12–16 vCPU / 48–64 GB | hardware/cloud SKU | changes node count |
| 4 | Steady-util headroom | 75% | 70–85% | perf baseline | too tight → no N+1 room |
| 5 | Copilot peak concurrent | 50 | 40–60 | pilot usage analytics | 60 → recheck in-flight, still 1 card |
| 6 | Copilot model class | 8–14B INT4 | policy | quality eval on Cakrawala's SOP corpus | fails eval → bigger model → recheck VRAM |
| 7 | Retail tx volume | 800/outlet/day | 500–1,200 | POS system export | ± lakehouse ingest rate |
| 8 | Finance-leasing retention | regulatory, 5–10 yrs | policy | compliance/legal sign-off | changes cumulative TB + in-country scope |
| 9 | Isolation pools | 3 (retail+logistics, finance-leasing, platform) | 6.2 sign-off | zero-trust segmentation review | wrong isolation → contention or security gap |

**One-line sizing statement:**
> Cakrawala Group's transformation sizes to **~40 Kubernetes nodes (band 36–44)** for the shared retail/logistics/finance-leasing platform, **1 GPU node with 2× GPU-class cards (L40S-class)** for the bounded AI ops-copilot, and **1 mid-size, single-region, in-country lakehouse** for the group data platform; the infra estate is **RAM-bound** because finance-leasing's 1:1 tiers and DB refuse to overcommit, and the AI footprint is sized to ~50 concurrent ops/store users on a right-sized 8–14B model — not the 18,000-employee workforce. The cost dials are **isolation-pool count**, **N+1 vs N+0 per pool**, and **8–14B vs a larger copilot model** — each priced, none assumed.

## Why this beats the guess

Pricing three independent platforms "so no BU has to negotiate for capacity" would add roughly 10–15 nodes (three separate control planes, no cross-BU peak-pooling) and blow past the lower end of the Rp 45–65B ceiling before storage or licensing are even priced. Defaulting the copilot to a 70B-class model "so it can grow into anything" would push the GPU line into Bumi-Energi territory — a dedicated serving tier the ~50-concurrent, narrow-corpus scope does not justify. Running the dual-constraint formula per domain, stating every overcommit ratio and concurrency assumption as a labelled band, and sizing the AI feature to its actual bounded population lands the platform at a number the CFO can interrogate and the platform team can run inside the 12–18 month window: **40 nodes, 1 GPU node with 2 cards, one mid-size in-country lakehouse.**

## Carry-forward → 6.4 (BOM) and 6.7 (LLD)

| Line | From this sheet | Confirm before purchase |
|---|---|---|
| Kubernetes worker + control-plane nodes | 40 (band 36–44), node spec 16 vCPU/64 GB | final overcommit sign-off; hardware/cloud SKU |
| Isolation pools | 3 (retail+logistics · finance-leasing · platform) | 6.2's zero-trust segmentation review |
| GPU serving | 1 node, 2× L40S-class (48 GB) | model/quantization eval on Cakrawala's SOP corpus |
| Lakehouse | mid-size, single-region, in-country, ~1–1.5 TB/yr new data | retention policy sign-off with compliance/legal |
| Network | per-site WAN bands (§8) | site survey against actual outlet/hub circuits |
