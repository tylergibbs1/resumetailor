# Editing the Typst resume without breaking format or the one-page budget

This describes the kind of Typst resume template this skill tailors. Read the actual `.typ` file in the project for its specific sections and wording — it is the source of truth. The structure below is the common shape; adapt to what the real file contains.

## Contents
- The template at a glance
- The one-page budget
- Editing each section safely
- The `twocol` helper and ATS reading order
- Things never to touch
- Compile commands

## The template at a glance

The resume is a single self-contained Typst file (typically US-letter, ~1.2–1.5cm margins, a serif body font around 9–10pt). Structure, top to bottom:

1. **Page / text / paragraph setup** — `#set page`, `#set text`, `#set par` (margins, font, size, leading).
2. **Heading style** — a `show heading.where(level: 1)` rule (e.g., bold ~11pt with an underline). Every `= Section` renders this way.
3. **A two-column date helper** — commonly `#let twocol(date, content)`: a full-width row with content in the left column (~75%) and a right-aligned, often gray, date in the right column (~20%).
4. **Header** — centered name, a role subtitle, and a single-line contact row (location, email, phone, site, LinkedIn, GitHub) as `#link`s, all in the document body.
5. **Sections** — standard headings such as `= Summary`, `= Experience`, `= Projects`, `= Skills` (or `= Technical Skills`), `= Education`. The exact set varies per resume.
6. **Footer** — sometimes a `#place(bottom + right, ...)` "Last updated" stamp.

Experience/project entries usually follow a consistent pattern: a `twocol([dates], [*Title*, Company])` row, then a `#block(inset: (left: 0.5cm))[ - bullet ... ]` list indented underneath.

## The one-page budget

The resume fills one US-letter page. Space is zero-sum: anything you add must be paid for by trimming elsewhere. Practical capacity knobs, in order of preference:

1. **Trade bullets** — swap a low-relevance bullet for a JD-relevant one rather than adding a net new line.
2. **Tighten wording** — shorter phrasing on existing bullets frees lines.
3. **Drop the least-relevant entry/bullet** for this specific job (it stays in the background file and the master).

Avoid shrinking font size, margins, or leading to cheat the budget — that degrades both readability and the format. Always confirm with `compile_check.sh` (see below); never eyeball it.

## Editing each section safely

- **Header subtitle** (e.g., `#text(size: 10pt)[<role title>]`) — update to the target role title when it honestly fits the candidate. Keep the size and structure.
- **Summary** — rewrite the prose to lead with the role's core (true) requirements and the JD's vocabulary. Keep it to roughly the same length (a few lines); `*...*` is bold for emphasis on metrics/keywords.
- **Experience / Projects bullets** — reorder so the most JD-relevant bullet is first in each block. Rephrase to use the JD's exact terms for skills the candidate already demonstrably used. Keep the `- ` list inside the existing `#block(inset: (left: 0.5cm))[...]`.
- **Skills** — this is the highest-leverage block for keyword matching. Lines are typically `*Category:* item, item, item \` (the trailing `\` is a line break — keep it). Reorder items so the JD's stack leads each line; you may add a true skill that's in the background file but missing here, and drop an irrelevant one to save space. Do not invent skills.
- **Education** — rarely changes; leave unless the JD calls out a credential the candidate has.

Use exact-string edits to content only. After any edit, recompile and re-verify the page count.

## The `twocol` helper and ATS reading order

A `twocol(date, content)` helper lays out `content` in the left column and `date` (right-aligned) in the right column. For ATS parsing, **keep all substantive keywords in `content` (left)** and use the right side only for dates. Don't relocate skills or titles into the date argument — a parser may read columns in an order that separates them from their context. If the target employer is known to run a strict legacy parser (e.g., Workday, Oracle Taleo), consider offering a true single-column variant or a DOCX version (see `references/ats-rules.md`).

## Things never to touch (unless the user explicitly asks)

- The `#set page`, `#set text`, `#set par` blocks (margins, font, size, leading).
- The `show heading` definition and the `twocol` (two-column helper) definition.
- Section order and the standard section headings (ATS expects them).
- The contact-info line's placement in the body header.

These define "the format." Tailoring changes *content within* them.

## Compile commands

Compile and verify one page in a single step (preferred):

```bash
bash skills/tailoring-resumes/scripts/compile_check.sh "tailored/<company>-<role>.typ" "tailored/<company>-<role>.pdf"
```

Raw compile if needed:

```bash
typst compile "tailored/<company>-<role>.typ" "tailored/<company>-<role>.pdf"
```

Optional live preview while iterating:

```bash
typst watch "tailored/<company>-<role>.typ" "tailored/<company>-<role>.pdf"
```
