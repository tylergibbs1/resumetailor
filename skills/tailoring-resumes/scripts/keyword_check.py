#!/usr/bin/env python3
"""Check ATS keyword coverage of a tailored resume against a job description.

Usage:
    keyword_check.py resume.pdf keywords.txt

- resume.pdf: the compiled tailored resume (text is extracted from the PDF,
  so this checks exactly what an ATS would parse).
- keywords.txt: one keyword or phrase per line (the must-have terms pulled
  from the job description).

Reports each keyword as PRESENT or MISSING (case-insensitive, whole-phrase),
then prints a coverage percentage. Exit 0 if all present, else exit 2.
"""
import re
import sys


def extract_text(pdf_path: str) -> str:
    try:
        import pypdf
    except ImportError:
        sys.exit("ERROR: pypdf not installed. Run: pip install pypdf")
    try:
        reader = pypdf.PdfReader(pdf_path)
    except Exception as e:  # corrupt/missing PDF
        sys.exit(f"ERROR: could not read {pdf_path}: {e}")
    return "\n".join(page.extract_text() or "" for page in reader.pages)


def normalize(s: str) -> str:
    # Collapse whitespace so multi-word phrases match across line wraps.
    return re.sub(r"\s+", " ", s).lower()


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit("usage: keyword_check.py resume.pdf keywords.txt")
    pdf_path, kw_path = sys.argv[1], sys.argv[2]

    text = normalize(extract_text(pdf_path))
    if not text.strip():
        sys.exit("ERROR: no extractable text in PDF — an ATS would see nothing.")

    with open(kw_path) as f:
        keywords = [line.strip() for line in f if line.strip()]

    present, missing = [], []
    for kw in keywords:
        if normalize(kw) in text:
            present.append(kw)
        else:
            missing.append(kw)

    for kw in present:
        print(f"PRESENT  {kw}")
    for kw in missing:
        print(f"MISSING  {kw}")

    total = len(keywords)
    pct = (len(present) / total * 100) if total else 100.0
    print(f"\nCoverage: {len(present)}/{total} ({pct:.0f}%)")

    if missing:
        print("Address each MISSING term: add it ONLY if the user truthfully "
              "has that experience; otherwise leave it out and report the gap.")
        sys.exit(2)
    sys.exit(0)


if __name__ == "__main__":
    main()
