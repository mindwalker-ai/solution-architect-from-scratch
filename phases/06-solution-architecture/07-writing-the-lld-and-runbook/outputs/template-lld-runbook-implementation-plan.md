---
name: template-lld-runbook-implementation-plan
description: LLD (infrastructure + integration spec) + cutover runbook + week-by-week implementation plan, bound field-for-field to the HLD/BOM/sizing/migration lessons that priced the deal
phase: 6
lesson: 7
audience: internal
---

# LLD + Runbook + Implementation Plan — Template

> Fill this in only after the HLD is signed. Every field below has a **"Traces to"** column — if you can't fill it in with an upstream lesson/document reference, either flag it as new implementation detail or stop and go find where the number should have come from. Never leave a field bound to a number you just made up.

**Customer:** `<company>`  ·  **Engagement:** `<deal/project name>`  ·  **Prepared by:** `<SA / delivery lead>`  ·  **Date:** `<YYYY-MM-DD>`
**HLD reference:** `<link/version of the signed HLD>`  ·  **BOM reference:** `<link/version of the signed BOM>`  ·  **Version:** `<v0.1 draft>`

---

## How to use this template

1. **Do not re-decide anything already decided.** Sizing, cost, security posture, migration order, and architecture patterns were fixed upstream (typically an HLD + supporting sizing/cost/security/migration lessons or workstreams). This document turns those decisions into a buildable spec — it does not re-open them.
2. **Every number gets a citation.** Use the traceability table in §6 as your final check before handoff.
3. **Write four things:** an infrastructure spec, an integration spec, a runbook for the *first* migration wave, and a week-by-week implementation plan.
4. **New implementation detail is fine** (subnet ranges, exact topic names, rollback timeouts) — it just isn't the same thing as a sizing/cost/timeline number, and should never be confused with one.

---

## 1. Infrastructure spec (traces to: sizing lesson / capacity plan)

> Break the aggregate sizing figure(s) into an exact, addressable platform. The subtotal MUST reconcile back to the upstream sizing number — if it doesn't, the table is wrong, not the upstream number.

| Cluster / zone | Nodes | Role | Network zone | Security posture (traces to: security lesson) |
|---|---:|---|---|---|
| `<zone 1>` | `<n>` | `<what runs here>` | `<CIDR>` | `<zero trust / segmentation / etc.>` |
| `<zone 2>` | `<n>` | `<what runs here>` | `<CIDR>` | `<…>` |
| `<…>` | | | | |
| **Subtotal** | `<matches upstream sizing total>` | | | |
| Specialized node(s) (GPU / HSM / etc.) | `<n>` | `<role>` | `<zone, reachability constraint>` | `<posture>` |
| Data platform (warehouse/lake/etc.) | `<n>` | `<role>` | `<zone>` | `<residency/compliance boundary if any>` |

**Zone map (ASCII, replace with your topology):**

```
                    <CUSTOMER> PLATFORM — ZONE MAP  (traces to: <sizing lesson> / <security lesson>)
   ┌──────────────────────────────────────────────────────────────────────────┐
   │  SHARED PLATFORM ZONE  <CIDR>                                            │
   │  <gateway/BFF> · <event bus> · <observability> · <CI/CD> · <identity>    │
   └───────────┬───────────────────────┬───────────────────────┬─────────────┘
   ┌───────────▼───────────┐ ┌─────────▼─────────────┐ ┌──────▼──────────────┐
   │ <ZONE A>               │ │ <ZONE B>               │ │ <ZONE C (sensitive)>  │
   │ <CIDR> (<n> nodes)     │ │ <CIDR> (<n> nodes)     │ │ <CIDR> (<n> nodes)    │
   └────────────────────────┘ └────────────────────────┘ └──────────────────────┘
```

## 2. Integration spec (traces to: architecture-patterns lesson / security lesson)

> One entry per named pattern from the upstream architecture design. Give each an exact, implementable contract — not a restatement of the pattern's name.

| Pattern (traces to upstream) | Exact contract in this LLD |
|---|---|
| `<pattern 1, e.g. strangler-fig legacy retirement>` | `<facade routing mechanism, cutover unit (per-cohort/per-tenant/etc.), rollback mechanism>` |
| `<pattern 2, e.g. event bus integration>` | `<topic naming convention, auth mechanism, versioning scheme>` |
| `<pattern 3, e.g. anti-corruption layer>` | `<exposed interface name/version, what it translates, what may NOT call the core directly>` |
| `<pattern 4, e.g. API gateway/BFF>` | `<routes, authN/Z, rate limits, what it must never reach directly>` |

**Sample event schema (replace with your own):**

```json
{
  "event_id": "uuid",
  "occurred_at": "iso8601",
  "<domain fields>": "…",
  "producer_auth": "<auth mechanism, e.g. mTLS client cert>"
}
```

**Gateway/BFF route table (bounded by the infra spec's node/capacity limits):**

| Route | Backend | AuthN/Z | Rate limit | Notes |
|---|---|---|---|---|
| `<route>` | `<backend>` | `<mechanism>` | `<cap, tied to §1's node count>` | `<what it must never touch directly>` |

## 3. Runbook — first migration wave cutover (traces to: migration-strategy lesson)

> Scoped to ONE event: the first wave's cutover. Written for a mixed-skill team under time pressure — numbered steps with explicit go/no-go and rollback triggers, not a reference manual.

1. **Pre-cutover (T-`<lead time>`):** `<data backfill validated, certs/security controls verified, rollback tested in staging, on-call roster published>`
2. **Freeze (T-0):** `<scope of the freeze — which cohort/tenant/subset, explicitly NOT everything>`
3. **Cutover:** `<the exact mechanism — a flag flip, a DNS cut, a config push — and the smoke tests that follow>`
4. **Monitor window (`<duration>`):** `<what's watched>`. **Rollback trigger:** `<explicit, measurable threshold>` → `<exact rollback steps, ideally the reverse of step 3>`.
5. **Go/no-go:** `<who signs off, what happens on each outcome>`
6. **Incident response:** `<Sev1/Sev2 definitions and paging tree for this specific event>`

**Roles for the mixed-skill cutover team:**

| Role | Owns | Paged for |
|---|---|---|
| `<platform lead>` | `<…>` | `<Sev1, Sev2, go/no-go>` |
| `<business/app owner>` | `<…>` | `<Sev1, go/no-go>` |
| `<security/network on-call>` | `<…>` | `<Sev1 only, or as scoped>` |
| `<PM>` | `<schedule impact, stakeholder comms>` | `<any rollback or missed milestone>` |

**Cheap-rollback check:** before sign-off, confirm the rollback in step 4 is genuinely as cheap as described (a flag/config flip) — if it actually requires a redeploy or manual reconciliation, fix §2's integration spec before the cutover date, not during it.

## 4. Implementation plan (traces to: migration-strategy / cost-BOM / HLD timeline)

| Phase | Weeks | Wave (traces to migration plan) | Milestone | Funded from (traces to BOM) |
|---|---|---|---|---|
| Mobilization | `<w1–w2>` | — | `<environments stood up per §1>` | `<BOM line item>` |
| Wave 1 | `<weeks>` | `<name>` (first) | `<pilot cutover per §3, then remaining batches>` | `<BOM line item>` |
| Wave 2 | `<weeks>` | `<name>` (second) | `<…>` | `<BOM line item>` |
| **Gate** (if any) | `<weeks>` | — | `<what must be independently confirmed before the next wave>` | — (gate, not a build activity) |
| Wave 3 | `<weeks>` | `<name>` (last, possibly gated) | `<…>` | `<BOM line item>` |
| Hypercare & close | `<final weeks>` | — | `<handoff to steady-state ops>` | `<BOM line item>` |

**Timeline (ASCII, replace with your own scale):**

```
        MONTH:  1    2    3    4    5    6    7    8   ...
Mobilization  [====]
Wave 1             [==============]
Wave 2                       [====================]
Gate                                            [==]
Wave 3                                               [==============]
```

## 5. Traceability check (run this before handoff — do not skip)

```
LLD FIELD                    VALUE                TRACES TO
────────────────────────────────────────────────────────────
<node count>                 <value>              <upstream lesson/doc>
<specialized node(s)>        <value>              <upstream lesson/doc>
<data platform>              <value>              <upstream lesson/doc>
<total budget envelope>      <value>              <upstream lesson/doc>
<migration order>            <value>              <upstream lesson/doc>
<delivery window>            <value>              <upstream lesson/doc>
<security posture>           <value>              <upstream lesson/doc>
<architecture patterns>      <value>              <upstream lesson/doc>
```

Every row must resolve to a real citation. A row that can't is either genuine new implementation detail (label it as such) or an invented number (fix it before this document leaves your hands).

---

*Worked example: see `example-cakrawala-lld-runbook-implementation-plan.md` in this folder.*
