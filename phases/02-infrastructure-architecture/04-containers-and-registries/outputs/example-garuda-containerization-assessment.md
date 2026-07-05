---
name: containerization-assessment-example
description: Worked Containerization Assessment for the fictional Garuda Finance — the five estate workloads scored on the readiness rubric, verdicts sequenced into waves, and a Harbor-based supply-chain policy for an OJK-regulated on-prem private cloud.
phase: 2
lesson: 4
audience: customer | internal
---

# Containerization Assessment — WORKED EXAMPLE (Garuda Finance)

> This is `template-containerization-assessment.md` filled in for a fictional customer so the matrix isn't abstract. **Garuda Finance** is an Indonesian financial-services firm — ~600 branches, ~8M customers, two data centers (Jakarta / Surabaya), ~4,000 transactions/min at peak, OJK-regulated — building an on-prem private cloud with a modern container/Kubernetes platform (Capstone B). K8s skills in-house are limited, which shapes the wave plan. The platform lead opened with "we'll containerize everything." This document is why that's the wrong instruction and what to do instead.

**Customer:** Garuda Finance  ·  **Industry:** Financial services (banking)  ·  **Prepared by (SA):** M. Ikhwan  ·  **Date:** 2026-07-04
**Platform target:** On-prem private cloud + K8s (Capstone B)  ·  **Regulatory driver:** OJK (supply-chain provenance is auditable)
**In-house platform maturity:** Limited — first production cluster. First wave must be low-blast-radius.

---

## 1. Workload inventory

| Workload | Origin | State | Change rate | Note |
|---|---|---|---|---|
| **Mobile app backend** (APIs) | Custom | Stateless (DB external) | Frequent | Customer-facing, spiky load |
| **New microservices** (greenfield) | Custom | Stateless | Frequent | Built cloud-native from day one |
| **Loan origination** (custom app) | Custom | Some session/workflow state | Occasional | Older custom monolith, local-disk habits |
| **Core-banking** (packaged COTS) | COTS | Deeply stateful (embedded DB) | Frozen | Vendor-supported on specific VMs only |
| **Batch / reporting** | Mixed | Jobs ephemeral, data heavy | Scheduled | Some scripts, some tied to the core DB |

---

## 2. Readiness scoring matrix

```
GARUDA FINANCE — CONTAINERIZATION READINESS SCORING     (0–2 each; /12 total)

 WORKLOAD              C1  C2  C3  C4  C5  C6   TOTAL   VERDICT
 ─────────────────────────────────────────────────────────────────────────────
 Mobile app backend     2   2   2   2   2   2  = 12    CONTAINERIZE  (first wave)
 New microservices      2   2   2   2   2   2  = 12    CONTAINERIZE  (first wave)
 Loan origination       2   1   2   1   1   2  =  9    CONTAINERIZE WITH WORK
 Batch / reporting      1   1   1   1   1   1  =  6    PARTIAL (split the tier)
 Core-banking (COTS)    0   0   0   0   0   0  =  0    KEEP AS VM
 ─────────────────────────────────────────────────────────────────────────────
   C1 origin · C2 state · C3 licensing · C4 change · C5 12-factor · C6 vendor support
```

| Workload | C1 | C2 | C3 | C4 | C5 | C6 | **Total /12** | Verdict band |
|---|:--:|:--:|:--:|:--:|:--:|:--:|:--:|---|
| Mobile app backend | 2 | 2 | 2 | 2 | 2 | 2 | **12** | Containerize (first wave) |
| New microservices | 2 | 2 | 2 | 2 | 2 | 2 | **12** | Containerize (first wave) |
| Loan origination | 2 | 1 | 2 | 1 | 1 | 2 | **9** | Containerize with work |
| Batch / reporting | 1 | 1 | 1 | 1 | 1 | 1 | **6** | Partial |
| Core-banking (COTS) | 0 | 0 | 0 | 0 | 0 | 0 | **0** | Keep as VM |

> **Veto check:** Core-banking's `C6 = 0` (vendor won't support containers) is decisive on its own — every other 0 just confirms it. The batch tier's honest score is a **6 hiding two workloads**: the stateless job-runners would score ~9, the DB-coupled ETL ~3. Averaging them to 6 is why we split it in §3 rather than treat "batch" as one thing.

---

## 3. Verdicts & recommendation

- **Mobile app backend (12) → Containerize, first wave.** Stateless, custom, deployed often, and already 12-factor. Highest payoff, lowest risk. Start here *because* K8s skills are thin — it builds the team's muscle on a workload whose failure doesn't stop the branch network.
- **New microservices (12) → Containerize, first wave.** Greenfield and cloud-native; there is no reason to build these as VMs. They set the pattern (approved base image, scan gate, signing) every later workload inherits.
- **Loan origination (9) → Containerize with work.** The code and license are friendly, but it holds workflow state and writes to local disk (C2/C5 = 1). The work is a scoped refactor: externalize sessions to a backing store, move config to environment variables, send logs to stdout. Second wave — after the greenfield services prove the platform.
- **Batch / reporting (6) → Partial.** Split the tier. The **stateless job-runners** (report generation, file transforms) containerize cleanly and gain on-demand scheduling. The **ETL jobs coupled to the core-banking database** stay on VMs next to their data until the data layer is modernized. Surfacing that one "batch" label hid two verdicts is the assessment earning its keep.
- **Core-banking COTS (0) → Keep as VM.** Every criterion says stop, and C6 vetoes: the vendor will not support a containerized deployment of the system that moves the bank's money. It stays on VMs in the private cloud and is **integrated with** the container platform (APIs, events), not absorbed into it.

**Wave plan:**
- **Wave 1 (prove the platform):** mobile app backend, new microservices.
- **Wave 2 (after refactor):** loan origination + the stateless batch job-runners.
- **Stays on VMs:** core-banking COTS, its embedded database, and the DB-coupled ETL.

---

## 4. Registry & software-supply-chain policy

**Private registry**
- [x] **Chosen registry: Harbor** — driver: open-source, on-prem-native, built-in Trivy scanning + cosign signing, aligns with the K8s stack, no license cost. No incumbent artifact platform to reuse.
- [x] **No public Docker Hub in the production path** — external images are vetted and mirrored into Harbor first.
- [x] **Replication:** Harbor in Jakarta **replicated to Surabaya**, so each DC pulls locally and stays deployable if the inter-DC link drops. The replication traffic is sized into the DC-interconnect from 2.3 (image pulls, not just DB replication).

**Base-image policy**
- [x] Golden base images (minimal — distroless / vendor UBI) in a locked Harbor project, owned by the platform team.
- [x] **`latest` banned; images pinned by digest.** Base images patched **monthly and on any Critical CVE**; downstream apps inherit the fix on rebuild.

**Scanning gate**
- [x] **Trivy on push. Critical CVEs block promotion.** Fix SLA — High: 30 days; Medium: next release.

**Signing & admission**
- [x] Promoted images **signed with cosign**.
- [x] The K8s platform's **admission control denies** any unsigned, unscanned, or off-policy image (enforced in 2.5).

**Access & audit**
- [x] Per-project **RBAC** in Harbor (dev / staging / prod separation).
- [x] Every push/pull **logged** for the OJK trail; retention per the bank's records policy.

---

## 5. Target-state picture

```
GARUDA FINANCE — CONTAINERIZATION TARGET STATE   (replicated across Jakarta ⇄ Surabaya)

   ┌──────────────────────────── PRIVATE CLOUD (Capstone B) ─────────────────────────┐
   │                                                                                 │
   │   CONTAINER PLATFORM (K8s — 2.5)               VM ESTATE (stays as VMs)          │
   │   ┌───────────────────────────────┐            ┌──────────────────────────────┐ │
   │   │ • Mobile app backend  (wave 1) │            │ • Core-banking COTS (SLA-safe)│ │
   │   │ • New microservices   (wave 1) │  <──────>  │ • Core-banking embedded DB    │ │
   │   │ • Loan origination    (wave 2) │            │ • ETL jobs bound to core DB   │ │
   │   │ • Batch job-runners   (wave 2) │            └──────────────────────────────┘ │
   │   └───────────────┬───────────────┘               integrate, don't absorb        │
   │                   │ pull trusted, signed images only                             │
   │         ┌─────────▼──────────┐                                                   │
   │         │  HARBOR REGISTRY    │  Trivy scan · cosign verify · RBAC · audit        │
   │         │  Jakarta DC         │◀────────── replicate ──────────▶  Surabaya DC     │
   │         └────────────────────┘                                                   │
   └─────────────────────────────────────────────────────────────────────────────────┘
        Source of truth for every box: the readiness scoring matrix in §2.
```

---

## One-line summary (pasted into the platform design report)

> "Of 5 workloads assessed, 2 containerize in wave 1 (mobile backend, new microservices — stateless, custom, high-change), 2 more after a scoped refactor (loan origination + stateless batch runners), and the rest stay on VMs (core-banking COTS is vendor-pinned and deeply stateful; its DB-coupled ETL follows the data). All images flow through Harbor — Trivy-scanned (Critical blocks promotion), cosign-signed, admission-verified — replicated across Jakarta and Surabaya. Garuda gets cloud-native where it pays off and keeps a supported core-banking SLA where it matters most to the regulator."

---

*This assessment feeds 2.5 Kubernetes Architecture (what runs on the cluster + admission enforcement of the signing policy) and Capstone B (the on-prem private cloud build).*
