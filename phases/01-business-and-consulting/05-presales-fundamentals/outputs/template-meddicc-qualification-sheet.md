---
name: template-meddicc-qualification-sheet
description: MEDDICC Qualification Sheet — a fill-in scorecard (evidence, RAG, gap, next action) plus a quantified value-case worksheet and a bid/no-bid verdict
phase: 1
lesson: 5
audience: internal
---

# MEDDICC Qualification Sheet — Template

> Fill this in during and after discovery, before you invest in a full design or PoC. It answers one question for the deal team: **is this deal real, winnable, and worth winning — and if not fully, what must we fix first?** Rate every element Red/Amber/Green; let the reds gate your spend. This is a living document — re-run it whenever the deal changes.

**Customer:** `<company>`  ·  **Opportunity:** `<deal / project name>`
**Account Executive (owns the number):** `<name>`  ·  **Solution Architect (owns the technical win):** `<name>`
**Date:** `<YYYY-MM-DD>`  ·  **Version:** `<v0.1 draft>`  ·  **Next re-qualify:** `<date>`

**RAG legend:** `[G]` known / strong · `[A]` partial / at-risk · `[R]` missing / blocked
**Ownership legend:** *AE* = account executive · *SA* = solution architect · *Shared* = both

---

## 1. MEDDICC scorecard (one-glance read)

```
   MEDDICC QUALIFICATION SCORECARD
   Deal: <name>            Verdict: <bid / no-bid / conditional>
   ──────────────────────────────────────────────────────────────
   ELEMENT               RAG  ONE-LINE STATUS
   ──────────────────────────────────────────────────────────────
   M  Metrics           [ ]   <quantified value in the buyer's #s?>
   E  Economic buyer    [ ]   <who signs — and have they seen proof?>
   D  Decision criteria [ ]   <what they score on + the weighting?>
   D  Decision process  [ ]   <steps · committee · dates · paper?>
   I  Identify pain     [ ]   <the pain + the compelling event?>
   C  Champion          [ ]   <has power · sells for you · tested?>
   C  Competition       [ ]   <rivals + "do nothing" + your edge?>
   ──────────────────────────────────────────────────────────────
   GATING RULE: any [R] on E, Decision process, or Champion caps
   the whole deal at AMBER — do NOT invest in a full PoC until it
   clears.
```

## 2. Element-by-element detail

> One row per MEDDICC element. Evidence = what discovery actually surfaced (facts, quotes, names). Gap = what's missing to make it green. Next action = the single most valuable thing to do next, with an owner and a date.

| Element | Evidence from discovery | RAG | Gap | Next action (owner · by when) |
|---|---|---|---|---|
| **M — Metrics** *(SA leads)*<br/>Quantified value in the buyer's numbers | `<what pain is worth, or "not yet quantified">` | `[ ]` | `<no CFO-grade case? soft only?>` | `<value-engineering workshop…>` |
| **E — Economic buyer** *(AE)*<br/>Who controls the money & signs | `<name/role; met directly? seen proof?>` | `[ ]` | `<no direct access? single-threaded?>` | `<request EB briefing…>` |
| **D — Decision criteria** *(Shared)*<br/>Technical + business + vendor criteria | `<known criteria; weighting?>` | `[ ]` | `<scoring unknown?>` | `<get RFP scoring matrix…>` |
| **D — Decision process** *(AE)*<br/>Steps, approvals, dates, paper process | `<RFP? committee? timeline? legal/security?>` | `[ ]` | `<how & when is it decided?>` | `<champion walkthrough…>` |
| **I — Identify pain** *(Shared, SA surfaces)*<br/>The pain + the compelling event | `<the pains; the dated forcing event>` | `[ ]` | `<pain vague? no event?>` | `<tie each pain to a metric…>` |
| **C — Champion** *(AE + SA)*<br/>Power · sells for you · tested | `<name/role; tested? armed?>` | `[ ]` | `<untested? unarmed? detractor?>` | `<arm champion; address detractor…>` |
| **C — Competition** *(Shared)*<br/>Rivals **and** "do nothing" | `<named rivals; likelihood of no-decision>` | `[ ]` | `<rival angle unknown? inaction cheap?>` | `<battlecard + cost-of-inaction case…>` |

## 3. Value-case worksheet (quantify M — never a single magic number)

> Turn pain into money. State every assumption, show the formula, give a **low / base / high** range, and split **hard** from **soft** benefits so the number survives finance scrutiny. This is the SA's highest-leverage output; it earns the economic-buyer meeting.

**Baseline (current-state cost of the pain):**

| Pain / cost driver | Formula (units × rate × frequency) | Low | Base | High | Hard or soft? |
|---|---|---|---|---|---|
| `<e.g. manual reporting labour>` | `<n staff × Rp/mo × %time × 12>` | `<Rp>` | `<Rp>` | `<Rp>` | Hard |
| `<e.g. penalty / risk exposure>` | `<exposure × probability reduction>` | `<Rp>` | `<Rp>` | `<Rp>` | Risk-avoided |
| `<e.g. staff productivity>` | `<n × time saved × loaded rate>` | `<Rp>` | `<Rp>` | `<Rp>` | Soft |

**Annual value (what solving it is worth):** `<Rp low>` – `<Rp base>` – `<Rp high>`   *(hard + risk only, unless soft is defensible)*
**Order-of-magnitude investment (placeholder — real BOM comes later):** `<Rp range over N years>`
**Headline for the economic buyer (one sentence):**
> Solving `<pain>` is worth ~`<Rp base>/yr` and removes `<risk>`, against an estimated `<Rp>` investment — a case the CFO can defend at the board.

*Assumptions:* `<list every number's source: interview, benchmark, estimate-to-be-validated>`

## 4. Verdict & bid decision

- **Verdict:** `<BID / NO-BID / CONDITIONAL BID>`  ·  **Confidence:** `<low / medium / high>`
- **If conditional — the conditions that must clear:** `<e.g. Decision process → amber; Metrics → green — within N weeks>`
- **Gap-closing priority (fix in this order):**
  1. `<the red that could hide a dead deal>`
  2. `<the gap that unlocks the most downstream, e.g. Metrics → EB meeting>`
  3. `<parallel ambers>`
- **Investment guardrail:** `<what we will NOT do until the conditions clear — e.g. no full PoC>`

## 5. Re-qualify triggers (when to re-run this sheet)

- [ ] Champion changes role or leaves
- [ ] Budget freezes, moves cycle, or the economic buyer changes
- [ ] A competitor enters or drops out
- [ ] The compelling event moves or disappears
- [ ] The decision process or criteria change
- [ ] Any element you rated green turns out to be assumed, not confirmed

---

*Worked example: see `example-nusantara-sehat-meddicc.md` in this folder.*
