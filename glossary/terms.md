# Glossary

What people **say** vs what things **actually mean** — the presales and architecture jargon, decoded.

> Format: each term has a **What people say** line (the loose/marketing usage) and a **What it actually means** line (the working definition an architect uses). Contributions welcome — keep the two-line shape so the site can parse it.

---

### HLD (High-Level Design)

**What people say:** "The architecture document."
**What it actually means:** The solution at the level of components, data flows, and integrations — enough for a stakeholder to understand and approve the shape, without implementation detail.

### LLD (Low-Level Design)

**What people say:** "The detailed architecture."
**What it actually means:** The build-ready spec — exact instance types, IPs, configs, versions, and runbooks — that an engineer can implement without guessing.

### BOM (Bill of Materials)

**What people say:** "The price list."
**What it actually means:** The itemized inventory of everything the solution needs — hardware, software licenses, cloud SKUs, support — that a sizing exercise produces and pricing is built on.

### Sizing

**What people say:** "How big does it need to be?"
**What it actually means:** Translating workload requirements (users, throughput, data volume, latency, GPU tokens/sec) into concrete capacity, with stated assumptions and headroom — the difference between a proposal that works and one that fails at go-live.

### TCO (Total Cost of Ownership)

**What people say:** "The cost."
**What it actually means:** The full multi-year cost including hardware, licenses, cloud, power, people, and migration — not just the sticker price of the first invoice.

### ROI (Return on Investment)

**What people say:** "It'll pay for itself."
**What it actually means:** A quantified business case — value created or cost avoided, minus TCO, over a defined period — that an executive can defend to a CFO.

### Discovery

**What people say:** "The first meeting."
**What it actually means:** A structured process of stakeholder interviews and workshops that surfaces the real pain, current state, and desired future state — before any architecture is drawn.

### MEDDICC

**What people say:** "A sales checklist."
**What it actually means:** A qualification framework (Metrics, Economic buyer, Decision criteria/process, Identify pain, Champion, Competition) that tells you whether a deal is real and winnable.

### Landing Zone

**What people say:** "The cloud setup."
**What it actually means:** A pre-configured, multi-account cloud baseline — identity, network, guardrails, logging — that every workload lands into, so governance is built in rather than bolted on.

### Lakehouse

**What people say:** "Lake plus warehouse."
**What it actually means:** A single storage layer (open table formats like Iceberg) that serves both cheap raw-data storage and warehouse-grade SQL analytics, avoiding two copies of the data.

### RAG (Retrieval-Augmented Generation)

**What people say:** "Chat with your documents."
**What it actually means:** An architecture that retrieves relevant context from a vector store and feeds it to an LLM at inference time, so answers are grounded in the customer's data instead of the model's training memory.

### GPU Sizing

**What people say:** "How many GPUs do we need?"
**What it actually means:** Deriving VRAM and throughput requirements from model size, quantization, context length, batch size, and target tokens/sec — the calculation that determines whether an AI proposal is affordable.

### Zero Trust

**What people say:** "Never trust, always verify."
**What it actually means:** An architecture with no implicit network trust — every request is authenticated, authorized, and encrypted regardless of origin — replacing the old "hard shell, soft center" perimeter.

### PoC (Proof of Concept)

**What people say:** "A quick demo."
**What it actually means:** A scoped, time-boxed exercise with pre-agreed success criteria that proves the solution solves the customer's specific problem — de-risking the deal for both sides.

### Embedding

**What people say:** "It converts text to numbers."
**What it actually means:** A vector that captures a piece of text's meaning, so similar meanings sit close together — the basis for semantic search and the retrieval half of RAG.

### Vector Database

**What people say:** "A database for AI."
**What it actually means:** A store optimized for similarity search over embeddings (Milvus, Qdrant, pgvector) — it finds the most relevant chunks to feed an LLM, and is the retrieval engine behind RAG.

### Inference vs Training

**What people say:** "Running the AI."
**What it actually means:** Inference is using a finished model to answer (cheap, per-request, constant); training is building the model's weights (expensive, rare). Most enterprise AI spend is inference, and most value comes from RAG around it — not training your own model.

### Fine-tuning

**What people say:** "Teach the model our data."
**What it actually means:** Retraining a model's weights to change its style or skill — not the usual way to add facts (that's RAG). Reach for it when you need a consistent format or behavior, not fresh knowledge.

### Token / Context Window

**What people say:** "How much text it can read."
**What it actually means:** Tokens are the word-pieces an LLM processes and bills for; the context window is the most it can hold at once. Both are direct cost and latency levers in an AI proposal.

### MECE

**What people say:** "Break the problem down."
**What it actually means:** Mutually Exclusive, Collectively Exhaustive — a decomposition where the pieces don't overlap and together cover the whole. It's how a consultant frames a problem so nothing is double-counted and nothing is missed.

### RFx (RFI / RFP / RFQ)

**What people say:** "The tender documents."
**What it actually means:** The family of buyer procurement requests: an RFI explores the market and shortlists, an RFP asks for a solution + price against a business need, an RFQ asks only for a price against a fixed spec. Knowing which one you're in tells you whether the solution is still yours to shape.

### System of Record (SoR)

**What people say:** "The main system."
**What it actually means:** The authoritative source for a given data domain (e.g. the HIS for patient data, the ERP for finance). Every integration and every "single view" design starts by naming which system owns which data — get this wrong and you duplicate or corrupt the truth.

### Win Theme

**What people say:** "Our key messages."
**What it actually means:** A small set of claims that tie a specific customer pain to your differentiator and back it with proof. Win themes turn an RFP response from a compliance checklist into an argument for why you — and they thread through the proposal, demo, and executive pitch.

### RTO / RPO

**What people say:** "The recovery numbers."
**What it actually means:** RTO (Recovery Time Objective) = how long you can be down; RPO (Recovery Point Objective) = how much data you can afford to lose (the age of the last good copy). They're set per workload tier and drive the entire DR design — a near-zero RPO over a long distance is physically impossible with synchronous replication.

### IOPS

**What people say:** "Storage speed."
**What it actually means:** Input/Output Operations Per Second — the *transaction* rate a storage system sustains, distinct from throughput (MB/s) and capacity (TB). A database is usually IOPS-bound; a backup is throughput-bound. Sizing storage on capacity alone is how designs end up fast-full or slow.

### Overcommit

**What people say:** "Squeeze more VMs on."
**What it actually means:** Allocating more virtual CPU/RAM to guests than the host physically has, betting they won't all peak at once. It saves money on general workloads but is dangerous for latency-critical ones (payments, databases) — the ratio is a per-tier design decision, not a global switch.

### Hyperconverged Infrastructure (HCI)

**What people say:** "Compute and storage in one box."
**What it actually means:** An architecture where compute, storage, and often networking are pooled from the same commodity nodes and managed by software (Nutanix, VMware vSAN), instead of a separate SAN. It simplifies operations and scales linearly, but couples compute and storage growth — a trade-off to weigh against disaggregated designs.

### FinOps

**What people say:** "Cloud cost cutting."
**What it actually means:** The operating practice of managing cloud spend as a shared engineering + finance responsibility — Inform (visibility, tagging, showback), Optimize (rightsizing, autoscaling, spot, commitments), Operate (governance) — measured in unit economics like cost per order, not just a total bill.

### The 6 R's

**What people say:** "Move it to the cloud."
**What it actually means:** The six migration dispositions for each workload — Rehost (lift-and-shift), Replatform (lift-and-tinker), Refactor (re-architect), Repurchase (swap for SaaS), Retire (switch off), Retain (leave it). Naming the R for every app is what turns "migrate to cloud" from a slogan into a plan.

### Multi-Cloud vs Hybrid Cloud

**What people say:** "It's all just cloud."
**What it actually means:** Two orthogonal choices. Hybrid = on-prem/private + public together (usually for residency, DR, or existing investment). Multi-cloud = two or more public clouds (for leverage, best-of-breed, or resilience). Each has legitimate uses and expensive anti-patterns (gratuitous multi-cloud; a lowest-common-denominator abstraction that throws away what you paid for).

### Well-Architected Framework

**What people say:** "Cloud best practices."
**What it actually means:** A provider's structured review lens (AWS Well-Architected, Azure WAF, Google Cloud Architecture Framework) across pillars like operational excellence, security, reliability, performance, cost, and sustainability. An SA uses it as a checklist to pressure-test a design and to frame trade-offs for the customer.

### CDC (Change Data Capture)

**What people say:** "Sync the database."
**What it actually means:** Capturing every insert/update/delete by reading the database's transaction log (e.g. Debezium reading the WAL) and streaming it as events — the clean way to unlock an operational database for analytics without polling it or making the app dual-write (both of which drift or add load).

### Medallion Architecture

**What people say:** "Layers in the data lake."
**What it actually means:** A convention that refines data through three zones — Bronze (raw, as-ingested), Silver (cleaned, conformed, deduplicated), Gold (business-ready aggregates/marts). Each layer has a clear job, so quality and trust increase as data flows toward the consumers.

### Data Governance

**What people say:** "Rules for data."
**What it actually means:** The operating system for trusted data — ownership/stewardship, quality checks, a catalog for discovery and lineage, data contracts, and privacy controls — run as living systems, not a policy PDF. Without it, a technically perfect platform is one nobody trusts or can find.

### Semantic Layer

**What people say:** "The metrics."
**What it actually means:** A governed layer that defines each business metric exactly once (e.g. "on-time delivery rate") so every dashboard and query returns the same number. It ends the "three teams, three definitions" chaos and is what makes self-service BI trustworthy.

### Data Contract

**What people say:** "The schema."
**What it actually means:** An explicit, versioned agreement between a data producer and its consumers on schema, semantics, quality, and SLAs — so an upstream change doesn't silently break every downstream pipeline and dashboard. The API-style discipline that keeps a platform stable.

### MCP (Model Context Protocol)

**What people say:** "How the AI uses tools."
**What it actually means:** An open standard for connecting an LLM/agent to external tools and data sources through a uniform interface — so you expose a system (a database, a ticketing API, a sensor feed) once and any compliant model can use it, instead of writing bespoke glue per model. The "USB-C for AI tools."

### Guardrails

**What people say:** "Keep the AI safe."
**What it actually means:** Programmatic checks wrapped around a model — input filters (PII, prompt-injection, jailbreak), output filters (toxicity, out-of-scope refusal, citation-required), and abstention rules — that enforce safety and policy independently of the model's own behavior. For safety-critical answers, the guardrail (not the prompt) is the control.

### LLMOps

**What people say:** "MLOps for LLMs."
**What it actually means:** The practice of operating LLM applications in production — versioning prompts + models + RAG config, evaluating in CI so a change can't silently degrade quality, and monitoring latency, cost, and quality/faithfulness drift. The moving parts are the prompt/RAG bundle, not model weights, which makes it distinct from classic MLOps.

### Quantization

**What people say:** "Make the model smaller."
**What it actually means:** Storing a model's weights (and sometimes activations) at lower precision — FP16 → INT8 → INT4 — to cut VRAM and cost, at some quality risk. It's the single biggest lever for making a large open model affordable to self-host on a given GPU budget.

### AI Gateway

**What people say:** "A proxy for the AI."
**What it actually means:** A single control point in front of all models (e.g. LiteLLM, Portkey) that handles routing/load-balancing + fallback across replicas, rate-limiting and quotas, auth, cost tracking, caching, audit logging, and guardrail enforcement — so applications don't each reinvent it and the platform stays governable. The API gateway pattern, applied to model calls.

### Strangler Fig Pattern

**What people say:** "Migrate the legacy app."
**What it actually means:** Incrementally routing traffic away from a legacy system into new services, capability by capability, until the old system can be switched off — instead of a risky big-bang rewrite. Named for the fig vine that grows around a host tree until the tree isn't needed anymore.

### Anti-Corruption Layer

**What people say:** "An adapter."
**What it actually means:** A translation layer placed in front of a legacy or regulated system so its awkward or outdated model doesn't leak into (and "corrupt") the clean design of everything around it. Lets you keep a system as-is for stability or compliance while still integrating it cleanly.

### Risk Register

**What people say:** "A list of things that could go wrong."
**What it actually means:** A structured, living table of risks — each scored by likelihood × impact, with a named mitigation and a named owner — reviewed on a cadence. It turns "things that could go wrong" from a vague worry into a tracked, assigned, and mitigated set of items an SA can defend to a customer.

### Runbook

**What people say:** "The instructions."
**What it actually means:** A step-by-step operational procedure for a specific situation (a deployment, a rollback, an incident) written so someone under pressure — not just the architect who designed the system — can execute it correctly. The difference between a design that works in theory and one that survives a 3am page.

### HLD vs LLD

**What people say:** "The architecture doc."
**What it actually means:** The High-Level Design answers *what* is being built, *why*, and at *what cost/risk* — written for an executive to approve. The Low-Level Design answers exactly *how* to build it — node counts, configs, interfaces — written for the engineers who implement it. Confusing the two produces either an HLD nobody can approve or an LLD nobody can execute from.
