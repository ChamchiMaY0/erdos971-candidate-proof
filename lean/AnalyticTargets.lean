import Erdos971Forum

/-!
# Analytic targets for a complete formalization of Erdős Problem 971

This file states, but does not assert or prove, the quantitative analytic estimates
that must be supplied to instantiate the kernel-checked finite reduction.
Every item is a `Prop` definition, not an axiom.
-/

open Filter Real
open scoped BigOperators Topology

namespace Erdos971LeanAudit

noncomputable section

/-- Eventual lower bound for the second factorial moment at a chosen base cutoff. -/
def PairMomentClaim (X₀ : ℕ → ℕ) : Prop :=
  ∃ α > (0 : ℝ), ∀ᶠ d in atTop,
    α * classMass (reducedResidues d) ≤
      pairMoment (reducedResidues d) (primeOccupancy d (X₀ d))

/-- Eventual upper bound for the third factorial moment at a chosen base cutoff. -/
def TripleMomentClaim (X₀ : ℕ → ℕ) : Prop :=
  ∃ β > (0 : ℝ), ∀ᶠ d in atTop,
    tripleMoment (reducedResidues d) (primeOccupancy d (X₀ d)) ≤
      β * classMass (reducedResidues d)

/-- Prime-number-theorem control of the total number of incidences at the base cutoff. -/
def TotalMassClaim (X₀ : ℕ → ℕ) (ε : ℕ → ℝ) : Prop :=
  Tendsto ε atTop (𝓝 0) ∧
  ∀ᶠ d in atTop,
    totalMass (reducedResidues d) (primeOccupancy d (X₀ d)) ≤
      (1 + ε d) * classMass (reducedResidues d)

/-- Control of the number of incidences added between two cutoffs. -/
def IncrementClaim (X₀ X₁ : ℕ → ℕ) (η : ℝ) : Prop :=
  ∀ᶠ d in atTop,
    incrementMass (reducedResidues d)
        (primeOccupancy d (X₀ d)) (primeOccupancy d (X₁ d)) ≤
      η * classMass (reducedResidues d)

end

end Erdos971LeanAudit
