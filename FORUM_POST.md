# Candidate proof of Erdős Problem 971 via pointwise variance and a three-tuple upper sieve

I am posting a candidate unconditional argument for Erdős Problem 971 together with a Lean 4 verification package. This is a request for independent checking, not a claim that the problem has already been accepted as solved.

For

\[
R=\left\lfloor\frac{\phi(q)\log q}{q}\right\rfloor,
\qquad X=qR,
\]

write

\[
N_a(X)=\#\{p\le X:p\equiv a\pmod q\},
\quad
C_2=\sum_{(a,q)=1}\binom{N_a(X)}2,
\quad
C_3=\sum_{(a,q)=1}\binom{N_a(X)}3.
\]

The proposed analytic route is

\[
V(X;q)\gg X\log q \quad\Longrightarrow\quad C_2\gg\phi(q),
\]

using the pointwise Friedlander-Goldston lower bound for Hooley's variance, and

\[
C_3\ll\phi(q),
\]

using a uniform upper-bound sieve for the three forms

\[
p,\qquad p+rq,\qquad p+sq,
\]

followed by a uniform average of their singular series. At primes dividing `q`, the local factor is exactly `(1-1/ℓ)^{-2}`, so the resulting `(q/φ(q))^2` factor is cancelled by the number of available shift pairs.

The two factorial-moment estimates imply that a positive proportion of reduced residue classes contain at least two primes below `X`. Since the total number of prime incidences is `φ(q)+o(φ(q))`, a positive proportion of classes are empty below `X`. A prime-number-theorem increment estimate then preserves a positive proportion of empty classes up to `(1+c)φ(q) log q` for some fixed `c>0`.

The attached Lean file checks the complete finite combinatorial reduction and the bridge

\[
N_a(X)=0 \quad\Longleftrightarrow\quad X<p(a,q),
\]

conditional on explicit analytic hypotheses. The compiled core contains no `sorry`, `admit`, or project-declared axioms. The deep analytic estimates themselves are not yet formalized, so a successful Lean build does not by itself certify the complete number-theoretic proof.

I would particularly appreciate checks of:

1. the exact centering, normalization, and uniformity of the pointwise variance lower bound in the range `q ≥ X/log X`;
2. the `o(X log q)` diagonal and prime-power bookkeeping;
3. the uniformity of the three-linear-form upper sieve when the shifts vary with `q` and can be of order `X`; and
4. the singular-series majorant and its average, especially for very smooth moduli.

The PDF contains the full proposed argument, explicit verification checkpoints, the Lean theorem interface, and reproducible build instructions. The ZIP contains the LaTeX source and the complete Lean project.
