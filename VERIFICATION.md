# Local verification record

Verified on 25 July 2026 with Lean 4.27.0 and mathlib v4.27.0.

## Lean

The following command completed successfully from `lean/`:

```bash
./check_source.sh
```

The fresh build completed 7,886 jobs. The principal theorem dependency report was:

```text
'Erdos971LeanAudit.moment_method_with_extension' depends on axioms:
[propext, Classical.choice, Quot.sound]

'Erdos971LeanAudit.emptyMass_primeOccupancy_eq_target_card' depends on axioms:
[propext, Classical.choice, Quot.sound]

'Erdos971LeanAudit.prime_moment_method_to_least_prime_classes' depends on axioms:
[propext, Classical.choice, Quot.sound]
```

No `sorryAx` dependency was reported. The compiled core also passed the textual scan
for `sorry`, `admit`, and project-declared `axiom`.

## PDF

`source/build_pdf.sh` completed with Tectonic 0.16.9. The resulting PDF has:

- 10 US Letter pages;
- `Kyungmin` as both the visible author and PDF metadata author;
- an explicit disclosure of substantial GPT-5.6 Pro assistance;
- no embedded copy of the separate forum-post draft;
- no encryption, forms, or JavaScript;
- six unique external reference links; and
- no visible clipping, overlap, or broken glyphs in a rendered review of all pages.

## Scope

These checks verify the conditional finite Lean reduction and package reproducibility.
They do not prove the Friedlander-Goldston variance theorem, the uniform three-tuple
upper sieve, the singular-series average, or the asymptotic estimates needed to
instantiate the analytic hypotheses.
