---
name: example-garuda-finance-kubernetes-hld
description: Worked Kubernetes Platform HLD for Garuda Finance — a two-DC on-prem private cloud for a thin K8s team, feeding Capstone B and handing DR to lesson 2.6
phase: 2
lesson: 5
audience: customer | internal
---

# Kubernetes Platform HLD — Garuda Finance (worked example)

> This is `template-kubernetes-platform-hld.md` filled in for the running Phase 2 customer. It shows what "good" looks like: the topology, the pools, and — decisively — the distro choice defended against the team's skills gap.

**Customer:** Garuda Finance (fictional)  ·  **Industry:** Indonesian financial services (core banking, loan origination, mobile)
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-04  ·  **Opportunity:** On-prem private cloud container platform  ·  **Version:** v0.2
**Key operating constraint:** **Limited in-house Kubernetes skill** + OJK regulation + 24/7 payments uptime → **drives a managed distro (§6).**

**Company shape (from discovery):** ~600 branches · ~8M customers · core banking + loan origination + mobile app at ~4,000 txns/min peak · 2 DCs (Jakarta primary, Surabaya DR) · building an on-prem private cloud.

Legend: **CP** = control plane · **etcd quorum** = odd member count kept intra-DC · **node pool** = worker group isolated by taint/label · **soft multi-tenancy** = namespace+quota+RBAC (not a hard security boundary).

---

## 1. Clusters & topology

| Cluster | Site / DC | Role | Notes |
|---|---|---|---|
| `gf-jkt-prod` | Jakarta (DC-1) | **Active** | Self-contained; owns its own etcd; runs all production traffic |
| `gf-sby-dr` | Surabaya (DC-2) | **DR / warm standby** | Self-contained; reconciled from the same Git repo; sized to run critical apps on failover |

**Stretch decision:** **Per-DC clusters.** Rejected one stretched cluster — with only two sites, no 3-member etcd can keep quorum after losing the majority DC, and Jakarta↔Surabaya WAN latency destabilizes Raft. DR is handled *above* the cluster (§7).

## 2. Control-plane HA

| Item | Decision | Rationale |
|---|---|---|
| Control-plane nodes per cluster | **3** | Odd quorum; tolerates loss of 1 node/rack (2 would tolerate 0) |
| etcd topology | **Stacked** (co-located on CP nodes) | One fewer tier for a thin team; revisit external etcd only if 2.2 I/O sizing demands it |
| etcd placement | **Intra-DC, spread across 3 racks/fault domains** | Keep Raft on the low-latency LAN; survive a single rack loss |
| API endpoint | **VIP / load balancer** in front of the 3 api-servers | Stable endpoint for nodes and `kubectl`; kills the single-master SPOF |

Quorum check: 3 members → quorum 2 → tolerates 1 failure. This is the sentence for the CTO: *one master is a SPOF, two survive nothing, three survive a node loss.*

## 3. Node pools (per cluster)

| Node pool | Workloads | Isolation | Sizing basis (design assumption) |
|---|---|---|---|
| **payments-isolated** | Core banking, payment rails | Dedicated nodes; `taint workload=payments:NoSchedule`; only payment pods tolerate | Sized for the ~4,000 txns/min peak **+ headroom**; predictable latency for 24/7 payments |
| **general** | Loan origination, mobile back-end | Default schedulable | Bursty, business-hours; tolerant of sharing |
| **batch** | Overnight reconciliation, reporting | Separate pool, lower PriorityClass | Overnight window; must never starve online workloads |

> Sizing here is a **design proposal** with stated assumptions — the Phase 6 sizing lesson finalizes vCPU/RAM/node counts against real workload telemetry. No new customer numbers are invented; only the given ~4,000 txns/min peak anchors the payments pool.

## 4. CNI / CSI / Ingress

| Edge | Choice | Ties to | Why |
|---|---|---|---|
| **CNI** | **Calico** (Cilium as upgrade path) | 2.3 fabric | NetworkPolicy for pod-level segmentation OJK expects; Calico is the simplest, most-deployed option — right for a thin team |
| **CSI** | **Storage-platform CSI from 2.2** | 2.2 storage | StorageClasses: `fast-nvme` for payment/core-banking DBs (StatefulSets), `standard` for the rest |
| **Ingress** | **NGINX Ingress + MetalLB** (or hardware LB if present) | 2.3 LB | No cloud LB on-prem; MetalLB assigns LoadBalancer IPs, NGINX does TLS + host/path routing |

## 5. Tenancy & RBAC

| Namespace | Owner team | ResourceQuota | NetworkPolicy | RBAC binding |
|---|---|---|---|---|
| `payments` | Core banking | Hard CPU/mem cap | default-deny + explicit allows | dev = `edit` in ns only |
| `loans` | Loan origination | Hard cap | default-deny + allows | dev = `edit` in ns only |
| `mobile` | Mobile back-end | Hard cap | default-deny + allows | dev = `edit` in ns only |
| `platform` | Platform team | — | — | `cluster-admin` |
| `audit` | Compliance (OJK evidence) | — | — | **read-only cluster-wide** |

Payments also gets the **dedicated node pool** from §3 — namespace-level soft multi-tenancy is not a hard security boundary, and a regulated payment workload needs the harder line.

## 6. Distribution decision (the call that makes the platform survivable)

| Distro | Ops burden | Cost | Hardening/support | Fit for Garuda |
|---|---|---|---|---|
| Upstream/kubeadm | **Highest** — team owns etcd, upgrades, certs, edges | Free SW / high people cost | DIY | **Poor** — a jet with no autopilot for a team with limited K8s skill |
| k3s | Low | Free | CIS-hardenable | Great for the lab and branch edge; light for a two-DC bank core |
| **RKE2 + Rancher** | **Low-med, managed** — lifecycle + one multi-cluster console | Free engine; optional paid support | **CIS-hardened, FIPS-capable**; Rancher fleet mgmt | **✅ Chosen** — on-prem, offsets skills gap, one console for both DCs, OJK-friendly hardening |
| OpenShift | Low, turnkey | **Highest** (per-core) | Enterprise, strong defaults | Strong alternative if budget allows a heavier, pricier turnkey platform |
| VMware Tanzu | Low-med | Licensed | Enterprise | Only if the private cloud is vSphere-based |

**Chosen distro: RKE2 + Rancher.**
**Defense (one sentence):** *We chose a managed distribution so a small team can safely run a two-DC platform — RKE2 automates the control-plane lifecycle and its CIS/FIPS hardening satisfies OJK, while Rancher gives them a single console to operate Jakarta and Surabaya; the distro is the autopilot for the skills gap.*
**Alternative on file:** Red Hat OpenShift, if Garuda prefers a fully turnkey developer platform and accepts the subscription cost and heavier footprint.

## 7. DR approach (handed to 2.6)

- **Pattern:** GitOps (Argo CD) — the Git repo is desired state, continuously reconciled into `gf-jkt-prod` and ready to reconcile into `gf-sby-dr`. Failover = point traffic at Surabaya and let GitOps redeploy the same manifests. **Redeploy the app, don't stretch the cluster.**
- **What the platform owns:** making the Surabaya redeploy trivial, repeatable, and identical to Jakarta.
- **Handed to 2.6:** payment-data replication mechanism, RPO/RTO targets, the failover runbook, and DNS/traffic cutover — the *data* problem, which etcd must never attempt.

---

## 8. Topology diagram

```mermaid
flowchart TB
    subgraph A["gf-jkt-prod — Jakarta (active)"]
      cpa["Control plane ×3<br/>etcd quorum=3 (intra-DC, 3 racks)<br/>VIP → api-servers"]:::cp
      pa1["pool: payments-isolated<br/>(taint workload=payments)"]:::pl
      pa2["pool: general (loans, mobile)"]:::pl
      pa3["pool: batch (overnight)"]:::pl
      cpa --> pa1 & pa2 & pa3
    end
    subgraph B["gf-sby-dr — Surabaya (DR, warm)"]
      cpb["Control plane ×3<br/>etcd quorum=3 (intra-DC)"]:::cp
      pb1["pool: payments-isolated"]:::pl
      pb2["pool: general / batch"]:::pl
      cpb --> pb1 & pb2
    end
    git["GitOps (Argo CD)<br/>desired state in Git"]:::g
    ran["Rancher — one console for BOTH clusters"]:::r
    git -->|reconcile| cpa
    git -->|reconcile on failover| cpb
    ran -.manages.-> cpa
    ran -.manages.-> cpb
    A -. async data replication (2.2 / 2.6) .-> B

    classDef cp fill:#E7F0FC,stroke:#2E86F0,color:#1B5FD9;
    classDef pl fill:#EAF6EC,stroke:#2E7D32,color:#1B5E20;
    classDef g fill:#FFF4E5,stroke:#B26A00,color:#7A4600;
    classDef r fill:#FDECEF,stroke:#C2185B,color:#880E4F;
```

### ASCII fallback

```
   ┌──── gf-jkt-prod (Jakarta, active) ────┐     ┌──── gf-sby-dr (Surabaya, DR) ────┐
   │ CP ×3   etcd quorum=3 (intra-DC)      │     │ CP ×3   etcd quorum=3 (intra-DC) │
   │ pools:                                │     │ pools:                           │
   │   payments-isolated (taint)  ← peak   │     │   payments-isolated              │
   │   general (loans, mobile)             │     │   general / batch                │
   │   batch (overnight)                   │     │                                  │
   └───────────────────┬───────────────────┘     └────────────────┬─────────────────┘
        Rancher ── one console manages both ──────────────────────┤
        Argo CD ── Git = desired state, reconciles both ──────────┘
   WAN carries: GitOps sync + async data replication (2.2/2.6). NEVER etcd quorum.
```

---

## 9. Decision log

| # | Decision | Alternative rejected | Why | Owner |
|---|---|---|---|---|
| 1 | Per-DC clusters (Jakarta + Surabaya) | One stretched cluster across both DCs | 2-site etcd can't keep quorum after losing the majority DC; WAN latency destabilizes Raft | SA |
| 2 | 3 control-plane nodes/cluster | 1 (SPOF) or 2 (tolerates 0) | Odd quorum; 3 survives a node/rack loss | SA |
| 3 | RKE2 + Rancher (managed) | Upstream/kubeadm | Offsets limited K8s skill; CIS/FIPS for OJK; one console for two DCs | SA |
| 4 | Dedicated payments node pool | Flat pool / namespace-only isolation | Regulatory + noisy-neighbor isolation for 24/7 payments | SA |
| 5 | One cluster per DC now | Separate payments cluster now | Extra control plane multiplies ops burden a thin team can't carry; add later via Rancher fleet mgmt | SA |
| 6 | GitOps DR redeploy | Stretched-cluster "auto DR" | Move manifests, not quorum; data/RPO/RTO belong to 2.6 | SA |

## 10. Open items & handoffs

- **Sizing (Phase 6):** finalize node counts and vCPU/RAM per pool from real workload telemetry; confirm the payments pool has enough headroom above the ~4,000 txns/min peak.
- **DR (2.6):** RPO/RTO targets, payment-data replication mechanism, failover runbook, DNS/traffic cutover.
- **Security (2.7):** image scanning in the registry (2.4), admission control, secrets management, and the audit trail OJK will request.

**So what (the pivot this HLD buys you):** instead of "put Kubernetes on it," Garuda gets a platform a *thin team can actually operate* — two independent HA clusters, payments isolated by design, and a managed distro that acts as the autopilot for their skills gap. This is the container-platform layer of **Capstone B (On-Premise Private Cloud)**, and it hands the data-recovery problem cleanly to **2.6**.
