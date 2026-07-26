# Status and Scope

**Title:** A Complete Candidate Proof of Erdős Problem 971  
**Author:** KyungMin Han  
**Date:** 26 July 2026

## Mathematical status

The manuscript presents a candidate unconditional proof using two published unconditional inputs:

1. the Friedlander–Goldston pointwise lower bound for the variance of primes in arithmetic progressions; and
2. a uniform upper-bound sieve for three linear forms.

No unproved prime-tuple conjecture is invoked. The argument should nevertheless be treated as a candidate proof until the cited theorem statements, their uniformity, and their application are independently checked by specialists.

## Formal verification scope

The accompanying Lean development is sorry-free and verifies the finite combinatorial reduction and the bridge from empty prime occupancy to the least congruent prime inequality. Its strongest arithmetic theorem takes the following analytic estimates as hypotheses:

- a positive linear lower bound for the second factorial moment;
- a linear upper bound for the third factorial moment;
- a total-incidence estimate at the base cutoff; and
- an increment estimate between the two cutoffs.

The Lean file does not formalize the Friedlander–Goldston variance theorem, the three-linear-form upper sieve, the singular-series average, or the required prime-number-theorem asymptotics. It is therefore a complete formal proof of the conditional finite implication, not an end-to-end formal proof of the analytic manuscript.

## AI assistance

The research exploration, proof organization, drafting, and formalization workflow were substantially assisted using OpenAI's GPT-5.6 Pro. KyungMin Han has reviewed the material and assumes responsibility for all mathematical claims, citations, and errors.
