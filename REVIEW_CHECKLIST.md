# Independent review checklist

The candidate argument should not be treated as a solution unless every item below has
been checked against the cited theorems or reproved directly.

## A. Pointwise variance input

- [ ] Confirm the exact definition of `V(X;q)` and its centering by
      `ψ(X,χ₀)/φ(q)`.
- [ ] Confirm a pointwise lower bound
      `V(X;q) ≥ (1/2-o(1)) X log q`
      for every individual modulus in the required range
      `X/(log X)^A ≤ q ≤ X`, with uniform `o(1)`.
- [ ] Confirm that the chosen cutoff satisfies that range for all sufficiently large `q`.

## B. Passage from variance to the second factorial moment

- [ ] Check the exact identity
      `V = D_Λ + 2P_Λ - S²/φ(q)`.
- [ ] Check uniformly that
      `D_Λ-S²/φ(q)=o(X log q)` at the selected cutoff.
- [ ] Check deletion of terms involving proper prime powers:
      `O(X^{1/2}R(log X)^2)=o(X log q)`.
- [ ] Check the conversion of the weighted pair sum to `C₂ ≫ φ(q)`.

## C. Three-tuple upper sieve

- [ ] Verify a theorem with an absolute constant for
      `p,p+rq,p+sq`, uniformly in `q,r,s`, when the shifts are `O(X)`.
- [ ] Verify that its singular series uses exactly the local occupancy
      `ν_ℓ(0,-rq,-sq)`.
- [ ] Verify the treatment of nonadmissible triples and the bound `T_q(r,s)≤3`.

## D. Singular-series average

- [ ] At every `ℓ|q`, verify that the local factor is exactly
      `(1-1/ℓ)^{-2}`.
- [ ] For `ℓ∤qrs(s-r)`, verify that the local factor is at most one for `ℓ≥5`.
- [ ] Check a uniform majorant
      `S_q(r,s) ≪ (q/φ(q))² F(r)F(s)F(s-r)`.
- [ ] Check `Σ_{n≤R}F(n)^3≪R` and the Hölder deduction of an `O(R²)` double sum.
- [ ] Check that these estimates yield `C₃≪φ(q)` for arbitrary, including smooth, `q`.

## E. Finite extraction and cutoff extension

- [ ] Rebuild the Lean project and inspect `AuditAxioms.lean`.
- [ ] Check the choice of fixed truncation threshold `T` from the constants in `C₂` and `C₃`.
- [ ] Check `M=π(X)-ω(q)=φ(q)+o(φ(q))` uniformly at the chosen cutoff.
- [ ] Check all floors, ceilings, strict inequalities, and the conversion to the real cutoff
      `(1+c)φ(q)log q`.
- [ ] Check `π(Y)-π(X)=cφ(q)+o(φ(q))` for fixed small `c>0`.

## Decision rule

A failure in A, C, or D invalidates the proposed closing argument. A failure in B or E may
be repairable but must be quantified. Only after all items pass should the argument be
presented as a complete unconditional proof.
