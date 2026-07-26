# Verification record

Updated on 26 July 2026.

## Lean

The finite reduction was independently rebuilt in a GitHub-hosted Ubuntu
environment with Lean 4.27.0 and mathlib v4.27.0. The build completed
successfully, as did the checks of `AnalyticTargets.lean`, `AuditAxioms.lean`,
and the textual scan for `sorry`, `admit`, and project-declared `axiom` in the
compiled core.

The principal theorem dependency report was:

```text
'Erdos971LeanAudit.moment_method_with_extension' depends on axioms:
[propext, Classical.choice, Quot.sound]

'Erdos971LeanAudit.emptyMass_primeOccupancy_eq_target_card' depends on axioms:
[propext, Classical.choice, Quot.sound]

'Erdos971LeanAudit.prime_moment_method_to_least_prime_classes' depends on axioms:
[propext, Classical.choice, Quot.sound]
```

No `sorryAx` dependency was reported.

The tracked Lean files, including `lean/Erdos971Forum.lean`, are preserved
unchanged in the manuscript revision.

## PDF

The revised manuscript has:

- visible and metadata author `KyungMin Han`;
- explicit disclosure of substantial assistance from OpenAI's GPT-5.6 Pro;
- Status and Scope removed to `STATUS_AND_SCOPE.md`;
- discussion/posting material removed to `DISCUSSION_POST.md`;
- no embedded forum-specific status or rules section.

## Scope

These checks verify the conditional finite Lean reduction and package
reproducibility. They do not constitute an end-to-end Lean formalization of the
Friedlander–Goldston variance theorem, the three-linear-form upper sieve, the
singular-series average, or the asymptotic estimates needed to instantiate the
analytic hypotheses.
