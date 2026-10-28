# resumetailor

A Claude Code / Agent **Skill** that tailors a [Typst](https://typst.app) resume to a
specific job description so it ranks well in automated resume screening (ATS), while
**preserving the resume's existing format** and keeping it to **one page**.

## Install

```
npx skills add tylergibbs1/resumetailor
```

Or clone the repo and link the skill folder into your skills directory (Claude Code
looks for `SKILL.md` directly inside each skill folder):

```
git clone https://github.com/tylergibbs1/resumetailor.git
ln -s "$PWD/resumetailor/skills/tailoring-resumes" ~/.claude/skills/tailoring-resumes
```

Then paste a job description and ask Claude to tailor your resume, or invoke
`/tailoring-resumes`. See [Usage](#usage).

## How it works

It aligns your resume's wording and emphasis to the job posting, grounded entirely in
your real experience. It never fabricates skills and never redesigns your template. It
reframes what's true so an ATS (and the human after it) sees the match.

The ATS guidance is grounded in how real screening pipelines work (parse → match → rank);
see [`skills/tailoring-resumes/references/ats-rules.md`](skills/tailoring-resumes/references/ats-rules.md).

## What it does

- **Reads your materials**: your resume (`.typ`) and a background/bio file (`.md`), the
  wider truth to draw from.
- **Extracts requirements**: the job description's must-match keywords and requirements.
- **Edits a copy**: never the master. It surfaces relevant, true experience using the
  posting's exact terminology.
- **Verifies one page**: compiles with Typst and checks the result is exactly one page.
- **Checks keyword coverage**: extracts text from the compiled PDF and checks it against
  the posting.
- **Reports honestly**: coverage, what changed, and gaps (including likely knockout
  questions).

## Requirements

- [`typst`](https://github.com/typst/typst) (`brew install typst`)
- One of `pdfinfo` (poppler), `pypdf`, or macOS `mdls` for page counting
- `python3` + `pypdf` for the keyword check (`pip install pypdf`)

## Usage

1. Put your resume `.typ` and a background `.md` in your project (see `examples/` for the
   expected shape; copy `examples/sample-resume.typ` to `resume.typ` to start).
2. Run it: paste a job description and ask to tailor your resume, or invoke
   `/tailoring-resumes`.

Tailored output is written to `tailored/<company>-<role>.{typ,pdf}`.

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

## License

MIT
