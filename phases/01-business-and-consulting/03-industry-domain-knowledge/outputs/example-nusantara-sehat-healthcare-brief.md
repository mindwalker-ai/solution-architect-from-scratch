---
name: example-nusantara-sehat-healthcare-brief
description: Worked Industry Pain-Point Brief for a fictional Indonesian hospital group (Nusantara Sehat) modernizing with AI — the six-lens scan filled in for healthcare
phase: 1
lesson: 3
audience: internal
---

# Industry Pain-Point Brief — Nusantara Sehat (worked example)

> This is `template-industry-pain-point-brief.md` filled in for the running Phase 1 customer. It shows what "good" looks like: a one-page scan that makes every later artifact — discovery report, HLD, BOM, proposal — speak healthcare from line one.

**Industry:** Healthcare (provider)  ·  **Sub-segment:** private hospital group, 8 hospitals + 20 clinics  ·  **Region:** Indonesia (regulation is local)
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-04  ·  **For opportunity:** Nusantara Sehat "AI modernization"  ·  **Version:** v0.2

**Company shape:** ~4,500 staff · ~1.2M patients/year · separate SIMRS per hospital (no group-wide patient identity).
**The ask (paraphrased):** *"Unified patient view, faster clinician access, and automated Ministry-of-Health reporting — modernize us with AI."*

> The Indonesian bodies and rules below (Kemenkes, BPJS, SATUSEHAT, INA-CBG, UU PDP, RME) are real regimes named at architect altitude. Confirm current thresholds/deadlines with the customer's compliance team on a live deal.

---

## ① Value chain — how a hospital creates and captures value

```
Access & Registration → Triage → Diagnosis (labs, imaging) → Treatment (inpatient/outpatient)
   → Discharge → Billing & Reimbursement (BPJS / INA-CBG) → Reporting (SATUSEHAT / Kemenkes)
                                    ⟳ follow-up loops back to Triage
```

- **Where the margin is:** reimbursement — the hospital is paid per episode via BPJS **INA-CBG** casemix tariffs; a denied or mis-coded claim is lost or delayed revenue.
- **Where our solution plugs in:** the whole chain sits on a **missing unified patient data layer**; the three asks map to (a) that layer under every link, (b) diagnosis/treatment links (clinician access), (c) the last link (reporting).

## ② Systems of record — which apps own the truth

| Data domain | System of record (anchor) | Do NOT read this from… |
|---|---|---|
| Patient demographics | **SIMRS / RME** (per hospital) | a spreadsheet export (stale, no master patient index) |
| Diagnoses & encounters | **SIMRS / RME** | the billing system (coded, not clinical) |
| Imaging | **PACS** | the EHR (holds the report, not the image) |
| Lab results | **LIS** | the EHR summary (may lag the LIS) |
| Claims & reimbursement | **BPJS / INA-CBG billing** | the EHR (clinical view, not the claim) |

- **The one anchor to know:** the **EHR/EMR** — locally the **SIMRS** plus mandated **RME** (Rekam Medis Elektronik).
- **Interop standard it speaks:** **HL7 FHIR** (mandated via SATUSEHAT).
- **The finding that reframes the deal:** a **separate SIMRS instance per hospital** means no group-wide patient identity → "unified patient view" is a **master patient index + FHIR interoperability** problem *first*, an AI problem second.

## ③ Regulators & rules — which bite

| Regulator / rule | What it governs | What it does to the architecture |
|---|---|---|
| **UU PDP** (Personal Data Protection Law) | Health data = *specific/sensitive* personal data | Consent, minimization, audit trails; **offshore LLM API on patient data = landmine** |
| **Data residency** (PP 71/2019 + sector rules) | Where health data may physically sit | Pushes to **in-country on-prem / sovereign cloud**; kills naive "just use a US region" |
| **SATUSEHAT** (Kemenkes national exchange) | Mandated **FHIR** interoperability + reporting | Must speak **HL7 FHIR** — a constraint *and* a lever (standardizes the data you unify) |
| **BPJS / INA-CBG** | National-insurance reimbursement (casemix) | Claim accuracy = money → **AI-assisted coding** targets a financial KPI |

- **The rule that dominates:** **PDP + data residency** — patient data and any AI touching it must stay onshore, where the law allows.
- **Data residency posture:** **onshore-only / sovereign** (on-prem or in-country sovereign cloud).

## ④ KPIs & economics — how they keep score and get paid

| KPI | What it means | Where AI/data credibly moves it |
|---|---|---|
| **ALOS** (avg length of stay) | Days per admission | Patient-flow + discharge-planning models |
| **30-day readmission rate** | Patients back within a month | Readmission-risk scoring at discharge |
| **BOR** (bed occupancy rate) | Utilization vs capacity (healthy band ~60–85%) | Capacity/flow forecasting |
| **Claim denial / pending rate** | % of BPJS claims rejected or held | AI-assisted **INA-CBG coding** at billing |
| **Reporting turnaround** | Days to compile Kemenkes/SATUSEHAT reports | Automated report generation from the unified layer |

- **How the business gets paid:** BPJS **INA-CBG casemix tariffs** per episode (plus private/insurance pay).
- **The KPI our ROI will target:** **claim denial rate** (direct cash recovery) + **reporting turnaround** (labor + compliance) — the two with the cleanest, defensible ROI.

## ⑤ Disruption & AI — credible vs hype

```
 CREDIBLE (documented value, acceptable risk)     HYPE / LANDMINE (kills the deal)
 ──────────────────────────────────────────────   ──────────────────────────────────────────────
 Unified patient view via MPI + FHIR layer        "Autonomous AI diagnosis" — no ID regulatory
 Ambient / retrieval clinical documentation         clearance; patient-safety + liability risk
   (summarize history, draft notes, human-in-     "Put patient records in ChatGPT" — breaks PDP
    the-loop)                                        + data residency in one move
 Automated SATUSEHAT / Kemenkes reporting          "Real-time everything" when SIMRS instances are
 AI-assisted INA-CBG coding to cut denials           batch-integrated — freshness is capped by the
 Readmission-risk scoring at discharge               slowest hop (lesson-1.2 rule, in health)
```

- **The posture the regulation forces:** **human-in-the-loop copilot**, never an autopilot. A model *suggests*; a clinician decides.

## ⑥ Buying triggers — what unlocks the budget

- **Live trigger(s):** the **RME electronic-records mandate** and **SATUSEHAT integration requirement** are compliance deadlines with teeth; **BPJS claim denials** are bleeding cash *now*.
- **Cost of inaction:** non-compliance exposure + continued denied-claim revenue leakage + manual reporting labor across 8 sites.
- **Who owns the budget:** CIO (platform) + CFO (claims recovery) + Medical Director / compliance (safety + PDP).

---

## Landmines — what kills deals in this vertical

| # | Landmine | Why it kills the deal | The safe move instead |
|---|---|---|---|
| 1 | Offshore / public LLM API on patient data | Breaks **PDP + data residency** | Sovereign, in-country inference; PDP-scoped data |
| 2 | Autonomous AI diagnosis | No regulatory clearance; patient-safety + liability | **Human-in-the-loop** clinical copilot |
| 3 | Promising "real-time" over batch SIMRS feeds | Freshness capped by the slowest integration | State achievable freshness; add direct feeds where it matters |
| 4 | Ignoring the per-hospital identity gap | "Unified view" silently becomes a multi-site MPI project | Scope the **master patient index** explicitly, up front |

---

## So-what — how this reshapes the pitch

- **Call the solution:** **"Unified patient view + clinical copilot"** — *not* "a data platform with a chatbot".
- **Anchor it to:** the **SIMRS/RME EHR**, PACS, LIS, and BPJS billing (via **FHIR**).
- **Gate it with:** **PDP + data residency** (sovereign/on-prem) and **FHIR/SATUSEHAT** interoperability.
- **Aim it at:** **claim-denial recovery** and **reporting turnaround** (CFO-grade ROI), with readmission/flow as the clinical upside.
- **Ride the trigger:** the RME + SATUSEHAT mandates and active claim leakage.

**One-line positioning statement:**
> For Nusantara Sehat, we deliver a **PDP-safe, FHIR-native unified patient view with a human-in-the-loop clinical copilot** that recovers denied BPJS/INA-CBG claims and automates SATUSEHAT reporting — plugging into the per-hospital SIMRS/RME estate and riding the electronic-records and national-exchange mandates. The integration, sovereignty, and coding accuracy — not the chatbot — are the real drivers of value, and naming that is why we win the room.

**Reuse note:** this brief feeds the Phase 1 **Discovery Report** (Capstone A), the requirement-gathering questionnaire (lesson 1.4), and later the AI-platform sizing in Phase 5 — where "sovereign, human-in-the-loop, FHIR-native" becomes concrete GPU, residency, and integration line items.
