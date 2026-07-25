# Erdős Problem 971: candidate proof and Lean-checked finite reduction

This package is prepared for independent review on the Erdős Problems forum.
The verification note is authored by Kyungmin and includes an explicit disclosure
that the mathematical investigation and package preparation received substantial
assistance from OpenAI's GPT-5.6 Pro.

## Status

This is **not presented as an accepted solution**. It contains:

1. a candidate unconditional analytic argument;
2. a Lean 4 formalization of the finite combinatorial reduction and the bridge from empty prime occupancy to the least congruent prime inequality; and
3. explicit analytic obligations that remain to be formalized and independently checked.

A successful Lean build verifies only the conditional finite implication encoded in
`lean/Erdos971Forum.lean`. It does **not** prove the Friedlander-Goldston variance
estimate, the uniform three-linear-form upper sieve, the singular-series average, or
the prime-number-theorem estimates used to instantiate the hypotheses.

## Package contents

- `Erdos971_candidate_verification_note.pdf` - forum-ready verification note.
- `source/erdos971_candidate.tex` - LaTeX source of the note.
- `source/build_pdf.sh` - reproducible PDF build script.
- `lean/Erdos971Forum.lean` - standalone compiled core, containing no `sorry`, `admit`, or declared project axioms.
- `lean/AnalyticTargets.lean` - named `Prop` definitions for the remaining analytic targets; these are not axioms.
- `lean/AuditAxioms.lean` - prints the axiom dependencies of the principal theorems.
- `lean/check_source.sh` - source, build, and `sorryAx` audit.
- `.github/workflows/lean.yml` - GitHub Actions workflow for the full package repository.
- `FORUM_POST.md` - suggested English forum post.
- `REVIEW_CHECKLIST.md` - focused list of points requiring expert verification.
- `README_KO.md` - Korean upload and verification guide.
- `VERIFICATION.md` - current local build, axiom-audit, and PDF verification record.
- `MANIFEST.sha256` - SHA-256 checksums for the distributable files.

## Lean verification

The project is pinned to Lean 4.27.0 and mathlib 4.27.0.

```bash
cd lean
chmod +x check_source.sh
./check_source.sh
```

Equivalent manual commands:

```bash
cd lean
lake update
lake build
lake env lean AnalyticTargets.lean
lake env lean AuditAxioms.lean
```

Review the last command's output. `sorryAx` must not appear. Foundational dependencies
such as `propext`, `Quot.sound`, and `Classical.choice` are ordinary in classical
mathlib developments and are not project-specific assumptions.

The strongest arithmetic specialization is:

```lean
theorem prime_moment_method_to_least_prime_classes
```

It proves that explicit lower/upper bounds for the second and third factorial moments,
together with total-incidence and cutoff-increment estimates, imply a quantitative
lower bound for

```text
{a < d | a.Coprime d ∧ X₁ < leastCongruentPrime a d}.
```

## Building the PDF

```bash
cd source
chmod +x build_pdf.sh
./build_pdf.sh
```

The script writes `../Erdos971_candidate_verification_note.pdf` and removes temporary
LaTeX files. It uses `pdflatex` when available and otherwise falls back to `tectonic`.

## GitHub Actions

If the full package directory is used as a GitHub repository, the workflow at
`.github/workflows/lean.yml` builds the Lake project in `lean/`, checks
`AnalyticTargets.lean`, prints the principal theorem dependencies, rejects `sorryAx`,
and scans the compiled core for textual trust escapes.

## Exact scope of the candidate proof

At

\[
R=\left\lfloor \frac{\phi(q)\log q}{q}\right\rfloor,
\qquad X=qR,
\]

let

\[
N_a(X)=\#\{p\le X:p\equiv a\pmod q\},
\quad
C_2=\sum_{(a,q)=1}\binom{N_a(X)}2,
\quad
C_3=\sum_{(a,q)=1}\binom{N_a(X)}3.
\]

The proposed analytic route is

\[
V(X;q)\gg X\log q \Longrightarrow C_2\gg\phi(q),
\]

and

\[
\text{uniform three-tuple upper sieve plus singular-series averaging}
\Longrightarrow C_3\ll\phi(q).
\]

The Lean-checked finite argument then gives a positive proportion of residue classes
with at least two primes below `X`, hence a positive proportion with no prime below
`X`; a prime-number-theorem increment estimate carries this to
`(1+c)φ(q) log q` for some fixed `c > 0`.

## Requested review

The decisive review points are the exact normalization and uniformity of the
pointwise variance lower bound, and the uniformity and singular-series accounting in
the three-shift sieve, particularly for highly composite or very smooth moduli.
See `REVIEW_CHECKLIST.md` and Sections 3-4 of the PDF.
