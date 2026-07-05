---
name: example-nusantara-sehat-rfp-poc
description: Worked RFP Response Outline + PoC Plan for a fictional Indonesian hospital group (Nusantara Sehat) modernizing patient data + piloting a clinician AI assistant
phase: 1
lesson: 6
audience: customer | internal | executive
---

# RFP Response Outline + PoC Plan — Nusantara Sehat (worked example)

> This is `template-rfp-response-and-poc-plan.md` filled in for a fictional customer. It shows what "good" looks like: three win themes tied to three real pains, a compliance matrix kept in its place, and a six-week paid PoC scoped to something you can actually prove.

**Customer:** Nusantara Sehat (fictional)  ·  **Opportunity:** "Hospital Modernization + Clinician-AI" RFP
**Prepared by:** SA — Presales  ·  **RFx type:** RFP (~600 requirements, 380 pp)  ·  **Response due:** 2026-07-25  ·  **Version:** v0.3
**Did we shape this RFx?** *Partly* — our champion (Head of Digital Health) reused our discovery checklist for the data-residency and interoperability sections. The rip-and-replace language we lobbied against did **not** make it in. Good sign, not a lock.

**Company shape:** 8 hospitals · 20 clinics · ~4,500 staff · best-of-breed HIS/SIMRS sprawl (each hospital runs its own HIS/SIMRS instance, no single dominant vendor) · monthly Ministry of Health (Kemenkes) reporting done by hand.

---

## Part A — RFP Response Outline

### A0. Deal snapshot (from the MEDDICC sheet, Lesson 1.5)

| MEDDICC element | This deal |
|---|---|
| **M**etrics | Cut monthly Ministry-reporting effort from ~5 staff-days/hospital to near-zero; measurable clinician time-to-information |
| **E**conomic buyer | **CFO** (signs the programme; exec-summary audience) |
| **D**ecision criteria | Integration feasibility · data residency / PDP compliance · clinician adoption · total cost / ROI · no vendor lock-in |
| **D**ecision process | Shortlist → **PoC** → BAFO → board award (target Q4) |
| **I**dentify pain | (1) Fragmented patient data (2) Manual Ministry reporting (3) PDP Law residency + AI-safety exposure |
| **C**hampion | Head of Digital Health (arms us internally; ran our discovery checklist) |
| **C**ompetition | A rival systems integrator + **"do nothing"** (CFO default) |

### A1. Win themes

| # | Customer pain / decision criterion | Our differentiator | Proof the buyer can verify | Targets |
|---|-------------------------------------|--------------------|-----------------------------|----------|
| **WT1** | Fragmented patient data across 8 hospitals' HIS/SIMRS instances | **Integrate-don't-replace** unified patient view over existing HIS/SIMRS instances as systems of record — no migration | PoC: one unified view across 2 pilot hospitals (Part B) + comparable hospital-group reference | CIO, CMO |
| **WT2** | 5-day manual monthly Kemenkes / SATUSEHAT reporting | One-click Ministry report generated from the same unified data layer | Live report generated in the PoC, reconciled vs. last manual month | CFO, CIO |
| **WT3** | PDP Law residency + AI safety | Sovereign in-country deployment; AI runs only on **de-identified** records | Residency reference architecture + DPIA signed off by the customer's DPO during the PoC | CIO, CMO, CFO(risk) |

```
   PAIN / DECISION CRITERION            →   DIFFERENTIATOR                →   PROOF (verifiable)                TARGETS
   ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   Fragmented patient data across       →   Integrate-don't-replace       →   PoC unified view, 2 pilot         CIO
   8 hospitals' own HIS/SIMRS instances     unified patient view              hospitals + hospital reference    CMO
   ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   5-day manual monthly Kemenkes        →   One-click SATUSEHAT report    →   Live report in PoC, reconciled    CFO
   (Ministry) reporting scramble            off the unified data layer        vs. last manual submission        CIO
   ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   PDP Law: data must stay in-country;  →   Sovereign in-country deploy;  →   Residency arch + DPIA;            CIO
   AI must be safe for clinicians           AI on de-identified data only     customer DPO sign-off in PoC      CMO/CFO
   ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   3 themes, 3 pains, 3 verifiable proofs. WT3 is also the wedge that eliminates any public-cloud-LLM bidder and
   turns "do nothing" from the safe option into the RISKIEST one (regulatory exposure).
```

### A2. Executive summary (1 page — written last)

- **Their goal, in their words:** *"A single, trusted view of the patient across our hospitals, automated Ministry reporting, and a safe AI assistant for clinicians — without our data leaving Indonesia."*
- **The win themes:** WT1 one patient, one record (without replacing your HIS/SIMRS) · WT2 the 5-day reporting scramble becomes a one-click submission · WT3 compliant by design, your data never leaves the country.
- **The outcome:** ~5 staff-days/month/hospital of reporting effort returned to care; clinicians find patient information in seconds; a documented PDP-compliant, in-country platform.
- **The ask:** approve a **paid 6-week PoC** across two pilot hospitals; on pass, advance to a phased rollout starting with those two hospitals in production.

### A3. Response section map

| # | Section | Filled in | Carries |
|---|---------|-----------|---------|
| 1 | Executive Summary | §A2 | all |
| 2 | Win Themes | §A1 | all |
| 3 | Understanding of Requirements | Restate the three pains + the compelling event (PDP enforcement + SATUSEHAT mandate) | — |
| 4 | Solution (HLD altitude) | 4.1 Unified patient data layer over existing HIS/SIMRS instances via HL7 FHIR (WT1) · 4.2 Automated Kemenkes/SATUSEHAT reporting (WT2) · 4.3 In-country deployment + de-identified clinician assistant (WT3) · 4.4 Phasing: Phase 1 = 2 hospitals to production; Phase 2 = remaining 6 + full assistant | WT1–3 |
| 5 | Proof | The PoC plan (Part B) · comparable hospital-group reference · DPIA + residency approach | WT1–3 |
| 6 | Commercials | Phased fixed-price stages; TCO vs. cost of manual reporting **+** the risk-weighted cost of a PDP breach (the true "do-nothing" price) | WT2, WT3 |
| 7 | Compliance Matrix | §A4 — all ~600 reqs, fast + accurate, zero mandatory misses | supports |
| 8 | Delivery, Risk & Team | Phased governance, clinical-informatics lead, named integration engineers | — |

### A4. Compliance matrix (excerpt — the pattern, not all 600)

| Req # | Requirement (verbatim) | Response | How / where met | Win-theme hook |
|-------|------------------------|----------|-----------------|----------------|
| 3.2.1 | "Solution must present a unified patient record across all facilities." | **Comply** | §4.1 unified data layer over existing HIS/SIMRS instances | **WT1** |
| 3.2.4 | "Must integrate with existing HIS/SIMRS instances without requiring data migration." | **Comply** | §4.1 read-only FHIR integration; HIS/SIMRS instances remain SoR | **WT1** (trap req — the rival struggles here) |
| 4.1.2 | "All personal and health data must be stored and processed within Indonesia." | **Comply** | §4.3 sovereign in-country deployment | **WT3** |
| 4.3.6 | "Any AI/ML must not process identifiable patient data." | **Comply** | §4.3 de-identification before the AI layer | **WT3** |
| 5.5.9 | "Automated generation of monthly Ministry (Kemenkes) reports." | **Comply** | §4.2 report engine off the unified layer | **WT2** |
| 6.7.3 | "Vendor to provide on-site staff at each facility 24/7 for year one." | **Alternative** | Central NOC + on-call + on-site during go-live per site; meets the intent at lower cost | — (note mitigation) |

*Discipline note:* the whole 600-row matrix was completed in two focused days by one engineer working from a response library — leaving the team's hours for §A2 and §A4's win-theme hooks, where the decision is actually made.

---

## Part B — PoC Plan (signed before any build)

```
   THE PoC CONTRACT — Nusantara Sehat "Unified Patient View" PoC
   ┌───────────────────────────────────────────────────────────────────────────────────┐
   │ OBJECTIVE   Prove a single, accurate, current, unified patient view across TWO       │
   │             pilot hospitals' different HIS/SIMRS — in-country, trusted by clinicians. │
   ├───────────────────────────────────────────────────────────────────────────────────┤
   │ SUCCESS     1 identity+accuracy | 50-record blind audit | >=98% field match          │
   │ CRITERIA    2 freshness         | 20 timed encounters    | <=15 min to unified view   │
   │  (signed by 3 residency+DPIA    | DPO checklist review   | DPO sign-off               │
   │   the DPO)  4 Ministry report   | reconcile vs last month| within agreed tolerance    │
   │             5 clinician trust*  | 10 clinicians, 1 task  | >=4/5 & <2 clicks  (*not a │
   │                                 |                        |  pass/fail gate)           │
   ├───────────────────────────────────────────────────────────────────────────────────┤
   │ SCOPE IN:   2 named hospitals · 2 HIS/SIMRS · 200-patient cohort · read-only ·        │
   │             de-identified data for AI slice · customer in-country PoC env             │
   │ SCOPE OUT:  other 6 hospitals · HIS/SIMRS write-back · prod HA/DR + security accred · │
   │             full historical migration · all specialties · full clinician assistant    │
   ├───────────────────────────────────────────────────────────────────────────────────┤
   │ TIMELINE    6 weeks, readout on 2026-09-12                                            │
   │ RESOURCING  PAID fixed-fee · customer: data+DPO+2 clinician SMEs+env · us: SA +        │
   │             data engineer + clinical-informatics advisor                              │
   │ EXIT        PASS -> full proposal + Phase-1 (2 hospitals) production                   │
   │             FAIL -> findings report kept by customer + paid remedy OR clean walk       │
   └───────────────────────────────────────────────────────────────────────────────────┘
```

### B1. Objective

Prove that a single, accurate, current, unified patient view can be produced across **two pilot hospitals' different HIS/SIMRS instances**, entirely within Indonesia, and trusted by clinicians — the foundation the whole modernization rests on. (Answers the CIO's biggest doubt: *can you actually unify our fragmented data, compliantly?*)

### B2. Success criteria (pre-agreed, signed by the customer's DPO and CIO)

| # | Criterion | How measured | Pass threshold | Gate / indicator |
|---|-----------|--------------|----------------|------------------|
| 1 | Identity + accuracy — same patient reconciled across both HIS/SIMRS instances; last 12 months of encounters shown | Blind audit of 50 records from a 200-patient cohort vs. each source HIS/SIMRS | **≥ 98%** field-level match | **Gate** |
| 2 | Freshness — a new encounter in either HIS/SIMRS appears in the unified view | Timed test on 20 fresh encounters | **≤ 15 min** (near-real-time path) | **Gate** |
| 3 | Residency + compliance — data stays in-country; AI slice on de-identified data only | DPIA checklist reviewed by the customer's DPO | **DPO sign-off** | **Gate** |
| 4 | Ministry reporting — one monthly Kemenkes/SATUSEHAT-format report from the unified data | Reconcile vs. the hospital's last manual submission | Within **agreed tolerance** | **Gate** |
| 5 | Clinician trust | 10 pilot clinicians: usefulness rating + "find latest creatinine" task | **≥ 4/5** and **< 2 clicks** | Leading indicator |

> Deliberately **not** promised: "the AI answers any clinical question accurately." That is unbounded and unprovable in six weeks — quoting it would be the credibility-killer this lesson warns against. The clinician slice is a thin, de-identified demo (criterion 5), explicitly a leading indicator, not a gate.

### B3. Scope guardrails

- **IN:** RSUD Pilot-A + RS Pilot-B · their two HIS/SIMRS instances · one bounded 200-patient cohort · read-only access · de-identified data for the AI slice · a customer-provided in-country PoC environment.
- **OUT:** the other 6 hospitals · write-back to any HIS/SIMRS · production HA/DR and security accreditation · full historical data migration · all clinical specialties · the full clinician-assistant scope. *(When week 3 brings "can you add a third hospital?", the fixed-fee and this list are what let you say "in Phase 1, not the PoC.")*

### B4. Timeline (6 weeks)

| Week | Milestone |
|------|-----------|
| W1–2 | Connect both HIS/SIMRS instances (FHIR read-only) · reconcile patient identity across sites |
| W3–4 | Build unified view · stand up residency controls · run de-identification for the AI slice |
| W5 | Generate the Ministry report · run the clinician demo with the 10 SMEs |
| W6 | Measure against all five criteria · joint readout with CIO + DPO + clinical lead |

### B5. Resourcing & commercial model

- **Paid, fixed-fee.** Skin in the game keeps the criteria honest and protects our margin against scope drift.
- **Customer provides:** de-identified data access, the DPO (for the DPIA sign-off), 2 clinician SMEs, and the in-country PoC environment.
- **We provide:** 1 SA (lead), 1 data/integration engineer, 1 clinical-informatics advisor.

### B6. Exit

- **PASS →** advance to the full proposal and the Phase-1 production rollout at the two pilot hospitals; carry the PoC's integration and residency learnings straight into the HLD and BOM (Phase 6 artifacts).
- **FAIL →** a documented findings report the customer keeps, plus either a scoped **paid** remediation sprint or a clean walk. No open-ended drift.

---

**So what (the pivot this pair buys you):** the reactive bid was "600 rows of Comply + a free platform PoC across 8 hospitals" — indistinguishable from the incumbent and beatable by "do nothing." The disciplined bid is **three win themes the CFO, CIO, and CMO each recognise as their own pain**, backed by a **six-week paid PoC that proves the riskiest claim and nothing more**. You look like the vendor who understood the estate, respected the regulator, and knew exactly what to prove first — which is how you take a deal away from both the incumbent and inertia.
