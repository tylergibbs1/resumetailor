---
name: tailoring-resumes
description: Tailors a candidate's resume to a specific job description so it passes automated resume screening (ATS), while preserving the existing Typst template and staying on one page. Use when the user pastes or links a job description and asks to tailor, customize, optimize, or "ATS-proof" their resume for a role, or mentions applying to a job, beating the resume screener, or matching a posting's keywords.
metadata:
  version: 1.1.0
---

# Tailoring Resumes

Rewrite a candidate's resume to match one specific job description so it ranks well in automated resume screening (ATS), **without changing the visual format and without exceeding one page**. The job is keyword alignment and emphasis, grounded in true experience — never fabrication and never a redesign.

> [!important] Two hard rules that override everything else
> 1. **Truth only.** Every claim must trace to the candidate's own materials (their resume and background file). If the job wants a skill the candidate doesn't have, you do NOT add it — you report the gap. Keyword stuffing with skills they can't back up gets caught by a human and burns the application.
> 2. **Never edit the master.** The candidate's resume file is the source of truth. Write tailored output to `tailored/<company>-<role>.typ`. Keep the master untouched.

## Inputs

This skill needs two files. **Locate them first** (don't assume specific names):

- **The resume** — the Typst `.typ` resume file in the project. This is both the content baseline and the **exact format to preserve** (layout, sections, one-page budget). If there's exactly one `.typ` resume, use it; if there are several or none, ask the user which file is their resume.
- **The background file** — a Markdown file holding the candidate's fuller background/bio: experience that did *not* make the one-page resume. Look for something like a file under an `about/`/`bio/` folder or named `*info*.md`, `bio.md`, `background.md`, `about.md`. This is the reservoir to pull from when a job calls for something the resume currently downplays.

Read both before editing. Treat the background file as the wider truth and the resume as the current one-page selection from it. If no background file exists or it's thin, work from the resume and **ask the user** for missing detail rather than inventing it.

## What ATS screening actually rewards

An ATS is a pipeline: it converts the file to text, **parses** it into fields, then **matches and ranks** candidates against the job — and surfaces a shortlist (e.g., top 30 of 300) to a recruiter. Most ATSs **rank rather than auto-reject**, so the goal is to *parse cleanly and rank near the top*, then survive the human read. The two levers a resume controls are **parseability** (does the machine extract the text right?) and **relevance** (does the extracted text match the JD's language?). Parseability comes first — a term the parser never extracts can't match anything. Full detail in `references/ats-rules.md`. The essentials:

- **Parse-first.** Parsing is the #1 failure point (multi-column scramble, headers/footers skipped, scanned PDFs). Keep contact info in the body, keep substantive keywords in the left content column of the `twocol` rows (dates only on the right), and never submit a scanned/image resume.
- **Mirror the posting's exact words.** If the JD says "CI/CD," "TypeScript," "RAG," "Kubernetes" — use those literal strings. Legacy keyword/Boolean search (still ubiquitous) won't match a synonym; modern embeddings still reward exact alignment.
- **Spell out acronym + expansion once** (e.g., "Model Context Protocol (MCP)") so both forms match.
- **Only claim what's true.** Reframe and re-emphasize real experience to speak the JD's language; do not add skills the candidate lacks.
- **Knockouts live on the form, not the resume.** Hard objective requirements (work authorization, minimum years, licensure) are the real auto-reject gate and can't be tailored away — flag them as gaps instead.

## Workflow

Copy this checklist and track progress:

```
Resume Tailoring Progress:
- [ ] Step 1: Locate inputs (resume .typ + background .md) and get the job description
- [ ] Step 2: Extract keywords + requirements → keywords.txt
- [ ] Step 3: Read both inputs; map JD terms to TRUE experience
- [ ] Step 4: Edit a COPY → tailored/<company>-<role>.typ (format preserved)
- [ ] Step 5: Compile + verify 1 page (compile_check.sh)
- [ ] Step 6: Verify keyword coverage from the PDF text (keyword_check.py)
- [ ] Step 7: Report coverage, changes, and honest gaps
```

### Step 1: Locate inputs and get the job description

Find the resume `.typ` and the background `.md` as described in **Inputs** above. Ask the user to paste the JD or give a file/URL if they haven't. Note the **company** and **role title** — they name the output file, and the role title should appear in the resume's header subtitle when truthful.

### Step 2: Extract keywords and requirements

From the JD, pull the must-match terms into `tailored/keywords.txt`, one per line. Capture:
- Hard skills, languages, frameworks, tools, platforms (literal strings as written).
- The role title and any seniority terms.
- Required qualifications and recurring domain phrases (e.g., "healthcare," "distributed systems," "agentic workflows").

Skip generic fluff ("team player," "fast-paced"). Prioritize terms that appear in a "Requirements"/"Qualifications" section or repeat across the posting.

### Step 3: Map JD terms to true experience

For each keyword, decide one of:
- **Already on the resume** → make sure the wording matches the JD's exact term.
- **True but only in the background file** → surface it: swap in a more relevant bullet or rephrase an existing one, within the one-page budget.
- **Not true / unsupported** → do NOT add it. Record it as a gap for Step 7.

### Step 4: Edit a copy, preserving format

Copy the master, then edit the copy:

```bash
cp <resume>.typ "tailored/<company>-<role>.typ"
```

Preserve the template exactly — same sections, `twocol` helper, headings, fonts, spacing, header block. You are editing **content within the existing structure**, not redesigning. Allowed moves:
- Rewrite the **Summary** to lead with the role's core requirements (true ones).
- Reorder and rephrase **Experience/Project bullets** so the most JD-relevant, keyword-bearing ones come first.
- Adjust the **Skills** lines to foreground the JD's stack and use its exact terms — only for skills the candidate actually has.
- Update the header subtitle to the target role title when it's an honest match.

Do not change margins, fonts, the `twocol`/heading definitions, or section order unless the user explicitly asks. See `references/typst-format.md` for how to edit each part safely.

### Step 5: Compile and verify one page (feedback loop)

```bash
bash skills/tailoring-resumes/scripts/compile_check.sh "tailored/<company>-<role>.typ" "tailored/<company>-<role>.pdf"
```

- Exit 0 → exactly one page. Continue.
- Exit 2 → it overflowed. Trim the lowest-value, least-JD-relevant content (tighten bullets, drop a weak line) and recompile. **Repeat until it reports one page.** Do not ship a 2-page resume.

### Step 6: Verify keyword coverage from the PDF

This reads text out of the compiled PDF — exactly what an ATS sees:

```bash
python3 skills/tailoring-resumes/scripts/keyword_check.py "tailored/<company>-<role>.pdf" tailored/keywords.txt
```

- For each `PRESENT` term, you're good.
- For each `MISSING` term: add it **only if the candidate truthfully has it** (then recompile and re-check, re-verifying the page count from Step 5); otherwise leave it out and list it as a gap.
- Aim to maximize honest coverage, not 100% at the cost of truth.

### Step 7: Report

Give the user:
- Output paths (`.typ` and `.pdf`).
- **Keyword coverage** (the script's percentage) and which terms are covered.
- **What changed** vs. the master (summary, reordered/added bullets, skills emphasis).
- **Honest gaps** — JD requirements the candidate can't truthfully claim — so they decide whether to apply, address them in a cover letter, or skip. Call out any that are likely **knockout questions** on the application form (work authorization, minimum years, licensure), since those can hard-reject regardless of the resume.
- **Submission notes** — remind the user to submit in the format the portal requests (DOCX generally parses better than PDF when both are accepted; Typst exports PDF — offer a DOCX conversion if the portal is DOCX-only or known strict), fill in every application-form field, and pursue a referral if they have any connection (the highest-leverage move past the ATS).

## Anti-patterns

- ❌ Inventing skills/tools/metrics to hit a keyword. Caught by humans; not worth it.
- ❌ Overwriting the master resume file.
- ❌ Redesigning the template, adding columns, or changing fonts to cram more in.
- ❌ Shipping a 2-page resume "just this once."
- ❌ Keyword-stuffing a hidden block or the skills line with unrelated terms.

## Reference files

- **`references/ats-rules.md`** — How ATS parsing/ranking works and the concrete formatting + keyword rules that pass it.
- **`references/typst-format.md`** — The Typst template's structure and how to edit each section (header, summary, experience, skills) without breaking format or the one-page budget.
