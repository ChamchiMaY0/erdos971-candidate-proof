# Erdős Problem 971: candidate proof and Lean-checked finite reduction

**Author:** KyungMin Han  
**AI assistance:** OpenAI's GPT-5.6 Pro

This repository contains a revised candidate proof of Erdős Problem 971 and a
sorry-free Lean 4 formalization of its finite combinatorial reduction.

## Main files

- `Erdos971_candidate_verification_note.pdf` — revised manuscript. The legacy
  path is retained so existing `blob/main` links continue to open the current PDF.
- `source/erdos971_candidate.tex` — LaTeX source.
- `lean/Erdos971Forum.lean` — standalone Lean file corresponding to the
  manuscript's finite reduction. The legacy path is retained for existing links.
- `STATUS_AND_SCOPE.md` — mathematical status and exact formal-verification scope.
- `DISCUSSION_POST.md` — separate discussion/update text.
- `FORUM_POST.md` — compatibility pointer to `DISCUSSION_POST.md`.
- `VERIFICATION.md` — current build and axiom-audit record.

## Exact Lean scope

The strongest Lean theorem takes four analytic estimates as explicit
hypotheses:

- a positive linear lower bound for the second factorial moment;
- a linear upper bound for the third factorial moment;
- a total-incidence estimate at the base cutoff; and
- an increment estimate between the two cutoffs.

It proves the finite implication from these estimates to a quantitative lower
bound for reduced residue classes whose least congruent prime exceeds the final
cutoff. The Lean development does **not** formalize the Friedlander–Goldston
variance theorem, the three-linear-form upper sieve, the singular-series
average, or the required prime-number-theorem asymptotics.

## Lean verification

The project is pinned to Lean 4.27.0 and mathlib v4.27.0.

```bash
cd lean
lake update
lake build
lake env lean AnalyticTargets.lean
lake env lean AuditAxioms.lean
```

`AuditAxioms.lean` must not report `sorryAx`. The compiled principal theorems
use only the usual foundational dependencies `propext`, `Classical.choice`, and
`Quot.sound`.

## PDF build

```bash
cd source
chmod +x build_pdf.sh
./build_pdf.sh
```

The output is written to the legacy-compatible path
`Erdos971_candidate_verification_note.pdf`.
