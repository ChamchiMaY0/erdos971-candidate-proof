# Candidate proof of Erdős Problem 971 via pointwise variance and a three-tuple upper sieve

I am sharing a candidate unconditional proof of Erdős Problem 971. The research exploration, proof organization, drafting, and formalization workflow were substantially assisted using OpenAI's GPT-5.6 Pro. I have reviewed the argument and take responsibility for the mathematical claims and citations.

Set

\[
R=\left\lfloor\frac{\phi(q)\log q}{q}\right\rfloor,
\qquad X=qR,
\]

and let \(N_a(X)\) count primes up to \(X\) in the reduced class \(a\pmod q\). The proof establishes

\[
\sum_a^*\binom{N_a(X)}2\gg\phi(q)
\]

from the pointwise Friedlander–Goldston lower bound for Hooley's variance. The variance is expanded exactly; the diagonal term cancels at the critical cutoff, and proper prime powers contribute only \(o(X\log q)\).

It also establishes

\[
\sum_a^*\binom{N_a(X)}3\ll\phi(q)
\]

using a uniform upper-bound sieve for

\[
p,\qquad p+rq,\qquad p+sq.
\]

The singular-series calculation is uniform even for very smooth moduli. At primes dividing \(q\), the local factors multiply to exactly \((q/\phi(q))^2\), which is cancelled by the number of shift pairs. The remaining local factors have an elementary \(O(R^2)\) average by Hölder's inequality.

The two factorial-moment bounds force a positive proportion of classes to contain at least two primes below \(X\). Since the total number of prime incidences is \(\phi(q)+o(\phi(q))\), a positive proportion of classes are empty. A prime-number-theorem increment estimate preserves a positive proportion of empty classes up to \((1+c)\phi(q)\log q\) for some absolute \(c>0\).

The accompanying sorry-free Lean file verifies the finite combinatorial reduction and

\[
N_a(X)=0\Longleftrightarrow X<p(a,q),
\]

conditional on explicit analytic hypotheses. It does not formalize the Friedlander–Goldston theorem, the upper-bound sieve, the singular-series average, or the prime-number-theorem asymptotics.

The points most in need of independent checking are the exact normalization and range of the pointwise variance estimate, the uniformity of the three-linear-form upper sieve, and the singular-series averaging for smooth moduli.
