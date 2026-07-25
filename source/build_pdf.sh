#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

OUT="../Erdos971_candidate_verification_note.pdf"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if command -v pdflatex >/dev/null 2>&1; then
  for _ in 1 2 3; do
    pdflatex -interaction=nonstopmode -halt-on-error \
      -output-directory="$TMP" erdos971_candidate.tex >/dev/null
  done
elif command -v tectonic >/dev/null 2>&1; then
  tectonic --outdir "$TMP" erdos971_candidate.tex >/dev/null
else
  echo "No LaTeX engine found. Install pdflatex (MacTeX/TeX Live) or tectonic." >&2
  exit 1
fi

cp "$TMP/erdos971_candidate.pdf" "$OUT"
echo "Wrote $OUT"
