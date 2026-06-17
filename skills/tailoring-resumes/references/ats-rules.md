# ATS rules for passing automated resume screening

Grounded in how real ATS pipelines work (ingestion → parse → store → match/rank → recruiter shortlist). The two levers a tailored resume controls are **parseability** (does the machine extract the text correctly?) and **relevance/keyword alignment** (does the extracted text rank well against the job?). Parseability comes first — a term the parser never extracts can't match anything.

## Contents
- The mental model: rank, don't auto-reject
- Parseability (the #1 failure point)
- Keyword and relevance matching
- File format and size
- Section and structure rules
- Knockout questions (the real auto-reject)
- What does NOT help (and what hurts)
- Source basis

## The mental model: rank, don't auto-reject

Most ATS platforms **rank** candidates and surface a shortlist (e.g., top 30 of 300) to a recruiter; they do not silently delete the rest. The "75% of resumes are auto-rejected" claim is a myth in its strong form. The functional effect is still real: if you're not near the top of the ranked list, no human sees you. So the goal is not "trick a binary filter" — it's **parse cleanly and rank high on relevance** so the resume reaches the top of the list and survives the human read that follows.

The matching engine spans generations that coexist in production: Boolean keyword search, TF-IDF/BM25 relevance scoring (the Elasticsearch/Lucene backbone of most ATS search), and modern semantic embeddings (Sentence-BERT, two-tower retrieval, LLM screeners). Practical consequence: **exact keyword match still matters** (Boolean search is everywhere), **and** semantic similarity matters (embeddings reward terminology that's conceptually aligned with the JD). Tailoring to the JD's actual language wins under all of them.

## Parseability (the #1 failure point)

Parsing — converting the file to text and extracting fields — is the foundational and most failure-prone stage. Roughly **30% of real-world parsing failures happen in document conversion before any "AI" runs**, and one analysis attributes ~23% of early-stage rejections to parse errors rather than weak content. Reported parse-success rates by layout: simple DOCX ~85%, text-based PDF ~75%, **designed/multi-column PDF ~45%**, image/scanned PDF ~15%. Rules that follow from this:

- **Single-column reading flow.** Multi-column layouts scramble on most platforms tested (reportedly 7 of 8); a naive extractor reads straight across the page and weaves columns into one garbled stream. Single-column reportedly preserves ~96% of fields. **The current template uses a Typst `twocol` grid** for date rows — see "the twocol caveat" below.
- **Keep contact info in the document body, never only in a page header/footer.** Many parsers skip header/footer regions, so contact details placed there can be lost. (The template's centered contact block is in the body — correct.)
- **Real selectable text, not images.** Typst → PDF produces selectable text, which parses well. Never embed substantive content (skills, titles) as graphics, and never submit a scanned/photographed resume (OCR introduces errors like "rn"→"m", "cl"→"d").
- **No tables, text boxes, or multi-column body text** for substantive content — they get stripped or jumbled.
- **`Month YYYY` date format**, plain bullet characters, standard fonts. Avoid decorative glyphs and icon fonts for anything meaningful.

**The twocol caveat (preserve format, mitigate risk).** The template's `twocol(date, content)` puts the title/company in the left content column and the date (gray) on the right — the safer arrangement, since the substantive keywords live in the left column and the experience bullets below are full-width single-column. Keep it that way: **never move skills, titles, or keywords into the date (right) argument.** This is a managed, low-but-nonzero risk. If the target employer is known to run a strict legacy parser (e.g., Workday, Oracle Taleo — both notoriously format-sensitive and order-scrambling on two columns), offer the user an escape hatch: a true single-column variant or a DOCX version. Don't redesign the template by default — only when the user asks or the target is known-strict.

## Keyword and relevance matching

- **Mirror the JD's exact strings.** Use the literal term the posting uses: "CI/CD" not "continuous integration"; "TypeScript" not "TS"; "Kubernetes" not "k8s". Boolean search matches exact tokens; embeddings still reward exact alignment.
- **Spell out acronym + expansion once** (e.g., "Model Context Protocol (MCP)", "Amazon Web Services (AWS)") so the resume matches whether the system searches the long or short form. After the first expansion, the short form is fine.
- **Put keywords where they're extracted and read first** — in the Summary and the lead bullets of relevant experience, plus a dedicated Skills section of bare tokens (ideal for keyword/entity extraction).
- **Semantic matching helps, but don't rely on it to bridge gaps.** Modern engines map skills to taxonomies (ESCO, O*NET) and catch some synonyms, but legacy keyword search and recruiter Boolean queries don't — so still use the JD's exact terms rather than trusting the system to infer them.
- **Match the role title** in the header subtitle when it honestly describes the candidate — title matching is a common ranking signal.
- **Density, not stuffing.** Cover the real required skills naturally across Summary, Experience, and Skills. Never paste unrelated keywords, and never use hidden/white-on-white text — modern parsers detect it and recruiters blacklist for it.

## File format and size

- **Submit the format the portal requests.** If it accepts either, **DOCX generally parses better than PDF** across platforms; PDF is fine when it's text-based (as Typst output is) and the portal asks for PDF. (Typst exports PDF natively, not DOCX — if a strict portal wants DOCX, that's a separate conversion step; offer it, don't assume it.)
- **Mind size limits.** Some parsers cap file size (Greenhouse ~2.5MB, Bullhorn ~4MB). A text-based one-page Typst PDF is far under this, so it's a non-issue here — just don't embed large images.

## Section and structure rules

- **Use conventional, parser-recognized section headings**: Summary, Experience, Skills (or Technical Skills), Education, Projects. The template already does — keep them; don't invent creative labels.
- **Reverse-chronological experience** with clear company, title, and `Month YYYY` dates per entry (the template's `twocol` pattern).
- **Skills section as literal tokens** — a delimited list of the actual tools/languages is exactly what entity extraction wants. Tune its contents to the JD using true skills.

## Knockout questions (the real auto-reject)

The one place most ATSs genuinely auto-reject is **knockout questions on the application form** (work authorization, licensure, minimum years, etc.) — deterministic rule filters, separate from the probabilistic resume match score. Two implications for the user:
- **Fill in every application-form field** — recruiters filter and search on them, and blank fields hurt.
- Resume tailoring can't fix a knockout answer. If the JD lists a hard, objective requirement the user doesn't meet, flag it as a gap in the report (Step 7) — that's a knockout, not something to paper over.

## What does NOT help (and what hurts)

- ❌ Skills/tools/metrics the candidate can't back up — they may pass a keyword filter but fail the human reviewer and the interview.
- ❌ Multi-column body layouts, tables, text boxes, graphics, or scanned/image PDFs (parse risk).
- ❌ Contact info only in a page header/footer (often skipped).
- ❌ Synonyms in place of the JD's exact term (legacy keyword search misses them).
- ❌ Keyword stuffing, hidden text, tiny-font keyword blocks (flagged as manipulation).
- ❌ A second page added to fit more keywords — keep it to one page and prioritize.

> [!tip] Highest-leverage move beyond the resume
> A referral that routes the application past the ATS is the single most effective tactic. If the user has any connection to the company, suggest they pursue it alongside the tailored resume.

## Source basis

Reflects how production ATS pipelines work (Workday, Taleo, Greenhouse, Lever, iCIMS; parsing engines from Textkernel/Sovren, Daxtra, Affinda, RChilli) and the matching generations they use (Boolean, TF-IDF/BM25, word2vec/GloVe embeddings, Sentence-BERT, two-tower retrieval, LLM parsers), normalized via skills taxonomies (ESCO/O*NET). Specific parse-rate percentages originate largely from resume-optimization vendors' internal, non-peer-reviewed testing — treat them as directional, not exact. The single-column rule is partly risk-minimization (modern NLP parsers handle columns better than legacy ones), but remains the safe default.
