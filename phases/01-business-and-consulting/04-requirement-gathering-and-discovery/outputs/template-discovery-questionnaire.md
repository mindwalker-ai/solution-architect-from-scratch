---
name: template-discovery-questionnaire
description: Discovery Questionnaire + Notes — a reusable kit (stakeholder map + power/interest grid + role-based question bank + structured notes and traceable requirements register) run at the top of any engagement.
phase: 1
lesson: 4
audience: customer | internal
version: 1.0.0
---

# Discovery Questionnaire + Notes — Template

> Run this in the first days of an engagement, *before* you design anything. Fill it **top to bottom**: map the stakeholders → script role-based questions → capture current state, future state, and constraints → converge it all into a traceable requirements register. The register is the artifact that feeds the **Qualify** gate and the **HLD**.

**Customer:** `<company>`  ·  **Industry:** `<industry>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Engagement / opportunity:** `<deal or project name>`  ·  **The ask (verbatim):** `"<what the customer literally said they want>"`  ·  **Version:** `<v0.1 draft>`

Legend: **FR** = functional requirement · **NFR** = non-functional requirement · **SoR** = system of record · **MoSCoW** = Must / Should / Could / Won't · **RTM** = requirements traceability matrix.

---

## How to use this kit

1. **Map the stakeholders first** (§1). You cannot script questions until you know who holds power, who holds the veto, and who you've been ignoring.
2. **Script role-based questions** (§2). Each stakeholder gets a *different* script. Ask open, listen 70% of the time, confirm with closed questions. Never lead.
3. **Capture current state with numbers** (§3). No baseline → no defensible ROI.
4. **Capture future state + sort constraints hard vs soft** (§4). A hard constraint bounds the design; a soft one is negotiable.
5. **Converge into the requirements register** (§5). Every requirement gets an ID, a type, a source, and a priority — and points forward to the design.
6. **Write the findings + one-line scope** (§6). This is what a colleague or the Qualify gate reads first.

---

## 1. Stakeholder map

> List every person who can say **yes** or **no**, plus the people who feel the pain. The champion is never your only source.

| Stakeholder (role/title) | Role in the deal | Power (H/M/L) | Interest (H/M/L) | What they care about | Interview format |
|---|---|---|---|---|---|
| `<name / CFO>` | Economic buyer | | | | 1:1 |
| `<name / CIO>` | Sponsor / champion | | | | 1:1 + co-design |
| `<name / role>` | Skeptic / influencer (can veto) | | | | 1:1 first |
| `<name / role>` | Compliance / security (can veto) | | | | 1:1 |
| `<name / role>` | Technical evaluator / SME | | | | Workshop + async |
| `<name / role>` | End users | | | | Workshop + PoC |

### Power / interest grid (Mendelow) — place each stakeholder

```
                    INTEREST in the project  ─────────────────▶
                    low                                  high
                 ┌──────────────────────┬──────────────────────┐
        high     │   KEEP SATISFIED     │   MANAGE CLOSELY      │
      P          │   (can veto — engage │   (core deal partners │
      O          │    early, low noise) │    — co-design)       │
      W          │   <econ buyer?       │   <champion?          │
      E          │    compliance?>      │    key influencer?>   │
      R  ────────┼──────────────────────┼──────────────────────┤
        low      │   MONITOR            │   KEEP INFORMED       │
                 │   (light touch)      │   (win in workshop/   │
                 │   <…>                │    PoC) <end users?>  │
                 └──────────────────────┴──────────────────────┘
```

*Findings to flag:* is your **champion** also your **economic buyer**? (Usually not.) Who can **veto** and hasn't been engaged yet? Which quadrant are you *over-* or *under-*investing in?

---

## 2. Role-based question bank

> Ask **open** questions to surface the story, **probe** to turn a symptom into a cost, **closed** to confirm a fact. Delete the rows you don't need; add stakeholders as needed. Never ask a **leading** question.

### 2a. Economic buyer (find the metric and the money)
- "What does the current problem cost you today — in time, money, risk, or reputation?"
- "If this worked perfectly, what number that you already report would move, and by how much before it's worth funding?"
- "Is this capex or opex for you, and what payback horizon would you defend to your board?"
- *(closed)* "Is there an approved budget line yet, or does this need a business case first?"

### 2b. Sponsor / champion (estate, feasibility, decision process)
- "Walk me through how your key systems actually talk to each other today — not the diagram, the reality."
- "What existing programmes or roadmaps must this align to or avoid disrupting?"
- "Who else has to say yes — and who can say no?"
- "What would make *you* confident enough to stake your name on this internally?"

### 2c. Skeptic / senior influencer (workflow, trust — mostly listen)
- "Walk me through the last time this process went wrong for you."
- "What would this solution have to *never* do for you to support it?"
- "You sound cautious — tell me more about what you've seen fail before."
- *(playback)* "So if I've understood you, the real risk you're worried about is `<…>` — is that right?"

### 2d. Compliance / security (the non-negotiables)
- "What regulations govern this data, and where is it legally allowed to be processed and stored?"
- "What must you be able to prove in an audit — who accessed what, and why?"
- "What is absolutely off the table — technologies, locations, data flows?"
- *(closed)* "So `<the risky pattern>` is a hard no?" — pin the hard constraint.

### 2e. Technical evaluator / SME (ground truth — often async)
- "For each system, what version, what uptime, and how does data get in and out today?"
- "Where are the manual steps and overnight batches everyone works around?"
- "What breaks most often, and what's the support headcount?"

---

## 3. Current state (as-is) — capture with numbers

> The baseline you will be measured against. Quantify wherever you can.

| Dimension | As-is finding | Number / metric (if any) |
|---|---|---|
| Core workflow (the pain) | `<how it works today>` | `<time / cost / volume>` |
| Systems involved | `<list the systems a user touches>` | `<# systems / # logins>` |
| Integration reality | `<API / batch / file / manual>` | `<freshness>` |
| Reporting / compliance effort | `<manual? automated?>` | `<FTE-days / frequency>` |
| Identity / access | `<SSO? fragmented?>` | `<# accounts>` |

**Baseline metric that prices the project:** `<the single number the economic buyer's business case rests on>`

---

## 4. Future state (to-be) + constraints

**Future state (one paragraph):**
> `<what "good" looks like from the user's point of view — the outcome, not the technology>`

**Constraints — sorted hard vs soft (the step that saves the deal):**

| Constraint | Hard or soft? | Source (who) | Implication for the design |
|---|---|---|---|
| `<e.g. data residency / no offshore>` | HARD | `<compliance>` | `<on-prem / sovereign>` |
| `<e.g. safety / human-in-loop>` | HARD | `<influencer>` | `<guardrails, no autonomy>` |
| `<e.g. must show payback by X>` | HARD (commercial) | `<econ buyer>` | `<needs baseline from §3>` |
| `<e.g. prefer incumbent vendor>` | Soft | `<sponsor>` | `<preference, negotiable>` |

---

## 5. Requirements register (the traceable output that feeds the HLD)

> One row per requirement. Every row is **sourced** and **prioritised**. This is your RTM: backward to who asked, forward to the design.

| ID | Requirement | Type (FR / NFR-category) | Source | Priority (MoSCoW) | Current-state gap | Feeds the HLD |
|---|---|---|---|---|---|---|
| FR-01 | `<what it must do>` | FR | `<stakeholder>` | Must | `<gap>` | `<design note>` |
| FR-02 | `<…>` | FR | | Should | | |
| NFR-01 | `<compliance / residency>` | NFR (compliance) | `<compliance>` | Must | | |
| NFR-02 | `<security / access / audit>` | NFR (security) | | Must | | |
| NFR-03 | `<performance / concurrency>` | NFR (performance) | | Should | | |
| NFR-04 | `<availability / RTO>` | NFR (availability) | | Should | | |
| NFR-05 | `<interoperability / standards>` | NFR (interop) | | Must | | |

**NFR checklist — did you ask about each?** (tick or mark N/A)

- [ ] Performance (speed + concurrency)
- [ ] Security & access control
- [ ] Compliance & data residency
- [ ] Availability / RTO / RPO
- [ ] Auditability
- [ ] Scalability / growth
- [ ] Usability / adoption
- [ ] Interoperability / standards

---

## 6. Findings & one-line scope

| # | Finding | Type (current / constraint / stakeholder) | Implication for the deal | Severity |
|---|---|---|---|---|
| 1 | `<e.g. economic buyer ≠ champion>` | Stakeholder | `<get the buyer in the room>` | H |
| 2 | `<e.g. residency rule found>` | Constraint | `<eliminates SaaS option>` | H |
| 3 | `<e.g. no current baseline captured>` | Current | `<must measure before ROI>` | M |

**One-line scope statement (fill in):**
> The proposed `<solution>` is a `<system of engagement>` that must satisfy `<n>` hard constraints (`<list>`) and integrate `<n>` systems of record, with `<the metric>` as the value driver — which reshapes the ask from "`<verbatim ask>`" into `<the honest, winnable scope>`.

---

## 7. Notes / running log

> Discovery never stops. Date-stamp decisions, open questions, and anything that changes after the first workshop.

- `<YYYY-MM-DD>` — `<what you learned / who you still need to talk to>`

---

*Worked example: see `example-nusantara-sehat-discovery.md` in this folder.*
