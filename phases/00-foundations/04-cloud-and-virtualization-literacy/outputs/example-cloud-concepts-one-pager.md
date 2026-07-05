---
name: cloud-concepts-one-pager-example
description: Worked example of the Cloud Concepts One-Pager, filled in for the fictional Meridian Retail omnichannel storefront.
phase: 0
lesson: 4
audience: customer
---

# Cloud Concepts One-Pager — WORKED EXAMPLE (Meridian Retail)

> This is `template-cloud-concepts-one-pager.md` filled in for a fictional customer, so the template isn't abstract. **Meridian Retail** is a mid-size omnichannel retailer whose traffic spikes 8–10× during quarterly flash sales. Goal from the CTO: "highly available, and stop overspending."

**Customer:** Meridian Retail **Date:** 2026-07-04 **Prepared by (SA):** M. Ikhwan
**Workload / project:** Omnichannel storefront + orders + analytics migration to cloud

---

## 1. Workload placement — the service-model chooser

| Component | Stateful? | Traffic shape | Differentiating? | Placement | Why |
|-----------|-----------|---------------|------------------|-----------|-----|
| Storefront (frontend + API) | No | Spiky (flash sales) | Somewhat (the brand) | **PaaS** (managed containers) | Stateless + spiky = must autoscale; provider owns OS/runtime |
| Catalog cache / sessions | Semi (cache) | Spiky | No | **PaaS** (managed Redis) | Commodity; self-running buys nothing |
| Orders & inventory DB | **Yes** | Steady, spikes on sale | No | **PaaS** (managed relational DB) | Critical but commodity engine; provider does backups/failover/patching |
| Product images / assets | Yes (objects) | Read-heavy, spiky | No | **Managed object storage** + CDN | Durable, cheap, multi-AZ by default |
| Site search | Semi (index) | Spiky | No | **PaaS** (managed search) | Undifferentiated; index scales with the sale |
| Analytics / BI | Yes (warehouse) | Nightly batch | No | **SaaS** BI + **PaaS** warehouse | Merchandisers consume dashboards; zero infra to run |
| Payments | N/A (external) | Follows checkout | No | **SaaS** (payment gateway) | Never build card handling — buy compliance + liability offload |

**Key observation:** *nothing lands on IaaS.* Modern retail app → managed-first is the defensible default. No legacy monolith or per-VM appliance here forces raw VMs.

---

## 2. Deployment model — whose building?

- [x] **Public** — elastic, opex, fastest start.
- [ ] Private / Hybrid / Multi-cloud.

**Chosen model + the driver that decided it:** Single **public cloud**, single region. Driver: **elastic flash-sale spikes** + no data-residency mandate + no sunk hardware worth keeping. (If a regulator required card data on owned hardware, we'd carve that one store onto a private cloud and go hybrid — not the case here.)

---

## 3. Region / AZ HA pattern

```
PUBLIC CLOUD — REGION: ap-southeast
┌──────────────────────────────────────────────────────────────┐
│                Internet → CDN → Load Balancer                 │
│                                 │  (spreads across AZs)        │
│        ┌────────────────────────┴─────────────────┐          │
│        ▼                                          ▼          │
│  ┌────────── AZ-A ──────────┐   ┌────────── AZ-B ──────────┐ │
│  │ Storefront containers ×N  │   │ Storefront containers ×N │ │
│  │ Cache node (replica)      │   │ Cache node (replica)     │ │
│  │ Orders DB ── PRIMARY ──────┼──▶│ Orders DB ── STANDBY     │ │
│  │            (sync replicate)│   │  (auto-failover)         │ │
│  └───────────────────────────┘   └──────────────────────────┘ │
│  Object storage ── REGIONAL, multi-AZ by default ──           │
│  Managed search / BI / payments ── provider handles their HA ─│
│                                                              │
│  DR: nightly cross-REGION backup of DB + objects.            │
│      RTO target: 4h   RPO target: 15m  (refined in Phase 2)  │
└──────────────────────────────────────────────────────────────┘
```

**HA checklist:**
- [x] Load balancer spreads traffic across AZ-A and AZ-B, health-checks containers.
- [x] Orders DB has a synchronous standby in AZ-B with automatic failover. ← the make-or-break HA decision.
- [x] Object storage confirmed regional/multi-AZ (default).
- [x] Managed search / BI / payments HA owned by their providers.
- [x] DR: cross-region nightly backup. **Multi-AZ ≠ DR** — this survives a whole-region loss.

**If asked "can we drop the standby DB to save money?"** No. The storefront could be perfectly redundant and the site still goes fully dark the first time AZ-A loses power, because orders can't be written. Single-AZ stateful tier = not HA.

---

## 4. Shared-responsibility line

```
SECURITY *IN* THE CLOUD  →  MERIDIAN OWNS
  · product/customer/order data & its classification
  · identity, accounts, permissions (IAM)
  · app config, secrets, LB/network rules
  · OS patching  ← NONE (nothing is on IaaS)
──────────────────────────────────────────────────
SECURITY *OF* THE CLOUD  →  PROVIDER OWNS
  · datacenter, power, cooling
  · hypervisor / virtualization
  · uptime & patching of managed containers, DB, cache, search, storage
```

**Any OS patching landing on the customer? (Y/N):** **N** — managed-first means no OS lands on Meridian. Worth surfacing to their security team early; it usually reframes the whole risk conversation.

---

## 5. VM-vs-container decision aid

| Component | VM / Container / Managed | Reason |
|-----------|--------------------------|--------|
| Storefront (frontend + API) | **Container** (on PaaS) | Stateless + spiky; milliseconds to start, scales out/in for the sale |
| Everything stateful (DB, cache, search, objects, BI, payments) | **Managed** | Skip VM/container ops entirely; provider owns OS + runtime |
| *(hypothetical legacy pricing engine)* | *would be **VM*** | *If it existed and assumed a full OS / per-VM license — none present* |

Result: **containers-on-PaaS for compute, managed services for everything stateful.**

---

## 6. Cost & responsibility sanity-check

- **Cost shape:** scales *down* off-peak — containers autoscale, so Meridian pays for 10× capacity only during the flash sale, not year-round. Always-on VMs sized for peak would be the classic ~3× overspend.
- **Opex vs capex:** fully opex; no datacenter, no hardware refresh, no DBA team to hire.
- **Responsibility surprise:** yes — Meridian expected to keep patching servers "for control." Showing that zero OS patching lands on them (nothing is on IaaS) turned the biggest objection into the biggest selling point.

---

## One-line summary (pasted into the HLD)

> "Meridian's storefront runs as managed containers with managed DB/cache/search/storage and SaaS BI + payments, on a single public cloud across 2 AZs in ap-southeast, with the orders database failing over to a second AZ and nightly cross-region DR backups (RTO 4h / RPO 15m). Meridian owns data, identity, and config; the provider owns the infrastructure and every managed service — no OS patching on the customer."
