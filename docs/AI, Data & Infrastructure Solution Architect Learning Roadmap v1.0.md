# AI, Data & Infrastructure Solution Architect — Learning Roadmap

## (Presales Track) · Zero → Enterprise Solution Architect

**Track 6 of Mindwalker Academy — "From Scratch" path.**

| | |
|---|---|
| **Duration** | ~10–12 months · ~285 hours (self-paced, with phase milestones) |
| **Structure** | 8 phases · 53 lessons · 7 capstones (4 flagship portfolio) |
| **Level** | Beginner → Advanced |
| **Prerequisites** | General IT literacy + business English (everything else is taught in Phase 0) |
| **Labs** | Local + free-tier only — reproducible, near-zero-cost |
| **Language** | English (`docs/en.md`), i18n-ready |
| **Certification** | Internal — Associate + Professional (Presales) |

> This roadmap is the authoritative curriculum for the internal LMS. The `README.md` renders it as the course website (via `site/build.js`); each lesson lives at `phases/NN-name/NN-lesson/docs/en.md`.

---

## Learning Philosophy

```
Business  →  Requirements  →  Architecture  →  Sizing  →  Implementation  →  Operations  →  Optimization
```

A Solution Architect must answer **"How does this solve the customer's problem?"** — not "How does Kubernetes work internally?" This track is built backward from the deal: every technology is taught only as deep as you need to **gather requirements, choose an architecture, size it, price it, and defend it to a customer**. That depth is called **architect altitude** — deep enough to design and sell, not deep enough to be the implementing engineer.

### The Mindwalker arc, adapted for an architect

Engineering tracks ship a *code artifact* per lesson. An SA ships **consulting deliverables**. So every lesson follows:

> **The Problem** (a customer situation you can't handle without this) → **The Concept** (mental model, diagrams, no tooling) → **Design It** (produce the architecture/artifact from a scenario) → **Compare It** (how real vendors/tools solve it + trade-offs) → **Ship It** (the deliverable, saved to `outputs/`) → **Exercises** → **Key Terms** → **Further Reading**

- **Lesson types:** `Learn` (build the mental model) · `Design` (produce an architecture/artifact) · `Present` (communicate & sell).
- **Labs** are local/free-tier and exist to *validate a design claim* (e.g. size a GPU cluster on paper, then sanity-check against a local vLLM benchmark) — not to build production systems.
- **Ship It** artifacts accumulate into the course output: the **Presales Solution Architect Toolkit** (see below).

### Self-contained

This track stands alone — it teaches its own infrastructure, data, and AI foundations from scratch at architect altitude. Where a learner wants deeper internals, lessons link out (optional) to the sister Mindwalker tracks (`ai-engineering-from-scratch`, `openstack-engineering-from-scratch`). You never *need* another track to finish this one.

---

## Prerequisites

**Required:** general IT literacy + business English. **No coding required to start.**

Everything technical is bootstrapped in **Phase 0 — Foundations** at *concept level* (understand-not-build). Labs use copy-run commands, not authored code. (This intentionally relaxes the heavier Python/Bash/SQL prerequisites of earlier drafts — a presales SA interprets technology more than they write it.)

---

## Curriculum

Legend — **Type:** `L`earn · `D`esign · `P`resent. **Ship It** = the deliverable saved to the lesson's `outputs/`.

### Phase 0 — Foundations (concept fluency) · Beginner · ~4 weeks · ~22h
> Give anyone — including non-engineers — enough fluency to read technology, not write it.

| # | Lesson | Type | Lab (local/free) | Ship It |
|---|--------|:----:|------------------|---------|
| 01 | How Enterprise IT Fits Together | L | — | Enterprise IT landscape diagram |
| 02 | Linux You Can Read (Not Script) | L | read logs/configs in a container | Linux-for-architects cheat sheet |
| 03 | Networking Mental Models (TCP/IP, DNS, HTTP/S, TLS, LB, firewall, VPN) | L | trace a request (curl/devtools) | Annotated network diagram |
| 04 | Cloud & Virtualization Literacy (IaaS/PaaS/SaaS, region/AZ, VM/container) | L | spin one free-tier VM | Cloud-concepts one-pager |
| 05 | Data & AI Literacy (SQL/JSON/YAML; ML/LLM/embeddings/vector/RAG/inference) | L | query SQLite + one LLM API call | Data/AI concept map |
| 06 | The Solution Architect Operating System (role, presales lifecycle, RFx) | L | — | SA lifecycle canvas |

*Gate:* `find-your-level` quiz — learners who pass may skip into Phase 1.

### Phase 1 — Business & Consulting Foundation · Beginner · ~4 weeks · ~28h
> Think like a consultant before you touch a technology.

| # | Lesson | Type | Ship It |
|---|--------|:----:|---------|
| 01 | Think Like a Consultant (value framing, MECE, hypothesis-led) | L | Problem-framing canvas |
| 02 | Enterprise Applications & Landscape (ERP/CRM/SCM/MES/IAM) | L | App-landscape map |
| 03 | Industry Domain Knowledge (health, banking, mfg, retail, gov, edu) | L | Industry pain-point brief |
| 04 | Requirement Gathering & Discovery (interview, workshop, current/future state) | D | Discovery questionnaire + notes |
| 05 | Presales Fundamentals (Solution/Value Selling, MEDDICC, SPIN) | L | MEDDICC qualification sheet |
| 06 | RFx & PoC Strategy (RFI/RFP/RFQ, PoC scoping, win themes) | D | RFP response outline + PoC plan |

**▸ Capstone A (mini):** Run a discovery session with a fictional customer → **Discovery Report**.

### Phase 2 — Infrastructure Architecture · Intermediate · ~6 weeks · ~34h
> Design enterprise infrastructure. Labs: Proxmox/KVM, Docker, k3s/kind, Ceph/MinIO, Prometheus.

| # | Lesson | Type | Lab | Ship It |
|---|--------|:----:|-----|---------|
| 01 | Compute & Virtualization (VMware/Proxmox/KVM) | D | KVM/Proxmox VM | Compute sizing note |
| 02 | Storage Architecture (block/file/object, Ceph/Longhorn, IOPS) | D | MinIO/Ceph single-node | Storage design + sizing |
| 03 | Data-Center Networking (VLAN, overlay, ingress, LB) | D | — | DC network HLD |
| 04 | Containers, Docker & Registries (Harbor) | D | Docker + local registry | Containerization assessment |
| 05 | Kubernetes Architecture (control plane, workloads, ingress) | D | k3s/kind cluster | Kubernetes platform HLD |
| 06 | HA, Backup & Disaster Recovery (RTO/RPO, failure domains) | D | — | DR strategy + RTO/RPO sheet |
| 07 | Observability & Infrastructure Security (Prom/Grafana/Loki, IAM, hardening) | D | Prometheus + Grafana | Observability + security design |

**▸ Capstone B:** **On-Premise Private Cloud** — HLD + BOM + sizing sheet.

### Phase 3 — Cloud Architecture · Intermediate · ~6 weeks · ~34h
> Become a multi-cloud architect. Labs: AWS/Azure/GCP free tiers, LocalStack, DevStack.

| # | Lesson | Type | Lab | Ship It |
|---|--------|:----:|-----|---------|
| 01 | Cloud Foundations & Landing Zones (org, accounts, guardrails) | D | — | Landing-zone design |
| 02 | AWS for Architects (core services map) | D | free tier / LocalStack | AWS reference architecture |
| 03 | Azure for Architects | D | free tier | Azure reference architecture |
| 04 | GCP for Architects | D | free tier | GCP reference architecture |
| 05 | OpenStack & Private Cloud | L | DevStack sandbox | Private-vs-public decision matrix |
| 06 | Hybrid, Multi-Cloud & Migration (6 R's, connectivity) | D | — | Migration strategy + wave plan |
| 07 | Cloud Security, FinOps & Cost Optimization | D | — | TCO/cost model + FinOps plan |

**▸ Capstone C (flagship):** **Hybrid Cloud Enterprise Architecture** — multi-cloud HLD + cost model + migration plan.

### Phase 4 — Data Platform Architecture · Intermediate · ~5 weeks · ~30h
> Design enterprise data platforms. Labs: Postgres, DuckDB/ClickHouse, local Kafka, dbt.

| # | Lesson | Type | Lab | Ship It |
|---|--------|:----:|-----|---------|
| 01 | Data Fundamentals (SQL vs NoSQL, modeling, OLTP/OLAP) | D | Postgres | Data model + store-selection matrix |
| 02 | Warehouse, Lake & Lakehouse (Iceberg, ClickHouse) | D | DuckDB/ClickHouse | Lakehouse HLD |
| 03 | Streaming & CDC (Kafka, Debezium) | D | local Kafka | Streaming architecture |
| 04 | Processing & Orchestration (Spark, Airflow, dbt) | D | dbt + DuckDB | Pipeline design |
| 05 | Data Governance, Quality & Catalog (MDM, metadata, lineage) | D | — | Governance framework |
| 06 | Analytics & BI Enablement (semantic layer, self-service) | D | — | BI enablement plan |

**▸ Capstone D (flagship):** **Enterprise Data Platform** — lakehouse + streaming + governance HLD + BOM.

### Phase 5 — AI Platform Architecture · Advanced · ~6 weeks · ~36h
> Design AI platforms. Labs: Ollama, vLLM/SGLang, Milvus/Qdrant, Haystack/LangGraph, LiteLLM, MLflow.

| # | Lesson | Type | Lab | Ship It |
|---|--------|:----:|-----|---------|
| 01 | LLM & Model Landscape (open vs closed, params, context, licensing) | D | Ollama | Model-selection matrix |
| 02 | Embeddings & Vector Databases (Milvus/Qdrant/OpenSearch) | D | local vector DB | Vector-store design |
| 03 | RAG Architecture (chunking, retrieval, evaluation) | D | Haystack/local RAG | RAG reference architecture |
| 04 | Agents & MCP (patterns, tools, orchestration, LangGraph) | D | — | Agent architecture |
| 05 | Model Serving, Inference & GPU Sizing (vLLM/SGLang, batching, quantization) | D | vLLM micro-bench | **GPU sizing sheet** + serving design |
| 06 | Evaluation, Guardrails & Responsible AI | D | — | Eval + guardrail plan |
| 07 | LLMOps & AI Gateway (MLflow, LiteLLM, cost & observability) | D | LiteLLM + MLflow | LLMOps + AI-gateway design |

**▸ Capstone E (flagship):** **Private AI Platform** — K8s + GPU + Ollama + Open WebUI + RAG: HLD + sizing + BOM.

### Phase 6 — Solution Architecture (connect everything) · Advanced · ~6 weeks · ~32h
> Produce the full enterprise deliverable set.

| # | Lesson | Type | Ship It |
|---|--------|:----:|---------|
| 01 | Architecture Patterns (microservices, event-driven, API gateway, integration) | D | Pattern-selection guide |
| 02 | Security Architecture & Zero Trust | D | Security architecture |
| 03 | Sizing & Capacity Planning (workload modeling) | D | Sizing methodology + sheet |
| 04 | Cost Estimation & BOM (build the BOM, licensing) | D | **BOM + pricing sheet** |
| 05 | Risk, Compliance & Migration Strategy | D | Risk register + migration plan |
| 06 | Writing the HLD | D | **HLD document** |
| 07 | Writing the LLD, Runbook & Implementation Plan | D | **LLD + runbook + implementation plan** |

**▸ Capstone F:** **Enterprise AI Transformation Proposal** — full HLD/LLD/BOM/sizing/plan set.

### Phase 7 — Presales Mastery · Advanced · ~4 weeks · ~28h
> Win the deal.

| # | Lesson | Type | Ship It |
|---|--------|:----:|---------|
| 01 | Technical Storytelling & Messaging | P | Solution narrative |
| 02 | Whiteboarding & Architecture Communication | P | Whiteboard playbook + recording |
| 03 | Demo Design & Delivery (PoC → demo) | P | Demo script + environment plan |
| 04 | Proposal & Executive Summary Writing | P | Proposal + executive summary |
| 05 | Commercial Awareness, Pricing & ROI | D | **ROI/TCO calculator** + pricing strategy |
| 06 | Competitive Analysis & Handling Objections | P | Battlecard + objection matrix |
| 07 | Executive Presentation & Negotiation | P | Executive deck + negotiation plan |

**▸ Capstone G (flagship, final):** **Executive Presales Demo** — Discovery → HLD → LLD → BOM → Pricing → Demo → Proposal → Q&A defense to a mock board.

---

## Portfolio — the 4 flagship capstones

By graduation, a learner has a defensible portfolio:

1. **Private AI Platform** — Kubernetes + GPU + Ollama + Open WebUI + RAG (Capstone E)
2. **Enterprise Data Platform** — Lakehouse + Streaming + Governance + BI (Capstone D)
3. **Hybrid Cloud Enterprise Architecture** — VMware → Kubernetes → AWS/Azure (Capstone C)
4. **Executive Presales Demo** — Discovery → HLD → LLD → BOM → Pricing → Demo → Proposal → Q&A (Capstone G)

Plus the mini/interim capstones: **Discovery Report** (A), **On-Premise Private Cloud** (B), **Enterprise AI Transformation Proposal** (F).

---

## Timeline (hybrid: self-paced with milestones)

| Phase | Weeks | Hours | Level | Milestone checkpoint |
|-------|:-----:|:-----:|-------|----------------------|
| 0 · Foundations | 4 | ~22 | Beginner | find-your-level quiz |
| 1 · Business & Consulting | 4 | ~28 | Beginner | Discovery Report (Capstone A) |
| 2 · Infrastructure | 6 | ~34 | Intermediate | Private Cloud HLD (Capstone B) |
| 3 · Cloud | 6 | ~34 | Intermediate | Hybrid Cloud Arch (Capstone C) |
| 4 · Data Platform | 5 | ~30 | Intermediate | Data Platform HLD (Capstone D) |
| 5 · AI Platform | 6 | ~36 | Advanced | Private AI Platform (Capstone E) |
| 6 · Solution Architecture | 6 | ~32 | Advanced | Transformation Proposal (Capstone F) |
| 7 · Presales Mastery | 4 | ~28 | Advanced | Executive Demo defense (Capstone G) |
| **Total** | **~41** | **~244 + ~40 capstone ≈ 285** | | Certification |

Learners still go at their own pace; the weeks are a suggested cadence (~6–7h/week ≈ 10–12 months).

---

## Certification (internal)

| Tier | Requirements |
|------|--------------|
| **Associate Solution Architect** | Phases 0–4 + Capstones B & D + per-phase `check-understanding` quizzes |
| **Professional Solution Architect – Presales** | All phases + Capstone F (Transformation Proposal) + Capstone G (Executive Demo defense) |

Quizzes ship as Claude Code skills: `.claude/skills/check-understanding` and `.claude/skills/find-your-level`.

---

## Course output — the Presales Solution Architect Toolkit

Every lesson's `Ship It` deliverable accumulates into a reusable toolkit:

- Discovery questionnaire · MEDDICC qualification sheet · RFP response outline
- **HLD / LLD templates** · **BOM template** · **sizing calculators (incl. GPU)** · **TCO/ROI model**
- Reference architectures (on-prem, AWS, Azure, GCP, data platform, AI platform)
- Proposal + executive-summary templates · battlecards · demo scripts · executive deck template · runbook template

---

## Recommended technology stack (labs)

- **Infrastructure:** Proxmox · KVM · Docker · k3s/kind · Ceph/MinIO · Harbor · Terraform · Ansible
- **Cloud:** AWS · Azure · GCP (free tiers) · LocalStack · OpenStack (DevStack)
- **Data:** PostgreSQL · DuckDB/ClickHouse · Kafka · Spark · Airflow · dbt · Iceberg
- **AI:** Ollama · vLLM · SGLang · MLflow · LangGraph · Haystack · Open WebUI · LiteLLM · Milvus · Qdrant
- **Observability:** Prometheus · Grafana · Loki · Tempo · OpenTelemetry
- **Security:** Keycloak · Vault · Trivy · Falco · OPA · Kyverno

---

## Internal LMS structure (Mindwalker style)

The repo mirrors the sister tracks so it drops into Mindwalker Academy with zero new tooling:

```
solution-architect-from-scratch/
├── README.md                 # journey + toolkit pitch (parsed by the site)
├── ROADMAP.md                # phase → lesson → status → time (parsed by the site)
├── LESSON_TEMPLATE.md        # the SA lesson arc
├── glossary/terms.md         # "what people say vs what it means"
├── site/build.js             # parses README+ROADMAP+glossary → data.js → static site (Vercel)
├── .claude/skills/           # check-understanding, find-your-level
├── phases/NN-name/NN-lesson/{docs/en.md, outputs/}
├── projects/                 # the 7 capstones
└── docs/                     # this roadmap + design specs
```

---

## Build status

**Stage 1 (scaffold) — done:** this roadmap, `README.md`, `ROADMAP.md`, the full `phases/` stub tree (53 `docs/en.md`), `projects/` capstone briefs, glossary seed, and the Vercel site are in place. All lessons are ⬚ *Planned*.

**Stage 2 (authoring) — next:** write the 53 lesson bodies + toolkit templates + capstone briefs, flipping each to ✅ in `ROADMAP.md` as it lands. Contribute by picking any ⬚ lesson (see `CONTRIBUTING.md`).
