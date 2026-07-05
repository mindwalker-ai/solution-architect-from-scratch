---
name: check-understanding
version: 1.1.0
description: >
  Per-phase knowledge quiz for the AI, Data & Infrastructure Solution
  Architect (Presales) track — 8 phases, 53 lessons. Generates a short
  multiple-choice test for one phase, scores it, and tells you whether you
  are ready to advance. Trigger phrases: "quiz me", "test phase 2",
  "check my understanding", "do I know phase 3", "am I ready for the next
  phase", or `/check-understanding <phase>`.
---

# Check Understanding

Test your knowledge of a phase from the **AI, Data & Infrastructure Solution
Architect (Presales)** course. There are 8 phases (0–7) and 53 lessons. This
skill quizzes one phase at a time, scores you, and tells you whether you are
ready to move on.

## Activation

This skill activates when the user says things like:

- `/check-understanding 0` or `/check-understanding cloud`
- "quiz me on phase 2"
- "test phase 1"
- "check my understanding of cloud architecture"
- "do I know phase 3"
- "am I ready for the next phase"

## Input

Accepts a phase number (0–7) or a phase name/keyword as argument. If no
argument is provided, ask the user which phase they want to be tested on by
listing all 8 phases.

## Phase Map

Map the argument to the correct phase directory under `phases/`:

| Input | Directory | Phase Name |
|-------|-----------|------------|
| 0, foundations, basics | `00-foundations` | Foundations |
| 1, business, consulting | `01-business-and-consulting` | Business & Consulting Foundation |
| 2, infrastructure, infra | `02-infrastructure-architecture` | Infrastructure Architecture |
| 3, cloud | `03-cloud-architecture` | Cloud Architecture |
| 4, data, data-platform | `04-data-platform-architecture` | Data Platform Architecture |
| 5, ai, ai-platform | `05-ai-platform-architecture` | AI Platform Architecture |
| 6, solution, solution-architecture, architecture | `06-solution-architecture` | Solution Architecture |
| 7, presales | `07-presales-mastery` | Presales Mastery |

## Procedure

### Step 1: Resolve the Phase

Parse the argument. If it is a number, validate it is between 0 and 7
inclusive. If the number is out of range, tell the user: "Phase [N] does not
exist. Valid phases are 0–7." and show the full list for them to pick from. If
it is a name or keyword, look it up in the Phase Map above. If the keyword does
not match any entry in the map, tell the user: "Unknown phase '[keyword]'. Pick
from the list below:" and present all 8 phases. If no argument is provided, ask
the user to pick from the full list.

### Step 2: Get the Question Set

Question sources, in priority order:

1. **Phase 0 (Foundations), Phase 1 (Business & Consulting Foundation), Phase 2
   (Infrastructure Architecture), Phase 3 (Cloud Architecture), Phase 4
   (Data Platform Architecture), Phase 5 (AI Platform Architecture), Phase 6
   (Solution Architecture), and Phase 7 (Presales Mastery)** — use the authored
   **Phase 0 Question Bank**, **Phase 1 Question Bank**, **Phase 2 Question
   Bank**, **Phase 3 Question Bank**, **Phase 4 Question Bank**, **Phase 5
   Question Bank**, **Phase 6 Question Bank**, and **Phase 7 Question Bank**
   embedded further down in this file.
   They are ready to use as-is; do not generate new questions for these phases
   unless the user asks for a fresh set, in which case rephrase within the same
   topics.
2. **Any phase whose lesson docs contain real teaching content** — use Glob to
   find all lesson directories under `phases/<phase-dir>/`, read each lesson's
   `docs/en.md`, and generate questions grounded in that material. If a phase
   has many lessons, prioritize a representative spread (first few, middle,
   last few). This is a fallback path only; all 8 phases currently have
   authored banks, so this path is not needed today.

### Step 3: Prepare the Questions

For Phase 0, use the 9 questions in the Phase 0 Question Bank as written. For
Phase 1, use the 8 questions in the Phase 1 Question Bank as written. For Phase
2, use the 8 questions in the Phase 2 Question Bank as written. For Phase 3, use
the 8 questions in the Phase 3 Question Bank as written. For Phase 4, use the 8
questions in the Phase 4 Question Bank as written. For Phase 5, use the 8
questions in the Phase 5 Question Bank as written. For Phase 6, use the 8
questions in the Phase 6 Question Bank as written. For Phase 7, use the 8
questions in the Phase 7 Question Bank as written.

For any phase generated from real lesson docs, create 8 multiple-choice
questions drawn from the lesson content you read:

**Roughly half Conceptual (What/Why)** — ideas, definitions, trade-offs, and
reasoning. Examples:
- "What problem does a landing zone solve?"
- "Why would you choose a lakehouse over a separate warehouse and lake?"
- "Which statement best describes the difference between HLD and LLD?"

**Roughly half Practical (How/Decide)** — applied judgement and architecture
decisions. Examples:
- "A customer needs sub-second analytics over streaming events. Which pattern fits?"
- "Which sizing input do you need before producing a Bill of Materials?"
- "How would you sequence a discovery-to-proposal engagement?"

Each question must have 3 or 4 answer options labeled A, B, C (and optionally
D). Exactly one option is correct. Wrong options should be plausible but
clearly incorrect to someone who studied the material. Tag each question with
the lesson it draws from (e.g., "Lesson 0.4: Cloud & Virtualization Literacy").

### Step 4: Present Questions One at a Time

Use the AskUserQuestion tool (or equivalent interactive prompt) to present each
question individually. Format:

```
Question 1/9 (Conceptual) — from Lesson 0.4: Cloud & Virtualization Literacy

You rent virtual machines and manage the OS, patching, and everything above
it, but the provider owns the physical hardware. Which service model is this?

A) SaaS
B) PaaS
C) IaaS
D) On-premise
```

Wait for the user's answer before moving to the next question.

### Step 5: Track and Score

Keep a running tally:

- Total correct out of N (N = number of questions asked; 9 for Phase 0)
- For each wrong answer, record: the question number, the user's answer, the
  correct answer, and which lesson it came from

### Step 6: Show Results

After all questions, display the score and grade. Thresholds are proportional
to N (percentages shown, with the 9-question Phase 0 counts as an example):

**≥ 85% correct — Mastered** (8–9 of 9)
If the phase is 7 (Presales Mastery): "You have mastered the final phase.
Congratulations — you have completed the entire curriculum."
Otherwise: "You have a strong grasp of Phase N. You are ready to move on to
Phase N+1: [next phase name]."

**65–84% correct — Almost** (6–7 of 9)
"Solid foundation. Review these specific areas before moving on:" then list the
lessons tied to the missed questions.

**40–64% correct — Developing** (4–5 of 9)
"You are building understanding but need to revisit some lessons:" then list
each missed question with the lesson to re-read.

**< 40% correct — Start Over** (0–3 of 9)
"This phase needs more time. Work through the lessons again from the beginning,
focusing on:" then list all missed topics.

### Step 7: Wrong Answer Breakdown

For every question the user got wrong, show:

```
Question N: [question text, abbreviated]
Your answer: B
Correct answer: C — [the correct option text]
Why: [1–2 sentence explanation of why C is correct]
Review: Lesson X.Y — [lesson name] (phases/<phase-dir>/<NN-lesson-slug>/docs/en.md)
```

### Step 8: What Next?

End by offering three choices:

1. **Retake this quiz** — present a fresh/rephrased set from the same phase
2. **Try another phase** — pick a different phase to test
3. **Explain a topic** — ask about any concept from the questions you missed

Wait for the user's choice and act accordingly.

## Rules

- Avoid repeating the exact same questions on retakes until the pool is
  exhausted. Once exhausted, reshuffle or rephrase.
- Questions must be grounded in the phase's material (the Phase 0 bank, or real
  lesson docs), not general trivia.
- Do not show the correct answer until after the user responds.
- Keep question text concise. One or two sentences max.
- Wrong options must be plausible. No joke answers.
- If a phase has no authored bank and no real lesson content yet, do not
  fabricate questions — tell the user the phase is not ready and point them to
  Phase 0.

---

## Question Bank Status

- **Phase 0 — Foundations:** ✅ Authored bank below (9 questions).
- **Phase 1 — Business & Consulting Foundation:** ✅ Authored bank below (8 questions).
- **Phase 2 — Infrastructure Architecture:** ✅ Authored bank below (8 questions).
- **Phase 3 — Cloud Architecture:** ✅ Authored bank below (8 questions).
- **Phase 4 — Data Platform Architecture:** ✅ Authored bank below (8 questions).
- **Phase 5 — AI Platform Architecture:** ✅ Authored bank below (8 questions).
- **Phase 6 — Solution Architecture:** ✅ Authored bank below (8 questions).
- **Phase 7 — Presales Mastery:** ✅ Authored bank below (8 questions).

**All 8 phases (0–7) are fully authored. No TODO phases remain.**

---

## Phase 0 Question Bank — Foundations

Nine questions covering the six Phase 0 lessons: enterprise IT layers, reading
Linux state, networking mental models, cloud service/deployment models and
VM-vs-container, data/AI/RAG basics, and the presales lifecycle and artifact
chain. Present all nine (score out of 9). One option per question is correct.

**Q1 (Conceptual) — Lesson 0.1: How Enterprise IT Fits Together**

Reading the enterprise IT stack from the business-facing top down to the
physical foundation, which ordering is correct?

- A) Infrastructure → Platform/Middleware → Data → Application → Business process
- B) Business process → Application → Data → Platform/Middleware → Infrastructure
- C) Application → Business process → Infrastructure → Data → Platform/Middleware
- D) Data → Infrastructure → Application → Business process → Platform/Middleware

**Correct: B.** Business processes sit at the top (what the organization does),
served by applications, backed by data, running on platform/middleware, on top
of infrastructure at the physical bottom.

**Q2 (Practical) — Lesson 0.2: Linux You Can Read**

You SSH into a Linux server during an outage. Where do you look first to read
system and application log files?

- A) `/etc`
- B) `/var/log`
- C) `/home`
- D) `/dev`

**Correct: B.** `/var/log` holds log files. `/etc` holds configuration, `/home`
holds user files, and `/dev` holds device files.

**Q3 (Practical) — Lesson 0.2: Linux You Can Read**

A customer says "the web service is down." Which command's output most directly
tells you whether a systemd-managed service is currently running?

- A) `df -h`
- B) `whoami`
- C) `systemctl status nginx`
- D) `ls -l /etc`

**Correct: C.** `systemctl status <service>` reports whether the unit is active
(running), failed, or stopped. `df -h` shows disk usage and `whoami` shows the
current user.

**Q4 (Conceptual) — Lesson 0.3: Networking Mental Models**

What is the primary job of DNS?

- A) Encrypting traffic between the browser and the server
- B) Distributing incoming requests across multiple servers
- C) Resolving human-readable domain names into IP addresses
- D) Blocking traffic based on firewall rules

**Correct: C.** DNS translates names like `app.example.com` into the IP
addresses machines actually route to. Encryption is TLS, distribution is a load
balancer, and filtering is a firewall.

**Q5 (Practical) — Lesson 0.3: Networking Mental Models**

A web tier is getting more traffic than one server can handle. Which component
sits in front of several identical backend servers and spreads requests across
them?

- A) A DNS resolver
- B) A load balancer
- C) A firewall
- D) A NAT gateway

**Correct: B.** A load balancer distributes incoming connections across a pool
of backends for scale and availability.

**Q6 (Conceptual) — Lesson 0.4: Cloud & Virtualization Literacy**

You rent virtual machines and manage the operating system, patching, and
everything above it, while the provider owns and operates the physical
hardware. Which cloud service model is this?

- A) SaaS
- B) PaaS
- C) IaaS
- D) On-premise

**Correct: C.** IaaS (Infrastructure as a Service) gives you compute/storage/
network primitives; you still own the OS and up. PaaS abstracts the OS/runtime,
and SaaS delivers a finished application.

**Q7 (Conceptual) — Lesson 0.4: Cloud & Virtualization Literacy**

Which statement best describes the difference between a virtual machine and a
container?

- A) A container includes a full guest OS; a VM shares the host kernel
- B) A VM includes a full guest OS on a hypervisor, while a container shares the host OS kernel and packages just the app plus its dependencies
- C) They are the same thing with different names
- D) A container can only run on Windows; a VM only on Linux

**Correct: B.** VMs virtualize hardware and each carries its own guest OS;
containers virtualize the OS, sharing the host kernel, so they are lighter and
faster to start.

**Q8 (Conceptual) — Lesson 0.5: Data & AI Literacy**

In a Retrieval-Augmented Generation (RAG) setup, why are documents retrieved
and injected into the prompt before the LLM generates an answer?

- A) To retrain the model's weights on the user's question
- B) To ground the answer in relevant, current, or private data and reduce hallucination
- C) To replace the language model with a search engine
- D) To compress the prompt so it uses fewer tokens

**Correct: B.** RAG supplies the model with relevant context at inference time
so it can answer from real, up-to-date, or proprietary sources instead of only
its frozen training data.

**Q9 (Practical) — Lesson 0.6: The Solution Architect Operating System**

In the solution architect's presales workflow, which order of artifacts is
correct?

- A) Proposal → HLD → Requirements → LLD → Bill of Materials
- B) Bill of Materials → Requirements → Proposal → HLD → LLD
- C) Requirements (discovery) → High-Level Design (HLD) → Low-Level Design (LLD) → Bill of Materials → Proposal
- D) HLD → Requirements → LLD → Proposal → Bill of Materials

**Correct: C.** You discover requirements first, shape them into an HLD, detail
it in an LLD, cost it out as a Bill of Materials, and package everything into a
proposal. Each artifact feeds the next.

---

## Phase 1 Question Bank — Business & Consulting Foundation

Eight questions covering the six Phase 1 lessons: thinking like a consultant
(reframing the ask, MECE hypothesis-led issue trees), the enterprise
application landscape and integration styles, industry domain fluency,
requirement discovery, presales fundamentals (value selling and MEDDICC), and
RFx/PoC strategy. Present all eight (score out of 8). One option per question is
correct.

**Q1 (Conceptual) — Lesson 1.1: Think Like a Consultant**

A hospital COO tells you, "We need to buy more servers." What should a
consultant do first?

- A) Configure and quote the largest server that fits the stated budget
- B) Treat the request as a proposed solution and reframe it into the underlying business problem it is meant to solve
- C) Recommend the same hardware the previous three customers purchased
- D) Ask the COO which server vendor they prefer

**Correct: B.** "Buy more servers" is a solution the customer has already jumped
to; the consultant works backward to the real business problem (e.g., systems
crawling during peak clinic hours) before committing to any answer, separating
the symptom from the root cause and the business value.

**Q2 (Practical) — Lesson 1.1: Think Like a Consultant**

You are decomposing "Why is patient wait time too high?" into a hypothesis-led
issue tree. Which set of branches is the most MECE?

- A) "Long check-in," "slow doctors," "old computers," "bad wifi"
- B) "Time before the appointment," "time during the appointment," "time after the appointment"
- C) "Staffing problems" and "staffing and process problems"
- D) "Things we can fix" and "everything else"

**Correct: B.** Splitting the visit into non-overlapping, gap-free stages is
Mutually Exclusive and Collectively Exhaustive; the other options overlap,
double-count, or leave gaps, so they cannot cleanly guide analysis.

**Q3 (Conceptual) — Lesson 1.2: Enterprise Applications & Landscape**

A system of record such as an ERP or a hospital's HIS/LIS is best distinguished
from a system of engagement by the fact that it:

- A) Is the authoritative source of core business data, prioritizing accuracy and consistency over slick user experience
- B) Exists mainly to give end users a polished, real-time interactive interface
- C) Never integrates with any other application
- D) Is always delivered as a cloud SaaS product

**Correct: A.** Systems of record (ERP, SCM/MES, and healthcare's HIS/LIS/
RIS-PACS) are the trusted source of truth optimized for integrity; systems of
engagement sit closer to the user and optimize for interaction.

**Q4 (Practical) — Lesson 1.2: Enterprise Applications & Landscape**

A customer has 30 applications wired together with brittle one-to-one links and
wants a governed, reusable integration layer that exposes managed APIs. Which
integration style should you steer them toward?

- A) Add more point-to-point (P2P) connections between each pair of systems
- B) An API-led (or ESB / event-driven) approach that centralizes and governs integration instead of hand-wiring every pair
- C) Copy data by hand between systems each night
- D) Remove all integrations and keep every system fully siloed

**Correct: B.** Point-to-point integration explodes in complexity as systems
grow; API-led, ESB, or event-driven styles provide a managed, reusable, loosely
coupled layer that scales far better.

**Q5 (Conceptual) — Lesson 1.3: Industry Domain Knowledge**

Why does industry domain fluency help a solution architect win deals?

- A) It lets you skip discovery entirely because you already know the answer
- B) Speaking the customer's language — their value chain, systems of record, regulators, and KPIs — builds trust and surfaces relevant use-cases faster than a generic pitch
- C) It removes any need to understand the underlying technology
- D) It guarantees you can offer the lowest price

**Correct: B.** Knowing an industry's value chain, core systems, regulators
(e.g., HL7/FHIR interoperability and data-residency rules in healthcare), KPIs,
and likely AI use-cases earns credibility and points to the problems that
actually matter to the buyer.

**Q6 (Practical) — Lesson 1.4: Requirement Gathering & Discovery**

Halfway through discovery you have interviewed only the executive champion who
sponsored the project. What is the biggest risk, and the fix?

- A) No risk — the champion speaks for everyone, so discovery is done
- B) You may miss the real workflow and non-functional needs of day-to-day users and other stakeholders; interview beyond the champion and map current vs future state
- C) Skip the remaining interviews and run a product demo instead
- D) Document only functional features and ignore performance, security, and compliance

**Correct: B.** Discovery is a structured interview across the whole stakeholder
map, not a demo; the champion's view must be validated against the people who do
the work, and both functional and non-functional requirements must be captured.

**Q7 (Conceptual) — Lesson 1.5: Presales Fundamentals**

In MEDDICC-based qualification, which statement is correct?

- A) The "Economic Buyer" is simply whoever writes the technical requirements
- B) You should sell features and specifications rather than quantified business value
- C) The "Economic Buyer" is the person with discretionary authority to release the budget, and "do nothing" (the status quo) is a real competitor you must beat
- D) Competition only ever means rival vendors, never the customer's current way of working

**Correct: C.** MEDDICC pushes you to reach the economic buyer who controls the
money and to treat "do nothing" as a competitor; strong presales sells
value, not features, and uses SPIN-style questioning to surface the pain first.

**Q8 (Practical) — Lesson 1.6: RFx & PoC Strategy**

A customer wants a proof of concept before committing. What is the single most
important thing to lock down first, and what should you avoid?

- A) Agree pre-defined, measurable success criteria up front; avoid over-promising scope you cannot deliver in the PoC window
- B) Keep success criteria vague so any result can be spun as a win
- C) Promise every requested feature to look strong now and sort out delivery later
- D) Treat an RFI (request for information) exactly like an RFQ (request for a firm price quote)

**Correct: A.** A PoC needs pre-agreed, measurable success criteria so both
sides know what "pass" means; vague scope and over-promising are how PoCs (and
deals) collapse. An RFI gathers information, an RFP seeks a proposed solution,
and an RFQ asks for a firm price — they are not interchangeable, and win themes
should tie back to the customer's real pains.

---

## Phase 2 Question Bank — Infrastructure Architecture

Eight questions covering the seven Phase 2 lessons: compute and virtualization
(overcommit, N+1, hypervisor cost), storage architecture (block vs object,
IOPS/throughput/capacity, replication and erasure-coding overhead), data-center
networking (spine-leaf, VXLAN, segmentation, inter-DC links), containers and
registries, Kubernetes architecture (control-plane HA and tenancy), HA/backup/DR
(RTO vs RPO, sync vs async), and observability and infrastructure security.
Present all eight (score out of 8). One option per question is correct.

**Q1 (Practical) — Lesson 2.1: Compute & Virtualization**

A bank is consolidating 200 lightly-used internal VMs onto a new virtualization
cluster and asks how aggressively to overcommit CPU and memory. What is the
right guidance?

- A) Overcommit every workload as hard as possible — including the card-payment authorization VMs — to maximize the consolidation ratio
- B) A moderate overcommit (consolidation) ratio is fine for the lightly-used internal VMs, but latency-sensitive, regulated workloads such as payment authorization must not be overcommitted, and the cluster must keep N+1 host capacity so one host can fail
- C) Never overcommit anything, so buy one physical host per VM
- D) Overcommit is only about storage, so it does not affect CPU or memory sizing

**Correct: B.** Overcommitting shared CPU/RAM raises the consolidation ratio and
lowers cost for bursty, lightly-used VMs, but you must not overcommit
latency-critical or regulated workloads (e.g., payments), and you always size
for N+1 so a single host failure has somewhere to land.

**Q2 (Conceptual) — Lesson 2.1: Compute & Virtualization**

A customer running VMware vSphere is alarmed by rising per-core licensing costs
and asks about alternatives. Which statement is accurate?

- A) KVM/Proxmox and VMware cost the same, so switching saves nothing
- B) Open-source hypervisors such as KVM (often via Proxmox) can remove or reduce hypervisor licensing cost, trading it for more in-house operational responsibility, whereas VMware's value is its mature, heavily-supported ecosystem
- C) VMware is free and open source; KVM is the expensive proprietary option
- D) The choice of hypervisor has no cost implications at enterprise scale

**Correct: B.** KVM/Proxmox can cut hypervisor licensing spend but shifts more
operational burden in-house; VMware charges for licensing and support but offers
a mature, well-supported stack. The trade-off is cost versus ecosystem maturity
and who carries the operational load.

**Q3 (Conceptual) — Lesson 2.2: Storage Architecture**

A transactional database needs low-latency random reads and writes for its
virtual disks. Which storage type fits, and how does it differ from object
storage?

- A) Object storage, because databases need HTTP GET/PUT access to individual files
- B) Block storage, which presents raw volumes for high-IOPS, low-latency random access (ideal for VM disks and databases); object storage instead offers massively scalable, HTTP-accessed buckets better suited to backups, media, and data-lake files
- C) They are interchangeable; pick whichever is cheaper per terabyte
- D) Object storage, because it always delivers higher IOPS than block storage

**Correct: B.** Block storage gives raw, low-latency, high-IOPS volumes for VM
disks and databases; object storage is scalable, HTTP-accessed bucket storage
optimized for capacity and throughput (backups, media, data lakes), not
transactional IOPS. Sizing means separating IOPS, throughput, and capacity — and
remembering that replication (e.g., 3x) or erasure coding consumes raw capacity,
so usable capacity sits well below raw.

**Q4 (Practical) — Lesson 2.3: Data-Center Networking**

A new data-center fabric must handle heavy east-west (server-to-server) traffic
from a virtualized, multi-tenant platform. Which design choices fit best?

- A) A classic three-tier (core/aggregation/access) design with VLANs only, because east-west traffic is negligible in modern data centers
- B) A spine-leaf (leaf-spine) fabric for predictable, low-latency east-west paths, with VXLAN overlays to scale segmentation beyond the ~4,094 VLAN limit and isolate tenants and security zones, plus a dedicated inter-DC link to carry replication
- C) Put every tenant on the same flat VLAN with no segmentation to keep it simple
- D) Spine-leaf is only for storage; networking between VMs should stay three-tier

**Correct: B.** Spine-leaf fabrics are built for east-west traffic (any leaf to
any leaf in one hop). VXLAN overlays scale L2 segmentation far past the ~4K VLAN
ceiling and enforce tenant/security-zone isolation, and replication between sites
rides a dedicated inter-DC link. Three-tier designs were optimized for
north-south traffic.

**Q5 (Conceptual) — Lesson 2.4: Containers & Registries**

A bank wants to "containerize everything," including its COTS (vendor-packaged)
core banking system. What is the sound architectural response?

- A) Containerize the vendor core banking system immediately, regardless of vendor support, to modernize it
- B) Containerize the new cloud-native, stateless services, but keep the COTS/legacy core banking system on a VM (vendor support and licensing usually require it); also mandate a private registry with image scanning and signing to protect the software supply chain
- C) Containers and VMs are the same, so it makes no difference where the core banking system runs
- D) Skip the private registry and pull all images directly from public registries to save time

**Correct: B.** Good candidates for containers are stateless, cloud-native,
frequently-deployed services; vendor-packaged COTS cores (like core banking)
typically stay on VMs because that is what the vendor supports and licenses. A
private registry with vulnerability scanning and image signing guards against
supply-chain risk.

**Q6 (Practical) — Lesson 2.5: Kubernetes Architecture**

You are designing a production Kubernetes platform for a team new to Kubernetes,
across two data centers ~700 km apart. Which control-plane design is sound?

- A) Run a single etcd cluster stretched across both far-apart data centers so one cluster spans both sites
- B) Use an odd number of control-plane/etcd members (e.g., 3 or 5) for quorum within a site, do NOT stretch one etcd cluster across the two distant DCs (WAN latency breaks quorum), adopt a managed/supported distribution to offset the team's skills gap, and use node pools plus RBAC for tenancy
- C) Run two etcd members so there is an even, balanced quorum
- D) Skip control-plane HA entirely because Kubernetes reschedules pods anyway

**Correct: B.** etcd needs an odd member count to hold quorum, and its consensus
is latency-sensitive, so stretching one etcd cluster across ~700 km breaks it —
replicate between per-site clusters instead. A managed/supported distribution
offsets a skills gap, and node pools plus RBAC provide tenancy isolation. A
highly-available control plane matters because losing quorum stops all cluster
changes.

**Q7 (Practical) — Lesson 2.6: HA, Backup & DR**

A regulator requires that a payments platform survive the loss of its primary
data center, with the DR site ~700 km away and near-zero data loss the goal but
WAN distance a constraint. Which framing is correct?

- A) HA, backup, and DR are the same thing, so a nightly backup satisfies the DR requirement
- B) HA (within a site), backup (recoverable copies), and DR (surviving a site loss) are three distinct concerns; RTO is how fast you must recover and RPO is how much data you can afford to lose; at ~700 km synchronous replication is impractical, so use asynchronous replication (accepting a small RPO) plus a 3-2-1 backup strategy
- C) Use synchronous replication across the 700 km link to guarantee zero RPO with no performance impact
- D) RTO and RPO mean the same thing, so you only need to pick one number

**Correct: B.** HA, backup, and DR solve different problems and none substitutes
for another. RTO (recovery time) and RPO (tolerable data loss) are distinct
targets. Synchronous replication over ~700 km adds too much latency, so
asynchronous replication is used (accepting a small RPO), backed by a 3-2-1
backup regime (3 copies, 2 media types, 1 offsite).

**Q8 (Conceptual) — Lesson 2.7: Observability & Infra Security**

When designing observability and infrastructure security for a regulated
platform, which description is correct?

- A) Observability means only collecting logs; metrics and traces are unnecessary
- B) Observability rests on three pillars — metrics, logs, and traces — with SLIs/SLOs defining measurable reliability targets; on the security side, secrets belong in a manager such as HashiCorp Vault, guardrails are enforced as policy-as-code, and an immutable audit trail supports compliance
- C) Storing secrets as plaintext environment variables baked into the container image is best practice
- D) An SLO is a hardware specification for the monitoring server

**Correct: B.** The three pillars of observability are metrics, logs, and traces;
an SLI measures actual behavior while an SLO sets the target for acceptable
reliability. Secrets are centralized in a manager such as Vault (never
hard-coded), policy-as-code enforces standards automatically, and an immutable
audit trail is what satisfies compliance and forensics.

---

## Phase 3 Question Bank — Cloud Architecture

Eight questions covering the seven Phase 3 lessons: cloud foundations and landing
zones (multi-account separation, guardrails, IaC, residency), AWS for architects
(EKS/ECS/Lambda, Aurora vs DynamoDB, regions/AZs, when to go serverless), Azure
for architects (AKS, Azure SQL/Cosmos DB, Entra ID, hybrid/identity strength),
GCP for architects (GKE, Cloud SQL/Spanner, global load balancing), OpenStack and
private cloud (rent-vs-own economics, when sovereign/private wins), hybrid,
multi-cloud and migration (legit drivers vs anti-patterns, the 6 R's, portability
via Kubernetes, the strangler pattern), and cloud security, FinOps and cost
optimization (Inform/Optimize/Operate, rightsizing/spot/savings-plans, unit
economics, shared responsibility and CSPM). Present all eight (score out of 8).
One option per question is correct.

**Q1 (Conceptual) — Lesson 3.1: Cloud Foundations & Landing Zones**

A retailer is about to move dozens of teams into the cloud and wants to avoid a
sprawl of ungoverned accounts. Why start with a landing zone built on multiple
accounts?

- A) A single shared account is simpler and gives the strongest blast-radius isolation
- B) A landing zone is a pre-governed, multi-account foundation — separating prod, non-prod, and shared services for blast-radius isolation and clean billing — with guardrails (service control policies / policy-as-code), centralized identity and network baselines, and everything provisioned as Infrastructure-as-Code so it is repeatable, auditable, and can enforce data-residency policy
- C) Landing zones are only about picking a cheaper region and have nothing to do with governance
- D) Multi-account separation is purely cosmetic and does not affect security or billing

**Correct: B.** A landing zone is the governed baseline you lay down before any
workloads: separate accounts isolate blast radius and clarify billing/ownership,
guardrails enforce standards automatically, identity and network baselines are
centralized, and it is all defined as IaC so it is repeatable and auditable —
including pinning workloads to in-country regions to satisfy residency policy.

**Q2 (Practical) — Lesson 3.2: AWS for Architects**

A customer wants to run a spiky, event-driven image-processing job with no
servers to manage, and separately needs a long-running microservices platform
their team already knows via Kubernetes. Which AWS pairing fits?

- A) Lambda for both the event-driven job and the long-running Kubernetes-style platform
- B) Lambda (serverless functions) for the spiky, event-driven image processing, and EKS (managed Kubernetes) for the microservices platform where the team wants Kubernetes portability; ECS/Fargate would be the simpler container option if they did not specifically want Kubernetes
- C) EC2 instances hand-managed for both, since serverless and managed Kubernetes add no value
- D) DynamoDB for the compute, because it scales automatically

**Correct: B.** Serverless (Lambda) fits bursty, event-driven, short-lived work
with no infrastructure to run; EKS gives managed Kubernetes when the team values
Kubernetes skills and portability, while ECS/Fargate is the lighter-weight
container choice when Kubernetes is not a requirement. Match the compute service
to the workload shape and the team's operating model.

**Q3 (Conceptual) — Lesson 3.2: AWS for Architects**

A team needs a relational database with strong consistency and complex SQL joins
for orders, plus a separate key-value store for a high-throughput shopping cart
needing single-digit-millisecond lookups. Which choice and which resilience
concept are correct?

- A) DynamoDB for the relational joins and Aurora for the key-value cart, spread across multiple Regions for low latency
- B) Aurora (managed relational, MySQL/PostgreSQL-compatible) for the transactional, join-heavy orders, and DynamoDB (managed NoSQL key-value) for the high-throughput cart; deploy across multiple Availability Zones within a Region for high availability
- C) Put everything in one service in a single Availability Zone, because AZs and Regions are the same thing
- D) Aurora for both, because NoSQL databases cannot scale

**Correct: B.** Aurora is the managed relational engine for transactional,
join-heavy SQL workloads; DynamoDB is the managed NoSQL key-value store for
massive-throughput, low-latency lookups like carts and sessions. Availability
Zones are isolated data centers within a Region — spanning multiple AZs gives HA,
while Regions are separate geographies chosen for latency, residency, and DR.

**Q4 (Conceptual) — Lesson 3.3: Azure for Architects**

An enterprise standardized on Microsoft 365 and Active Directory asks you to map
their AWS reference design onto Azure. Which mapping and Azure strength are
stated correctly?

- A) Azure has no managed Kubernetes, so containers must run on raw VMs
- B) AKS is Azure's managed Kubernetes, Azure SQL Database and Cosmos DB cover relational and globally-distributed NoSQL, and Microsoft Entra ID (formerly Azure AD) is the identity service — and Azure's particular strength is deep hybrid and identity integration with existing Microsoft and on-prem estates
- C) Cosmos DB is a relational-only engine and Azure SQL is a NoSQL store
- D) Entra ID is a billing tool unrelated to identity

**Correct: B.** Azure's equivalents are AKS (managed Kubernetes), Azure SQL
Database (managed relational) and Cosmos DB (globally-distributed multi-model
NoSQL), with Microsoft Entra ID as the identity backbone. Azure's differentiator
for many enterprises is its tight hybrid and identity integration — a natural fit
for organizations already invested in Active Directory, Microsoft 365, and
on-prem Windows workloads.

**Q5 (Practical) — Lesson 3.4: GCP for Architects**

A customer is going global and needs a relational database that stays strongly
consistent while scaling horizontally across regions, plus one anycast IP that
routes users worldwide to the nearest healthy backend. Which GCP services fit?

- A) Cloud SQL stretched across every region, fronted by a separate load balancer per region with manual DNS failover
- B) Cloud Spanner for horizontally-scalable, strongly-consistent, globally-distributed relational data, and Google Cloud's global load balancing (a single anycast IP steering users to the nearest healthy region); GKE is the managed-Kubernetes layer, and Cloud SQL remains the fit for standard single-region relational needs
- C) Bigtable for relational joins and Spanner only for caching
- D) There is no way to get a single global IP on GCP; you must run one stack per country

**Correct: B.** Spanner is Google's globally-distributed, horizontally-scalable
relational database with strong consistency — the answer when Cloud SQL (regional
managed MySQL/PostgreSQL) cannot scale globally. GCP's global load balancer
offers a single anycast IP that routes to the nearest healthy backend, and GKE is
its mature managed-Kubernetes service. Google's strengths cluster around
Kubernetes (which it originated) and global data and analytics.

**Q6 (Practical) — Lesson 3.5: OpenStack & Private Cloud**

A media company runs a large, steady, predictable compute base 24/7 and is
subject to strict data-residency law. They ask whether to stay on public cloud or
build private cloud on OpenStack. What is the sound framing?

- A) Public cloud is always cheaper, so never build private cloud regardless of scale or regulation
- B) It is a rent-vs-own break-even: public cloud wins for spiky, unpredictable, or early-stage demand, but a large, steady, predictable 24/7 base can be cheaper to own, and strict residency/sovereignty needs can force private — OpenStack is the open-source IaaS control plane that gives cloud-like self-service on your own hardware
- C) OpenStack is a public-cloud provider like AWS, so moving to it is not really private cloud
- D) Data-residency law is irrelevant to the cloud-hosting decision

**Correct: B.** The public-vs-private choice is an economic break-even, like
renting versus owning: public cloud's pay-as-you-go elasticity wins for variable
or uncertain demand, while a large, steady, always-on baseline plus strict
residency/sovereignty requirements can tip toward owning private infrastructure.
OpenStack is the open-source IaaS control plane that delivers on-demand,
self-service compute, storage, and network on hardware you operate.

**Q7 (Practical) — Lesson 3.6: Hybrid, Multi-Cloud & Migration**

A bank keeps its core system on-prem for regulatory reasons but wants to burst
analytics into a public cloud, and is separately being pushed to adopt a second
cloud "for redundancy." How should you advise, and how might they migrate the
core app?

- A) Hybrid and multi-cloud are the same anti-pattern; refuse both
- B) Hybrid (on-prem plus one public cloud working together) is a legitimate fit here for regulatory data gravity plus elastic burst; a second cloud purely "for redundancy" is often an anti-pattern that multiplies cost and complexity unless there is a real driver (lock-in avoidance, sovereignty, best-of-breed services) — and portability is best pursued via Kubernetes rather than deep managed-service coupling. For the core app, apply the 6 R's (rehost, replatform, refactor, and so on) and consider a strangler-fig migration that peels functionality off incrementally
- C) Move everything to two clouds at once in a single big-bang cutover with no fallback
- D) Multi-cloud always reduces cost and risk, so adopt as many clouds as possible

**Correct: B.** Hybrid is valid when data gravity or regulation keeps some
workloads on-prem while you burst elsewhere; multi-cloud has legitimate drivers
(lock-in avoidance, sovereignty, best-of-breed) but "redundancy" alone usually
just multiplies cost and operational burden. Portability comes from standardizing
on Kubernetes rather than wiring deeply into one provider's managed services.
Migrations are framed by the 6 R's (rehost, replatform, repurchase, refactor,
retire, retain), and the strangler-fig pattern replaces a monolith incrementally
instead of a risky big-bang.

**Q8 (Conceptual) — Lesson 3.7: Cloud Security, FinOps & Cost Optimization**

A CFO complains the cloud bill is unpredictable and asks how FinOps and cloud
security fit together. Which description is correct?

- A) FinOps is a one-time cost cut, and in the cloud the provider is responsible for securing everything including your data and configuration
- B) FinOps runs as a continuous Inform → Optimize → Operate loop (cost visibility and unit economics like cost-per-order, then rightsizing / spot / savings-plans and commitment discounts, then ongoing governance); security follows the shared-responsibility model (the provider secures the cloud, you secure what you put in it), with CSPM tooling continuously checking for misconfigurations
- C) Unit economics means the total monthly invoice, and spot instances are just discounted support plans
- D) CSPM is a compute instance type optimized for cost

**Correct: B.** FinOps is an operating model, not a one-off: Inform (cost
visibility and unit economics such as cost per order or per customer), Optimize
(rightsizing, spot/preemptible instances, savings plans and reserved
commitments), and Operate (continuous governance and accountability). Security
uses the shared-responsibility model — the provider secures the underlying cloud
while you secure your data, identities, and configuration — and CSPM (Cloud
Security Posture Management) continuously scans for risky misconfigurations.

---

## Phase 4 Question Bank — Data Platform Architecture

Eight questions covering the six Phase 4 lessons: data fundamentals (SQL vs
NoSQL families and access patterns, OLTP vs OLAP, ACID, polyglot persistence and
store selection), warehouse vs lake vs lakehouse (open table formats like
Iceberg/Delta, the medallion architecture, star schema, storage/compute
separation), streaming and CDC (batch vs streaming, Kafka topics/partitions,
log-based CDC vs polling vs dual-write, delivery guarantees), processing and
orchestration (ETL vs ELT, dbt models/tests/lineage, Airflow DAGs/retries/
backfill/idempotency, when Spark), data governance/quality/catalog (quality
dimensions and in-pipeline tests, MDM/entity resolution and the golden record,
catalog and lineage, data contracts, PII/PDP), and analytics and BI enablement
(the semantic/metrics layer, governed self-service, pre-aggregation/serving, and
persona dashboards). Present all eight (score out of 8). One option per question
is correct.

**Q1 (Conceptual) — Lesson 4.1: Data Fundamentals**

Which statement best contrasts OLTP and OLAP systems?

- A) OLTP and OLAP are two names for the same workload; the choice is purely about which vendor you buy from
- B) OLTP systems handle high volumes of short, row-oriented transactional reads and writes with ACID guarantees (e.g., an orders database), while OLAP systems are optimized for large, column-oriented analytical scans and aggregations over historical data (e.g., a warehouse) — which is why one store rarely serves both well
- C) OLAP is for transactions and OLTP is for analytics
- D) ACID guarantees only matter for OLAP analytical queries, not for OLTP transactions

**Correct: B.** OLTP means many small ACID transactions on current, operational
data (row-oriented); OLAP means fewer, heavy analytical scans and aggregations
over history (column-oriented). Running both on one store usually hurts each,
which is exactly why operational databases are separated from the analytics
platform.

**Q2 (Practical) — Lesson 4.1: Data Fundamentals**

A retailer needs one store for a product catalog with flexible, nested
attributes, another for high-throughput session and shopping-cart lookups by
key, and a third for a strongly-consistent financial ledger with complex joins.
Which approach fits?

- A) Force all three into a single relational database because one technology should serve every workload
- B) Apply polyglot persistence: a document store for the flexible, nested catalog, a key-value store for fast session/cart lookups by key, and a relational (ACID) database for the join-heavy, strongly-consistent ledger — matching each store's data model and access pattern to the workload
- C) Put everything in a key-value store because key-value is always the fastest option
- D) Choose NoSQL for all three simply because NoSQL scales and SQL does not

**Correct: B.** Polyglot persistence means picking the store whose data model and
access pattern fit each workload: document for flexible/nested data, key-value
for keyed low-latency lookups, and relational for transactional, join-heavy,
strongly-consistent data. No single family is optimal for all three access
patterns.

**Q3 (Conceptual) — Lesson 4.2: Warehouse, Lake & Lakehouse**

How does a lakehouse differ from a classic data warehouse and a raw data lake?

- A) A lakehouse is just a marketing name for a data warehouse with no technical difference
- B) A warehouse gives strong schema, governance, and fast SQL but is costly and rigid; a raw lake gives cheap, open, any-format storage but lacks transactions and easily becomes a "swamp"; a lakehouse adds an open table format (e.g., Apache Iceberg or Delta Lake) over cheap object storage to bring ACID transactions, schema, and time-travel to the lake — with storage and compute kept separate so each scales independently
- C) A data lake enforces star schemas and ACID transactions, while a warehouse stores raw unstructured files
- D) A lakehouse requires tightly coupling storage and compute onto the same servers to work

**Correct: B.** The lakehouse puts a transactional open table format (Iceberg or
Delta) over inexpensive object storage, delivering warehouse-like guarantees
(ACID, schema, time-travel) on lake-like open, cheap storage. Separating storage
from compute lets each scale on its own, unlike the tightly-coupled classic
warehouse.

**Q4 (Practical) — Lesson 4.2: Warehouse, Lake & Lakehouse**

You are organizing a lakehouse for a bank and must design both the pipeline
layering and the analytics schema. Which pairing is sound?

- A) Load everything into one giant denormalized table and let each analyst clean it themselves on every query
- B) Use a medallion architecture — bronze (raw ingested), silver (cleaned and conformed), gold (business-level aggregates) — to refine data in stages, and model the gold marts as a star schema (central fact tables surrounded by dimension tables) for fast, understandable BI queries
- C) Skip bronze and silver and expose the raw source dumps directly to executives' dashboards
- D) Model everything as one fully normalized 3NF schema because analytics queries prefer many-way joins over wide dimensions

**Correct: B.** The medallion pattern progressively refines data through bronze →
silver → gold so each layer has a clear contract and quality level, and the gold
layer is typically modeled as a star schema (facts plus dimensions) that BI
tools query efficiently and business users find intuitive.

**Q5 (Practical) — Lesson 4.3: Streaming & CDC**

A customer must propagate changes from their operational orders database into the
analytics platform in near-real-time and wants to avoid the classic consistency
trap. Which design is correct?

- A) Have the application "dual-write" — write to the database and also publish to Kafka in the same code path — since that keeps both perfectly in sync
- B) Use log-based Change Data Capture (e.g., Debezium reading the database's transaction log) to stream row changes into Kafka topics partitioned by key to preserve per-key ordering; prefer this over high-frequency polling (which adds load and can miss intermediate states) and over dual-write, which is an anti-pattern because the DB commit and the message publish can fail independently and drift out of sync
- C) Batch-export the whole table nightly, because streaming and CDC never provide any freshness benefit
- D) Poll the table every second forever, since polling is always superior to reading the transaction log

**Correct: B.** Log-based CDC (Debezium tailing the transaction log) captures
every committed change with low overhead and streams it to partitioned Kafka
topics that preserve ordering per key. Dual-write is an anti-pattern — the
database write and the publish are not atomic, so they drift — while polling adds
load and can miss intermediate changes.

**Q6 (Practical) — Lesson 4.4: Processing & Orchestration**

A cloud data team is choosing between ETL and ELT, needs reliable scheduling with
safe reruns, and wants to know when to reach for Spark. Which set of choices is
sound?

- A) Prefer ETL that transforms data on a hand-built server before loading, avoid any orchestration tool, and use Spark for every job regardless of size
- B) Use ELT — load raw data into the warehouse/lakehouse first, then transform in-place with dbt (versioned SQL models with built-in tests and auto-generated lineage); orchestrate with a tool like Airflow (DAGs with retries, scheduled backfills, and idempotent tasks so a rerun produces the same result); and bring in Spark for genuinely large-scale distributed processing rather than for small jobs the warehouse handles fine
- C) Make every pipeline task non-idempotent so re-running a failed job always double-counts the data
- D) Skip dbt tests and lineage to ship faster, and never backfill historical data

**Correct: B.** ELT pushes transformation into the scalable warehouse/lakehouse;
dbt provides versioned SQL models with tests and lineage; Airflow (or similar)
schedules DAGs with retries and backfills, and tasks should be idempotent so
reruns are safe. Spark earns its complexity for genuinely large distributed
workloads, not small jobs the warehouse already handles.

**Q7 (Conceptual) — Lesson 4.5: Data Governance, Quality & Catalog**

A regulated enterprise wants to trust its data and prove control over it. Which
description of the governance building blocks is correct?

- A) Data quality is a one-time cleanup, master data does not matter, and a catalog is unnecessary because everyone already knows where data lives
- B) Data quality is measured across dimensions (accuracy, completeness, consistency, timeliness, and more) and enforced with automated in-pipeline tests; Master Data Management with entity resolution reconciles duplicate records into a single "golden record"; a data catalog with end-to-end lineage makes datasets discoverable and traceable; data contracts set enforceable expectations between producers and consumers; and PII must be protected under a data-protection/privacy (PDP) regime
- C) A "golden record" is a backup tape, and data lineage is a type of firewall
- D) Data contracts mean the legal purchase agreement with your cloud vendor, unrelated to schemas or data quality

**Correct: B.** Quality is tracked across dimensions and enforced by tests that
run inside the pipeline; MDM and entity resolution merge duplicates into one
golden record; a catalog plus lineage delivers discovery and traceability; data
contracts make producer/consumer expectations explicit and enforceable; and PII
is governed under data-protection/privacy rules.

**Q8 (Conceptual) — Lesson 4.6: Analytics & BI Enablement**

An organization complains that every team reports a different number for "active
customers" and that all analytics requests pile up in a central BI backlog. Which
approach fixes this?

- A) Let each dashboard author redefine every metric inline, so definitions stay flexible and can differ per report
- B) Introduce a semantic/metrics layer that defines each metric (like "active customer") once, centrally and consistently, so every tool and dashboard computes it the same way; enable governed self-service (business users explore trusted, modeled data themselves within guardrails) to drain the report backlog; and pre-aggregate/serve common queries for fast, persona-specific dashboards
- C) Remove all dashboards and email raw CSV exports so people compute their own numbers however they like
- D) Keep everything locked behind the central BI team and forbid self-service entirely, accepting the growing backlog as unavoidable

**Correct: B.** A semantic (metrics) layer encodes each metric's definition once
so every consumer agrees on the number; governed self-service lets business users
answer their own questions against trusted models, relieving the BI backlog; and
pre-aggregation/serving plus persona-tailored dashboards keep it fast and
relevant.

---

## Phase 5 Question Bank — AI Platform Architecture

Eight questions covering the seven Phase 5 lessons: the LLM and model landscape
(open-weight vs closed API and confidentiality, parameters/context window/
license, quantization, self-host vs API), embeddings and vector databases
(chunking and embeddings, vector stores such as Milvus/Qdrant, HNSW vs IVF
indexes, hybrid search and metadata filtering for access control), RAG
architecture (retrieve → rerank → generate with citations, RAG vs fine-tuning,
latency budget, grounding to prevent hallucination), agents and MCP (the agent
loop and tool use, the Model Context Protocol, tool-permission scoping and
human-in-the-loop for state-changing actions, and when NOT to use an agent),
model serving and GPU sizing (vLLM continuous batching and the KV-cache, what
drives VRAM, quantization, throughput vs latency vs concurrency), evaluation,
guardrails and responsible AI (faithfulness/groundedness/citation-coverage and
retrieval-recall metrics, regression eval gates, citation-required and
injection-defense guardrails, human-in-the-loop for safety-critical decisions),
and LLMOps and the AI gateway (LiteLLM routing/fallback, rate-limiting, auth,
cost, audit and guardrail enforcement, prompt/model versioning with MLflow, and
LLM observability/drift). Present all eight (score out of 8). One option per
question is correct.

**Q1 (Conceptual) — Lesson 5.1: LLM & Model Landscape**

A hospital wants to use an LLM on sensitive patient records, but those records
must never leave its own environment. How should the open-weight vs closed-API
choice be framed?

- A) Always use the closed frontier API because it is the most capable, and
  confidentiality is fully guaranteed by the vendor's terms of service
- B) Open-weight models (downloadable weights under a stated license) can be
  self-hosted so prompts and data never leave the customer's environment —
  trading some peak capability and more operational burden for control and
  confidentiality — whereas a closed API (hidden weights, accessed over the
  network) is often more capable and lower-ops but sends prompts to the
  provider; model selection also weighs parameter count, context window, and
  license terms
- C) Open-weight and closed models are identical except for their price
- D) Self-hosting is impossible for any open-weight model, so the API is the
  only option

**Correct: B.** Open-weight models can be run on the customer's own hardware, so
confidential data stays in-house — the deciding factor for regulated,
data-residency-bound workloads — at the cost of peak capability and more ops.
Closed APIs are typically more capable and lower-maintenance but send prompts to
the provider. Beyond hosting, you compare parameters, context window, and
license.

**Q2 (Practical) — Lesson 5.2: Embeddings & Vector Databases**

A bank needs semantic search across millions of internal documents, must keep
sub-second latency at that scale, and must ensure each user only sees documents
their role is cleared for. Which design fits?

- A) Store the raw documents in a relational table and run
  `SELECT ... LIKE '%keyword%'`, since keyword matching is equivalent to
  semantic search
- B) Chunk the documents, embed each chunk into a vector, and index the vectors
  in a vector database (e.g., Milvus or Qdrant) using an approximate-nearest-
  neighbor index — HNSW (fast queries, memory-hungry) or IVF (more
  memory-efficient) — for scale; combine dense vector search with keyword
  (hybrid) search for better recall, and attach metadata to each chunk so
  queries can filter by the user's clearance, enforcing document-level access
  control at retrieval time
- C) Embed every document into one giant vector so there is a single vector to
  compare each query against
- D) Skip metadata entirely and rely on the LLM to refuse documents the user
  should not see

**Correct: B.** Semantic search needs embeddings over chunked text stored in a
vector DB, with an ANN index (HNSW for speed, IVF for memory efficiency) to hold
latency at scale. Hybrid (dense + keyword) search improves recall, and metadata
filtering enforces per-user access control at retrieval — never leaving it to the
model to self-censor.

**Q3 (Practical) — Lesson 5.3: RAG Architecture**

A customer wants an assistant that answers from their constantly-changing
internal knowledge base, must cite its sources, and must not invent facts.
Should you fine-tune a model on the documents or build RAG, and what is the
pipeline?

- A) Fine-tune the base model on the documents every night, because fine-tuning
  is how you inject new facts and it removes hallucination
- B) Build a RAG pipeline: retrieve the most relevant chunks for the question,
  rerank them so the best context leads, then have the LLM generate an answer
  grounded in — and citing — that retrieved context; RAG suits frequently-
  changing or proprietary knowledge and citation requirements better than
  fine-tuning (which bakes in style and behavior, not fresh facts), and you must
  budget latency across the retrieve → rerank → generate steps
- C) Neither — just paste all the documents into the system prompt on every call
- D) Fine-tune and forbid retrieval, then trust the model to cite sources from
  memory

**Correct: B.** RAG retrieves, reranks, then generates a grounded, cited answer,
which is the right fit for fast-changing or private knowledge and for citation
and anti-hallucination requirements. Fine-tuning shapes behavior/style, not
current facts. The retrieve → rerank → generate chain each adds latency, so the
budget must be planned.

**Q4 (Conceptual) — Lesson 5.4: Agents & MCP**

Which statement about LLM agents and the Model Context Protocol (MCP) is
correct?

- A) An agent is just a single prompt-and-response; it never calls tools or
  loops
- B) An agent runs a loop — reason, choose a tool, act, observe the result,
  repeat — to accomplish a goal, and MCP is a standard protocol for connecting
  models to tools and data sources; because agents take real actions, tools
  should be permission-scoped to least privilege and state-changing or
  irreversible actions should route through human-in-the-loop approval, while
  for simple, deterministic, single-step tasks a plain workflow or single call
  is often better than an agent
- C) MCP is a database engine, and agents should always be granted full admin
  access to every system to be useful
- D) Agents should autonomously execute irreversible actions such as payments or
  deletions with no human approval, because that is the whole point of autonomy

**Correct: B.** An agent is the reason → act → observe loop over tools; MCP is
the standard for wiring models to those tools and data. Because agents act in the
real world, tools get least-privilege scoping and state-changing actions get
human-in-the-loop review — and simple deterministic tasks do not need an agent at
all.

**Q5 (Practical) — Lesson 5.5: Model Serving & GPU Sizing**

You must serve an open-weight LLM to about 200 concurrent users on GPUs and size
the hardware. Which reasoning is sound?

- A) VRAM is driven only by the model weights, so once the weights fit you can
  serve unlimited concurrent users; batching makes no difference
- B) GPU memory must hold both the model weights AND the per-request KV-cache,
  which grows with concurrency and context length — so ~200 concurrent
  long-context sessions need substantial VRAM beyond the weights; use an
  inference server such as vLLM (continuous batching plus a paged KV-cache) to
  raise throughput, apply quantization to shrink the weights' footprint, and
  remember that throughput, latency, and concurrency trade off against one
  another when sizing
- C) Just buy the biggest GPU available; concurrency, context length, and the
  KV-cache have nothing to do with memory
- D) Quantization increases VRAM usage, so avoid it when memory is tight

**Correct: B.** VRAM is consumed by both the weights and the KV-cache, and the
KV-cache scales with the number of concurrent sessions and their context length,
so 200 concurrent users need headroom well beyond the weights. vLLM's continuous
batching and paged KV-cache lift throughput, quantization shrinks the weights,
and throughput/latency/concurrency must be balanced.

**Q6 (Practical) — Lesson 5.6: Evaluation, Guardrails & Responsible AI**

Before shipping changes to a RAG assistant, the team wants to prove answers are
trustworthy and prevent regressions. Which evaluation approach fits?

- A) Judge quality by eyeballing a couple of answers by hand and ship if they
  look fine
- B) Build an evaluation set and measure RAG-specific metrics —
  faithfulness/groundedness (is the answer actually supported by the retrieved
  context?), citation coverage, and retrieval recall (did retrieval surface the
  right chunks?) — then run that eval as an automated regression gate in CI, so a
  prompt or model change that drops the scores blocks release
- C) Only measure end-to-end latency, since answer correctness cannot be
  measured for LLMs
- D) Track accuracy on a generic public benchmark unrelated to the customer's own
  documents

**Correct: B.** RAG quality is measured with faithfulness/groundedness, citation
coverage, and retrieval recall against a curated eval set, and wiring that eval
into CI as a regression gate stops a prompt or model change from silently
degrading answers before it ever reaches users.

**Q7 (Conceptual) — Lesson 5.6: Evaluation, Guardrails & Responsible AI**

A regulated AI assistant must not answer without citing a source, must resist
users and documents trying to override its instructions, and must not
autonomously make safety-critical decisions. Which set of controls is correct?

- A) Guardrails are unnecessary if the base model is good enough, and prompt
  injection is not a real threat
- B) Apply guardrails — a citation-required policy that blocks or flags
  ungrounded answers, and prompt-injection defenses that treat retrieved and
  user-supplied content as untrusted so it cannot override the system
  instructions — and route safety-critical or high-impact decisions through a
  human-in-the-loop rather than letting the model act alone
- C) Let the model self-police with no external checks, and allow retrieved
  documents to silently change its instructions
- D) Replace all guardrails with a longer system prompt and remove human review
  to move faster

**Correct: B.** Responsible AI is enforced with explicit guardrails — require
citations (block/flag ungrounded output) and defend against prompt injection by
treating retrieved/user content as untrusted — plus human-in-the-loop review for
safety-critical decisions, rather than trusting the model to police itself.

**Q8 (Conceptual) — Lesson 5.7: LLMOps & AI Gateway**

An enterprise is putting many teams and applications onto LLMs and wants central
control over cost, access, reliability, and safety. What does an AI gateway
provide, and what else does LLMOps add?

- A) An AI gateway is just a faster GPU, and prompts or model versions never need
  tracking
- B) An AI gateway (e.g., LiteLLM) is a single control point in front of the
  models that handles routing and fallback across providers, rate-limiting,
  authentication, cost tracking/chargeback, audit logging, and centralized
  guardrail enforcement; alongside it, LLMOps versions prompts and models (e.g.,
  with MLflow) and runs LLM observability to catch drift and quality regressions
  in production
- C) The gateway should be bypassed so each team calls providers directly with
  its own keys, leaving no central cost or audit view
- D) Model and prompt versioning is unnecessary because LLM behavior never
  changes between versions

**Correct: B.** An AI gateway centralizes routing/fallback, rate-limiting, auth,
cost tracking, audit, and guardrail enforcement so many teams share one governed
entry point to the models. LLMOps complements it by versioning prompts and models
(e.g., MLflow) and running observability to detect drift and regressions in
production.

---

## Phase 6 Question Bank — Solution Architecture

Eight questions covering the seven Phase 6 lessons: architecture patterns
(monolith-vs-microservices triggers, strangler fig, choreography vs
orchestration, picking a pattern per capability), security architecture and
Zero Trust (identity as the new perimeter, sensitivity-based microsegmentation,
policy enforcement points, an AI assistant as a new attack surface), sizing and
capacity planning (multi-domain transformation sizing, assumption+formula+range
discipline, right-sizing a bounded AI feature vs a dedicated AI platform), cost
estimation and BOM (CapEx vs OpEx, one-time vs run-rate, professional services
as the biggest line item, contingency, tying the BOM to ROI/cost-to-serve),
risk/compliance/migration strategy (the risk register, phased/wave migration vs
big-bang, compliance gates before a regulated cutover), writing the HLD (HLD vs
LLD altitude, executive-legible writing, one target-architecture diagram,
leading with the ask), and writing the LLD/runbook/implementation plan (LLD
traceability to the HLD/BOM/sizing numbers, runbook purpose, week-by-week/wave
implementation planning). Present all eight (score out of 8). One option per
question is correct.

**Q1 (Conceptual) — Lesson 6.1: Architecture Patterns**

A platform team is debating whether to split a monolith into microservices.
Which trigger is the right basis for that decision?

- A) The codebase has grown past a certain line count, so it must be split
- B) The organization has multiple teams that need to deploy independently and own separate services without blocking each other, and the domain has clear bounded contexts to draw seams around
- C) Microservices are the modern default, so every system should adopt them regardless of team structure
- D) A single team maintains the whole system and deploys it together, which is exactly when microservices deliver the most value

**Correct: B.** The real trigger for microservices is organizational — independent
teams needing independent deploy cadence and clean bounded contexts (Conway's
Law) — not raw code size or fashion. A single team with one deploy cadence is
often better served by a well-modularized monolith.

**Q2 (Practical) — Lesson 6.1: Architecture Patterns**

A retailer's modernization program must retire a legacy inventory system
without a risky cutover, run real-time order fulfillment across many
independent services, and keep a simple internal reporting tool untouched.
Which framing is correct?

- A) Pick one pattern — e.g., microservices — and mandate it uniformly across every capability for consistency
- B) Retire the legacy inventory system in a single big-bang cutover, and put one central orchestrator in command of every fulfillment step with no service autonomy
- C) Use the strangler fig pattern to incrementally peel functionality off the legacy inventory system, use event-driven choreography (services reacting to events with no central conductor) for fulfillment if loose coupling and autonomy matter most, or orchestration if a clear owner must direct the sequence, and choose the pattern per capability rather than one pattern for the whole estate
- D) Choreography and orchestration are the same technique with different names, so the choice does not matter

**Correct: C.** Architecture patterns are chosen per capability based on its own
risk, coupling, and ownership needs: strangler fig retires legacy systems
incrementally and safely; choreography suits loosely coupled, autonomous
services while orchestration suits flows that need explicit, centrally-directed
sequencing; forcing one pattern onto every capability ignores those
differences.

**Q3 (Conceptual) — Lesson 6.2: Security Architecture & Zero Trust**

A bank is rolling out a Zero Trust architecture at the same time it deploys an
internal AI assistant with access to customer data. Which statement is
correct?

- A) Zero Trust means trusting any request that originates from inside the corporate network perimeter
- B) Identity becomes the new perimeter (every request is authenticated and authorized regardless of network location), segmentation is drawn around data sensitivity rather than just network zones, policy enforcement points inspect and gate traffic at each hop — and the new AI assistant itself must be treated as a new attack surface (e.g., prompt injection, data exfiltration through its outputs), not exempted from these controls
- C) Once a user is authenticated once, they should be trusted for the rest of the session with no further checks
- D) An AI assistant that only reads internal data cannot introduce new security risk and needs no additional scrutiny

**Correct: B.** Zero Trust replaces "trust the network" with "verify every
request," using identity as the perimeter, microsegmenting by data sensitivity,
and enforcing policy at explicit enforcement points. An AI assistant with
access to sensitive data is a new attack surface — injection, exfiltration,
over-broad tool permissions — and must be brought inside the same Zero Trust
controls, not carved out as an exception.

**Q4 (Practical) — Lesson 6.3: Sizing & Capacity Planning**

You are sizing a multi-domain digital transformation program spanning
infrastructure, data, and a narrow, bounded AI chatbot feature (not a
dedicated AI platform). Which approach is sound?

- A) Size only the AI chatbot in detail since AI is the most visible part, and skip formal sizing for infrastructure and data because they are "commodity"
- B) State the sizing assumptions and formulas used for each domain, express results as ranges rather than falsely precise single numbers, size infrastructure and data independently of the AI feature's needs, and recognize that a narrow, bounded AI feature typically needs only a modest GPU footprint — unlike a dedicated AI platform serving many use cases, which must be sized for much larger sustained and peak demand
- C) Assume the AI feature will need the same GPU capacity as a dedicated multi-tenant AI platform, since all AI workloads scale identically
- D) Produce one combined number for the whole transformation with no stated assumptions, since stakeholders prefer a single figure

**Correct: B.** Sound sizing states its assumptions and formulas explicitly and
gives ranges rather than spuriously precise single numbers, sizes each domain
on its own drivers, and right-sizes AI compute to the actual workload — a
single bounded feature needs far less GPU capacity than a dedicated AI
platform built to serve many concurrent use cases.

**Q5 (Conceptual) — Lesson 6.4: Cost Estimation & BOM**

Which description of a Bill of Materials (BOM) for a solution proposal is
correct?

- A) A BOM should only list one-time hardware CapEx; recurring OpEx and labor do not belong in a BOM
- B) A BOM should separate CapEx from OpEx and one-time costs from run-rate costs, typically finds that professional services/labor is the largest line item rather than the hardware or software itself, includes a contingency line for estimating uncertainty, and should tie back to the customer's ROI or cost-to-serve target rather than stand alone as a number
- C) Contingency is padding that should always be stripped out to make the proposal look cheaper
- D) Professional services and labor are always a minor, negligible cost compared to hardware and licensing

**Correct: B.** A well-built BOM cleanly separates CapEx/OpEx and one-time/
run-rate spend, is honest that professional services and implementation labor
is very often the single biggest line item (not the hardware), carries a
contingency buffer for estimating uncertainty, and is framed against the
customer's ROI or cost-to-serve target so the number means something rather
than floating in isolation.

**Q6 (Practical) — Lesson 6.5: Risk, Compliance & Migration Strategy**

A regulated healthcare customer needs to migrate its claims platform to a new
architecture. Which approach is sound?

- A) Execute a single big-bang cutover on go-live night with no risk register, since phased migration just adds project overhead
- B) Maintain a risk register that scores each risk by likelihood × impact, defines a mitigation, and assigns a named owner; migrate in phased/wave cutovers rather than one big-bang event to contain blast radius; and require compliance sign-off gates before any regulated data or process is cut over
- C) Skip compliance review until after go-live, since it can be handled retroactively
- D) Only track risks that already have zero likelihood of occurring, and ignore the rest

**Correct: B.** A risk register (likelihood × impact, mitigation, owner) keeps
risk visible and actionable; phased/wave migration contains the blast radius of
each cutover far better than a single big-bang event; and regulated systems
need compliance gates cleared before, not after, a cutover that touches
protected data or processes.

**Q7 (Conceptual) — Lesson 6.6: Writing the HLD**

What distinguishes a High-Level Design (HLD) from a Low-Level Design (LLD),
and what makes an HLD effective for an executive audience?

- A) An HLD and LLD are interchangeable; either can be handed to an executive sponsor
- B) An HLD sits at a business-and-architecture altitude — written so an executive sponsor can read and approve it, built around a single clear target-architecture diagram rather than ten detailed ones, and opens by leading with the ask or recommendation — while the LLD drops down to component-level, implementation-ready detail
- C) An HLD should contain the same level of configuration detail as an LLD so nothing is left ambiguous
- D) The best way to open an HLD is with a lengthy technical appendix before stating any recommendation

**Correct: B.** The HLD operates at a higher altitude than the LLD: it is
written to be executive-legible, anchors on one clear target-architecture
diagram instead of a pile of detailed ones, and leads with the ask or
recommendation up front rather than burying it. The LLD is where
implementation-level detail belongs.

**Q8 (Practical) — Lesson 6.7: Writing the LLD, Runbook & Implementation Plan**

While writing the LLD, the runbook, and the implementation plan for an
already-approved HLD, which practice is correct?

- A) Re-derive fresh sizing and cost numbers in the LLD independently of the HLD and BOM, since more up-to-date math looks more rigorous
- B) The LLD should trace directly back to the HLD's architecture and to the sizing/BOM numbers already produced — re-deriving fresh numbers at this stage is a credibility risk if they do not match; the runbook exists to give operators step-by-step operational procedures; and the implementation plan should be sequenced week-by-week (or wave-by-wave) rather than left as a vague single milestone
- C) A runbook is just a rebranded copy of the HLD with no operational content
- D) The implementation plan should have no schedule detail since scope always changes anyway

**Correct: B.** The LLD must trace to the HLD's architecture and the
already-agreed sizing/BOM figures — inventing new numbers here undermines trust
in the whole proposal if they disagree. The runbook captures concrete
operational procedures (start/stop, failover, troubleshooting) for the people
running the system, and the implementation plan lays out a week-by-week or
wave-by-wave schedule so delivery is trackable, not just an amorphous end date.

---

## Phase 7 Question Bank — Presales Mastery

Eight questions covering the seven Phase 7 lessons: technical storytelling and
messaging (the Situation→Complication→Resolution→Payoff narrative arc,
message-market fit across CFO/CIO/COO/CEO audiences, and the "so what" test),
whiteboarding and architecture communication (the layered-reveal technique,
narrating while drawing, and holding the thread through interruptions), demo
design and delivery (scoping the demo to exactly what is proposed, the "one
thing this must prove" discipline, and a fallback for live failure), proposal
and executive summary writing (proposal vs HLD altitude and audience, the
executive summary as a standalone document, and BOM traceability), commercial
awareness/pricing/ROI (pricing structures and risk transfer, and a defensible
ROI/TCO built on sensitivity ranges rather than one falsely precise number),
competitive analysis and objection handling (battlecard anatomy, the
acknowledge→reframe→evidence→check framework, and pre-empting objections from
your own risk register), and executive presentation and negotiation (leading
an executive deck with the ask, the SA's negotiation lane, and reading the true
economic buyer via MEDDICC). Present all eight (score out of 8). One option per
question is correct.

**Q1 (Conceptual) — Lesson 7.1: Technical Storytelling & Messaging**

Which structure describes the standard narrative arc for presenting a solution
to a customer?

- A) Payoff → Resolution → Complication → Situation, so you always lead with the win
- B) Situation → Complication → Resolution → Payoff: establish the customer's current state, surface the tension or problem that threatens it, present the solution that resolves that tension, then land the business payoff it unlocks
- C) Complication → Payoff → Situation → Resolution, because the problem should always come before any context
- D) A features list ordered alphabetically by product module

**Correct: B.** The arc grounds the audience in their own current state
(Situation), names the tension that makes the status quo untenable
(Complication), introduces the proposed solution as the way through it
(Resolution), and closes on the concrete business outcome it delivers
(Payoff) — the same shape as any persuasive story, applied to a technical pitch.

**Q2 (Practical) — Lesson 7.1: Technical Storytelling & Messaging**

You have one fact — "the new platform cuts batch-processing time from 6 hours
to 40 minutes" — and must brief a CFO, a CIO, a COO, and a CEO in turn. What is
the right approach, and what test should every version pass?

- A) Recite the exact same sentence to all four, since the fact itself never changes
- B) Reframe the same underlying fact into each audience's own terms — e.g., cost avoidance and payback period for the CFO, architectural risk and reliability for the CIO, throughput and operational SLAs for the COO, competitive speed-to-market for the CEO — and run each version through a "so what" test: if the audience cannot say why it matters to them, reframe again
- C) Only brief the CIO, since technical facts belong exclusively to technical stakeholders
- D) Add more technical jargon for executives so the depth of the work is obvious

**Correct: B.** Message-market fit means the underlying fact stays constant
while the framing shifts to what each stakeholder actually optimizes for; the
"so what" test is the check that a message has been translated into terms that
audience will act on, not just restated.

**Q3 (Practical) — Lesson 7.2: Whiteboarding & Architecture Communication**

You are whiteboarding a target architecture live for a mixed technical and
business audience. Which approach keeps the room following you, and what do
you do when someone interrupts with a tangential question?

- A) Draw the complete, fully-detailed diagram first in silence, then explain it all at once at the end
- B) Use a layered-reveal technique — build the diagram progressively, one layer at a time (e.g., users, then services, then data, then security), narrating each addition as you draw it — and when interrupted, acknowledge the question, give a short direct answer or park it for later, then explicitly return to the point in the diagram where you left off
- C) Ignore all interruptions completely so the flow of drawing is never broken
- D) Erase and restart the whole diagram from scratch every time a question is asked

**Correct: B.** Revealing the architecture layer by layer while narrating keeps
a mixed audience oriented and builds understanding incrementally instead of
dumping a wall of boxes and arrows; handling an interruption by acknowledging
it, answering or parking it, and then explicitly resuming keeps the thread
intact instead of losing the room.

**Q4 (Practical) — Lesson 7.3: Demo Design & Delivery**

You are designing a customer demo two days before the meeting. Which practice
is sound?

- A) Show every capability the product could ever do, including features that are not part of the current proposal, to maximize perceived value
- B) Scope the demo to exactly what has been proposed (never demonstrate beyond it, since that sets expectations you have not committed to deliver), decide the one specific thing this demo must prove before you build it, and prepare a fallback (recording, screenshots, or a backup environment) in case the live demo fails
- C) Skip planning entirely and improvise live, since spontaneity reads as confidence
- D) Assume nothing will go wrong technically, so a fallback plan is unnecessary

**Correct: B.** A demo that wanders beyond the proposed scope creates promises
you have not priced or committed to; deciding the single thing it must prove
keeps it focused and measurable; and because live software fails in front of
customers more often than anyone likes to admit, a fallback protects the
meeting from a technical hiccup derailing the whole pitch.

**Q5 (Conceptual) — Lesson 7.4: Proposal & Executive Summary Writing**

How should a proposal and its executive summary relate to the HLD and to the
BOM?

- A) The proposal is simply the HLD with a different cover page, and the executive summary is optional filler
- B) The proposal is shorter and more sales-forward than the HLD, written for a commercial/executive audience rather than a technical one; its executive summary must stand alone as a complete document (a reader who reads only that page should still get the recommendation and the ask); and every number quoted in the proposal must trace exactly to the BOM — a mismatch damages credibility
- C) The executive summary should contain only technical implementation detail, since executives want the same depth as engineers
- D) Numbers in the proposal can round differently from the BOM as long as they are roughly close

**Correct: B.** A proposal is pitched at a different altitude and audience than
the HLD — shorter, sales-forward, decision-oriented — and its executive summary
must work as a fully standalone artifact for readers who go no further.
Traceability discipline means every figure in the proposal must match the BOM
exactly; any drift undermines trust in the whole document.

**Q6 (Conceptual) — Lesson 7.5: Commercial Awareness, Pricing & ROI**

A customer asks for a fixed-price contract for a project with significant
scope uncertainty, and separately wants a headline ROI number for the board.
Which framing is sound?

- A) Any pricing structure carries identical risk for the vendor, so structure is just a formality; ROI should be quoted as one precise number so it looks credible
- B) Pricing structures (fixed-price, time-and-materials, milestone-based, outcome-based) each transfer risk differently between vendor and customer, so the structure should match how well the scope is actually known; and a defensible ROI/TCO is built with sensitivity ranges around the key assumptions rather than a single suspiciously-precise figure, which signals the estimate has not been stress-tested
- C) Time-and-materials pricing always caps the customer's cost, so it is the least risky option for them
- D) Outcome-based pricing removes all risk from the vendor by definition

**Correct: B.** Fixed-price shifts scope-overrun risk to the vendor, T&M shifts
it to the customer, milestone-based ties payment to delivery checkpoints, and
outcome-based ties it to results — the right choice depends on how well-defined
the scope is. A trustworthy ROI/TCO shows a range driven by explicit
assumptions (and how sensitive the result is to each one), rather than a single
precise-looking number that invites the question "how do you know that
exactly?"

**Q7 (Practical) — Lesson 7.6: Competitive Analysis & Handling Objections**

A prospect raises an objection mid-pitch: "Your competitor claims their
platform is 30% cheaper." How should you handle it, and how should this kind
of objection ideally have been avoided?

- A) Deny the competitor's claim outright with no evidence and move on quickly
- B) Use the acknowledge → reframe → evidence → check framework: acknowledge the concern without getting defensive, reframe the comparison onto the terms that actually matter (e.g., total cost of ownership, not sticker price), back it with concrete evidence (a battlecard-backed TCO comparison), and check that the reframe actually landed with the prospect; ideally this objection was already pre-empted earlier in the pitch by surfacing it proactively from your own risk register rather than waiting for the prospect to raise it
- C) Concede that the competitor is definitely cheaper and pivot to a different topic
- D) Argue price point by point from memory with no supporting battlecard material

**Correct: B.** The framework de-escalates first (acknowledge), shifts the frame
to the metric that actually matters (reframe), grounds the reframe in real
evidence such as a prepared battlecard (evidence), and confirms the objection is
actually resolved (check). The strongest version of objection handling gets
ahead of known objections — drawn from your own risk register — by addressing
them before the prospect has to ask.

**Q8 (Practical) — Lesson 7.7: Executive Presentation & Negotiation**

In the final executive presentation and negotiation stage, which practices are
sound?

- A) Bury the recommendation at the end of a long deck, negotiate by discounting price whenever the customer pushes back, and assume whoever speaks most in the room is the real decision-maker
- B) Structure the executive deck to lead with the ask up front rather than building up to it; know the solution architect's actual negotiation lane — trading concessions like scope, timeline, or resourcing rather than price, and never conceding something for free without getting something back — and use MEDDICC to identify the true economic buyer in the room, who is not always the loudest or most technical voice
- C) Only ever negotiate on price, since that is the one lever an SA is authorized to move
- D) Skip preparing for the executive meeting since the proposal document already said everything that needs saying

**Correct: B.** Executive audiences want the recommendation first, with support
following, not a slow build-up. An SA's negotiation lane is typically scope,
timeline, and resourcing trade-offs rather than price (which usually sits with
sales/commercial ownership), and concessions should always be exchanged for
something, never given away free. MEDDICC's economic-buyer discipline reminds
you that the real budget holder is not necessarily the most vocal or most
technical person at the table.
