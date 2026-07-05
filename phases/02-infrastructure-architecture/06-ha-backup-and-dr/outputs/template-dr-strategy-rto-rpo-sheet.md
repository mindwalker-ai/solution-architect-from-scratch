---
name: template-dr-strategy-rto-rpo-sheet
description: DR Strategy + RTO/RPO Sheet — tiered recovery targets, DR-pattern choice, replication (sync/async) design, 3-2-1 backup plan, and a tested DR runbook cadence
phase: 2
lesson: 6
audience: customer | executive | internal
---

# DR Strategy + RTO/RPO Sheet — Template

> Fill this in during (and just after) a resilience / BCP workshop. It turns "we're highly available" into numbers an auditor can check and a business can sign. An executive should grasp the tier table and the pattern choice; an engineer should trust the replication and backup design.

**Customer:** `<company>`  ·  **Industry / regulator:** `<industry / regulator, e.g. banking / OJK>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Sites:** `<primary DC>` (primary) + `<DR DC>` (DR)  ·  **Site distance:** `<km>` (drives sync-vs-async)  ·  **Version:** `<v0.1 draft>`

Legend: **RTO** = max tolerable downtime · **RPO** = max tolerable data loss · **HA** = in-DC redundancy · **DR** = cross-site failover · **sync/async** = replication mode.

---

## How to use this template

1. **Separate the three concerns first.** Confirm the estate has HA *inside* each DC, backups against corruption/ransomware, and DR *across* sites. Don't let "we're HA" stand in for DR.
2. **Tier the workloads** by business/regulatory impact and set RTO/RPO *ranges* per tier (§1). These are assumptions to confirm — never one number for the whole estate.
3. **Pick the DR pattern** per tier from the ladder and defend it (§2).
4. **Design replication** and resolve the sync-vs-async question using the site distance (§3).
5. **Design 3-2-1 backup** so corruption/ransomware is covered separately from replication (§4).
6. **Commit to a test cadence + runbook** — an untested plan is fiction (§5).

---

## 0. HA vs Backup vs DR — confirm all three exist

| Concern | Protects against | In place today? | Gap / action |
|---|---|---|---|
| **HA** (in-DC) | Component failure (node, disk, switch) | `<Y/N + how: N+1, clustering>` | `<…>` |
| **Backup** | Data loss, corruption, ransomware | `<Y/N + where stored>` | `<is it on the same array it protects?>` |
| **DR** (cross-site) | Loss of an entire site | `<Y/N + last tested?>` | `<…>` |

*Red flag:* a single, redundant DC sold as "resilient." Redundant ≠ multi-site. One DC is one failure domain.

## 1. Workload tiers + RTO/RPO (the heart of the sheet)

> Assign each workload to a tier; set RTO/RPO as a **range** (planning assumption — confirm with business + regulator). If every tier ends up identical, you tiered nothing.

| Tier | Workloads | RTO (range) | RPO (range) | Why this number |
|---|---|---|---|---|
| **0 — Mission-critical** | `<e.g. payments / core ledger>` | `<15–30 min>` | `<~0–60 s>` | `<regulatory / money-movement impact>` |
| **1 — Business-critical** | `<e.g. customer app, origination>` | `<1–2 h>` | `<5–15 min>` | `<revenue / customer-facing>` |
| **2 — Important** | `<e.g. back-office, CRM>` | `<4–8 h>` | `<1–4 h>` | `<internal; degraded mode ok>` |
| **3 — Deferrable** | `<e.g. warehouse, batch, dev/test>` | `<24–48 h>` | `<~24 h>` | `<restore from nightly backup>` |

## 2. DR pattern selection (the ladder — cost buys lower RTO)

> ① Backup & Restore → ② Pilot Light → ③ Warm Standby / Active-Passive → ④ Active-Active

```
   Chosen pattern (per tier):
   Tier 0: <pattern>   because <why not the rung above/below>
   Tier 1: <pattern>   because <…>
   Tier 2: <pattern>   because <…>
   Tier 3: <pattern>   because <…>
   Topology: <active-passive / active-active>  ·  Primary <site> → DR <site>
```

*State explicitly why you did NOT climb to active-active (usually: cross-site write-conflict cost over distance).*

## 3. Replication design + the sync/async decision

**Distance → latency:** `<km>` ⇒ propagation floor ≈ `<km ÷ 200>` ms one-way; realistic RTT ≈ `<___>` ms *(confirm with carrier)*.
**Rule:** synchronous is practical only at metro distance (~<100 km, ~<2 ms RTT). Beyond that → **async**, and RPO = replication lag.

| Data set | Replication level (storage / DB / app) | Tool | Sync or async? | Resulting RPO |
|---|---|---|---|---|
| `<core DB / ledger>` | `<DB — log/redo shipping>` | `<Data Guard / streaming>` | `<async>` | `<lag, ~10–60 s>` |
| `<files / VMs>` | `<storage array>` | `<SRDF / SnapMirror / ActiveDR>` | `<async>` | `<…>` |
| `<stateless apps>` | `<app / GitOps>` | `<Argo CD / Flux>` | `<n/a — redeploy>` | `<n/a>` |

**RPO=0 tension (if any tier demands zero):** `<accept async ~seconds + idempotent replay, OR fund a metro-distance synchronous 3rd site — name the cost & escalate>`.

**Kubernetes DR (if applicable):** do NOT stretch one cluster across sites (etcd quorum + latency). Run a cluster per site; redeploy identical manifests via GitOps; promote the replicated data; flip DNS/GSLB. Cluster = cattle, data = pet.

## 4. Backup — the 3-2-1 plan (separate from replication)

> Replication copies corruption/ransomware too. Backup is the time machine.

```
   3 copies:      <production> + <backup A> + <backup B>
   2 media:       <backup system ≠ the production array>
   1 off-site:    <DR site>
  +1 immutable:   <WORM / air-gapped copy — ransomware defense>
  +0 verified:    <test-restore cadence + evidence>
```

| Tier | Backup type | Frequency | Retention | Immutable copy? |
|---|---|---|---|---|
| 0–1 | `<incrementals + daily full>` | `<sub-hourly / daily>` | `<…>` | `<Y>` |
| 2–3 | `<daily / nightly>` | `<nightly>` | `<…>` | `<Y/N>` |

## 5. DR test cadence + runbook

| Test type | Proves | Cadence |
|---|---|---|
| Tabletop | Team knows runbook + roles | `<quarterly>` |
| Component failover | One tier promotes cleanly | `<semi-annual>` |
| Full live failover | DR site runs production; RTO/RPO met | `<≥ annual — regulator expectation>` |

**Runbook skeleton (attach or link):**
- **Declaration authority:** `<who declares a disaster + criteria>`
- **Failover steps:** `<ordered, per-tier>`
- **Data promotion:** `<promote standby DB, repoint apps>`
- **Traffic cut-over:** `<GSLB/DNS flip, TTL note>`
- **Failback plan:** `<planned return to primary>`
- **Every test records:** measured RTO/RPO vs target (the auditor's artifact).

---

## 6. Findings & the one-line resilience statement

| # | Finding | Concern (HA/Backup/DR) | Implication | Severity |
|---|---|---|---|---|
| 1 | `<e.g. backups on the production array>` | Backup | `<move to separate + immutable system>` | `<H/M/L>` |
| 2 | `<e.g. DR never tested>` | DR | `<schedule full failover>` | `<…>` |
| 3 | `<e.g. no RPO/RTO defined>` | DR | `<this sheet resolves it>` | `<…>` |

**One-line resilience statement (fill in):**
> `<Company>` runs **HA within each DC**, **3-2-1 backups** against corruption/ransomware, and **`<pattern>` DR** from `<primary>` to `<DR>` (`<km>` ⇒ **async**), meeting **Tier-0 RTO `<__>` / RPO `<__>`**, proven by a **`<cadence>` tested failover** — the evidence the regulator asks for.

---

*Worked example: see `example-garuda-finance-dr-strategy.md` in this folder.*
