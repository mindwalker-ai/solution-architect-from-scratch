---
name: example-cakrawala-whiteboard-playbook
description: Worked Whiteboard Playbook + Recording for the fictional Cakrawala Group board session — a live six-layer build of the 6.6 target architecture, including a fully handled skills-gap interruption
phase: 7
lesson: 2
audience: internal | customer
---

# Whiteboard Playbook + Recording — Cakrawala Group

> This is `template-whiteboard-playbook.md` filled in for the running Phase 6/7 customer. It shows what "good" looks like: the 6.6 HLD's target-architecture diagram, sequenced into six live reveals, narrated against the 7.1 core message, and interrupted by exactly the risk Cakrawala's own 6.5 risk register already flagged as the highest-scored item on the board.

**Customer:** Cakrawala Group (fictional)  ·  **Engagement:** Group Technology Platform Modernization — Capstone F
**Prepared by:** SA — Presales  ·  **Date:** 2026-07-05  ·  **Version:** v1.0 (rehearsed)  ·  **Source diagram:** 6.6 HLD §3, Target Architecture
**Audience:** CIO (technical, sign-off authority) + 5 board members (mixed technical depth)  ·  **Format:** in-person  ·  **Tool:** physical whiteboard (with a Miro fallback pre-staged for a remote repeat session)

**Context this playbook responds to:** a rival global systems integrator has pitched the same board with a structurally similar shared-platform concept, delivered as a read-through deck. This session is deliberately live, to demonstrate ownership of the architecture rather than recite it.

---

## 1. Draw-sequence table

| Step | Box / element | Color (physical) or lane (virtual) | One-line narration | Serves which message |
|---|---|---|---|---|
| 1 | 3 BU boxes: Retail (~350 outlets), Logistics (~40 hubs), Finance & Leasing (1 back office) | neutral outline | "Three business units, three legacy stacks that don't talk to each other today." | Sets up the ask |
| 2 | Shared Platform box (~40 Kubernetes nodes + 1 lakehouse) | blue | "One shared platform replaces three — this is where the 15–20% cost-to-serve target comes from." | The ask |
| 3 | Legacy links: strangler-fig arrows (Retail, Logistics) + anti-corruption layer (Finance & Leasing) | orange (legacy) + green (ACL) | "Nothing is ripped out on day one — each legacy system is strangled off at its own pace, and finance-leasing's core is protected by a translation layer until it's safe to touch." | Architecture in one sentence |
| 4 | Integration: API gateway + event bus | purple | "This bus is the only reason three business units can share one platform without stepping on each other's data." | Architecture in one sentence |
| 5 | Security: zero-trust boundary around the Finance & Leasing enclave | pink | "Finance-leasing sits behind its own wall — a retail incident can never become a compliance incident." | Risk in one sentence |
| 6 | GPU node / AI ops-copilot (smallest box, added last) | blue, smaller | "And once that platform is standing, this is the smallest, safest place to add the AI ops-copilot everyone in this room actually wants to talk about." | The payoff, last |

**Rule of thumb applied:** the AI ops-copilot — the component every board member in the room actually came to hear about — is deliberately last and drawn smallest. It lands as the payoff sitting on top of the platform and risk story, not as the whole pitch.

## 2. Narration script

> **Step 1:** *(draw three boxes, label them)* "Let me start simple. Three business units — Retail, Logistics, Finance & Leasing — three legacy stacks. Today, none of them talk to each other." *(pause, marker down)*
> **Step 2:** *(draw the platform box underneath, spanning all three)* "Underneath all three, one shared platform. This is the ~40-node Kubernetes footprint and the lakehouse from our sizing work — and it's the single biggest reason we can promise a 15 to 20 percent cost-to-serve reduction: one platform to run, not three." *(pause)*
> **Step 3:** *(draw dotted arrows from legacy to new, then the green ACL box on the Finance & Leasing side)* "We don't touch anything on day one. Retail and Logistics get strangled off their legacy systems gradually — old and new run side by side until we're confident. Finance & Leasing is different: its legacy core isn't touched at all yet. It sits behind an anti-corruption layer — a translation boundary — until its migration wave clears compliance." *(pause)*
> **Step 4:** *(draw the gateway and the bus, connecting all three BUs to the platform)* "This bus is the plumbing. It's the only reason three business units, each with their own systems of record, can share one platform without one BU's traffic colliding with another's." *(pause)*
> **Step 5:** *(draw a boundary line around the Finance & Leasing box and the ACL)* "This boundary is zero trust — every call across it is authenticated regardless of what network it comes from. A Retail incident cannot become a Finance & Leasing incident. That's not a slogan, that's the reason this box is drawn separately from the other two." *(pause — the interruption below lands here)*
> **Step 6:** *(draw one small box, last, off to the side of the platform)* "Last, and smallest on purpose: the AI ops-copilot everyone's been asking about. It's small because it's the payoff sitting on top of everything we just built, not the foundation — and putting it up first would have told you the wrong story about where the risk and the cost actually are."

## 3. Parking-lot log (predicted interruptions)

| Predicted question | Likely arrives at step | Park or answer immediately? | Prepared answer (cite the source artifact) |
|---|---|---|---|
| "Who operates this ~40-node platform day two — our team runs the legacy stacks today." | Step 5 (security boundary) | **Park** — the full answer needs the whole picture drawn first | 6.5 risk register, risk #1 (score 9, highest on the register): staged SI-partner-led delivery, named knowledge-transfer milestones, explicit exit criteria before full internal handover |
| "What happens if the event bus goes down mid-migration?" | Step 4 (integration) | Answer immediately, one sentence | 6.5 risk #6: idempotency keys + nightly reconciliation job during every parallel-run window |
| "Why not just buy one platform from the other integrator pitching us?" | Step 2 or after close | Park if it derails Step 2's pacing; otherwise answer immediately | 6.1 pattern rationale (strangler-fig avoids a rip-and-replace); Compare It §, "out-reason, don't out-slide" |
| "What's the actual budget and timeline?" | After Step 6, at close | Answer immediately — it's the closing line | 6.6 HLD §1 Executive Summary: ~Rp 52B (band 48–58B), 12–18 months, 3 waves |

## 4. The recording — full written play-by-play

```
CAKRAWALA GROUP — BOARD WHITEBOARD SESSION — WRITTEN PLAY-BY-PLAY
Presenter: SA (Presales)  ·  Audience: CIO (technical) + 5 board members (mixed) ·  Format: in-person

[00:00] SA picks up blue marker, draws 3 boxes labeled Retail / Logistics / Finance & Leasing.
        SAYS: Step 1 narration. Pauses, marker down.

[00:45] SA draws Shared Platform box beneath the three, in blue.
        SAYS: Step 2 narration. Pauses.

[01:45] SA draws dotted "strangled by" arrows from each legacy box into the platform,
        then the green ACL box on the Finance & Leasing side.
        SAYS: Step 3 narration. Pauses.

[03:00] SA draws the API gateway and event bus connecting all three BUs into the platform.
        SAYS: Step 4 narration. Pauses.

[04:15] SA draws the pink boundary line around Finance & Leasing + the ACL.
        SAYS: Step 5 narration, first sentence.

[04:40] ── INTERRUPTION ──
        CIO: "Before you go on — who's actually going to operate this ~40-node platform
              day two? Our team runs the legacy stacks today. This is a different skill set."

        SA:  "That's the right question to ask before we go further — I'm going to write it
              here [points to a dedicated corner of the board, writes: 'Q: day-2 skills gap']
              and I will come back to it before we close. Let me finish this security picture
              first, because the answer to your question actually depends on what I'm about
              to draw." [taps the parking-lot note once, resumes]

[04:55] SA finishes Step 5 narration (the zero-trust boundary sentence), pauses.

[05:40] SA draws the small AI ops-copilot box, last.
        SAYS: Step 6 narration.

[06:30] ── RETURN TO PARKING LOT ──
        SA: [walks to the parking-lot corner, taps the noted question]
            "Back to your question — who operates this day two. You're right that a mixed-
            skill team operating a new Kubernetes and lakehouse platform is the single
            highest risk in our own register — higher-scored than any compliance risk on
            this board. Our answer is a staged, SI-partner-led delivery: we operate
            alongside your team through the migration, with named knowledge-transfer
            milestones and explicit exit criteria before we hand full operation back to you.
            We don't call it done until your team can run it without us — that's written
            into the delivery model, not left as a training slide."

[07:15] SA steps back from the board, gestures at the full six-layer diagram.
        SAYS (closing): "So: one platform under three business units, migrated wave by
              wave with the riskiest unit protected and going last, and the skills question
              you just raised built into the delivery model from day one, not bolted on
              after. That's the ~Rp 52 billion ask, and that's the plan to earn it."

[07:45] SA opens the floor. Parking lot is empty — the only item written on it was answered
        on the record before the close.
```

## 5. Rehearsal log

| Rehearsal # | Date | Ran with | Timing (target vs actual) | What broke / what to fix |
|---|---|---|---|---|
| 1 | 2026-06-28 | Solo, timed | Target 8 min, actual 11 min | Step 3 narration ran long — trimmed the legacy-link sentence from two clauses to one |
| 2 | 2026-07-01 | Colleague playing CIO, in-person | Target 8 min, actual 8:30 | First run of the skills-gap interruption felt scripted; re-drilled the park-and-resume line until it sounded natural mid-sentence |
| 3 | 2026-07-03 | Colleague playing CIO, on Miro (remote fallback) | Target 8 min, actual 9 min | Pre-staged box positions saved ~90 seconds versus drawing shapes live; kept the pre-staged layout for the remote version |

## 6. Toolkit and go/no-go decision

- **Format chosen:** live whiteboard build — because the CIO is the technical sign-off authority in the room and a rival integrator has already shown this board a read-through deck of a structurally similar concept; a live build is the differentiating move here, not the safe one.
- **Tool chosen:** physical whiteboard for the in-person board session, with a pre-staged Miro board held in reserve for any follow-up session the CIO's team wants to run remotely with their own engineers.
- **Color/lane legend:** blue = new shared-platform services, orange = legacy systems, green = anti-corruption layer, purple = integration (gateway/bus), pink = zero-trust security boundary — the same palette as the 6.6 HLD's Mermaid diagram, so the whiteboard and the leave-behind HLD visually agree.
- **Do NOT whiteboard this session if:** a future session with this same customer is time-boxed to under ten minutes with board members only and no CIO present — default to the 6.6 HLD's Executive Summary slide instead, and save the live build for the next technical session.
