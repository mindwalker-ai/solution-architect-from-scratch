---
name: find-your-level
version: 1.1.0
description: >
  Placement quiz that maps what you already know across business & consulting,
  infrastructure, cloud, data, AI, architecture, and presales to a starting
  phase (0–7) in the AI, Data & Infrastructure Solution Architect (Presales)
  curriculum — 8 phases, 53 lessons — so you skip what you know and land where
  the challenge starts.
  Trigger phrases: "where should I start", "find my level", "what do I know",
  "which phase", "assess my knowledge", "placement test", "skip ahead"
tags: [assessment, onboarding, curriculum, solution-architect, presales]
---

# Find Your Level

You are administering a placement quiz for the **AI, Data & Infrastructure
Solution Architect (Presales)** curriculum (8 phases, 53 lessons). Your job is
to figure out where the learner should begin so they skip material they already
know and land right where the challenge starts.

## Quiz Structure

There are 5 knowledge areas, 2 questions each, 10 questions total. The areas
span the whole track — from consulting fundamentals through infrastructure,
cloud, data & AI platforms, to solution architecture and presales. Present the
questions in rounds of 2 (one round per area). After the learner answers both
questions in a round, score that area before moving on.

## Scoring

Each question is worth 1 point (0 = wrong or blank, 1 = correct). Each area
scores 0–2. Total score ranges from 0 to 10.

## Administering the Quiz

Start by greeting the learner briefly, then jump straight into Round 1. Use
**AskUserQuestion** for every question. After each round, tell the learner
their score for that area (e.g. "Business & Consulting: 2/2") before moving to
the next round. Keep commentary short. Do not explain the answers until the
very end.

---

### Round 1 — Business & Consulting  (maps to Phase 1)

**Q1.** During a discovery meeting, a stakeholder says "we want to reduce
operating costs." What is the most useful next question for a solution
architect to ask?

- A) "Which cloud provider do you prefer?"
- B) "What does 'reduce costs' mean in numbers — which costs, by how much, by when?"
- C) "Should we use Kubernetes or serverless?"
- D) "How many servers do you currently own?"

**Correct: B** (turn a vague goal into a measurable business outcome before
touching technology).

**Q2.** In a typical enterprise application landscape, what does an ERP system
primarily handle?

- A) Real-time video streaming to customers
- B) Core business processes like finance, procurement, and inventory
- C) Wireless network configuration
- D) GPU scheduling for model training

**Correct: B** (ERP = enterprise resource planning: finance, supply chain, HR,
and related core operations).

---

### Round 2 — Infrastructure  (maps to Phase 2)

**Q3.** Which statement best describes the difference between a virtual machine
and a container?

- A) They are identical; the names are interchangeable
- B) A VM runs a full guest OS on a hypervisor; a container shares the host OS kernel and packages just the app and its dependencies
- C) A container always includes its own guest OS; a VM does not
- D) A VM can only run stateless workloads; a container can only run databases

**Correct: B.**

**Q4.** In Kubernetes, what is the smallest deployable unit that the scheduler
places onto a node?

- A) A container image
- B) A Pod
- C) A namespace
- D) A Deployment

**Correct: B** (a Pod wraps one or more containers and is the unit Kubernetes
schedules).

---

### Round 3 — Cloud  (maps to Phase 3)

**Q5.** In the IaaS / PaaS / SaaS model, which responsibility stays with the
customer under **IaaS** but is handled by the provider under **PaaS**?

- A) The physical data-center hardware
- B) The operating system and runtime patching
- C) The end-user application features
- D) The building's power and cooling

**Correct: B** (IaaS = you manage the OS/runtime up; PaaS abstracts the OS and
runtime away).

**Q6.** A customer wants to keep sensitive workloads in their own data center
while running elastic, bursty workloads in a public cloud, with connectivity
between them. What is this called?

- A) A single-region deployment
- B) A hybrid cloud architecture
- C) A monolith
- D) An air-gapped network

**Correct: B.**

---

### Round 4 — Data & AI Platforms  (maps to Phases 4–5)

**Q7.** What is the main difference between OLTP and OLAP systems?

- A) OLTP is for high-volume transactional reads/writes; OLAP is for analytical queries over large datasets
- B) OLTP is always NoSQL; OLAP is always SQL
- C) OLTP stores images; OLAP stores text
- D) They are two names for the same workload

**Correct: A.**

**Q8.** In a Retrieval-Augmented Generation (RAG) system, what happens before
the LLM generates its answer?

- A) The model is retrained on the user's query
- B) Relevant documents are retrieved (often via a vector database) and injected into the prompt
- C) The user manually pastes in all the context every time
- D) The model searches only its own frozen weights

**Correct: B.**

---

### Round 5 — Solution Architecture & Presales  (maps to Phases 6–7)

**Q9.** In the solution architect's workflow, which sequence of artifacts is
correct?

- A) Proposal → HLD → Requirements → LLD → Bill of Materials
- B) Requirements (discovery) → High-Level Design → Low-Level Design → Bill of Materials → Proposal
- C) Bill of Materials → Requirements → Proposal → HLD → LLD
- D) HLD → Requirements → LLD → Proposal → Bill of Materials

**Correct: B** (discover, design high-level, detail it low-level, cost it,
then package the proposal).

**Q10.** During a presales demo, a prospect raises a strong objection about a
missing feature. What is the best immediate response?

- A) Argue that the feature is unnecessary
- B) Acknowledge it, clarify the underlying need, and address it honestly (roadmap, workaround, or trade-off)
- C) Ignore it and continue the scripted demo
- D) Immediately offer the largest possible discount

**Correct: B** (understand the real need behind the objection before
responding).

---

## After All 5 Rounds

Display the area breakdown and total:

```
Business & Consulting:            X/2
Infrastructure:                   X/2
Cloud:                            X/2
Data & AI Platforms:              X/2
Solution Architecture & Presales: X/2
--------------------------------------
Total:                            X/10
```

## Score-to-Entry-Point Mapping

| Total Score | Entry Point | What It Means |
|-------------|-------------|---------------|
| 0–2 | Phase 0: Foundations | Start from the ground up — build core literacy first |
| 3–4 | Phase 1: Business & Consulting Foundation | You have baseline literacy; begin the consulting track |
| 5–6 | Phase 2: Infrastructure Architecture | Consulting basics are solid; build technical depth |
| 7–8 | Phase 4: Data Platform Architecture | Infra and cloud are solid; move on to data and AI platforms |
| 9–10 | Phase 6: Solution Architecture | Strong across the board; go straight to synthesis and presales |

## Personalized Learning Path

After revealing the entry point, generate a markdown table covering all 8
phases (0–7). Use the score to determine the status of each phase:

- Phases **below** the entry point → "Skip" (the learner already knows the
  material).
- Phases **at or above** the entry point → "Do".
- If a learner scored **1/2** in an area that maps to a skippable phase, mark
  that phase as "Review" instead of "Skip" (they should skim it).

Area-to-phase mapping for review detection:

- Business & Consulting (1/2) → mark **Phase 1** as "Review"
- Infrastructure (1/2) → mark **Phase 2** as "Review"
- Cloud (1/2) → mark **Phase 3** as "Review"
- Data & AI Platforms (1/2) → mark **Phases 4 and 5** as "Review"
- Solution Architecture & Presales (1/2) → mark **Phases 6 and 7** as "Review"

Phase 0 (Foundations) has no dedicated round: mark it "Skip" when the entry
point is above Phase 0, or "Do" when the entry point is Phase 0.

Read the time estimates from ROADMAP.md (the canonical source of truth). Each
phase section contains a lesson table where every lesson row ends with an hour
estimate in the format `~Nh`. Sum the per-lesson `~Nh` values within a phase's
table to get that phase's total hours. Parse these values instead of using
hardcoded numbers so the learning path stays in sync with the roadmap as
estimates are updated.

## Output Format

Generate the table like this:

```markdown
| Phase | Name | Status | Est. Hours |
|-------|------|--------|------------|
| 0 | Foundations | Skip | -- |
| 1 | Business & Consulting Foundation | Review | 28 |
| 2 | Infrastructure Architecture | Do | 34 |
| 3 | Cloud Architecture | Do | 34 |
| ... | ... | ... | ... |
```

Rules for the table:

- "Skip" phases show `--` for hours (they do not count toward the total).
- "Review" phases show full hours (the learner should skim them).
- "Do" phases show full hours.
- Sum the hours for "Review" and "Do" phases and show the total at the bottom.

After the table, add one sentence with the estimated total: "Your personalized
path: ~X hours across Y phases."

Then add a brief recommendation: which phase to start with, and what to focus
on first based on their weakest area.
