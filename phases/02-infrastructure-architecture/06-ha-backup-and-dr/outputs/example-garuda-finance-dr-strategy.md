---
name: example-garuda-finance-dr-strategy
description: Worked DR Strategy + RTO/RPO Sheet for Garuda Finance — active-passive Jakarta→Surabaya, async DB replication, 3-2-1 backup, and an OJK-satisfying test cadence
phase: 2
lesson: 6
audience: customer | executive | internal
---

# DR Strategy + RTO/RPO Sheet — Garuda Finance (worked example)

> This is `template-dr-strategy-rto-rpo-sheet.md` filled in for a fictional customer. It shows what "good" looks like: tiered targets, a defended DR pattern, replication that respects the physics of a 700 km link, and a test cadence a regulator will accept. Core input to **Capstone B**.

**Customer:** Garuda Finance (fictional)  ·  **Industry / regulator:** Financial services / **OJK** (BCP/DR mandated)
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-04  ·  **Version:** v0.2
**Sites:** **Jakarta** (primary) + **Surabaya** (DR)  ·  **Site distance:** **~700 km** (drives sync-vs-async)
**Company shape:** ~600 branches · ~8M customers · core banking + loan origination + mobile app, **~4,000 txns/min peak** · on-prem / in-country · **24/7 payments uptime** required · brief calls for **active-passive** DR.

---

## 0. HA vs Backup vs DR — all three, confirmed

| Concern | Protects against | In place today? | Gap / action |
|---|---|---|---|
| **HA** (in-DC) | Component failure | **Y** — Jakarta: dual power, dual core switches, N+1 cooling, K8s across 3 racks, dual-controller array (from 2.1–2.5) | Mirror the same HA at Surabaya |
| **Backup** | Corruption, ransomware | **Partial** — nightly backups written to **the production array** | **Fix:** move to a separate backup system + immutable copy |
| **DR** (cross-site) | Loss of Jakarta | **Weak** — a Surabaya DB copy exists but **has never been failed over to** | **Fix:** warm standby + a tested failover (this sheet) |

*Red flag caught:* Jakarta's "five nines HA" was being sold as resilience. A single redundant DC is one failure domain — it does not survive a fire, flood, or regional event. HA ≠ DR.

## 1. Workload tiers + RTO/RPO

> Ranges are planning assumptions to confirm with the business and OJK. Payments/ledger tightest; batch loosest.

| Tier | Workloads (Garuda) | RTO (range) | RPO (range) | Why this number |
|---|---|---|---|---|
| **0 — Mission-critical** | Payments rail + core-banking ledger posting (24/7 path) | **15–30 min** | **~0 → 60 s** | A regulated bank cannot silently drop committed money movement; downtime = customer + OJK harm |
| **1 — Business-critical** | Mobile app, internet banking, loan origination | **1–2 h** | **5–15 min** | Customer-facing, revenue-linked; a short, communicated outage is survivable |
| **2 — Important** | Branch/teller support, CRM, back-office | **4–8 h** | **1–4 h** | Internal; branches can run degraded/manual for hours |
| **3 — Deferrable** | Data warehouse, reporting, batch, dev/test | **24–48 h** | **~24 h** | Restore from last nightly backup; no real-time need |

*Sanity check:* the tiers span 15 min → 48 h of RTO. If they'd all come out "15 min," someone gold-plated the estate and the BOM would prove it.

## 2. DR pattern selection

```
   Tier 0: Warm Standby / Active-Passive   because active-active over 700 km means resolving
                                           conflicting ledger writes from two sites — a multi-year
                                           correctness program a bank rarely takes on for the core.
   Tier 1: Warm Standby / Active-Passive   because a 1–2 h RTO needs a warm, pre-synced DR stack.
   Tier 2: Pilot Light                     because 4–8 h allows building most of the stack on failover.
   Tier 3: Backup & Restore                because 24–48 h allows a cold rebuild from backups.
   Topology: ACTIVE-PASSIVE · Primary Jakarta → DR Surabaya
```

**Why not active-active (rung ④)?** It would buy RTO≈0 but force cross-site write-conflict handling for an ~8M-customer ledger — enormous cost and risk for marginal gain over warm standby. Garuda sits on rung ③ deliberately.

## 3. Replication design + the sync/async decision

**Distance → latency:** ~700 km ⇒ propagation floor ≈ **3.5 ms one-way / ~7 ms RTT**; realistic RTT ≈ **~10–15 ms** *(confirm with carrier's measured latency)*.
**Rule applied:** sync is practical only at metro distance (~<100 km, ~<2 ms). 700 km ⇒ **async**, so RPO = replication lag.

| Data set | Replication level | Tool (illustrative) | Sync or async? | Resulting RPO |
|---|---|---|---|---|
| Core-banking DB / ledger | DB — redo/log shipping | Oracle Data Guard (max-performance) / PostgreSQL streaming | **async** | **~10–60 s** (lag, monitored as SLO) |
| Files, images, VM disks | Storage array | SRDF/A / SnapMirror / ActiveDR | **async** | seconds–minutes |
| Stateless K8s apps | App / GitOps | Argo CD (redeploy from Git) | n/a (redeploy) | n/a — data comes from the DB |

**RPO=0 tension (Tier 0), stated honestly:** the ledger *wants* RPO=0, but 700 km forbids synchronous replication for a 4,000-txn/min OLTP path (sync would tax **every** commit with ~10–15 ms). Decision: **target RPO ~seconds via async log shipping + idempotent, replayable transactions from a durable log.** True zero would require a **third, metro-distance synchronous site near Jakarta** — a real capital cost escalated to the CFO/board, not quietly promised. Replication lag is paged when it exceeds the Tier-0 RPO, because silent lag widens the data-loss window.

**Kubernetes DR (from 2.5):** Garuda runs **one cluster per site**, not a stretched cluster (etcd needs low-latency quorum + an odd member count; two sites 700 km apart can't do that safely). Argo CD in Surabaya is pre-synced to the same Git repo and idle; on failover, scale up, promote the standby DB, repoint, flip GSLB.

```
        JAKARTA  (PRIMARY — active)                       SURABAYA  (DR — passive / warm)
        ══════════ ~700 km · async replication link (~10–15 ms RTT) ══════════▶
   ┌──────────────────────────────────┐                ┌──────────────────────────────────┐
   │  GSLB / DNS  (health-checked)     │◀── fail over ─▶│  GSLB / DNS  (stands by)          │
   ├──────────────────────────────────┤                ├──────────────────────────────────┤
   │  K8s cluster A  (LIVE)            │  same manifests │  K8s cluster B  (WARM, scaled-    │
   │  mobile · internet bank · loans   │◀── via GitOps ─▶│  down; Argo CD synced, ready)     │
   ├──────────────────────────────────┤                ├──────────────────────────────────┤
   │  Core-banking DB  (PRIMARY)       │= = = ASYNC = = ▶│  Core-banking DB  (STANDBY)       │
   │  RPO ≈ lag (~10–60 s)             │  (700 km ⇒ NO   │  read-only, applying redo         │
   │                                   │   sync for OLTP)│  promote on failover              │
   ├──────────────────────────────────┤                ├──────────────────────────────────┤
   │  Storage array  ─────────────────┼── async array ──▶│  Storage array (replica)          │
   └───────────────┬──────────────────┘                └───────────────┬──────────────────┘
                   │ 3-2-1 backup                                       │ off-site copy lands here
                   ▼                                                    ▼
        Immutable / offline copy (WORM, air-gapped — ransomware defense)

   ── SYNC / ASYNC BOUNDARY: inside a DC (<1 ms) sync is free (that's HA). Across 700 km it isn't. ──
```

## 4. Backup — the 3-2-1 plan

```
   3 copies:      production (Jakarta) + Jakarta backup + Surabaya backup
   2 media:       backups on a SEPARATE backup system — never the production array (the fixed trap)
   1 off-site:    Surabaya
  +1 immutable:   WORM / air-gapped copy — ransomware can't encrypt what it can't reach
  +0 verified:    scheduled test-restores with recorded evidence for OJK
```

| Tier | Backup type | Frequency | Retention | Immutable copy? |
|---|---|---|---|---|
| 0–1 | Incrementals + daily full | Sub-hourly incrementals | 35 days + regulatory archive | **Yes** |
| 2–3 | Daily / nightly full | Nightly | 30 days | Yes (Tier 2) / optional (Tier 3) |

*Key fix from The Problem:* backups leave the production array. A copy on the same failure domain as the primary is not a backup — it dies with the array.

## 5. DR test cadence + runbook

| Test type | Proves | Cadence |
|---|---|---|
| Tabletop | Team knows the runbook + roles | Quarterly |
| Component failover | One tier (e.g. the ledger DB) promotes cleanly | Semi-annual |
| **Full live failover** | Surabaya actually runs production; Tier-0 RTO/RPO met | **At least annual (OJK expectation)** |

**Runbook skeleton:**
- **Declaration authority:** Head of Infrastructure + CISO jointly declare a disaster; criteria = Jakarta unreachable / unrecoverable within the Tier-0 RTO.
- **Failover order:** Tier 0 (payments + ledger) → Tier 1 (mobile/internet/origination) → Tier 2 → Tier 3.
- **Data promotion:** promote Surabaya standby DB to primary; repoint app connection strings.
- **Traffic cut-over:** flip GSLB/DNS to Surabaya (short TTLs kept for exactly this).
- **Failback:** planned reverse-replication and return to Jakarta once stable — a scheduled event, not a scramble.
- **Every test records:** measured RTO/RPO vs target → the gap analysis the auditor wants and the input to next year's tightening.

---

## 6. Findings & the one-line resilience statement

| # | Finding | Concern | Implication | Severity |
|---|---|---|---|---|
| 1 | Nightly backups written to the production array | Backup | Move to a separate + immutable backup system now | **High** |
| 2 | Surabaya DR copy never failed over to | DR | Schedule a full live failover; it's untested until then | **High** |
| 3 | No defined RTO/RPO before this sheet | DR | Tiers 0–3 now set and defended (§1) | **High** |
| 4 | 700 km link can't carry synchronous ledger replication | DR | Tier-0 RPO is ~seconds (async), not 0 — escalate the metro-site option | Medium |
| 5 | "Five nines HA" sold as resilience | HA/DR | Reframe: HA ≠ DR; both now layered | Medium |

**One-line resilience statement:**
> Garuda Finance runs **HA within each DC**, **3-2-1 backups (+immutable)** against corruption/ransomware, and **active-passive DR** from Jakarta to Surabaya (**~700 km ⇒ async** replication), meeting **Tier-0 RTO 15–30 min / RPO ~seconds**, proven by an **at-least-annual tested live failover** — exactly the defined-and-tested RTO/RPO evidence OJK requires.

**So what (the pivot this sheet buys):** instead of "we're highly available," Garuda now has an auditable resilience *design* — tiered targets, a pattern chosen for the physics, a backup plan that survives ransomware, and a test that turns the diagram into a defensible control. This sheet is a direct input to the Capstone B private-cloud build.
