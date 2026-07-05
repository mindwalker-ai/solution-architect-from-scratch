---
name: template-data-ai-concept-map
description: A one-page Data & AI concept map (diagram + term→plain-English table + "map the ask" worksheet) to align a customer on vocabulary before scoping an AI deal
phase: 0
lesson: 5
audience: customer
---

# Data & AI Concept Map — Template

> Hand this to the room at the *start* of AI discovery. Its only job is to give everyone
> one shared vocabulary so nobody leaves thinking "the LLM already knows our data" or
> "we need to fine-tune." Fill the blanks, keep it to one page.

**Customer:** `<name>`
**Prepared by:** `<SA name>` · **Date:** `<date>`
**The ask, in the customer's words:** `<paste the verbatim ask>`

---

## 1. The one-page picture

```
                        ┌──────────────────────────────────────────────┐
                        │              RAW DATA  (the fuel)            │
                        │   JSON · YAML · CSV · PDFs · logs · records  │
                        └───────────────┬──────────────┬───────────────┘
             structured / rows          │              │   unstructured / text
                                        ▼              ▼
        ┌───────────────────────────────────┐   ┌───────────────────────────┐
        │             DATABASES             │   │         DOCUMENTS         │
        │  SQL (Postgres)   NoSQL (Mongo)   │   │  policies, contracts,     │
        │  OLTP: writes     OLAP: analytics │   │  tickets, wiki, email     │
        └───────────────┬───────────────────┘   └────────────┬──────────────┘
                        │  query / report                    │  chunk → embed
                        ▼                                     ▼
                 ┌────────────┐                        ┌───────────────────┐
                 │ dashboards │                        │  EMBEDDINGS        │
                 │  & apps    │                        │  (vectors) stored  │
                 └────────────┘                        │  in a VECTOR DB    │
                                                       └─────────┬──────────┘
                                                                 │ retrieve top-k
                                                                 ▼
              question ──►  [ RAG:  prompt = instructions + retrieved context ]  ──►  LLM  ──►  answer
                                        ▲                                                 │
                                        └──────── tokens fill the context window ─────────┘
```

*Training happens off this page — in a lab, once, to make the model exist. Everything shown here is **inference**.*

## 2. Term → plain-English (the shared vocabulary)

| Term | Say this to the customer |
|------|--------------------------|
| **LLM** | A text predictor. It does **not** know your data until we put your data in front of it. |
| **Training vs inference** | Training *builds* the model (rare, expensive). Inference *uses* it (constant, cheap). You pay for inference. |
| **Prompt / token / context window** | The text we send the model; it's billed per token and can only "see" what fits in its context window. |
| **Embedding** | A way to turn text into numbers that capture meaning, so we can search by meaning, not keywords. |
| **Vector database** | The store that holds those embeddings and finds the most relevant passages fast. |
| **RAG** | Retrieve *your* relevant text and paste it into the prompt so the answer is grounded in your data, with citations. |
| **Fine-tuning** | Retraining the model to change its *style/skill* — usually **not** how we add facts (that's RAG). |
| **SQL / NoSQL / OLTP / OLAP** | Where structured facts live: SQL tables (default), NoSQL for flexible data; OLTP for transactions, OLAP for analytics. |

## 3. "Map the ask" worksheet

Fill one row per capability the customer wants.

| Question the customer wants answered | Structured lookup or language/RAG? | Component(s) needed | Data source | What could go wrong |
|---|---|---|---|---|
| `<e.g. "what's this policy's refund window?">` | `<lookup / RAG>` | `<SQL DB / vector DB + LLM>` | `<system of record>` | `<stale data, hallucination, PII...>` |
| | | | | |
| | | | | |

## 4. Data-readiness check (the make-or-break, done before promising anything)

- [ ] Documents/data are **machine-readable** (real text, not scanned images needing OCR)
- [ ] They are **current** (superseded versions are removed or flagged)
- [ ] They are **de-duplicated** (no three conflicting copies across systems)
- [ ] **Access/permissions** are known and preservable (who may see what)
- [ ] There is a **ground truth** to measure accuracy against, and an agreed **success metric**

## 5. How we'll teach the model (pick the cheapest that works)

- [ ] **Prompting** — instructions only (tone, format, simple tasks)
- [ ] **RAG** — the model needs *your facts*, they change, and you want citations ← usual answer for "chat with our data"
- [ ] **Fine-tuning** — only if prompting + RAG can't hit the bar (consistent house style, niche skill, latency/cost at very high volume)

## 6. Honest scope note (say the quiet part)

> `<Restate the ask as an architecture: "This is a RAG solution, not model training — weeks not months, modest inference hardware.">`
> `<Name the real risk: "The make-or-break is data readiness.">`
> `<Refuse the un-scopeable number: "'95% accuracy on everything' isn't committable until we define what we measure. Propose a PoC on the top-N items with a measurable bar.">`

---

*A fully worked version of this template for a fictional customer is in
[`example-data-ai-concept-map.md`](./example-data-ai-concept-map.md).*
