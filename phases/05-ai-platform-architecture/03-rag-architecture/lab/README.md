# Lab — Local RAG with Haystack: prove hybrid + rerank + cite-or-refuse

> **Goal:** validate the load-bearing claim of Lesson 5.3 on your laptop — that **hybrid retrieval + a reranker + a cite-or-refuse prompt** beats **naive top-k vector search** on a safety-style corpus. This is a *design-validation* lab, not a product. It runs on CPU, uses small local models, and needs no API keys.

## What you'll see

Two retrieval pipelines over a tiny corpus of fake Bumi Energi procedures:

1. **Naive** — vector-only top-k. Miss the exact equipment tag, return a plausible-but-wrong page.
2. **Advanced** — hybrid (embedding + BM25) → cross-encoder rerank → top-k. Return the right page.

Optionally, a **grounded generation** step (via a local Ollama model) that answers *only* from the retrieved sources and **cites** them — or refuses.

## Prerequisites

- Python 3.9+
- ~1.5 GB disk for the small embedding + reranker models (downloaded on first run)
- (Optional) [Ollama](https://ollama.com) for the generation step: `ollama pull llama3.2:3b`

## Setup (copy-run)

```bash
python -m venv .venv && source .venv/bin/activate
pip install "haystack-ai>=2.0" "sentence-transformers>=3.0"
```

## Step 1 — Build the corpus + both pipelines

Save as `rag_lab.py`:

```python
from haystack import Document, Pipeline
from haystack.document_stores.in_memory import InMemoryDocumentStore
from haystack.components.embedders import (
    SentenceTransformersDocumentEmbedder,
    SentenceTransformersTextEmbedder,
)
from haystack.components.retrievers.in_memory import (
    InMemoryEmbeddingRetriever,
    InMemoryBM25Retriever,
)
from haystack.components.joiners import DocumentJoiner
from haystack.components.rankers import TransformersSimilarityRanker

EMBED = "sentence-transformers/all-MiniLM-L6-v2"     # small, CPU-friendly
RERANK = "cross-encoder/ms-marco-MiniLM-L-6-v2"       # small cross-encoder

# --- A tiny, safety-style corpus. Note the EXACT equipment tags. ---
docs = [
    Document(content="SOP-4471 K-201 Compressor Maintenance: before opening the "
             "casing, isolate and perform a nitrogen purge for 10 minutes minimum "
             "until O2 reads below 1%.", meta={"doc": "SOP-4471", "page": 12}),
    Document(content="SOP-3300 K-105 Compressor Maintenance: nitrogen purge the "
             "casing for 6 minutes before opening.", meta={"doc": "SOP-3300", "page": 4}),
    Document(content="General purge guidance: purge durations vary by vessel "
             "volume; always follow the equipment-specific procedure.",
             meta={"doc": "GEN-001", "page": 2}),
    Document(content="SOP-4471 K-201 Lockout/Tagout: apply LOTO to all energy "
             "sources and verify zero energy before maintenance.",
             meta={"doc": "SOP-4471", "page": 9}),
]

store = InMemoryDocumentStore()
emb = SentenceTransformersDocumentEmbedder(model=EMBED)
emb.warm_up()
store.write_documents(emb.run(docs)["documents"])

# --- NAIVE: vector-only top-k ---
naive = Pipeline()
naive.add_component("q_emb", SentenceTransformersTextEmbedder(model=EMBED))
naive.add_component("retr", InMemoryEmbeddingRetriever(store, top_k=1))
naive.connect("q_emb.embedding", "retr.query_embedding")

# --- ADVANCED: hybrid (embedding + BM25) -> rerank -> top-k ---
adv = Pipeline()
adv.add_component("q_emb", SentenceTransformersTextEmbedder(model=EMBED))
adv.add_component("emb_retr", InMemoryEmbeddingRetriever(store, top_k=4))
adv.add_component("bm25_retr", InMemoryBM25Retriever(store, top_k=4))
adv.add_component("join", DocumentJoiner())
adv.add_component("rank", TransformersSimilarityRanker(model=RERANK, top_k=1))
adv.connect("q_emb.embedding", "emb_retr.query_embedding")
adv.connect("emb_retr", "join")
adv.connect("bm25_retr", "join")
adv.connect("join", "rank")

Q = "What is the nitrogen purge duration for the K-201 compressor?"

def show(name, docs):
    d = docs[0]
    print(f"[{name}] -> {d.meta['doc']} p.{d.meta['page']}: {d.content[:70]}...")

show("NAIVE ", naive.run({"q_emb": {"text": Q}, "retr": {}})["retr"]["documents"])
show("ADVNCD", adv.run({"q_emb": {"text": Q}, "bm25_retr": {"query": Q},
                        "rank": {"query": Q}})["rank"]["documents"])
```

Run it:

```bash
python rag_lab.py
```

**Expected shape of the result:** naive vector-only often grabs the *general* guidance or the *wrong* compressor (K-105) because "nitrogen purge compressor" is semantically close to several docs; the advanced pipeline's **BM25 leg locks onto the exact tag `K-201`** and the **reranker** promotes `SOP-4471 p.12` — the correct page. That gap *is* the lesson: on exact-token, safety-critical corpora, hybrid + rerank is not optional.

## Step 2 (optional) — Grounded, cited generation

With Ollama running (`ollama pull llama3.2:3b`), feed the top reranked chunk to a local model under the **cite-or-refuse** contract:

```python
from haystack_integrations.components.generators.ollama import OllamaGenerator  # pip install ollama-haystack

PROMPT = (
    "Answer using ONLY the source below. Cite it as [doc, page]. "
    "If the source does not contain the answer, say you don't know.\n\n"
    "SOURCE [{doc}, p.{page}]: {content}\n\nQUESTION: {q}\nANSWER:"
)
top = adv.run({"q_emb": {"text": Q}, "bm25_retr": {"query": Q},
               "rank": {"query": Q}})["rank"]["documents"][0]
gen = OllamaGenerator(model="llama3.2:3b")
print(gen.run(prompt=PROMPT.format(doc=top.meta["doc"], page=top.meta["page"],
                                   content=top.content, q=Q))["replies"][0])
```

**What to verify:** the answer states *10 minutes* **and** carries `[SOP-4471, p.12]`. Then ask something the corpus can't answer (e.g. *"purge time for the K-999 turbine?"*) and confirm the model **refuses** instead of inventing — the anti-hallucination contract at work.

## What this proves (and what it doesn't)

- **Proves:** the *architecture* choices in the lesson (hybrid, rerank, cite-or-refuse) change retrieval precision and answer grounding in a way you can observe — the defensible core of the reference architecture.
- **Does not prove:** production latency, GPU sizing at 200 concurrent (that's **5.5**), OCR quality on real scans, or ACL enforcement (that's a metadata filter you'd add to the retrievers). Those are design claims you *size and defend*, not laptop benchmarks.
