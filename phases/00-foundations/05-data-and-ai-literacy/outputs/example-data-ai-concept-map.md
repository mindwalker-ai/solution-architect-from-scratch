---
name: example-data-ai-concept-map
description: Worked example of the Data & AI concept map for a fictional insurer (Sentinel Mutual) taking "chat with our 4,000 policy documents" from ask to labeled RAG pipeline and an honest scope
phase: 0
lesson: 5
audience: customer
---

# Data & AI Concept Map — Worked Example: Sentinel Mutual

**Customer:** Sentinel Mutual (mid-size insurer, ~1,200 staff)
**Prepared by:** A. Rahman (Solution Architect) · **Date:** 2026-07-04
**The ask, in the customer's words:** *"We want an AI that answers questions about our 4,000 policy documents — 95% accuracy across everything, live in six weeks."*

---

## 1. The one-page picture (annotated for Sentinel)

```
                        ┌──────────────────────────────────────────────┐
                        │        RAW DATA — Sentinel's 4,000 docs      │
                        │  PDFs (some scanned!) · DOCX · SharePoint    │
                        └───────────────┬──────────────┬───────────────┘
             structured / rows          │              │   unstructured / text
                                        ▼              ▼
        ┌───────────────────────────────────┐   ┌───────────────────────────┐
        │   Policy admin DB (Postgres)      │   │   Policy WORDINGS &        │
        │   OLTP: premiums, status          │   │   endorsements (the docs) │
        └───────────────┬───────────────────┘   └────────────┬──────────────┘
                        │  exact lookups                      │  chunk → embed
                        ▼                                     ▼
                 ┌────────────┐                        ┌───────────────────┐
                 │ agent apps │                        │  EMBEDDINGS in a   │
                 │ dashboards │                        │  VECTOR DB (Qdrant)│
                 └────────────┘                        └─────────┬──────────┘
                                                                 │ retrieve top-k
                                                                 ▼
       "What's P-1041's refund window?" ─► [ RAG: instructions + retrieved wording ] ─► LLM ─► answer + cite
```

## 2. Term → plain-English (used live in the room)

Delivered verbatim from the template's table. The two that landed hardest with Sentinel's team:

- **"The LLM does not already know your policies."** It's a text predictor trained on the public web; we feed it your wordings at question time (that's RAG). This killed the assumption that we'd "just upload the docs and it learns them."
- **"Fine-tuning ≠ adding facts."** Their IT lead had scoped "fine-tune GPT on our policies." We showed that RAG is cheaper, updates the moment a wording changes, and can cite the exact policy id — which their compliance team requires.

## 3. "Map the ask" worksheet (filled)

| Question the customer wants answered | Lookup or RAG? | Component(s) | Data source | What could go wrong |
|---|---|---|---|---|
| "What is policy P-1041's refund window?" | **Lookup** (exact field) | Postgres query | Policy admin DB | Answering from a doc instead of the system of record → wrong number |
| "Summarize the cancellation terms in plain English." | **RAG** | Vector DB + LLM | Policy wordings | Retrieval pulls the wrong/old wording → confidently wrong answer |
| "Does this wording cover flood damage?" | **RAG** | Vector DB + LLM | Policy wordings | Scanned PDF never got OCR'd → chunk is empty → no answer |
| "Which policies expire in March?" | **Lookup** (analytical) | Postgres / OLAP query | Policy admin DB | Not an AI question at all — don't over-engineer it into RAG |

## 4. Data-readiness check (what we actually found)

- [x] Machine-readable — **partly.** ~30% of the 4,000 are **scanned PDFs** needing OCR. *This is the schedule risk, not the AI.*
- [ ] Current — **no.** Superseded endorsements live alongside active ones; nothing flags which wording is in force.
- [ ] De-duplicated — **no.** Same wording exists in two SharePoint sites with minor differences.
- [x] Access/permissions — known; broker-only wordings must not leak to policyholders (needs metadata filtering in the vector DB).
- [ ] Ground truth / success metric — **none yet.** No labeled set of "right answers" exists to measure accuracy against.

**Verdict:** the model is the easy part; the data cleanup and a labeled eval set are the real work.

## 5. How we'll teach the model

- [ ] Prompting — used for tone and the "cite the policy id, refuse if unsure" behavior.
- [x] **RAG** — the core: retrieve Sentinel's wordings, answer from them, cite the source. Updates instantly when a wording changes.
- [ ] Fine-tuning — **not now.** Revisit only if answer *style* is inconsistent after RAG is tuned.

Model choice: **open-weight, self-hosted** (data-residency — insurance policy data stays inside Sentinel's cloud), fronted by an AI gateway so the model can be swapped later. (Detailed model selection is a Phase 5 exercise.)

## 6. Honest scope note (delivered)

> "What you're describing is a **RAG** assistant, not a trained model — so it's **weeks, not months**, and it runs on modest inference hardware, self-hosted to keep policy data in your tenant.
>
> The critical path is **data readiness**: ~30% of your documents are scanned and need OCR, active vs superseded wordings aren't flagged, and there are duplicate copies. Fixing that is most of the timeline.
>
> **'95% accuracy across everything' is not a number I can sign up to** until we agree what 'accuracy' means and build a labeled test set to measure it. What I'd propose instead: a **4-week PoC** over your **200 most-queried active policies**, with a pre-agreed success bar (e.g. 'correct, grounded, cited answer on 90% of a 100-question test set, zero broker-only leaks'). Land that, then scale to all 4,000."

**Outcome:** Sentinel agreed to the scoped PoC and a data-readiness workstream — a defensible deal instead of a six-week promise nobody could keep.
