# Contributing

Thanks for helping build the **AI, Data & Infrastructure Solution Architect (Presales)** track — Track 6 of Mindwalker Academy.

## How to contribute a lesson

1. Pick any ⬚ *Planned* lesson from the [Roadmap](ROADMAP.md).
2. Open its folder: `phases/<phase>/<lesson>/docs/en.md` (a stub is already there).
3. Fill it in following [`LESSON_TEMPLATE.md`](LESSON_TEMPLATE.md) — the SA lesson arc:
   **Problem → Concept → Design It → Compare It → Ship It → Exercises → Key Terms → Further Reading**.
4. Produce the lesson's **Ship It** deliverable and save it under the lesson's `outputs/` (a reusable template + one worked example).
5. Flip the lesson to ✅ in `ROADMAP.md` and add its link in `README.md`
   (e.g. `| 01 | [Lesson Title](phases/.../lesson/) | Design | HLD |`).
6. Rebuild the site to check it: `node site/build.js`.
7. Open a PR.

## Conventions

- **Altitude:** teach at *architect altitude* — enough to design, size, price, and defend, not to be the implementing engineer. Link out to sister tracks for deeper internals.
- **Labs:** local or free-tier only. They validate a design claim; they don't build a product.
- **Language:** English in `docs/en.md`. Translations go in `docs/<lang>.md` (e.g. `docs/id.md`).
- **Deliverables:** every template must be usable on a real deal, with assumptions stated and a worked example.
- **Glossary:** add new terms to `glossary/terms.md` in the two-line format (What people say / What it actually means).

## Quizzes

Per-phase `check-understanding` and the `find-your-level` placement quiz live in `.claude/skills/`. Keep their question banks aligned with the lessons you add.
