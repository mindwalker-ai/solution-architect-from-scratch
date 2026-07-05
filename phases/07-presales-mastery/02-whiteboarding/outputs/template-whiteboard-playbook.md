---
name: template-whiteboard-playbook
description: Whiteboard Playbook + Recording — a rehearsed live-architecture-build script (draw sequence, narration, interruption handling, and a full written play-by-play)
phase: 7
lesson: 2
audience: internal | customer
---

# Whiteboard Playbook + Recording — `<Customer Name>`

> This is a rehearsal artifact, not a leave-behind. Its job is to make a live whiteboard build repeatable: anyone on the team should be able to pick it up, rehearse from it, and run the same session. Pair it with the HLD (or equivalent target-architecture diagram) it's drawn from — this playbook never invents new content, it only sequences and narrates content that's already been approved.

**Customer:** `<company>`  ·  **Engagement:** `<program / deal name>`  ·  **Prepared by:** `<SA name>`
**Date:** `<YYYY-MM-DD>`  ·  **Version:** `<v0.1 draft>`  ·  **Source diagram:** `<HLD section / lesson this is drawn from>`
**Audience:** `<e.g. CIO (technical) + board (mixed)>`  ·  **Format:** `<in-person | remote | hybrid>`  ·  **Tool:** `<physical whiteboard | Miro | FigJam | Excalidraw>`

---

## How to use this template

1. Never start from a blank board. Start from an already-approved diagram (an HLD target architecture, a pattern diagram, an estate map) and decide what to **cut down into layers** — this playbook sequences that diagram, it doesn't design a new one.
2. Fill in §1 (draw sequence) first, then §2 (narration) so every box has exactly one rehearsed sentence, then §3 (parking lot) with the questions you can *predict*, then §4 (the full script) as the dry-run artifact, then §5 (rehearsal log).
3. Rehearse §4 aloud, timed, at least twice before the real session — once alone, once with a colleague playing the toughest likely interrupter.
4. Decide §6 (toolkit and go/no-go) *before* you build anything — some rooms should get the deck, not the whiteboard (see the lesson's "When not to whiteboard").

---

## 1. Draw-sequence table

List every box/element in the source diagram, in the order it will be revealed. Never more than 6–8 steps — if the source diagram needs more, group elements into fewer layers.

| Step | Box / element | Color (physical) or lane (virtual) | One-line narration (fill in §2) | Serves which message (ask / architecture / risk) |
|---|---|---|---|---|
| 1 | `<e.g. entity boxes for each business unit / domain>` | | | |
| 2 | `<e.g. the shared platform / core system>` | | | |
| 3 | `<e.g. legacy links, migration pattern>` | | | |
| 4 | `<e.g. integration layer>` | | | |
| 5 | `<e.g. security boundary>` | | | |
| 6 | `<e.g. the newest/smallest feature, drawn last>` | | | |

**Rule of thumb:** the most-hyped or newest component (an AI feature, a new brand, a headline capability) goes **last and smallest** — it should land as the payoff on top of a platform story, never as the whole pitch.

## 2. Narration script

One sentence per step — the *why*, not the *what*. Write it, then read it aloud until you don't need to read it.

> **Step 1:** *(draw ___)* "___" *(pause)*
> **Step 2:** *(draw ___)* "___" *(pause)*
> **Step 3:** *(draw ___)* "___" *(pause)*
> **Step 4:** *(draw ___)* "___" *(pause)*
> **Step 5:** *(draw ___)* "___" *(pause — interruptions most often land here or later; have §3 ready)*
> **Step 6:** *(draw ___)* "___"

## 3. Parking-lot log (predicted interruptions)

List every hard question you can reasonably predict this audience will ask, before the session — most of them come straight out of your own risk register, BOM, or competitive battlecard.

| Predicted question | Likely arrives at step | Park or answer immediately? | Prepared answer (cite the source artifact) |
|---|---|---|---|
| `<e.g. "who operates this day two?">` | | | |
| `<e.g. "what if [component] goes down?">` | | | |
| `<e.g. "why not just buy [competitor]'s platform?">` | | | |

**Rule:** if a question can be answered in one sentence without breaking the sequence, answer it immediately. If it requires content you haven't drawn yet, park it visibly and name the point in the sequence where you'll return to it.

## 4. The recording — full written play-by-play

Because a live session may not be recordable on video, this section **is** the recording: a timestamped, quotable script anyone could use to run the session cold, including at least one handled interruption.

```
<CUSTOMER> — <SESSION NAME> — WRITTEN PLAY-BY-PLAY
Presenter: <name/role>  ·  Audience: <roles>  ·  Format: <in-person | remote>

[00:00] <action: what's drawn>
        SAYS: <Step 1 narration>. Pauses.

[00:xx] <action>
        SAYS: <Step 2 narration>. Pauses.

...continue for every step...

[xx:xx] ── INTERRUPTION ──
        <ROLE>: "<the question, verbatim>"

        SA:  "<park-or-answer response — name the parking-lot note if parked>"

[xx:xx] ── RETURN TO PARKING LOT (if parked) ──
        SA: "<the full answer, delivered on the record>"

[xx:xx] <closing action>
        SAYS (closing): "<one sentence tying the whole build back to the ask>"

[xx:xx] Floor opens. Parking lot is empty — every item was answered before the close.
```

## 5. Rehearsal log

| Rehearsal # | Date | Ran with | Timing (target vs actual) | What broke / what to fix |
|---|---|---|---|---|
| 1 | | Solo | | |
| 2 | | Colleague playing interrupter | | |
| 3 | | Colleague playing interrupter (virtual tool) | | |

## 6. Toolkit and go/no-go decision

- **Format chosen:** `<live whiteboard | pre-built deck | hybrid>` — because: `<one sentence citing audience seniority, hostility, and familiarity>`
- **Tool chosen:** `<physical | Miro | FigJam | Excalidraw>` — because: `<one sentence citing remote/in-person and audience size>`
- **Color/lane legend:** `<one color or lane per BU/zone, matching the source diagram's palette so the whiteboard and any leave-behind document visually agree>`
- **Do NOT whiteboard this session if:** the room is senior-only and time-boxed, hostile/adversarial, or remote with attendees or connectivity you can't reliably read — default to the deck or the hybrid instead.
