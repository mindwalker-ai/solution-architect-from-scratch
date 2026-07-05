---
name: example-cakrawala-lld-runbook-implementation-plan
description: Worked LLD + cutover runbook + implementation plan for the fictional Cakrawala Group AI transformation, bound field-for-field to lessons 6.1–6.6
phase: 6
lesson: 7
audience: internal | customer
---

# LLD + Runbook + Implementation Plan — Cakrawala Group (worked example)

> This is `template-lld-runbook-implementation-plan.md` filled in for **Cakrawala Group** — the fictional Indonesian conglomerate from Phase 6: ~350 retail outlets, ~40 logistics hubs, one finance/leasing back office, ~18,000 employees. The board approved the HLD in 6.6; this is the build-ready spec the delivery team executes from. **Every sizing, cost, timeline, and migration figure below is cited verbatim from the upstream lesson that set it — none are re-derived.**

**Customer:** Cakrawala Group (fictional)  ·  **Engagement:** AI & Data Platform Transformation
**Prepared by:** SA — Solution Delivery  ·  **Date:** 2026-07-05
**HLD reference:** 6.6 Writing the HLD (board-approved)  ·  **BOM reference:** 6.4 Cost Estimation & BOM  ·  **Version:** v1.0

---

## 1. Infrastructure spec (traces to: 6.3 Sizing & Capacity Planning)

6.3 sized the platform at **~40 mid-size Kubernetes nodes**, **1 on-prem GPU node with 2× GPU-class cards (e.g. L40S-class)** for the bounded AI ops-copilot, and **1 mid-size single-region in-country lakehouse**. This spec allocates that total across Cakrawala's three business units plus shared services — the subtotal reconciles to 6.3's ~40 exactly.

| Cluster / zone | Nodes | Role | Network zone | Security posture (traces to: 6.2) |
|---|---:|---|---|---|
| Retail production | 14 | POS/order/inventory services behind the strangler-fig facade (6.1) | 10.20.0.0/20 | Zero trust, standard segment |
| Logistics production | 8 | Dispatch/routing services, event bus consumers | 10.21.0.0/20 | Zero trust, standard segment |
| Finance-leasing production | 6 | Ledger/leasing core, reachable only via the anti-corruption layer (6.1) | 10.22.0.0/22 | **Segmented enclave** (6.2) — isolated VRF, mTLS-only ingress |
| Shared platform | 8 | API gateway/BFF (6.1), event bus brokers, observability, CI/CD, identity | 10.10.0.0/22 | Zero trust, cross-zone chokepoint |
| Non-production | 4 | Staging/UAT for all three business units | 10.30.0.0/21 | Zero trust, no prod data |
| **Subtotal (K8s)** | **40** | | | matches 6.3's ~40-node figure exactly |
| GPU node | 1 | AI ops-copilot inference — 2× L40S-class cards (per 6.3) | Shared platform zone, reachable only through the API gateway/BFF | Zero trust, no direct external ingress |
| Lakehouse | 1 | Single-region, in-country — landing zone for all three BUs' event streams (per 6.3) | 10.40.0.0/24 | Data residency boundary for the finance-leasing compliance gate (6.5) |

**Zone map:**

```
                    CAKRAWALA PLATFORM — ZONE MAP  (traces to: 6.3 / 6.2)
   ┌──────────────────────────────────────────────────────────────────────────┐
   │  SHARED PLATFORM ZONE  10.10.0.0/22  (8 nodes + GPU node)                 │
   │  API gateway/BFF · event bus brokers · observability · CI/CD · identity  │
   │  GPU node (2× L40S-class) — AI ops-copilot, reachable ONLY via gateway   │
   └───────────┬───────────────────────┬───────────────────────┬─────────────┘
               │ mTLS                  │ mTLS                  │ mTLS + ACL only
   ┌───────────▼───────────┐ ┌─────────▼─────────────┐ ┌──────▼──────────────┐
   │ RETAIL PROD           │ │ LOGISTICS PROD         │ │ FINANCE-LEASING PROD │
   │ 10.20.0.0/20 (14)      │ │ 10.21.0.0/20 (8)       │ │ 10.22.0.0/22 (6)      │
   │ strangler-fig facade   │ │ dispatch/routing       │ │ SEGMENTED ENCLAVE     │
   └────────────────────────┘ └────────────────────────┘ └──────────────────────┘
               │                        │                          │
               └──────────────┬─────────┴──────────────────────────┘
                               ▼
                 LAKEHOUSE  10.40.0.0/24  (single-region, in-country — 6.3)
                 NON-PROD  10.30.0.0/21  (4 nodes, all BUs, no prod data)
```

## 2. Integration spec (traces to: 6.1 Architecture Patterns, 6.2 Security Architecture)

| Pattern (traces to 6.1) | Exact contract in this LLD |
|---|---|
| Strangler-fig retail legacy retirement | Facade in the retail zone routes checkout/inventory-lookup/returns to legacy or new services via a **per-store-cohort config flag** — never a code branch. Rollback = flip the flag back. |
| Event bus integration | Topics are versioned, BU-scoped: `retail.pos.transactions.v1`, `logistics.dispatch.events.v1`, `finance.ledger.postings.v1`. Every producer/consumer authenticates with **mTLS** (6.2); no topic accepts unauthenticated connections. |
| Anti-corruption layer on the finance-leasing core | Exposes one stable interface, `finance.acl.v1`, translating inbound events (e.g., a retail sale → a leasing-fee accrual) into the finance-leasing core's internal ledger model. **Nothing outside the segmented enclave (6.2) calls the core directly.** |
| API gateway / BFF for the AI ops-copilot | Exposes `/copilot/v1/query`; authenticates + rate-limits every call; routes to the GPU node's inference service. BFF aggregates read-only retail/logistics views via the lakehouse; finance-leasing data only via the ACL. |

**Sample event schema:**

```json
// retail.pos.transactions.v1 — produced by retail zone, consumed by event bus + lakehouse
{
  "event_id": "uuid",
  "cohort_id": "string",
  "store_id": "string",
  "occurred_at": "iso8601",
  "line_items": [{ "sku": "string", "qty": "number", "unit_price_idr": "number" }],
  "producer_auth": "mTLS client cert — retail-zone-issued (per 6.2)"
}
```

**Gateway/BFF route table:**

| Route | Backend | AuthN/Z | Rate limit | Notes |
|---|---|---|---|---|
| `POST /copilot/v1/query` | GPU node inference service | Service token + user SSO claim | Capped to the single GPU node's throughput (6.3) | Read-only; never writes to any SoR |
| `GET /copilot/v1/context/retail` | BFF → lakehouse | Service token | Standard | Aggregated retail view only |
| `GET /copilot/v1/context/logistics` | BFF → lakehouse | Service token | Standard | Aggregated logistics view only |
| `GET /copilot/v1/context/finance` | BFF → ACL (`finance.acl.v1`) | Service token + enclave-scoped cert (6.2) | Standard, logged | Only path into finance-leasing data |

## 3. Runbook — Wave 1 retail cutover (traces to: 6.5 Migration Strategy)

6.5 fixed the order: **retail first, then logistics, then finance-leasing last, behind a compliance gate.** This runbook covers wave 1 only.

1. **Pre-cutover (T-48h):** confirm pilot store cohort's data backfill reconciled; confirm mTLS certs on the event bus rotated and valid (6.2); confirm the facade's rollback flag tested in staging; publish on-call roster (platform, retail app, network/security).
2. **Freeze (T-0):** freeze legacy writes for the pilot cohort only — all other store cohorts keep running on legacy, untouched.
3. **Cutover:** flip the facade routing flag for the pilot cohort from legacy → new services; run the smoke-test suite (checkout, inventory lookup, returns).
4. **Monitor window (4h):** watch the cohort's error budget. **Rollback trigger:** error rate crosses the pre-agreed threshold, or any smoke test fails twice → flip the flag back to legacy, unfreeze, notify stakeholders.
5. **Go/no-go:** platform lead + retail app owner sign off. Go → unfreeze on the new path, schedule the next cohort. No-go → step 4's rollback already ran.
6. **Incident response:** Sev1 (customer-facing outage) pages platform + retail app owner + network/security on-call simultaneously. Sev2 (degraded, not down) pages platform on-call only, escalates after 30 minutes without mitigation.

**Roles for the mixed-skill cutover team:**

| Role | Owns | Paged for |
|---|---|---|
| Platform lead | Facade routing flag, infra health, rollback execution | Sev1, Sev2, every go/no-go |
| Retail app owner | Smoke tests, cohort selection, business sign-off | Sev1, every go/no-go |
| Network/security on-call | mTLS cert validity, zone boundary integrity (6.2) | Sev1 only |
| PM | Schedule impact of a rollback, stakeholder notification | Any rollback, any missed milestone |

**Cheap-rollback check:** rollback here is a config flag flip, not a redeploy — because the strangler-fig facade (§2) was built per-cohort from day one. Wave 2 (logistics) and wave 3 (finance-leasing) each get their own runbook in this same shape before their cutover dates.

## 4. Implementation plan (traces to: 6.5 Migration Strategy, 6.4 Cost Estimation & BOM, 6.6 HLD)

The HLD committed the board to a **12–18 month delivery window** (6.6), built on 6.5's 3-wave order and priced inside the **~Rp 52 billion BOM (band ~Rp 48–58 billion, per 6.4)**.

| Phase | Weeks | Wave (6.5) | Milestone | Funded from (6.4) |
|---|---|---|---|---|
| Mobilization | 1–4 | — | Team onboarded, environments stood up per §1 | BOM services/labor line item |
| Wave 1 — Retail | 5–24 (~months 2–6) | Retail (first) | Pilot cohort cut over (§3), remaining cohorts in batches | BOM services/labor line item |
| Wave 2 — Logistics | 20–44 (~months 5–11, overlaps wave 1's tail) | Logistics (second) | All 40 hubs migrated, event bus load validated | BOM services/labor line item |
| **Compliance gate** | 44–48 | — | Data residency confirmed in the lakehouse; ACL and enclave segmentation (6.2) independently reviewed; regulator sign-off obtained for the finance-leasing back office | — (gate, not a build activity) |
| Wave 3 — Finance-leasing | 48–78 (~months 11–18) | Finance-leasing (last, gated) | ACL live, core cut over, enclave validated in production | BOM services/labor line item |
| Hypercare & close | 75–78 | — | Runbooks handed to steady-state operations | BOM services/labor line item |

The 18-month schedule above is the conservative end of the 12–18 month band (6.6); a 12-month fast-track compresses the same three waves with tighter overlap between wave 1 and wave 2 and a shorter hypercare tail. Neither path moves the compliance gate ahead of wave 3.

```
        MONTH:  1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18
Mobilization  [====]
Wave 1 Retail      [========================]
Wave 2 Logistics                [==========================================]
Compliance gate                                                  [==]
Wave 3 Finance-leasing                                                [============================]
Hypercare                                                                                        [==]
                ^retail first        ^logistics second                 ^gate       ^finance-leasing last (6.5)
```

## 5. Traceability check

```
LLD FIELD                          VALUE                          TRACES TO
──────────────────────────────────────────────────────────────────────────
K8s node count                     ~40 (14+8+6+8+4)                6.3 sizing
GPU node                           1 node, 2x L40S-class cards     6.3 sizing
Lakehouse                          1, mid-size, single-region      6.3 sizing
Total BOM envelope                 ~Rp 52B (band ~Rp 48-58B)       6.4 cost estimation
Migration order                    retail -> logistics -> finance  6.5 migration strategy
Delivery window                    12-18 months                   6.6 HLD (derived from 6.4/6.5)
Zero trust / enclave / mTLS        as specified                    6.2 security architecture
Strangler-fig / event bus / ACL /  as specified                    6.1 architecture patterns
API gateway-BFF
```

**Bottom line:** every figure a delivery engineer will touch — node counts, the GPU node, the lakehouse, the budget, the wave order, the timeline — is the exact figure the board approved in 6.6, priced in 6.4, sized in 6.3, sequenced in 6.5, patterned in 6.1, and secured in 6.2. This document adds build-level detail; it invents nothing.
