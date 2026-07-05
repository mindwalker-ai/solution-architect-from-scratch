---
name: template-kubernetes-platform-hld
description: Kubernetes Platform HLD — clusters/topology, control-plane HA, node pools, CNI/CSI/ingress, tenancy/RBAC, distro decision, and DR approach for a container platform
phase: 2
lesson: 5
audience: customer | internal
---

# Kubernetes Platform — High-Level Design (Template)

> Fill this in once containerization (2.4) is approved and before capacity sizing (Phase 6). Work the sections **in order** — each decision constrains the next. An executive should grasp the topology diagram; an operator should trust the decision log. This HLD is *design + defense*, not a runbook.

**Customer:** `<company>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`
**Key operating constraint:** `<e.g. thin in-house K8s skill / regulator / uptime SLA>` ← this drives the distro choice in §6.

Legend for every diagram/table below: **CP** = control plane · **etcd quorum** = odd member count that must stay intra-DC · **node pool** = worker group isolated by taint/label · **soft multi-tenancy** = namespace+quota+RBAC (not a hard security boundary).

---

## How to use this template

1. **Clusters & topology** — how many clusters, where, active/DR. Decide stretch vs per-site *first*; it constrains everything.
2. **Control-plane HA** — master count, etcd quorum, VIP, fault-domain spread.
3. **Node pools** — isolate regulated/critical workloads from bursty/batch ones.
4. **CNI / CSI / Ingress** — wire the network (2.3), storage (2.2), and north-south entry.
5. **Tenancy & RBAC** — namespaces with quotas, NetworkPolicy, and role bindings.
6. **Distro decision** — pick the distribution that fits the *skills* and *compliance* constraints, and defend it.
7. **DR approach** — how you recover across sites (GitOps redeploy), with the data problem handed to 2.6.

---

## 1. Clusters & topology

> Decide stretch-vs-per-site here. Two far DCs → **one self-contained cluster per DC**, never one stretched etcd. Name each cluster and its role.

| Cluster | Site / DC | Role | Notes |
|---|---|---|---|
| `<name-site-prod>` | `<DC-1>` | Active | `<self-contained; owns its etcd>` |
| `<name-site-dr>` | `<DC-2>` | DR / standby | `<warm/cold; reconciled via GitOps>` |

**Stretch decision (state it explicitly):** `<per-DC clusters — reason>` / `<stretched — only if a 3rd low-latency arbiter site exists>`

## 2. Control-plane HA

| Item | Decision | Rationale |
|---|---|---|
| Control-plane nodes per cluster | `<3 / 5>` | `<odd for quorum; 3 = tolerate 1 loss>` |
| etcd topology | `<stacked / external>` | `<simplicity vs I/O isolation>` |
| etcd placement | `<intra-DC, spread across N fault domains>` | `<keep Raft on the LAN>` |
| API endpoint | `<VIP / load balancer in front of api-servers>` | `<stable endpoint for nodes & kubectl>` |

Quorum sanity check: **N members → quorum ⌊N/2⌋+1 → tolerates ⌊(N−1)/2⌋ failures.** (1→0, 2→0, **3→1**, 5→2.) Use odd; default to 3.

## 3. Node pools (worker groups)

| Node pool | Workloads | Isolation (taint/label) | Sizing basis (assumption) |
|---|---|---|---|
| `<isolated-critical>` | `<regulated / latency-critical>` | `<taint workload=X:NoSchedule>` | `<peak + headroom>` |
| `<general>` | `<business apps>` | `<default schedulable>` | `<business-hours burst>` |
| `<batch>` | `<overnight/reporting>` | `<separate pool, low priority>` | `<batch window>` |

*Rule:* anything regulated or latency-critical gets a **dedicated pool** — namespace isolation alone is not a boundary.

## 4. CNI / CSI / Ingress (the pluggable edges)

| Edge | Choice | Ties to | Why |
|---|---|---|---|
| **CNI** | `<Calico / Cilium>` | 2.3 network fabric | `<NetworkPolicy for segmentation; simplicity vs eBPF>` |
| **CSI** | `<storage-vendor / Ceph CSI>` | 2.2 storage | `<StorageClasses: fast for DBs, standard for rest>` |
| **Ingress** | `<NGINX / HAProxy>` + `<MetalLB / hardware LB>` | 2.3 LB | `<no cloud LB on-prem; TLS + host/path routing>` |

## 5. Tenancy & RBAC

| Namespace | Owner team | ResourceQuota | NetworkPolicy | RBAC binding |
|---|---|---|---|---|
| `<app-1>` | `<team>` | `<cpu/mem cap>` | `<default-deny + allows>` | `<edit in ns only>` |
| `<app-2>` | `<team>` | `<...>` | `<...>` | `<...>` |
| `<platform>` | `<platform team>` | `<...>` | `<...>` | `<cluster-admin>` |
| `<audit>` | `<compliance>` | — | — | `<read-only cluster-wide>` |

## 6. Distribution decision (offset the constraint)

> The most consequential choice. Score against the **operating constraint** from the header — usually skills + compliance — not the feature list.

| Distro | Ops burden | Cost | Hardening/support | Fit vs constraint |
|---|---|---|---|---|
| Upstream/kubeadm | Highest | Free SW / high people | DIY | `<...>` |
| k3s | Low | Free | CIS-hardenable | `<...>` |
| RKE2 + Rancher | Low-med, managed | Free engine / opt. support | CIS/FIPS, fleet mgmt | `<...>` |
| OpenShift | Low, turnkey | Highest (per-core) | Enterprise | `<...>` |
| VMware Tanzu | Low-med | Licensed | Enterprise | `<only if vSphere shop>` |

**Chosen distro:** `<distro>` — **Defense (one sentence):** `<why this distro fits the constraint a thin/regulated team must live inside>`

## 7. DR approach (handed to 2.6)

- **Pattern:** `<GitOps redeploy (Argo CD / Flux) to DR cluster — not a stretched cluster>`
- **What the platform owns:** `<make the redeploy trivial & repeatable>`
- **Handed to 2.6:** `<data replication, RPO/RTO, failover runbook, DNS/traffic cutover>`

---

## 8. Topology diagram (Mermaid skeleton)

```mermaid
flowchart TB
    subgraph A["Cluster A — &lt;DC-1, active&gt;"]
      cpa["Control plane ×3<br/>etcd quorum=3 (intra-DC)<br/>VIP → api-servers"]:::cp
      pa1["pool: isolated-critical"]:::pl
      pa2["pool: general"]:::pl
      pa3["pool: batch"]:::pl
      cpa --> pa1 & pa2 & pa3
    end
    subgraph B["Cluster B — &lt;DC-2, DR&gt;"]
      cpb["Control plane ×3<br/>etcd quorum=3 (intra-DC)"]:::cp
      pb1["pool: isolated-critical"]:::pl
      pb2["pool: general/batch"]:::pl
      cpb --> pb1 & pb2
    end
    git["GitOps repo (desired state)<br/>Argo CD / Flux"]:::g
    git -->|reconcile| cpa
    git -->|reconcile on failover| cpb
    A -. async data replication (2.2/2.6) .-> B

    classDef cp fill:#E7F0FC,stroke:#2E86F0,color:#1B5FD9;
    classDef pl fill:#EAF6EC,stroke:#2E7D32,color:#1B5E20;
    classDef g fill:#FFF4E5,stroke:#B26A00,color:#7A4600;
```

### ASCII fallback

```
   ┌──── CLUSTER A (DC-1, active) ────┐        ┌──── CLUSTER B (DC-2, DR) ────┐
   │ CP ×3  etcd quorum=3 (intra-DC)  │        │ CP ×3  etcd quorum=3         │
   │ pools: isolated · general · batch│        │ pools: isolated · gen/batch  │
   └────────────────┬─────────────────┘        └───────────────┬──────────────┘
                    │        GitOps (Argo/Flux) reconciles both │
                    └──────────────┬───────────────────────────┘
        WAN = Git sync + async data replication (2.2/2.6)  — NOT etcd quorum
```

---

## 9. Decision log (defend the un-obvious calls)

| # | Decision | Alternative rejected | Why | Owner |
|---|---|---|---|---|
| 1 | `<per-DC clusters>` | `<one stretched cluster>` | `<quorum can't survive DC loss w/o 3rd site; WAN kills etcd>` | `<SA>` |
| 2 | `<3 control-plane nodes>` | `<1 or 2>` | `<odd quorum; 3 tolerates 1 loss, 2 tolerates 0>` | `<SA>` |
| 3 | `<managed distro>` | `<upstream/kubeadm>` | `<offsets skills gap; distro = autopilot>` | `<SA>` |
| 4 | `<dedicated payments pool>` | `<flat pool>` | `<isolation + compliance; namespace is soft only>` | `<SA>` |
| 5 | `<one cluster/DC now>` | `<many small clusters>` | `<extra CPs multiply ops burden; add later via fleet mgmt>` | `<SA>` |

## 10. Open items & handoffs

- **Sizing (Phase 6):** `<finalize node counts / vCPU / RAM per pool from real workload numbers>`
- **DR (2.6):** `<RPO/RTO, data replication mechanism, failover runbook>`
- **Security (2.7):** `<image scanning, admission control, secrets management, audit for the regulator>`

---

*Worked example: see `example-garuda-finance-kubernetes-hld.md` in this folder.*
