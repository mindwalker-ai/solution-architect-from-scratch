---
name: cloud-concepts-one-pager
description: A one-page cloud-placement artifact — service-model chooser, region/AZ HA pattern, and VM-vs-container decision aid — to align an SA and a customer during scoping.
phase: 0
lesson: 4
audience: customer
---

# Cloud Concepts One-Pager — TEMPLATE

> Fill this in during or right after a discovery/scoping call. It gives everyone in the room one shared map, and it pre-empts the four classic confusions: "cloud = public cloud", "container = lightweight VM", ignoring the shared-responsibility line, and single-AZ designs sold as "highly available".

**Customer:** _____________________ **Date:** __________ **Prepared by (SA):** __________
**Workload / project:** _______________________________________________

---

## 1. Workload placement — the service-model chooser

For each component, tag its traits, then place it on the ladder. **Rule of thumb: push each workload as far up toward SaaS as its need for control allows** — every rung up is undifferentiated ops you stop paying for. Stay lower only when data control, licensing, or a genuinely custom need pins you there.

**The tie-breaker question:** *Who patches the OS?* If it's you → IaaS. If it's the provider → PaaS or SaaS.

| Component | Stateful? | Traffic shape | Differentiating? | Placement (IaaS / PaaS / SaaS) | Why |
|-----------|-----------|---------------|------------------|-------------------------------|-----|
| _______ | _______ | _______ | _______ | _______ | _______ |
| _______ | _______ | _______ | _______ | _______ | _______ |
| _______ | _______ | _______ | _______ | _______ | _______ |
| _______ | _______ | _______ | _______ | _______ | _______ |
| _______ | _______ | _______ | _______ | _______ | _______ |

**Placement defaults to reach for:**
- Stateless + spiky → **PaaS** (managed containers / app platform); autoscale, provider owns OS+runtime.
- Commodity database / cache / search → **PaaS** (managed service); don't hand-run what's included.
- Files / images / static assets → **managed object storage** (multi-AZ by default; front with CDN).
- Dashboards, email, payments → **SaaS** (buy compliance and liability offload; never build payments).
- Raw VMs (**IaaS**) only when forced: legacy monolith assuming a full OS, per-VM licensed appliance, or a "must control the host" compliance rule.

---

## 2. Deployment model — whose building?

Pick per driver; name the *real* reason, not "we want control."

- [ ] **Public** — elastic, opex, fastest start. Default when there's no residency/hardware constraint.
- [ ] **Private** — data residency, regulatory control, sunk hardware, special GPUs/appliances (built on VMware / OpenStack / Proxmox — pick one).
- [ ] **Hybrid** — keep regulated/steady-state on-prem, burst spiky/new workloads to public. State where the boundary falls: __________________________.
- [ ] **Multi-cloud** — only with a concrete driver (second-source regulation, a service only one cloud has). Portability has a cost.

**Chosen model + the driver that decided it:** ______________________________________________

---

## 3. Region / AZ HA pattern

> **HA rule: at least two AZs.** Redundant servers in one AZ = redundancy, not availability. The stateful tier is where single-AZ designs die — put a standby in a second AZ with automatic failover.

Adapt this layout (drop in your components):

```
PUBLIC/PRIVATE CLOUD — REGION: ________________
┌──────────────────────────────────────────────────────────────┐
│                Internet → [CDN?] → Load Balancer              │
│                                    │  (spreads across AZs)    │
│        ┌───────────────────────────┴──────────────┐          │
│        ▼                                          ▼          │
│  ┌────────── AZ-A ──────────┐   ┌────────── AZ-B ──────────┐ │
│  │ Stateless tier  ×N        │   │ Stateless tier  ×N       │ │
│  │ ___________________       │   │ ___________________      │ │
│  │ DB ── PRIMARY ─────────────┼──▶│ DB ── STANDBY (failover) │ │
│  │           (sync replicate) │   │                          │ │
│  └───────────────────────────┘   └──────────────────────────┘ │
│  Object storage ── REGIONAL, multi-AZ by default ──           │
│  Managed services ── provider handles their own HA ──         │
│                                                              │
│  DR: cross-REGION backup/replica → survives a whole region.  │
│      RTO target: ______   RPO target: ______  (size in Ph.2) │
└──────────────────────────────────────────────────────────────┘
```

**HA checklist:**
- [ ] Load balancer spreads traffic across ≥2 AZs and health-checks nodes.
- [ ] Every **stateful** tier has a standby in a second AZ with automatic failover.
- [ ] Object/blob storage confirmed multi-AZ (usually default).
- [ ] Managed services' own HA (multi-AZ) confirmed with the provider.
- [ ] DR (cross-region) sized separately if a whole-region loss must be survived. **Multi-AZ ≠ DR.**

---

## 4. Shared-responsibility line

Draw the line for THIS design so the security team sees who owns what. The line moves up as workloads climb the service ladder.

```
SECURITY *IN* THE CLOUD  →  CUSTOMER OWNS
  · data & its classification
  · identity / accounts / permissions (IAM)
  · app config, secrets, network rules you set
  · OS patching  ← ONLY if any tier is on IaaS: ______________
──────────────────────────────────────────────────
SECURITY *OF* THE CLOUD  →  PROVIDER OWNS
  · physical datacenter, power, cooling
  · host hypervisor / virtualization layer
  · each managed service's uptime & patching
```

**Any OS patching landing on the customer? (Y/N):** ______  If yes, which tier and why it's on IaaS: ______________

---

## 5. VM-vs-container decision aid (for compute you package yourself)

| Question | If YES → | If NO → |
|----------|----------|---------|
| Can this be a **managed service** (PaaS) instead? | Do that — skip VM/container ops entirely | Continue below |
| Does it need a **full OS** or a per-VM **license**, or **legacy** OS assumptions? | **VM (IaaS)** | Continue |
| Is it **stateless** and does it **scale elastically / spike**? | **Container** | Either; default to container for density |
| Does it need **hard, hardware-level isolation** (untrusted tenants)? | **VM**, or containers *inside* VMs | Container is fine |

**Reminder:** a container is **not** a lightweight VM — it shares the host kernel (fast, dense, weaker isolation); a VM boots its own kernel (slower, heavier, strong isolation).

**Compute packaging decisions:**
| Component | VM / Container / Managed | Reason |
|-----------|--------------------------|--------|
| _______ | _______ | _______ |
| _______ | _______ | _______ |

---

## 6. Cost & responsibility sanity-check

- **Cost shape:** does the design scale *down* off-peak, or is it sized for peak 24/7? _______________________
  (Managed + containers = pay for the spike only. Always-on fat VMs sized for peak = the classic ~3× overspend.)
- **Opex vs capex:** ____________________
- **Responsibility surprise:** did re-drawing the line reveal work the customer didn't expect to own (or expected to own but doesn't)? _______________________

---

## One-line summary (paste into the HLD)

> _"<Workload> runs as <placement mix> on <deployment model> across <N> AZs in <region>, with <stateful tier> failing over to a second AZ and <DR posture>. The customer owns data, identity, and config; the provider owns the infrastructure and every managed service."_
