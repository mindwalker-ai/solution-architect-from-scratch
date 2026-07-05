---
name: sa-lifecycle-canvas-example-meridian
description: Worked SA Lifecycle Canvas for the fictional Meridian Regional Bank private-AI-assistant deal — shows what good exit criteria look like and where a real deal gets disqualified or de-risked.
phase: 0
lesson: 6
audience: internal
version: 1.0.0
---

# SA Lifecycle Canvas — Worked Example: Meridian Regional Bank

A filled-in canvas for the lesson's fictional inbound deal. It shows what real exit
criteria read like, where the **Qualify** gate nearly killed the deal, and how the
constraint discovered on day one (data residency) shaped every downstream artifact.

> Fictional customer. Numbers are illustrative and stated as ranges, not magic figures.

## Deal header

| Field | Value |
|-------|-------|
| Customer | Meridian Regional Bank |
| Industry / segment | Retail banking · regulated · 2.1M customers, ~90 branches |
| Lead source | Inbound — RM attended "Private AI for Regulated Industries" webinar |
| RFx in play | None yet (we are shaping — aim to influence the eventual RFP) |
| Account Executive (owner) | A. Rahman |
| Solution Architect (you) | — |
| Deal size (rough) | ~$1.4–1.9M (platform build + year-1 support) |
| Target decision date | Board sign-off, Q4 |

## The canvas

| # | Stage | Objective / activity | Artifact produced | Exit criteria (gate to advance) | Owner | Status |
|---|-------|----------------------|-------------------|---------------------------------|-------|--------|
| 1 | **Lead** | Confirm inbound is real; book discovery | Qualified-lead note | Sponsor = Head of Digital; AE assigned; on-prem AI is our sweet spot | AE + SA | ✅ |
| 2 | **Discovery** | 2 workshops: call-centre + RM workflow, compliance, existing stack (Temenos core, Salesforce CRM) | Discovery notes; current/future state | **Metric = avg handle-time (target −20%)**; **hard constraint = no customer data off-shore / no public LLM API** documented | SA | ✅ |
| 3 | **Qualify (MEDDICC)** | Score winnability; find the real signer | MEDDICC scorecard + bid/no-bid | Economic buyer = **COO** (not the RM); champion = Head of Digital; on-prem constraint *disqualifies the SaaS competitor* → **BID** | SA + AE | ✅ |
| 4 | **Solution Design (HLD→LLD)** | Design on-prem private-AI platform meeting every decision criterion | HLD → LLD | HLD: K8s + GPU nodes + vLLM/Ollama + vector DB + RAG over policy docs + read-only Temenos/Salesforce connectors; **every decision criterion mapped** | SA | ◐ |
| 5 | **Sizing & BOM** | Size GPUs for concurrency + storage for the index; price line items | Sizing sheet + BOM | ~150 concurrent users at <3s p95 → sizing shows GPU/RAM/storage with assumptions **and a range**; BOM priced + sanity-checked | SA | ◐ |
| 6 | **PoC** | 4-week PoC on 500 redacted real policy docs, 20 pilot agents | PoC plan + success criteria + results | Pre-agreed: answer accuracy ≥ 85% on a graded question set **and** handle-time down on the pilot cohort | SA + customer | ⬚ |
| 7 | **Proposal & Pricing** | Package why-us / why-now / ROI for the COO + board | Proposal + exec summary + TCO/ROI | 3-year TCO vs handle-time saving shows payback < 18 months; buyer confirms fit | SA + AE | ⬚ |
| 8 | **Demo** | Show the assistant answering a real Meridian policy question, on-prem | Demo script + environment | **COO** (decision-maker), not just the champion, has seen it live | SA | ⬚ |
| 9 | **Negotiate** | Land phase-1 scope (call-centre first, RMs in phase 2) to de-risk delivery | Revised BOM / SOW + negotiation plan | Scope, price, phasing, SLAs agreed; verbal commit before board | AE + SA | ⬚ |
| 10 | **Handoff** | Transfer buildable design to delivery | LLD + runbook + implementation plan + handoff notes | Delivery signs off design as buildable as-sold; no open compliance risk | SA → Delivery | ⬚ |

## The Qualify gate — bid / no-bid decision (stage 3)

| MEDDICC element | What you know | Green / Red |
|-----------------|---------------|-------------|
| **M**etrics | Avg handle-time −20%; ~150 agents; a plausible ~$0.9M/yr productivity saving | 🟢 |
| **E**conomic buyer | **COO** owns operations budget and the board slot — *not* the RM who filled the webinar form | 🟢 (found late — was a 🔴 risk on day 1) |
| **D**ecision criteria | Data stays on-shore; integrates with Temenos + Salesforce; auditable answers | 🟢 (and it *excludes* the public-cloud competitor) |
| **D**ecision process | Head of Digital → CIO tech review → COO → board sign-off in Q4 | 🟢 |
| **I**dentify pain | Regulator flagged inconsistent customer advice; a compelling, dated event | 🟢 |
| **C**hampion | Head of Digital — credible, has budget influence, wants a win | 🟢 |
| **C**ompetition | A public-cloud AI-SaaS vendor is circling — but can't meet the residency rule | 🟢 (our constraint is their disqualifier) |

**Decision:** ✅ **BID** — winnable *and* worth winning. The residency constraint that first
looked like a problem is our moat: it disqualifies the SaaS competitor and points straight
at the private-AI architecture this track is built to design.

## Artifact-chain checklist

- [x] Discovery notes
- [x] HLD (High-Level Design)
- [ ] LLD (Low-Level Design)
- [x] Sizing sheet *(draft — GPU/storage ranges)*
- [x] BOM (Bill of Materials) *(draft)*
- [ ] TCO / ROI model
- [ ] Proposal + executive summary
- [ ] Demo (script + environment)
- [ ] Handoff pack (LLD + runbook + implementation plan)

## Notes / running log

- **Day 1 (Discovery):** Nearly ran to design on the RM's enthusiasm. Discovery revealed
  the RM has no budget authority — parked "who signs?" as the top open question, which the
  Qualify gate then resolved to the COO. *Lesson: the loudest voice is rarely the economic buyer.*
- **Constraint drives everything:** "No customer data off-shore / no public LLM API" was
  written down at Discovery and became the single most important line in the HLD, the BOM
  (GPUs to buy, not tokens to rent), and the win theme in the proposal.
- **Where this deal teaches the rest of the track:** the HLD/BOM/sizing come from Phases
  2–6; the GPU sizing sheet is Phase 5; the TCO/ROI and proposal are Phase 7. Two links this
  learner can't yet produce — the GPU sizing sheet and the TCO/ROI — are exactly what
  **Capstone E** (Private AI Platform) and **Capstone F** (Transformation Proposal) prove.
