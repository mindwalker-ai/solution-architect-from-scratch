# Lesson Template

Use this template when creating a new lesson. Copy the folder structure and fill in the content. This track adapts the "from scratch" pedagogy to solution architecture: **you don't build the product — you design, size, price, and defend it. Every lesson ships a consulting deliverable.**

## Folder Structure

```
NN-lesson-name/
├── docs/
│   └── en.md               (the canonical lesson — REQUIRED)
├── outputs/
│   ├── template-*.md       (a reusable deliverable template — HLD, BOM, sizing, proposal…)
│   ├── example-*.md        (a worked example for a fictional customer)
│   └── diagram-*.{md,svg}   (architecture/topology diagrams — Mermaid/SVG)
└── lab/                    (OPTIONAL: copy-run commands / compose files to validate a design claim)
    └── README.md
```

## Documentation Format (docs/en.md)

```markdown
# [Lesson Title]

> [One-line motto — the idea that sticks]

**Type:** Learn | Design | Present
**Track:** AI, Data & Infrastructure Solution Architect (Presales)
**Prerequisites:** [prior lessons / phase]
**Time:** ~[estimate]
**Lab:** [local/free-tier lab, or —]
**Ship It:** [the deliverable this lesson produces]

## The Problem

[2-3 paragraphs. A concrete customer situation you can't handle without this —
a discovery you'd botch, an architecture you'd oversize, a deal you'd lose.]

## The Concept

[The mental model, with diagrams and trade-off tables. No tooling yet.
Build the way an architect reasons before drawing a single box.]

## Design It

[Hands-on architecture. Given a scenario, produce the artifact step by step:
the decision, the diagram, the sizing, the trade-off rationale. This is where
the learner does the SA's actual job.]

### Step 1: [Name]
[Explanation + the design decision / calculation]

### Step 2: [Name]
...

## Compare It

[How real vendors and tools solve this, and when to pick which. Name the
products (VMware, AWS, Ceph, Kafka, vLLM, …), the trade-offs, and the
"it depends" that a customer will ask about.]

## Ship It

[The reusable deliverable — an HLD/LLD, a BOM, a sizing sheet, a TCO/ROI model,
a discovery kit, a proposal, a battlecard, a demo script. Save it under outputs/.]

## Exercises

1. [Easy — reinforce the core idea]
2. [Medium — apply it to a different customer/scenario]
3. [Hard — extend, or combine with a prior lesson's deliverable]

## Key Terms

| Term | What people say | What it actually means |
|------|----------------|------------------------|
| [term] | [common misconception] | [actual definition] |

## Further Reading

- [Resource 1](url) — [why it's worth reading]
- [Resource 2](url) — [why it's worth reading]
```

## Deliverable Guidelines

- Every `Ship It` artifact must be **reusable on a real deal** — a template a colleague could pick up and fill in.
- Include one **worked example** against a fictional customer so the template isn't abstract.
- Sizing/cost artifacts: state assumptions explicitly, show the formula, and give a sanity-check range. Never present a single magic number.
- Diagrams: Mermaid or SVG, with a legend. An architect's diagram must be readable by both an engineer and an executive.
- Labs are optional and local/free-tier only; they exist to **validate a design claim**, not to build a product.

## Output File Format

### Deliverable template

```markdown
---
name: template-name
description: The deliverable this template produces (HLD, BOM, sizing sheet…)
phase: [phase number]
lesson: [lesson number]
audience: [customer | internal | executive]
---

[The fill-in-the-blank template + a worked example]
```
