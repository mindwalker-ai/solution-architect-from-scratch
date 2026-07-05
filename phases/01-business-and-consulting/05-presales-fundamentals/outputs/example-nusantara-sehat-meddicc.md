---
name: example-nusantara-sehat-meddicc
description: Worked MEDDICC Qualification Sheet for Nusantara Sehat (Indonesian hospital group) — a conditional bid with a first-pass value case and gap-closing plan
phase: 1
lesson: 5
audience: internal
---

# MEDDICC Qualification Sheet — Nusantara Sehat (worked example)

> This is `template-meddicc-qualification-sheet.md` filled in for a fictional customer. It shows what "good" looks like: an honest scorecard, a value case with a range and stated assumptions, and a bid decision that gates expensive design work on qualification — not on enthusiasm.

**Customer:** Nusantara Sehat (fictional) — Indonesian hospital group, 8 hospitals · 20 clinics · ~4,500 staff, modernising with AI
**Opportunity:** Unified Patient-Data Platform + AI clinician access + automated PDP compliance reporting
**Account Executive (owns the number):** A. Rahman  ·  **Solution Architect (owns the technical win):** You
**Date:** 2026-07-04  ·  **Version:** v0.3  ·  **Next re-qualify:** 2026-07-18 (2 weeks)

**RAG legend:** `[G]` known / strong · `[A]` partial / at-risk · `[R]` missing / blocked

---

## 1. MEDDICC scorecard

```
   MEDDICC QUALIFICATION SCORECARD — Nusantara Sehat
   Verdict: QUALIFIED BID (conditional)   ·   Confidence: medium
   ──────────────────────────────────────────────────────────────
   ELEMENT               RAG  ONE-LINE STATUS
   ──────────────────────────────────────────────────────────────
   M  Metrics           [A]   pain known; value not yet in Rp
   E  Economic buyer    [A]   CFO identified; not met directly
   D  Decision criteria [A]   technical known; weighting unclear
   D  Decision process  [R]   RFP steps + timeline UNKNOWN  ◀ fix first
   I  Identify pain     [G]   fragmentation · manual reporting · PDP
   C  Champion          [A]   CIO willing; untested + CMO detractor
   C  Competition       [A]   rival integrator + "do nothing"
   ──────────────────────────────────────────────────────────────
   GATING RULE HIT: Decision process is RED → deal capped at AMBER.
   No full PoC until it clears and Metrics is quantified.
```

## 2. Element-by-element detail

| Element | Evidence from discovery | RAG | Gap | Next action (owner · by when) |
|---|---|---|---|---|
| **M — Metrics** *(SA leads)* | Pains are known — reporting ~3 wks/cycle, fragmented data across ~12 systems, PDP exposure — but **no value has been quantified in Rp** or validated with finance. | `[A]` | No CFO-grade business case; only qualitative pain. | Run a value-engineering workshop with the CFO's finance lead to baseline labour hours, cycle time, and penalty exposure; agree the ROI model. *(SA · by Jul 16)* |
| **E — Economic buyer** *(AE)* | **CFO** controls the budget; the board approves in the annual capex cycle (Q4). We have met only the CIO — the CFO hears about us **second-hand**. | `[A]` | No direct EB access → single-threading risk. | AE requests a 30-min CFO briefing anchored on the value case; SA prepares the one-page exec business case. *(AE + SA · by Jul 18)* |
| **D — Decision criteria** *(Shared)* | Technical criteria partly known: unify patient data, automate PDP reporting, **data resident in Indonesia**. Scoring weights + non-technical criteria (local support, references, price weighting) unknown. | `[A]` | Don't know how the RFP is scored. | Obtain the RFP evaluation matrix from the CIO; shape criteria toward our differentiators (in-country residency, healthcare references). *(SA · by Jul 14)* |
| **D — Decision process** *(AE)* | Decision runs through a **procurement RFP**, but the steps, evaluation committee, timeline, and approval gates are unknown. | `[R]` | Biggest blind spot — we don't know *how or when* the decision is made. | CIO walks us through the procurement process, committee membership, key dates, and the paper process (PDP/DPA, security review). *(AE + SA · by Jul 11)* |
| **I — Identify pain** *(Shared)* | Three concrete, validated pains: fragmented patient data, manual compliance reporting (~3-wk cycles), PDP non-compliance risk. **Compelling event:** PDP enforcement + an upcoming reporting/audit deadline. | `[G]` | Minimal — keep quantifying (feeds M). | Tie each pain to a metric and a named owner in the value case. *(SA · ongoing)* |
| **C — Champion** *(AE + SA)* | **CIO** is a willing technical sponsor and wants the modernisation. But he is **untested** (hasn't sold for us when we're absent) and **unarmed** (no business case for the CFO). The **CMO** is a skeptical influencer who could block on clinician-trust / workflow grounds. | `[A]` | Champion unproven + an unaddressed detractor. | Arm the CIO with a one-page value case + a reference story; schedule a session to convert or neutralise the CMO's clinical-safety concerns. *(SA + AE · by Jul 18)* |
| **C — Competition** *(Shared)* | A **rival integrator** is in the deal and may have shaped the RFP earlier; plus the ever-present **"do nothing"** / no-decision. | `[A]` | Don't know the rival's angle or why they might defer. | Build a battlecard vs the rival; build the **cost-of-inaction** case (PDP risk grows, reporting stays manual) to beat no-decision. *(SA · by Jul 16)* |

## 3. Value-case worksheet (first pass — to validate with finance)

> This is a *first-pass estimate to open the conversation*, not a committed number. It is why Metrics is amber, not green: the base figures come from discovery interviews and public benchmarks and must be confirmed by the CFO's finance lead. Note the split between **hard** benefits (bankable), **risk-avoided** (real but probabilistic), and **soft** (excluded from the headline).

**Baseline — current-state cost of the pain:**

| Pain / cost driver | Formula (units × rate × frequency) | Low | Base | High | Type |
|---|---|---|---|---|---|
| Manual compliance-reporting labour | 6 analysts × Rp 25M/mo loaded × 50% time on manual wrangling × 12 mo | Rp 450M | Rp 900M | Rp 1.1B | Hard (baseline) |
| ↳ *recoverable via automation* (~70% of the above) | 0.7 × baseline | Rp 315M | **Rp 630M** | Rp 770M | **Hard benefit** |
| PDP penalty exposure avoided | Statutory exposure up to ~2% of annual revenue × modest probability reduction | Rp 200M | Rp 600M | Rp 2.0B | Risk-avoided |
| Clinician time from faster record access | 400 clinicians × ~8 min/day × 220 days × Rp 3,000/min loaded | Rp 1.0B | Rp 2.1B | Rp 3.0B | **Soft — excluded from headline** |

**Bankable annual value (hard + risk-avoided only):** Rp 0.5B – **Rp 1.2B** – Rp 2.8B/yr
**Order-of-magnitude investment (placeholder — real BOM in Phase 6):** ~Rp 8–12B over 3 years (build + licence + run)
**Headline for the CFO (one sentence):**
> Automating compliance reporting reclaims ~Rp 630M/yr of analyst time and materially cuts PDP penalty exposure; combined with a unified patient view, the modernisation pays back on hard-plus-risk value alone, before counting clinician productivity.

*Assumptions:* analyst count and loaded cost from the CIO interview (to confirm with HR/finance); 70% automation rate is a benchmark estimate (to validate in a scoping session); PDP exposure framed from the published statutory maximum (~2% of annual revenue) — used as *risk reduction*, not a booked saving; clinician-time value is deliberately **excluded** from the headline because saved minutes do not automatically convert to cash. Every base figure is *estimate-to-be-validated* pending the value-engineering workshop.

**Honest read:** the hard payback is real but modest against the investment; the deal's economic case leans heavily on **risk avoidance (PDP)** and the **strategic value of a unified patient view**. That is exactly why the CFO must see and shape the number herself — and why Metrics stays amber until she does.

## 4. Verdict & bid decision

- **Verdict:** **CONDITIONAL BID**  ·  **Confidence:** medium
- **Conditions that must clear before a full PoC:**
  1. **Decision process → at least amber** (we understand the RFP steps, committee, and dates)
  2. **Metrics → green** (value validated with the CFO's finance lead)
  3. **Economic buyer → we have secured a direct CFO briefing**
- **Gap-closing priority:**
  1. **Decision process (R):** CIO walkthrough — a red here can hide the fact that the RFP is pre-wired for the rival. *Fix first.*
  2. **Metrics (A → G):** value-engineering workshop — unlocks the CFO meeting (E).
  3. **Champion + Competition (A):** arm the CIO, address the CMO, build the "do nothing" cost case — in parallel.
- **Investment guardrail:** **no full PoC and no detailed LLD** until conditions 1–3 clear. We *will* invest in the value case and the champion enablement, because those are what make the deal real.

## 5. Re-qualify triggers

- [x] **Decision process still unknown** → scheduled CIO walkthrough (Jul 11)
- [ ] CFO briefing granted or refused → re-rate E immediately
- [ ] CMO converts, blocks, or stays silent → re-rate Champion/Competition
- [ ] Rival integrator's role in shaping the RFP confirmed → re-rate Competition
- [ ] Compelling event (audit/reporting deadline) moves → re-rate Identify pain and the whole timeline

---

**The pivot this sheet buys you:** instead of ten weeks designing a platform for a deal that quietly stalls, you spend two weeks making the deal *real* — mapping the decision process, quantifying the value with the CFO, arming the champion, and neutralising the detractor. Only then do you invest the design effort, now aimed at a buyer you know will decide. That is the SA qualifying, building the business case, and supporting the close — without ever carrying the quota.
