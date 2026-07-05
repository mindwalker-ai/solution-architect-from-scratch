---
name: template-industry-pain-point-brief
description: Industry Pain-Point Brief — a one-page, six-lens scan of any vertical (value chain, systems of record, regulators, KPIs/economics, credible AI vs hype, buying triggers) produced before the first customer meeting
phase: 1
lesson: 3
audience: internal
---

# Industry Pain-Point Brief — Template

> Fill this in *before* the first meeting in any vertical. It is an internal battlecard, not a customer deliverable — its job is to make your discovery, HLD, and proposal speak the customer's language from line one. Aim for one page; if a lens takes more than a few lines, you're going too deep for presales altitude.

**Industry:** `<vertical>`  ·  **Sub-segment:** `<e.g. hospital group / retail bank / discrete mfg>`  ·  **Region:** `<country — regulation is local>`
**Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`  ·  **For opportunity:** `<deal / customer>`  ·  **Version:** `<v0.1 draft>`

Legend: **SoR** = system of record (owns the truth) · **KPI** = the number an executive is scored on · **credible** = documented value + acceptable risk · **hype** = a regulatory/safety landmine dressed as a demo.

---

## How to use this template

Answer the **six lenses** in order. Each is one question; keep the answer to a few lines. Don't try to become the practitioner — get to the point where the customer stops explaining their *business* and starts explaining their *problem*.

```
 ① VALUE CHAIN  →  ② SYSTEMS OF RECORD  →  ③ REGULATORS & RULES
        →  ④ KPIs & ECONOMICS  →  ⑤ DISRUPTION & AI  →  ⑥ BUYING TRIGGERS
                              ↓
                   the pitch reshapes itself
```

---

## ① Value chain — how does this industry create and capture value?

> The ordered activities from input to paid outcome. The customer's pain sits on a *link*, not on "IT".

```
<step 1> → <step 2> → <step 3> → <step 4> → <step 5> → <step 6> → <step n>
```

- **Where the margin is:** `<which link makes/loses the money>`
- **Where our solution plugs in:** `<the link(s) the opportunity touches>`

## ② Systems of record — which apps own the truth?

> Name the vertical's anchor app(s); that names most of the estate before you ask.

| Data domain | System of record (anchor) | Do NOT read this from… |
|---|---|---|
| `<domain>` | `<anchor app>` | `<the wrong copy + why>` |
| `<domain>` | `<anchor app>` | `<…>` |
| `<domain>` | `<anchor app>` | `<…>` |

- **The one anchor to know:** `<the app the whole vertical revolves around>`
- **Interop standard it speaks:** `<HL7/FHIR, ISO 20022, OPC-UA, etc. — or "none, custom">`

## ③ Regulators & rules — who governs them, and which rules actually bite?

> The lens that decides the architecture. Focus on rules that constrain *where data sits, what's auditable, what a model may decide*.

| Regulator / rule | What it governs | What it does to the architecture |
|---|---|---|
| `<body / law>` | `<data / capital / safety / …>` | `<residency / audit / human-in-the-loop / …>` |
| `<body / law>` | `<…>` | `<…>` |

- **The rule that dominates:** `<the single constraint everything is designed around>`
- **Data residency posture:** `<onshore-only / sovereign cloud / public cloud OK>`

## ④ KPIs & economics — how do they keep score, and how do they get paid?

> If your solution doesn't move a KPI the buyer is measured on, it's a hobby. If you ignore the revenue/reimbursement model, your ROI won't be believed.

| KPI | What it means | Where AI/data credibly moves it |
|---|---|---|
| `<KPI>` | `<plain-English meaning>` | `<the use-case that shifts it>` |
| `<KPI>` | `<…>` | `<…>` |
| `<KPI>` | `<…>` | `<…>` |

- **How the business gets paid:** `<revenue / reimbursement / funding model>`
- **The KPI our ROI will target:** `<the one number we promise to move>`

## ⑤ Disruption & AI — credible vs hype

> Naming the hype earns more trust than promising everything.

```
 CREDIBLE (documented value, acceptable risk)     HYPE / LANDMINE (kills the deal)
 ──────────────────────────────────────────────   ──────────────────────────────────────────────
 <use-case>                                        <over-claim + why it's a landmine>
 <use-case>                                        <over-claim + why it's a landmine>
 <use-case>                                        <over-claim + why it's a landmine>
```

- **The posture the regulation forces:** `<human-in-the-loop copilot / autonomous OK / …>`

## ⑥ Buying triggers — what actually unlocks the budget?

> Interest is not budget. Name the event that creates urgency *this quarter*.

- **Live trigger(s):** `<mandate + deadline / failed audit / incident / competitor move / merger>`
- **Cost of inaction:** `<the fine, the lost revenue, the risk if they don't act>`
- **Who owns the budget:** `<CIO / CFO / CMO / compliance / line-of-business>`

---

## Landmines — what kills deals in this vertical

> The traps a technology-first competitor walks into. Say these out loud in the room; it builds trust.

| # | Landmine | Why it kills the deal | The safe move instead |
|---|---|---|---|
| 1 | `<e.g. offshore data processing>` | `<breaks residency/privacy law>` | `<sovereign / on-prem design>` |
| 2 | `<e.g. autonomous decisioning>` | `<regulator forbids / safety risk>` | `<human-in-the-loop>` |
| 3 | `<e.g. "real-time" over batch SoRs>` | `<freshness capped by slowest hop>` | `<state the achievable freshness>` |

---

## So-what — how this reshapes the pitch (fill in)

> The payoff line. Rewrite a generic "we do AI / a data platform + assistant" pitch in *this industry's* language.

- **Call the solution:** `<the vertical's name for it, e.g. "unified patient view" not "data platform">`
- **Anchor it to:** `<the SoR it plugs into>`
- **Gate it with:** `<the rule that decides the architecture>`
- **Aim it at:** `<the KPI + economics the buyer cares about>`
- **Ride the trigger:** `<the live urgency>`

**One-line positioning statement:**
> For `<industry buyer>`, we deliver `<vertical-named solution>` that `<moves this KPI / recovers this money>` while staying `<compliant with the rule that bites>` — plugging into `<the anchor SoR>` and riding `<the live buying trigger>`.

---

*Worked example: see `example-nusantara-sehat-healthcare-brief.md` in this folder.*
