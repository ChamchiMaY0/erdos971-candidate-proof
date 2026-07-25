#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if grep -nE '(^|[^[:alnum:]_])(sorry|admit|axiom)([^[:alnum:]_]|$)' Erdos971Forum.lean; then
  echo "Forbidden trust escape found in Erdos971Forum.lean" >&2
  exit 1
fi

lake update
lake build
lake env lean AnalyticTargets.lean
lake env lean AuditAxioms.lean | tee axioms.log

if grep -q 'sorryAx' axioms.log; then
  echo "sorryAx detected" >&2
  exit 1
fi

echo "Lean source check completed. Inspect axioms.log for foundational axioms."
