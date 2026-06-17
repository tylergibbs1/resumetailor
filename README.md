# resumetailor

A Claude Code / Agent **Skill** that tailors a [Typst](https://typst.app) resume to a
specific job description so it ranks well in automated resume screening (ATS) — while
**preserving the resume's existing format** and keeping it to **one page**.

It works by aligning your resume's wording and emphasis to the job posting, grounded
entirely in your real experience. It never fabricates skills and never redesigns your
template — it reframes what's true so an ATS (and the human after it) sees the match.

## What it does

- Reads your resume (`.typ`) and a background/bio file (`.md`) — the wider truth to draw from.
- Extracts the job description's must-match keywords and requirements.
- Edits a **copy** (never the master) to surface relevant, true experience using the
  posting's exact terminology.
- Compiles with Typst and **verifies the result is exactly one page**.
- Checks ATS keyword coverage by extracting text from the compiled PDF.
- Reports coverage, what changed, and honest gaps (including likely knockout questions).

The ATS guidance is grounded in how real screening pipelines work (parse → match → rank);
see [`skills/tailoring-resumes/references/ats-rules.md`](skills/tailoring-resumes/references/ats-rules.md).

## Layout

```
.claude-plugin/plugin.json            # plugin manifest
skills/tailoring-resumes/
├── SKILL.md                          # main instructions + workflow
├── references/
│   ├── ats-rules.md                  # how ATS parse/match/rank works + rules to pass it
│   └── typst-format.md               # how to edit the template without breaking it
├── scripts/
│   ├── compile_check.sh              # compile .typ → PDF, verify exactly 1 page
│   └── keyword_check.py              # extract PDF text, check JD keyword coverage
└── evals/evals.json                  # test scenarios
examples/
├── sample-resume.typ                 # a resume in the supported template format
└── sample-background.md              # a background/bio file to draw from
```

## Requirements

- [`typst`](https://github.com/typst/typst) (`brew install typst`)
- One of `pdfinfo` (poppler), `pypdf`, or macOS `mdls` for page counting
- `python3` + `pypdf` for the keyword check (`pip install pypdf`)

## Usage

1. Put your resume `.typ` and a background `.md` in your project (see `examples/` for the
   expected shape — copy `examples/sample-resume.typ` to `resume.typ` to start).
2. Install the skill: either add this repo as a Claude Code plugin, or symlink the skill
   into your project: `ln -s ../../skills/tailoring-resumes .claude/skills/tailoring-resumes`.
3. Run it — paste a job description and ask to tailor your resume, or invoke
   `/tailoring-resumes`.

Tailored output is written to `tailored/<company>-<role>.{typ,pdf}`.

## License

MIT
