---
name: example-nusantara-sehat-discovery
description: Worked Discovery pack for the fictional Nusantara Sehat hospital-group clinician-AI-assistant deal — stakeholder map, role-based questions asked, current/future state, sorted constraints, and a traceable requirements register.
phase: 1
lesson: 4
audience: customer | internal
version: 1.0.0
---

# Discovery Pack — Nusantara Sehat (worked example)

> This is `template-discovery-questionnaire.md` filled in for a fictional customer. It shows what "good" discovery looks like: the map, the role-tailored questions, the numbered baseline, the sorted constraints, and the traceable register that turns a vague ask into a winnable scope — and it is the discovery input to **Capstone A**.

**Customer:** Nusantara Sehat (fictional)  ·  **Industry:** Healthcare — private hospital group, Indonesia
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-04  ·  **Opportunity:** "Clinician AI Assistant" discovery → PoC
**The ask (verbatim):** *"Give our doctors an AI assistant — ask it about a patient and get a straight, safe answer without digging through five systems."*  ·  **Version:** v0.2

**Company shape:** 8 hospitals · 20 clinics · ~4,500 staff · ~1.2M patients/yr. Aging siloed estate: HIS (SIMRS), LIS, RIS-PACS, ERP, patient portal — HL7 v2 point-to-point. Manual Kemenkes reporting. Under UU PDP + SATUSEHAT (FHIR) pressure.

Legend: **FR** = functional requirement · **NFR** = non-functional · **SoR** = system of record · **PHI** = protected health information · **MoSCoW** = Must/Should/Could/Won't.

---

## 1. Stakeholder map

| Stakeholder | Role in the deal | Power | Interest | What they care about | Format |
|---|---|---|---|---|---|
| **CFO** | **Economic buyer** — signs | High | Low (skeptical) | ROI, payback, capex vs opex, risk | 1:1 (Keep Satisfied → win) |
| **CIO** | **Sponsor / champion** | High | High | Modern estate, technical win, feasibility | 1:1 + co-design (Manage Closely) |
| **CMO** | Clinician influencer — **can veto** | High | High (negative) | Patient safety, clinician trust, workflow fit | 1:1 first (Manage Closely) |
| **Compliance officer** | **Can veto** on UU PDP | Med-High | Medium | Data residency, consent, audit, breach duty | 1:1 (Keep Satisfied) |
| **Hospital IT leads** (×2) | Technical evaluators / SMEs | Medium | High | Integration reality, uptime, support load | Workshop + async questionnaire |
| **Clinicians / nurses** | End users | Low | High | "Does it make my day easier and safer?" | Workshop + PoC (Keep Informed) |

### Power / interest grid — filled

```
                    INTEREST  ───────────────────────────────▶
                    low                                    high
                 ┌──────────────────────┬──────────────────────┐
        high     │  CFO (economic buyer)│  CIO (champion)      │
      P          │  Compliance officer  │  CMO (skeptic —      │
      O          │  → KEEP SATISFIED    │       must be won)   │
      W          │    (either can veto) │  → MANAGE CLOSELY    │
      E  ────────┼──────────────────────┼──────────────────────┤
      R          │                      │  Hospital IT leads   │
        low      │  → MONITOR           │  Clinicians / nurses │
                 │    (none here)       │  → KEEP INFORMED     │
                 └──────────────────────┴──────────────────────┘
```

**Findings from the map:** the champion (CIO) is **not** the buyer (CFO) and **not** the biggest risk (CMO). Two people can independently veto (CMO on safety, compliance on UU PDP). Interviewing only the enthusiastic CIO would have missed both the funder and both vetoes — the exact failure this lesson exists to prevent.

---

## 2. Role-based questions asked (and what each surfaced)

**CFO — economic buyer** → *found the metric.*
- "What does a clinician's time cost, and how much goes to hunting for information today?" → *"Clinical time is our scarcest resource; if doctors are wasting an hour a day across systems, that's real money."*
- "If this worked, what number on your board report moves, and by how much before it's worth funding?" → **average clinician minutes per patient review**, and payback must be **under ~2 years**.
- *(closed)* "Is there a budget line yet?" → **No — needs a business case first.** (This is why §3's baseline matters.)

**CIO — champion** → *estate + decision process.*
- "How do these five systems actually talk today?" → HL7 v2 **point-to-point**, no unified view, **no FHIR layer yet**.
- "Where are you on SATUSEHAT?" → **early**; anything new must **align to FHIR**, not fight it.
- "Who else says yes, and who says no?" → **CFO signs; CMO and compliance can each veto; board approves in Q4.**

**CMO — skeptic** → *listened 70%; surfaced the safety veto.*
- "Walk me through the last time patient information was hard to get to." → a real, dated near-miss where a lab result was missed across systems.
- "What would this assistant have to *never* do?" → **never act on its own; never present an answer without a source; never let a doctor see a patient they aren't treating.**
- *(did NOT ask)* "You'd want it to auto-write notes, right?" — that leading question would have hardened the skeptic. Instead: *"Tell me more about what you've seen go wrong."*

**Compliance officer** → *found the showstopper early.*
- "Under UU PDP, where can patient data live and travel?" → **must stay in Indonesia; no PHI to any offshore or public service.**
- *(closed)* "So PHI to a public LLM API is off the table?" → **Confirmed — hard no.** (This single answer eliminates the SaaS-LLM competitor.)
- "What must you prove in an audit?" → **who accessed which record and why**, retained and immutable.

**Hospital IT leads (async questionnaire + workshop)** → *ground truth.*
- Versions, uptime, and interfaces per system; where the manual batches and workarounds live; support headcount.

---

## 3. Current state (as-is) — with numbers

| Dimension | As-is finding | Number / metric |
|---|---|---|
| Core workflow (the pain) | Clinician manually opens multiple systems to assemble one patient view | **4–5 systems, 4–5 logins** |
| Time cost | Information-hunting per complex patient review | **~8–12 min/review** |
| Integration reality | HL7 v2 **point-to-point**; no unified view; no FHIR | Batch/near-real-time mix |
| Reporting effort | Kemenkes SIRS / RS Online compiled **by hand** | **~5–7 FTE-days / hospital / month** |
| Identity / access | Separate account per system; **no SSO** | Fragmented; weak audit trail |

**Baseline metric that prices the project:** *clinician minutes per patient review* (× ~4,500 staff × patient volume) — the number the CFO's business case rests on. **Captured, not invented.**

---

## 4. Future state (to-be) + constraints

**Future state:**
> A clinician asks **one** assistant, in Bahasa Indonesia or English, and gets a **cited, safe** answer drawn from that patient's record, labs, and imaging reports — without opening five systems — with every answer traceable to its source and every access logged.

**Constraints — sorted:**

| Constraint | Hard or soft? | Source | Implication for the design |
|---|---|---|---|
| No PHI offshore / no public LLM API (UU PDP + residency) | **HARD** | Compliance officer | On-prem / sovereign inference; **eliminates SaaS-LLM vendors** |
| Decision-*support* only — never autonomous clinical action | **HARD** | CMO | Human-in-the-loop; guardrails; "assistant not authority" |
| Per-clinician access control + immutable audit | **HARD** | Compliance + CMO | Access scoped to care relationship; break-glass logged |
| Must align to SATUSEHAT / FHIR, not disrupt it | **HARD** | CIO | FHIR integration layer; ride or run beside the national programme |
| Business case must show payback < ~2 yrs | **HARD (commercial)** | CFO | Depends on the §3 baseline being real |
| Prefer extending the incumbent HIS vendor | **Soft** | CIO | A preference — negotiable, not a design constraint |
| Prefer piloting one hospital first | **Soft** | CMO | Helps us — a safety-first PoC de-risks the CMO's veto |

---

## 5. Requirements register (traceable — feeds the HLD)

| ID | Requirement | Type | Source | Priority | Current-state gap | Feeds the HLD |
|---|---|---|---|---|---|---|
| FR-01 | Answer clinical questions over a patient's record, labs, imaging reports | FR | CMO, clinicians | Must | Data siloed across 4–5 systems | RAG over HIS/LIS/RIS via FHIR retrieval |
| FR-02 | Cite the source system + record for every answer | FR | CMO, compliance | Must | No provenance today | Answer-with-citations + audit log |
| FR-03 | Bahasa Indonesia + English + clinical terminology | FR | CMO | Should | — | Bilingual model + eval set |
| FR-04 | Assist with drafting Kemenkes report figures (human-verified) | FR | CIO, CFO | Could | ~5–7 FTE-days/hospital/month manual | Read from SoRs; human sign-off |
| NFR-01 | No PHI leaves Indonesia; no public LLM API | NFR (compliance) | Compliance | Must | N/A (new) | On-prem / sovereign inference; no external API |
| NFR-02 | Decision-support only; human confirms every action | NFR (safety) | CMO | Must | N/A (new) | Guardrails, no write-back, review step |
| NFR-03 | Access scoped per clinician–patient relationship; immutable audit | NFR (security) | Compliance, CMO | Must | Fragmented identity, weak audit | SSO + RBAC + immutable access log |
| NFR-04 | < 3s for a patient summary; ~150 concurrent clinicians | NFR (performance) | CIO, clinicians | Should | N/A (new) | GPU sizing for concurrency (Phase 5) |
| NFR-05 | 99.5% availability in business hours (support, not life-support) | NFR (availability) | CIO | Should | N/A (new) | HA sized to *support*, not over-built |
| NFR-06 | Align to SATUSEHAT / FHIR R4 | NFR (interop) | CIO | Must | HL7 v2 point-to-point only | FHIR integration layer to the SoRs |

**NFR checklist:** ☑ Performance · ☑ Security · ☑ Compliance/residency · ☑ Availability · ☑ Auditability · ☑ Interoperability · ☐ Scalability (revisit at design) · ☑ Usability/adoption (PoC-driven).

---

## 6. Findings & one-line scope

| # | Finding | Type | Implication for the deal | Severity |
|---|---|---|---|---|
| 1 | Economic buyer (CFO) ≠ champion (CIO); two independent vetoes (CMO, compliance) | Stakeholder | Must win the CFO's business case **and** neutralise both vetoes | **High** |
| 2 | Residency rule: no PHI offshore / no public LLM API | Constraint | Eliminates SaaS-LLM competitors → **our moat**; forces sovereign inference | **High** |
| 3 | No FHIR layer; HL7 v2 point-to-point; SATUSEHAT early | Constraint | A FHIR integration layer is the real effort, not the chatbot | **High** |
| 4 | Baseline captured (minutes/review; FTE-days/report) | Current | The CFO's ROI is now defensible, not invented | Medium |
| 5 | CMO wins the room only via a safety-first, single-hospital PoC | Stakeholder | Phase the deal; PoC de-risks the safety veto | Medium |

**One-line scope statement:**
> The **Clinician AI Assistant** is a *system of engagement over regulated PHI* that must satisfy four hard constraints (**data residency, clinical-safety human-in-loop, per-clinician access + audit, SATUSEHAT/FHIR alignment**) and integrate **four systems of record** via a new FHIR layer — with **clinician minutes-per-review** as the value driver — which reshapes the ask from *"an AI assistant"* into a **sovereign, safety-first, phased platform**: the integration, compliance, and CMO buy-in — not the chatbot — are the real drivers of effort, timeline, and price.

**So what (the pivot this pack buys you):** instead of a two-week proposal for "a chatbot," the honest, winnable path is — Phase 1: single-hospital safety-first PoC on redacted records to win the CMO and prove the metric; Phase 2: sovereign inference + FHIR integration to the four SoRs with per-clinician access + audit; Phase 3: rollout + Kemenkes reporting assist. You priced it correctly, you found the funder's metric and the compliance showstopper **before** designing, and you have a sourced, prioritised register to defend every line.

---

## 7. Notes / running log

- **2026-07-04 (interviews):** Nearly ran to design on the CIO's enthusiasm. The stakeholder map forced the CFO and CMO interviews — which surfaced the funding gap and the safety veto. *Lesson: the friendliest contact is rarely the signer or the blocker.*
- **Constraint drives everything:** "No PHI offshore / no public LLM API" (compliance, Must) became the single most important line — it eliminates the SaaS competitor and dictates sovereign inference in the HLD.
- **Open question still to close:** exact per-review time baseline needs a short time-and-motion sample at 2 hospitals before the business case is final.
- **Where this feeds the track:** this register is the direct input to **Capstone A (Discovery Simulation)**; the FHIR integration + sovereign-inference design lands in Phases 4–5; the TCO/ROI (built on the §3 baseline) is Phase 7.
