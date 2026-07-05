---
name: template-model-selection-matrix
description: Model-Selection Matrix — the confidentiality gate, a six-column candidate comparison (quality/context/license/VRAM/quantization/latency), a right-sizing fleet, and a defended verdict + fallback for an LLM platform
phase: 5
lesson: 1
audience: customer | internal | executive
---

# Model-Selection Matrix (Template)

> Fill this in the moment "which model?" is on the table — before RAG design (5.3), before GPU sizing (5.5). Work the sections **in order**: the gate decides the shelf, the axes rank the survivors, your eval picks the winner. An executive should grasp the gate and the verdict; an engineer should trust the VRAM and license columns. This is *choose-and-defend*, not a serving runbook.

**Customer:** `<company>`  ·  **Prepared by:** `<SA name>`  ·  **Date:** `<YYYY-MM-DD>`
**Opportunity:** `<deal / project name>`  ·  **Version:** `<v0.1 draft>`
**Decisive constraint:** `<e.g. absolute confidentiality / latency target / cost ceiling>` ← this drives the gate in §2.

Legend: **open-weight** = weights you self-host (≠ open-source) · **closed API** = vendor-hosted, data leaves your premises · **quant** = quantization (FP16/INT8/INT4, the size↔quality lever) · **VRAM ≈ params × bytes/param** (INT4 = 0.5 B/param) + ~20–40% KV/overhead · verdict = **eval-confirmed**, not leaderboard.

---

## How to use this template

1. **Requirements** — capture the numbers that bound the choice (users, concurrency, latency, data sensitivity, budget, team size).
2. **The gate** — can the data go to a public LLM API? This alone decides open-weight vs closed *before* quality.
3. **Candidate matrix** — score every model on the same six columns; strike anything the gate disqualifies.
4. **Right-size the fleet** — a quality-critical primary + a small utility model + a fallback. Don't run one giant model for everything.
5. **Quantization & VRAM** — set the precision (default INT4; INT8 if a safety/quality eval demands it) and the resulting footprint.
6. **Latency vs GPU cost** — sanity-check the latency target; hand the GPU *count* to the sizing lesson (5.5).
7. **Decision log** — record the verdict, the fallback, and what you rejected and why.

---

## 1. Requirements (what bounds the choice)

| Requirement | Value | Why it matters to model choice |
|---|---|---|
| Named users / concurrency | `<N users / M concurrent>` | Sets serving scale (→ 5.5) |
| Answer latency target | `<~Ns>` | Caps how big a model you can run |
| **Data sensitivity** | `<public / internal / confidential / regulated>` | **Decides the gate (§2)** |
| Cost posture | `<cost-sensitive / balanced / quality-first>` | Weights GPU vs quality trade-off |
| Team capacity | `<small / medium ML+platform team>` | Favors off-the-shelf instruct + RAG over fine-tuning |
| Accuracy stakes | `<informational / business-critical / safety-critical>` | Sets quantization floor + eval rigor |
| Languages / domain | `<languages; domain>` | Task-shaped quality — general benchmarks won't measure it |

## 2. The gate — open-weight vs closed API

> One binary question, answered first.

**Can this customer's data leave the premises / go to a public LLM API?**  `<YES / NO>`

- **YES →** closed APIs are in play (best quality, zero GPU ops, per-token cost). Still compare against self-host on TCO + lock-in.
- **NO →** **self-host open-weight on hardware you control.** All closed APIs are disqualified regardless of quality. `<state it in one sentence for the room>`

**Shelf chosen:** `<open-weight self-hosted / closed API / hybrid>` — **because** `<the decisive constraint>`.

## 3. Candidate matrix (same six columns for every model)

> Score, then strike anything the gate rules out. Fill the QUALITY column from *your eval shortlist*, not a raw leaderboard.

| Candidate | Params | Context | License | VRAM @ `<quant>` | ~Latency | Self-host? | Quality (your eval) | Verdict |
|---|---|---|---|---|---|---|---|---|
| `<GPT-4o / Claude / Gemini>` | n/a | `<128K–1M>` | closed API | n/a | low | **✗ vendor** | `<n/a>` | `<✗ gate>` |
| `<Llama 3.3 70B-Instruct>` | 70B | 128K | Llama Community | `<~40 GB>` | `<~6–16s>` | ✓ | `<score>` | `<primary / fallback>` |
| `<Qwen2.5-72B-Instruct>` | 72B | 128K | Qwen License | `<~40 GB>` | `<~6–16s>` | ✓ | `<score>` | `<primary / fallback>` |
| `<Mistral Small 3 (24B)>` | 24B | 128K | Apache 2.0 | `<~14 GB>` | `<faster>` | ✓ | `<score>` | `<mid-tier?>` |
| `<Gemma 3 27B>` | 27B | 128K | Gemma Terms | `<~16 GB>` | `<faster>` | ✓ | `<score>` | `<mid-tier?>` |
| `<Qwen2.5-7B-Instruct>` | 7B | 128K | Apache 2.0 | `<~5 GB>` | `<fast>` | ✓ | `<score>` | `<utility>` |

*Rules of thumb:* MoE models keep **all** experts in VRAM (memory ∝ total params) though only some fire per token (speed ∝ active params). Avoid heavy **reasoning** models on the latency-bound answer path.

## 4. Right-size the fleet (not one giant model for everything)

| Role | Model | Quant | ~VRAM | License | Why this role |
|---|---|---|---|---|---|
| **Primary (quality-critical)** | `<~70B-class instruct>` | `<INT4 / INT8>` | `<~40 GB>` | `<license>` | Final, cited, high-stakes answers |
| **Small utility (lightweight)** | `<7–8B instruct>` | INT4 | `<~5 GB>` | `<license>` | Rewrite / route / classify / summarize — keeps big GPU free |
| **Fallback primary** | `<license-diverse 70B>` | INT4 | `<~40 GB>` | `<license>` | Resilience: swap without re-architecting |
| **Embedding** (→ 5.2) | `<retrieval model>` | — | small | `<license>` | Seam reserved; chosen with the vector store |

## 5. Quantization & VRAM

```
 VRAM(weights) ≈ params × bytes-per-param     (FP16=2.0 · INT8=1.0 · INT4=0.5)
 + KV cache & runtime overhead: add ~20–40% (grows with context × concurrency)

 Primary <params>B @ <quant> ...... ~<X> GB  → fits <N>× <GPU model / VRAM>
 Default: INT4 (Q4_K_M / AWQ). Step up to INT8 only if the safety/quality eval
 (5.6) shows INT4 degrades the critical question set. Never below INT4 for
 business-/safety-critical answers.
```

## 6. Latency vs GPU cost (sanity-check, then hand to 5.5)

```
 <params>B @ <quant>, single stream ... ~<t>–<t> tokens/sec (assumption)
 Answer length ........................ ~<n> tokens (assumption)
 Single-stream generation ............. ~<t>s  vs target ~<N>s
 Levers to hit target: INT4 · vLLM continuous batching · cap+stream tokens ·
   small model absorbs non-answer tasks.
 → Model choice makes the target FEASIBLE; the GPU COUNT at <M> concurrent = 5.5.
```

## 7. Decision log

| # | Decision | Alternative rejected | Why | Owner |
|---|---|---|---|---|
| 1 | `<shelf: self-host open-weight>` | `<closed API>` | `<the gate — data sensitivity>` | SA |
| 2 | `<primary model + quant>` | `<other 70B / FP16>` | `<quality/latency/VRAM/license>` | SA |
| 3 | `<primary + small utility fleet>` | `<one model for everything>` | `<GPU cost; right tool per task>` | SA |
| 4 | `<named fallback model>` | `<single-model dependency>` | `<license/supply-chain resilience>` | SA |
| 5 | `<verdict confirmed by eval (5.6)>` | `<leaderboard rank>` | `<contamination/task-mismatch>` | SA |

**One-sentence defense (fill in):**
> Because `<decisive constraint>`, we `<self-host open-weight / use closed API>` — a `<primary>` at `<quant>` for `<the high-stakes job>`, a `<small model>` for the cheap tasks, and a `<fallback>` for resilience — a fleet that fits the `<budget>`, keeps `<latency target>` in reach, and clears the license review, with the final pick confirmed by our own eval, not a leaderboard.

**Handoffs:** embedding + vector store → **5.2** · RAG pipeline → **5.3** · GPU count & serving → **5.5** · eval + guardrails → **5.6** · platform → **Capstone E**.

---

*Worked example: see `example-bumi-energi-model-selection.md` in this folder.*
