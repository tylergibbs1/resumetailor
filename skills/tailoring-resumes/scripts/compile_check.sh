#!/usr/bin/env bash
# Compile a Typst resume to PDF and report the page count.
# Usage: compile_check.sh input.typ [output.pdf]
# Exit 0 if exactly 1 page; exit 2 if more than 1 page; exit 1 on error.
set -euo pipefail

SRC="${1:?usage: compile_check.sh input.typ [output.pdf]}"
OUT="${2:-${SRC%.typ}.pdf}"

if ! command -v typst >/dev/null 2>&1; then
  echo "ERROR: typst not installed. Install with: brew install typst" >&2
  exit 1
fi

# Compile from the source file's directory so relative imports resolve.
typst compile "$SRC" "$OUT"

count_pages() {
  local pdf="$1"
  # Prefer pdfinfo (poppler) — fast and exact.
  if command -v pdfinfo >/dev/null 2>&1; then
    pdfinfo "$pdf" 2>/dev/null | awk '/^Pages:/ {print $2; exit}'
    return
  fi
  # Fall back to pypdf.
  if python3 -c "import pypdf" >/dev/null 2>&1; then
    python3 -c "import pypdf,sys; print(len(pypdf.PdfReader(sys.argv[1]).pages))" "$pdf"
    return
  fi
  # Last resort on macOS: Spotlight metadata.
  if command -v mdls >/dev/null 2>&1; then
    mdls -name kMDItemNumberOfPages -raw "$pdf"
    return
  fi
  echo "ERROR: no page-counting tool (pdfinfo, pypdf, or mdls) available" >&2
  exit 1
}

PAGES="$(count_pages "$OUT")"
echo "Compiled: $OUT"
echo "Pages: $PAGES"

if [ "$PAGES" = "1" ]; then
  echo "OK: fits on one page."
  exit 0
else
  echo "OVERFLOW: resume is $PAGES pages — must trim to 1." >&2
  exit 2
fi
