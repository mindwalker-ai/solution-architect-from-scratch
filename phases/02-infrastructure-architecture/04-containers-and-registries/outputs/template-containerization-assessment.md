---
name: containerization-assessment
description: A scored, defensible portfolio call on which workloads to containerize (and which stay VMs), plus the registry + software-supply-chain policy that governs the images the estate will trust.
phase: 2
lesson: 4
audience: customer | internal
---

# Containerization Assessment — TEMPLATE

> Fill this in when a customer says "we want to containerize." It converts that ambition into a **scored portfolio** (containerize now / with work / keep as VM) and a **governance policy** (registry, base images, scanning, signing). It exists to stop two failure modes: "containerize everything" (which drags COTS and stateful systems into a mess) and "containerize nothing" (which forfeits the elasticity and CI/CD the platform is paying for). Feeds the Kubernetes design (2.5) and the private-cloud capstone (Capstone B).

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by (SA):** `<name>`  ·  **Date:** `<YYYY-MM-DD>`
**Platform target:** `<on-prem private cloud / public K8s / hybrid>`  ·  **Regulatory driver:** `<e.g. OJK, HIPAA, PCI, none>`
**In-house platform maturity:** `<strong / limited / none>`  (drives how aggressive the first wave should be)

---

## How to use this template

1. **Inventory** the workloads and tag their traits (§1).
2. **Score** each on the 6-criteria rubric, 0–2 per criterion (§2).
3. **Band** the total into a verdict and write the per-workload recommendation (§3).
4. **Govern** the images the containerized tiers will run: registry, base images, scan, sign, admission (§4).
5. **Draw** the target state — container platform + VM estate + one registry (§5).

**Rubric legend:** `C1` build origin · `C2` state · `C3` licensing · `C4` change frequency · `C5` 12-factor fit · `C6` vendor support in containers.

---

## 1. Workload inventory

> List the real estate the workshop surfaced. Keep it qualitative — you're assessing readiness, not doing a hardware count.

| Workload | Origin (custom / COTS) | State (stateless / externalizable / embedded) | Change rate | Note |
|---|---|---|---|---|
| `<app>` | `<custom / COTS>` | `<state>` | `<frequent / occasional / frozen>` | `<context>` |
| `<app>` | | | | |
| `<app>` | | | | |
| `<app>` | | | | |
| `<app>` | | | | |

---

## 2. Readiness scoring matrix

Score each workload 0–2 per criterion. Higher = more container-ready. Fill the totals and let the band decide the verdict.

```
CONTAINERIZATION READINESS RUBRIC   (score 0–2 per criterion; higher = more container-ready)

 CRITERION                        0  (keep as VM)         1  (needs work)          2  (container-ready)
 ────────────────────────────────────────────────────────────────────────────────────────────────────
 C1  Build origin                 COTS, no vendor image   COTS w/ vendor image     Custom code you own
 C2  State                        embedded / local data   state can externalize    stateless by design
 C3  Licensing                    per-socket / appliance  license allows it        OSS / core-agnostic
 C4  Change frequency             frozen / rare           occasional               frequent (CI/CD pays off)
 C5  12-factor fit                assumes full OS + disk  minor refactor           config-in-env, disposable
 C6  Vendor support (containers)  unsupported / voids SLA community / at own risk  fully supported
 ────────────────────────────────────────────────────────────────────────────────────────────────────
 TOTAL /12  →   0–4  KEEP AS VM       5–8  CONTAINERIZE WITH WORK       9–12  CONTAINERIZE (first wave)
```

| Workload | C1 | C2 | C3 | C4 | C5 | C6 | **Total /12** | Verdict band |
|---|:--:|:--:|:--:|:--:|:--:|:--:|:--:|---|
| `<app>` | _ | _ | _ | _ | _ | _ | `__` | `<band>` |
| `<app>` | _ | _ | _ | _ | _ | _ | `__` | `<band>` |
| `<app>` | _ | _ | _ | _ | _ | _ | `__` | `<band>` |
| `<app>` | _ | _ | _ | _ | _ | _ | `__` | `<band>` |
| `<app>` | _ | _ | _ | _ | _ | _ | `__` | `<band>` |

> **Veto rules to apply before trusting the total:** `C6 = 0` (vendor won't support containers) is nearly decisive on its own — a working SLA beats a modern packaging. `C2 = 0` (embedded stateful data) means data gravity, not "un-containerizable-forever," but keep it off an immature platform.

---

## 3. Verdicts & recommendation

For each workload, one paragraph the customer can act on. Sequence the "containerize" verdicts into **waves** — de-risk the platform on low-blast-radius, stateless, custom services first, especially when in-house skills are limited.

- **`<app>` (score `__`) → `<Containerize, first wave / With work / Partial / Keep as VM>`.** `<why — cite the deciding criteria; if "with work," name the scoped refactor; if "partial," name the split; if "keep as VM," name the veto>`.
- **`<app>` (score `__`) → `<verdict>`.** `<why>`
- **`<app>` (score `__`) → `<verdict>`.** `<why>`
- **`<app>` (score `__`) → `<verdict>`.** `<why>`
- **`<app>` (score `__`) → `<verdict>`.** `<why>`

**Wave plan:**
- **Wave 1 (prove the platform):** `<stateless, custom, high-change services>`
- **Wave 2 (after refactor):** `<the "with work" apps + the containerizable half of any "partial">`
- **Stays on VMs:** `<COTS the vendor pins, deeply stateful systems, licensed appliances>`

---

## 4. Registry & software-supply-chain policy

The containerized tiers need governed images. Specify each control — this is the section a regulator's security team reads.

**Private registry**
- [ ] **Chosen registry:** `<Harbor / Quay / Nexus / Artifactory>` — driver: `<on-prem, OSS, incumbent artifact tool, vendor support…>`
- [ ] **No public registry in the production path** (no direct Docker Hub pulls at deploy time).
- [ ] **Replication / HA:** `<replicate across DC-A ⇄ DC-B so each site pulls locally and survives an inter-DC link drop — size the link for image pulls>`

**Base-image policy**
- [ ] Curated **golden base images** (minimal — distroless / UBI / slim), in a locked registry project. Owner: `<team>`.
- [ ] **Ban `latest`; pin by digest.** Patch cadence for base images: `<e.g. monthly + on Critical CVE>`.

**Scanning gate**
- [ ] Scanner: `<Trivy / Clair / Xray>`, run on push.
- [ ] **Critical CVEs block promotion.** Fix SLA for High: `<e.g. 30 days>`; Medium: `<e.g. next release>`.

**Signing & admission**
- [ ] Sign promoted images with `<cosign / Notation>`.
- [ ] Admission control **denies** any image that is unsigned, unscanned, or off-policy. (Enforced at the K8s layer — see 2.5.)

**Access & audit**
- [ ] Per-project **RBAC** in the registry.
- [ ] Every push/pull **logged** for the compliance trail. Retention: `<per regulator>`.

---

## 5. Target-state picture

Replace the placeholders. Show a container platform for the ready tiers, a VM estate for what stays, and one governed registry feeding both.

```
<CUSTOMER> — CONTAINERIZATION TARGET STATE   (replicated across <DC-A> ⇄ <DC-B>)

   ┌──────────────────────────── PRIVATE CLOUD / PLATFORM ───────────────────────────┐
   │                                                                                 │
   │   CONTAINER PLATFORM (K8s — 2.5)               VM ESTATE (stays as VMs)          │
   │   ┌───────────────────────────────┐            ┌──────────────────────────────┐ │
   │   │ • <wave-1 stateless service>   │            │ • <COTS the vendor pins>      │ │
   │   │ • <wave-1 stateless service>   │  <──────>  │ • <stateful DB / ledger>      │ │
   │   │ • <wave-2 refactored app>      │            │ • <DB-coupled batch / ETL>    │ │
   │   │ • <stateless job-runners>      │            └──────────────────────────────┘ │
   │   └───────────────┬───────────────┘               integrate, don't absorb        │
   │                   │ pull trusted, signed images only                             │
   │         ┌─────────▼──────────┐                                                   │
   │         │  <REGISTRY>         │  scan · verify signature · RBAC · audit           │
   │         │  <DC-A>             │◀────────── replicate ──────────▶  <DC-B>          │
   │         └────────────────────┘                                                   │
   └─────────────────────────────────────────────────────────────────────────────────┘
        Source of truth for every box: the readiness scoring matrix in §2.
```

---

## One-line summary (paste into the platform design report)

> _"Of `<n>` workloads assessed, `<x>` containerize in wave 1 (stateless, custom, high-change), `<y>` after a scoped refactor, and `<z>` stay on VMs (`<COTS/stateful reason>`). All images flow through `<registry>` — scanned (`<scanner>`, Critical blocks), signed (`<cosign>`), and admission-verified — replicated across `<DC-A>`/`<DC-B>`. The customer gets cloud-native where it pays off and keeps a supported SLA where it matters."_

---

*Worked example: see `example-garuda-containerization-assessment.md` in this folder.*
