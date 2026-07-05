---
name: template-risk-register-and-migration-plan
description: Risk Register + Migration Plan — scored risk register across 5 categories, a phased wave plan with a Mermaid timeline, compliance sign-off gates, and a program RACI
phase: 6
lesson: 5
audience: customer | internal | executive
---

# Risk Register + Migration Plan — Template

> Fill this in once the pattern (6.1), security model (6.2), sizing (6.3), and BOM/pricing (6.4) are settled. It turns "we've thought about risk" into a scored, owned register and a phased cutover plan a steering committee can actually inspect — a rollback trigger for every wave, a compliance gate before the riskiest cutover, and one accountable name per critical decision. An executive should grasp the top-risk table and the wave timeline; a delivery lead should be able to run the program from the wave table and the RACI.

**Customer:** `<company>`  ·  **Industry / regulator:** `<industry / regulator, e.g. financial services / OJK-style>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **Version:** `<v0.1 draft>`
**Delivery window:** `<e.g. 12–18 months>`  ·  **Business units / workloads in scope:** `<list them>`

**Hard constraints (fill these first — they drive the wave order and the gates below):**
- **Residency / regulatory:** `<what data must stay where, under which regulator, and why>`
- **Delivery window:** `<the hard deadline or range that bounds the wave plan>`
- **Operating model constraint:** `<e.g. mixed-skill team, in-house vs SI-partner delivery>`
- **Prior architecture decisions to recap:** `<pattern from the sizing/cost lessons — cutover mechanism, platform size, price band>`

Legend: **L/M/H** = Low/Medium/High (score 1/2/3; risk score = Likelihood × Impact, 1–9) · **RACI** = Responsible/Accountable/Consulted/Informed (exactly one **A** per row) · **facade** = strangler-fig router used as the rollback mechanism.

---

## How to use this template

1. **Score the risks first** (§1) — work the five categories, name risks specific to *this* deal, sort by score. This is what you brief the steering committee on, top-down.
2. **Sequence the waves** (§2) — order by risk, not convenience: lowest-regulatory/technical-risk workload first as a proving ground, the riskiest last. Give every wave explicit entry/exit criteria and a rollback trigger.
3. **Gate the riskiest cutover** (§3) — if any workload is regulated, build an explicit, evidenced sign-off checklist that must clear in full before that wave starts.
4. **Assign the RACI** (§4) — name exactly one accountable owner per critical decision, especially the rollback call and the compliance sign-off.
5. **Commit to a review cadence** (§5) — a register that isn't re-scored on a schedule becomes theater. State the cadence explicitly.

---

## 1. Risk register (score, sort, own)

> One row per risk, sorted by score descending. A generic risk ("integration might fail") is worthless — name the *specific* failure mode for this deal.

| # | Risk (specific to this deal) | Category | Likelihood | Impact | Score | Mitigation | Owner |
|---|---|---|---|---|---|---|---|
| 1 | `<the single highest-scoring risk — often organizational>` | `<Regulatory / Technical / Organizational / Delivery / Vendor>` | `<L/M/H>` | `<L/M/H>` | `<1–9>` | `<concrete action taken BEFORE it fires>` | `<named role>` |
| 2 | | | | | | | |
| 3 | | | | | | | |
| 4 | | | | | | | |
| 5 | | | | | | | |
| … | | | | | | | |

**Category prompts (use these to make sure you haven't missed one):**

| Category | Ask yourself… |
|---|---|
| Regulatory / compliance | Could data residency, an audit trail, or a required sign-off be violated mid-migration? |
| Technical | Could the integration layer (ACL, event bus, facade) mistranslate, lose, or misroute data during cutover? |
| Organizational | Does the team operating the new platform have the skills the platform assumes? What happens if key people leave mid-program? |
| Delivery | Is the window realistic given the integration effort? Does one wave's delay cascade into the next? |
| Vendor / lock-in | Are we over-reliant on one partner's tribal knowledge, one platform's operational knowledge, or a hardware lead time? |

*Note: cost risk is handled by the BOM's contingency band (the risk-based version, not a flat percentage — see Compare It in the lesson), not as its own register row.*

---

## 2. Migration wave plan

> Phase by workload/BU, ordered by risk — lowest regulatory/technical risk first as a proving ground, the riskiest last. Every wave needs entry criteria, exit criteria, and a rollback trigger; "we'll know it's stable when we see it" is not an exit criterion.

**Timeline skeleton (replace waves/dates/labels — delete rows you don't need):**

```mermaid
gantt
    title <Customer> - Phased Migration Across the <N-month> Window
    dateFormat  YYYY-MM-DD
    axisFormat  M%m
    section Wave 0 - Foundation
    <Landing zone, integration layer, security baseline>   :w0, <YYYY-MM-DD>, <nM>
    section Wave 1 - <lowest-risk workload/BU>
    <Cutover, capability by capability>                    :w1a, after w0, <nM>
    <Parallel-run + rollback window>                       :w1b, after w1a, <nM>
    section Wave 2 - <next workload/BU>
    <Cutover, capability by capability>                    :w2a, <YYYY-MM-DD>, <nM>
    <Parallel-run + rollback window>                        :w2b, after w2a, <nM>
    section Wave 3 - <highest-risk / regulated workload>
    <Compliance sign-off gate>                              :crit, w3g, <YYYY-MM-DD>, <nM>
    <Cutover, capability by capability>                     :w3a, after w3g, <nM>
    <Extended parallel-run + rollback window>               :w3b, after w3a, <nM>
```

**Wave table (fill in the criteria — this is the part a steering committee will actually read):**

```
WAVE   WORKLOAD/BU        MONTHS    PARALLEL-RUN / ROLLBACK WINDOW    EXIT CRITERIA (go to next wave)
-------------------------------------------------------------------------------------------------------
 0     <foundation>        <…>      n/a - no prod traffic yet          <platform live, integration
                                                                        layer smoke-tested, security
                                                                        baseline verified>
 1     <lowest-risk>        <…>      <n months, capability-by-cap.>     <error rate/latency SLO for
                                                                        N consecutive days; reconciles
                                                                        against legacy>
 2     <next>               <…>      <n months, capability-by-cap.>     <same bar as Wave 1, PLUS:
                                                                        integration layer proven under
                                                                        a second workload's traffic>
 3     <highest-risk/       <…>      <n months, EXTENDED — regulated>   <technical bar AND compliance
        regulated>                                                     sign-off (§3) cleared BEFORE
                                                                        cutover starts>
-------------------------------------------------------------------------------------------------------
ROLLBACK TRIGGER (any wave): <reconciliation mismatch beyond threshold / sustained SLO breach /
compliance finding> -> facade weight reverts to legacy; legacy remains system of record until the
trigger condition is resolved and re-tested.
```

**Sizing the rollback window:** don't use a uniform window for every wave. Size it to the cost of getting the rollback wrong — a wave touching regulated or money-movement data deserves a longer parallel-run than a low-stakes wave, on both ends (a gate before, a longer window after).

---

## 3. Compliance sign-off gate (only if a workload is regulated)

> Required before the regulated wave begins. Technical exit criteria (§2) are necessary but not sufficient for a regulated cutover — this gate is the evidence an auditor and a board member can both verify happened.

```
COMPLIANCE SIGN-OFF GATE - <regulated workload/BU> Cutover (must clear ALL before this wave begins)
+---+---------------------------------------------------------+-------------+----------+
| # | CHECK                                                    | EVIDENCE    | SIGN-OFF |
+---+---------------------------------------------------------+-------------+----------+
| 1 | <Data confirmed in required jurisdiction at rest AND     | <…>         | <…>      |
|   |  in transit through the migration path>                 |             |          |
| 2 | <Audit trail continuous across the cutover window — no   | <…>         | <…>      |
|   |  unaccounted gap during dual-write>                      |             |          |
| 3 | <Regulatory reporting continues uninterrupted through     | <…>         | <…>      |
|   |  the parallel-run window>                                |             |          |
| 4 | <Rollback path tested end-to-end at least once before     | <…>         | <…>      |
|   |  the live cutover — not just designed on paper>           |             |          |
+---+---------------------------------------------------------+-------------+----------+
Gate owner: <role> (Accountable). Missing ANY row blocks this wave - no exceptions.
```

---

## 4. Program RACI

> Exactly one **A** per row. A committee cannot be paged when a rollback decision needs to be made in minutes — accountability must resolve to a named person or role.

```
RACI - <Customer> transformation program
+-----------------------------------+---------+----------+------------+------------+----------+
| ACTIVITY                          | Sponsor | Delivery | Compliance | BU Ops     | Security |
|                                    | <role>  | Lead     | / Legal    | Lead       | Lead     |
+-----------------------------------+---------+----------+------------+------------+----------+
| Maintain risk register             |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
| Wave cutover go/no-go               |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
| Rollback decision                   |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
| Regulated-wave compliance gate      |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
| Post-cutover platform operations    |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
| Training / knowledge transfer       |   <…>   |   <…>    |    <…>     |    <…>     |   <…>    |
+-----------------------------------+---------+----------+------------+------------+----------+
```

---

## 5. Review cadence & one-line summary

**Review cadence:** `<e.g. weekly during any active wave, monthly otherwise; re-score, don't just re-read>`

**One-line strategy statement (fill in):**
> The register's highest-scored risk is `<risk #1>`, mitigated by `<mitigation>`. The migration is `<n>` waves — `<lowest-risk workload>` first as a proving ground, `<highest-risk workload>` last behind a `<compliance gate / equivalent>` — inside a `<delivery window>`, with rollback via `<facade/other mechanism>` and one accountable owner per critical decision.

---

*Worked example: see `example-cakrawala-group-risk-and-migration-plan.md` in this folder.*
