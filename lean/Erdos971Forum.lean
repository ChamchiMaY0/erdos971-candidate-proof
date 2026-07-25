import Mathlib

/-!
# Erdős 971 finite audit — standalone file

This file inlines the complete finite/combinatorial audit scaffold and the
residue-class specialization. It has no project-local imports, so it can be
submitted as one unit to a Lean 4.27.0 + mathlib checker such as AXLE.
It does not contain the missing analytic number theory.
-/


/-! ===== Inlined from Erdos971LeanAudit/Combinatorial.lean ===== -/


/-!
# The finite combinatorial core of the proposed approach to Erdős Problem 971

This file contains no analytic number theory.  It formalizes the implication

* large second factorial moment,
* controlled third factorial moment,
* nearly one point of total mass per class

⇒ many empty classes.

The weights below are the polynomial extensions to `ℝ` of `Nat.choose n 2`
and `Nat.choose n 3`.
-/

open scoped BigOperators

namespace Erdos971LeanAudit

noncomputable section

/-- The number of unordered pairs selected from a natural occupancy `n`, cast to `ℝ`. -/
def pairWeight (n : ℕ) : ℝ :=
  (n : ℝ) * ((n : ℝ) - 1) / 2

/-- The number of unordered triples selected from a natural occupancy `n`, cast to `ℝ`. -/
def tripleWeight (n : ℕ) : ℝ :=
  (n : ℝ) * ((n : ℝ) - 1) * ((n : ℝ) - 2) / 6

lemma pairWeight_nonneg (n : ℕ) : 0 ≤ pairWeight n := by
  by_cases h : n = 0
  · simp [pairWeight, h]
  · have hn : 1 ≤ n := Nat.one_le_iff_ne_zero.mpr h
    have hn' : (1 : ℝ) ≤ n := by exact_mod_cast hn
    unfold pairWeight
    exact div_nonneg (mul_nonneg (by positivity) (sub_nonneg.mpr hn')) (by norm_num)

lemma pairWeight_pos {n : ℕ} (hn : 2 ≤ n) : 0 < pairWeight n := by
  have hn0Nat : 0 < n := by omega
  have hn0 : (0 : ℝ) < n := by exact_mod_cast hn0Nat
  have hn1 : (0 : ℝ) < (n : ℝ) - 1 := by
    have : (1 : ℝ) < n := by exact_mod_cast hn
    linarith
  unfold pairWeight
  positivity

lemma tripleWeight_nonneg (n : ℕ) : 0 ≤ tripleWeight n := by
  by_cases hn : n ≤ 2
  · interval_cases n <;> norm_num [tripleWeight]
  · have hn3 : 3 ≤ n := by omega
    have h0 : (0 : ℝ) ≤ n := by positivity
    have h1 : (0 : ℝ) ≤ (n : ℝ) - 1 := by
      have : (1 : ℝ) ≤ n := by exact_mod_cast (show 1 ≤ n by omega)
      linarith
    have h2 : (0 : ℝ) ≤ (n : ℝ) - 2 := by
      have : (2 : ℝ) ≤ n := by exact_mod_cast (show 2 ≤ n by omega)
      linarith
    unfold tripleWeight
    positivity

lemma three_mul_tripleWeight (n : ℕ) :
    3 * tripleWeight n = ((n : ℝ) - 2) * pairWeight n := by
  unfold tripleWeight pairWeight
  ring

lemma pairWeight_mono {m n : ℕ} (hm : 1 ≤ m) (hmn : m ≤ n) :
    pairWeight m ≤ pairWeight n := by
  have hmn' : (m : ℝ) ≤ n := by exact_mod_cast hmn
  have hm' : (1 : ℝ) ≤ m := by exact_mod_cast hm
  have hdiff : 0 ≤ (n : ℝ) - m := by linarith
  have hsum : 0 ≤ (n : ℝ) + m - 1 := by linarith
  have hprod : 0 ≤ ((n : ℝ) - m) * ((n : ℝ) + m - 1) :=
    mul_nonneg hdiff hsum
  unfold pairWeight
  nlinarith

/-- Indicator that an occupancy is zero. -/
def emptyIndicator (n : ℕ) : ℝ :=
  if n = 0 then 1 else 0

/-- Indicator that an occupancy is positive. -/
def occupiedIndicator (n : ℕ) : ℝ :=
  if 1 ≤ n then 1 else 0

/-- Indicator that an occupancy is at least two. -/
def doubleIndicator (n : ℕ) : ℝ :=
  if 2 ≤ n then 1 else 0

@[simp] lemma emptyIndicator_add_occupiedIndicator (n : ℕ) :
    emptyIndicator n + occupiedIndicator n = 1 := by
  by_cases h : n = 0
  · simp [emptyIndicator, occupiedIndicator, h]
  · have hn : 1 ≤ n := Nat.one_le_iff_ne_zero.mpr h
    simp [emptyIndicator, occupiedIndicator, h, hn]

lemma occupiedIndicator_add_doubleIndicator_le (n : ℕ) :
    occupiedIndicator n + doubleIndicator n ≤ (n : ℝ) := by
  by_cases h0 : n = 0
  · simp [occupiedIndicator, doubleIndicator, h0]
  by_cases h1 : n = 1
  · simp [occupiedIndicator, doubleIndicator, h1]
  · have hn2 : 2 ≤ n := by omega
    have hn1 : 1 ≤ n := by omega
    simp only [occupiedIndicator, doubleIndicator, if_pos hn1, if_pos hn2]
    exact_mod_cast hn2

/-- The number of classes, cast to `ℝ`. -/
def classMass {α : Type*} (S : Finset α) : ℝ :=
  S.card

/-- Total occupancy over the finite set of classes. -/
def totalMass {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, (N a : ℝ)

/-- Number of empty classes, represented as a real-valued indicator sum. -/
def emptyMass {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, emptyIndicator (N a)

/-- Number of occupied classes, represented as a real-valued indicator sum. -/
def occupiedMass {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, occupiedIndicator (N a)

/-- Number of classes with occupancy at least two. -/
def doubleMass {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, doubleIndicator (N a)

/-- Second factorial moment over the classes. -/
def pairMoment {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, pairWeight (N a)

/-- Third factorial moment over the classes. -/
def tripleMoment {α : Type*} (S : Finset α) (N : α → ℕ) : ℝ :=
  ∑ a ∈ S, tripleWeight (N a)

lemma classMass_nonneg {α : Type*} (S : Finset α) : 0 ≤ classMass S := by
  simp [classMass]

lemma emptyMass_eq_card {α : Type*} (S : Finset α) (N : α → ℕ) :
    emptyMass S N = ((S.filter fun a ↦ N a = 0).card : ℝ) := by
  classical
  simp [emptyMass, emptyIndicator]

lemma occupiedMass_eq_card {α : Type*} (S : Finset α) (N : α → ℕ) :
    occupiedMass S N = ((S.filter fun a ↦ 1 ≤ N a).card : ℝ) := by
  classical
  simp [occupiedMass, occupiedIndicator]

lemma doubleMass_eq_card {α : Type*} (S : Finset α) (N : α → ℕ) :
    doubleMass S N = ((S.filter fun a ↦ 2 ≤ N a).card : ℝ) := by
  classical
  simp [doubleMass, doubleIndicator]

lemma emptyMass_add_occupiedMass {α : Type*} (S : Finset α) (N : α → ℕ) :
    emptyMass S N + occupiedMass S N = classMass S := by
  classical
  unfold emptyMass occupiedMass classMass
  rw [← Finset.sum_add_distrib]
  calc
    (∑ a ∈ S, (emptyIndicator (N a) + occupiedIndicator (N a))) =
        ∑ _a ∈ S, (1 : ℝ) := by
          apply Finset.sum_congr rfl
          intro a _ha
          exact emptyIndicator_add_occupiedIndicator (N a)
    _ = S.card := by simp

lemma occupiedMass_add_doubleMass_le_totalMass {α : Type*}
    (S : Finset α) (N : α → ℕ) :
    occupiedMass S N + doubleMass S N ≤ totalMass S N := by
  classical
  unfold occupiedMass doubleMass totalMass
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_le_sum fun a _ha ↦ occupiedIndicator_add_doubleIndicator_le (N a)

/-- Exact bookkeeping inequality: every class costs one point of mass to be occupied,
and every class counted by `doubleMass` costs at least one additional point. -/
theorem emptyMass_lower_raw {α : Type*} (S : Finset α) (N : α → ℕ) :
    classMass S - totalMass S N + doubleMass S N ≤ emptyMass S N := by
  have hpartition := emptyMass_add_occupiedMass S N
  have hincidence := occupiedMass_add_doubleMass_le_totalMass S N
  linarith

/-- Pointwise truncation inequality. It is the elementary engine that prevents the
second moment from concentrating in a small number of very highly occupied classes. -/
lemma truncation_pointwise (T n : ℕ) (hT : 3 ≤ T) :
    ((T : ℝ) - 2) * pairWeight n ≤
      ((T : ℝ) - 2) * pairWeight T * doubleIndicator n + 3 * tripleWeight n := by
  have hc : 0 < (T : ℝ) - 2 := by
    have : (2 : ℝ) < T := by exact_mod_cast (show 2 < T by omega)
    linarith
  have hc0 : 0 ≤ (T : ℝ) - 2 := le_of_lt hc
  by_cases hn2 : 2 ≤ n
  · rw [doubleIndicator]
    simp only [if_pos hn2, mul_one]
    by_cases hnT : n < T
    · have hmono : pairWeight n ≤ pairWeight T :=
        pairWeight_mono (show 1 ≤ n by omega) (show n ≤ T by omega)
      have hscaled := mul_le_mul_of_nonneg_left hmono hc0
      have htriple := tripleWeight_nonneg n
      nlinarith
    · have hTn : T ≤ n := by omega
      have hcoef : (T : ℝ) - 2 ≤ (n : ℝ) - 2 := by
        have : (T : ℝ) ≤ n := by exact_mod_cast hTn
        linarith
      have hp : 0 ≤ pairWeight n := pairWeight_nonneg n
      have hmain : ((T : ℝ) - 2) * pairWeight n ≤
          ((n : ℝ) - 2) * pairWeight n :=
        mul_le_mul_of_nonneg_right hcoef hp
      have hbonus : 0 ≤ ((T : ℝ) - 2) * pairWeight T :=
        mul_nonneg hc0 (pairWeight_nonneg T)
      rw [three_mul_tripleWeight]
      linarith
  · have hn : n = 0 ∨ n = 1 := by omega
    rcases hn with rfl | rfl <;>
      norm_num [pairWeight, tripleWeight, doubleIndicator]

/-- Summed form of `truncation_pointwise`. -/
theorem moment_truncation {α : Type*} (S : Finset α) (N : α → ℕ)
    (T : ℕ) (hT : 3 ≤ T) :
    ((T : ℝ) - 2) * pairMoment S N ≤
      ((T : ℝ) - 2) * pairWeight T * doubleMass S N + 3 * tripleMoment S N := by
  classical
  have hsum :
      (∑ a ∈ S, ((T : ℝ) - 2) * pairWeight (N a)) ≤
        ∑ a ∈ S,
          (((T : ℝ) - 2) * pairWeight T * doubleIndicator (N a) +
            3 * tripleWeight (N a)) :=
    Finset.sum_le_sum fun a _ha ↦ truncation_pointwise T (N a) hT
  simpa [pairMoment, doubleMass, tripleMoment, Finset.mul_sum,
    Finset.sum_add_distrib, mul_assoc] using hsum

/-- A certificate form of the second/third-moment support argument.

`hGap` is a purely scalar inequality.  In an application one chooses a fixed `T`
and checks it from the constants in the pair lower bound and triple upper bound. -/
theorem doubleMass_lower_bound_of_moments {α : Type*}
    (S : Finset α) (N : α → ℕ) (T : ℕ) (hT : 3 ≤ T)
    (pairConst tripleConst doubleConst : ℝ)
    (hPair : pairConst * classMass S ≤ pairMoment S N)
    (hTriple : tripleMoment S N ≤ tripleConst * classMass S)
    (hGap :
      (((T : ℝ) - 2) * pairWeight T) * (doubleConst * classMass S) +
          3 * (tripleConst * classMass S) ≤
        ((T : ℝ) - 2) * (pairConst * classMass S)) :
    doubleConst * classMass S ≤ doubleMass S N := by
  let cT : ℝ := (T : ℝ) - 2
  let A : ℝ := cT * pairWeight T
  have hcT : 0 < cT := by
    dsimp [cT]
    have : (2 : ℝ) < T := by exact_mod_cast (show 2 < T by omega)
    linarith
  have hA : 0 < A := by
    dsimp [A]
    exact mul_pos hcT (pairWeight_pos (show 2 ≤ T by omega))
  have hPairScaled : cT * (pairConst * classMass S) ≤ cT * pairMoment S N :=
    mul_le_mul_of_nonneg_left hPair (le_of_lt hcT)
  have hTrunc := moment_truncation S N T hT
  have hTripleScaled : 3 * tripleMoment S N ≤ 3 * (tripleConst * classMass S) :=
    mul_le_mul_of_nonneg_left hTriple (by norm_num)
  have hCombined :
      cT * (pairConst * classMass S) ≤
        A * doubleMass S N + 3 * (tripleConst * classMass S) := by
    dsimp [cT, A] at hPairScaled hTripleScaled hTrunc ⊢
    linarith
  have hMul : A * (doubleConst * classMass S) ≤ A * doubleMass S N := by
    dsimp [cT, A] at hGap hCombined ⊢
    linarith
  nlinarith

/-- If total mass is at most `(1 + ε)` times the number of classes and at least a
`δ` proportion of the classes have occupancy at least two, then at least a
`δ - ε` proportion are empty. -/
theorem emptyMass_lower_bound {α : Type*}
    (S : Finset α) (N : α → ℕ) (ε δ : ℝ)
    (hTotal : totalMass S N ≤ (1 + ε) * classMass S)
    (hDouble : δ * classMass S ≤ doubleMass S N) :
    (δ - ε) * classMass S ≤ emptyMass S N := by
  have hraw := emptyMass_lower_raw S N
  have hclass := classMass_nonneg S
  nlinarith

/-- Total increase in occupancy when passing from `N₀` to `N₁`. -/
def incrementMass {α : Type*} (S : Finset α) (N₀ N₁ : α → ℕ) : ℝ :=
  ∑ a ∈ S, ((N₁ a - N₀ a : ℕ) : ℝ)

lemma emptyIndicator_le_after_add_increment {n₀ n₁ : ℕ} (hmono : n₀ ≤ n₁) :
    emptyIndicator n₀ ≤ emptyIndicator n₁ + ((n₁ - n₀ : ℕ) : ℝ) := by
  by_cases h0 : n₀ = 0
  · subst n₀
    by_cases h1 : n₁ = 0
    · simp [emptyIndicator, h1]
    · have hn1 : 1 ≤ n₁ := Nat.one_le_iff_ne_zero.mpr h1
      simp [emptyIndicator, h1]
      exact_mod_cast hn1
  · have hnonneg : 0 ≤ ((n₁ - n₀ : ℕ) : ℝ) := by positivity
    simp [emptyIndicator, h0]
    positivity

/-- Adding incidences can destroy at most one empty class per added incidence. -/
theorem emptyMass_le_after_add_increment {α : Type*}
    (S : Finset α) (N₀ N₁ : α → ℕ)
    (hmono : ∀ a ∈ S, N₀ a ≤ N₁ a) :
    emptyMass S N₀ ≤ emptyMass S N₁ + incrementMass S N₀ N₁ := by
  classical
  have hsum :
      (∑ a ∈ S, emptyIndicator (N₀ a)) ≤
        ∑ a ∈ S, (emptyIndicator (N₁ a) + ((N₁ a - N₀ a : ℕ) : ℝ)) :=
    Finset.sum_le_sum fun a ha ↦ emptyIndicator_le_after_add_increment (hmono a ha)
  simpa [emptyMass, incrementMass, Finset.sum_add_distrib] using hsum

/-- Quantitative extension lemma: a base empty-class lower bound survives after adding
at most `c` incidences per class on average. -/
theorem emptyMass_lower_bound_after_extension {α : Type*}
    (S : Finset α) (N₀ N₁ : α → ℕ) (δ c : ℝ)
    (hmono : ∀ a ∈ S, N₀ a ≤ N₁ a)
    (hBase : δ * classMass S ≤ emptyMass S N₀)
    (hIncrement : incrementMass S N₀ N₁ ≤ c * classMass S) :
    (δ - c) * classMass S ≤ emptyMass S N₁ := by
  have hloss := emptyMass_le_after_add_increment S N₀ N₁ hmono
  linarith

end

end Erdos971LeanAudit

/-! ===== Inlined from Erdos971LeanAudit/Residues.lean ===== -/


/-!
# Residue classes and the least congruent prime

This file supplies the elementary bridge from finite occupancy counts to the
`leastCongruentPrime` formulation.  Dirichlet's theorem on primes in arithmetic
progressions is already available in mathlib and is used only to show that the set
whose infimum is taken is nonempty.
-/

open scoped BigOperators Nat.Prime

namespace Erdos971LeanAudit

noncomputable section

/-- Reduced residue representatives in `[0,d)`. -/
def reducedResidues (d : ℕ) : Finset ℕ :=
  (Finset.range d).filter fun a ↦ a.Coprime d

lemma reducedResidues_card (d : ℕ) :
    (reducedResidues d).card = d.totient := by
  simpa [reducedResidues, Nat.coprime_comm] using
    (Nat.totient_eq_card_coprime d).symm

/-- The number of primes `p ≤ X` in the residue class `a mod d`. -/
def primeOccupancy (d X a : ℕ) : ℕ :=
  ((Finset.range (X + 1)).filter fun p ↦ p.Prime ∧ p ≡ a [MOD d]).card

lemma primeOccupancy_mono {d X Y a : ℕ} (hXY : X ≤ Y) :
    primeOccupancy d X a ≤ primeOccupancy d Y a := by
  unfold primeOccupancy
  apply Finset.card_le_card
  intro p hp
  simp only [Finset.mem_filter, Finset.mem_range, Nat.lt_add_one_iff] at hp ⊢
  exact ⟨le_trans hp.1 hXY, hp.2⟩

lemma primeOccupancy_eq_zero_iff (d X a : ℕ) :
    primeOccupancy d X a = 0 ↔
      ∀ p ≤ X, p.Prime → ¬p ≡ a [MOD d] := by
  classical
  simp [primeOccupancy]

/-- Same definition as the one used in Formal Conjectures' Erdős 971 file. -/
noncomputable def leastCongruentPrime (a d : ℕ) : ℕ :=
  sInf {p : ℕ | p.Prime ∧ p ≡ a [MOD d]}

lemma congruentPrimeSet_nonempty {a d : ℕ} (hd : d ≠ 0) (ha : a.Coprime d) :
    Set.Nonempty {p : ℕ | p.Prime ∧ p ≡ a [MOD d]} := by
  obtain ⟨p, _hp0, hp, hpa⟩ := Nat.forall_exists_prime_gt_and_modEq 0 hd ha
  exact ⟨p, hp, hpa⟩

lemma leastCongruentPrime_spec {a d : ℕ} (hd : d ≠ 0) (ha : a.Coprime d) :
    (leastCongruentPrime a d).Prime ∧ leastCongruentPrime a d ≡ a [MOD d] := by
  unfold leastCongruentPrime
  exact Nat.sInf_mem (congruentPrimeSet_nonempty hd ha)

lemma leastCongruentPrime_le_of_prime_mod {a d p : ℕ}
    (hp : p.Prime) (hpa : p ≡ a [MOD d]) :
    leastCongruentPrime a d ≤ p := by
  unfold leastCongruentPrime
  exact Nat.sInf_le ⟨hp, hpa⟩

/-- The minimum exceeds `X` exactly when the class contains no prime up to `X`. -/
theorem cutoff_lt_leastCongruentPrime_iff {a d X : ℕ}
    (hd : d ≠ 0) (ha : a.Coprime d) :
    X < leastCongruentPrime a d ↔
      ∀ p ≤ X, p.Prime → ¬p ≡ a [MOD d] := by
  constructor
  · intro hleast p hpX hp hpa
    have hmin := leastCongruentPrime_le_of_prime_mod hp hpa
    omega
  · intro hnone
    by_contra hnot
    have hle : leastCongruentPrime a d ≤ X := by omega
    have hspec := leastCongruentPrime_spec hd ha
    exact hnone (leastCongruentPrime a d) hle hspec.1 hspec.2

/-- Occupancy zero is exactly the desired least-prime inequality. -/
theorem primeOccupancy_eq_zero_iff_cutoff_lt_least {a d X : ℕ}
    (hd : d ≠ 0) (ha : a.Coprime d) :
    primeOccupancy d X a = 0 ↔ X < leastCongruentPrime a d := by
  exact (primeOccupancy_eq_zero_iff d X a).trans
    (cutoff_lt_leastCongruentPrime_iff hd ha).symm

/-- Reduced residue classes whose least congruent prime exceeds `X`. -/
def emptyLeastPrimeClasses (d X : ℕ) : Finset ℕ :=
  (Finset.range d).filter fun a ↦ a.Coprime d ∧ X < leastCongruentPrime a d

/-- The `emptyMass` used by the finite reduction is literally the cardinality of
classes satisfying the least-congruent-prime cutoff inequality. -/
theorem emptyMass_primeOccupancy_eq_target_card {d X : ℕ} (hd : d ≠ 0) :
    emptyMass (reducedResidues d) (primeOccupancy d X) =
      ((emptyLeastPrimeClasses d X).card : ℝ) := by
  have hsets :
      (reducedResidues d).filter (fun a ↦ primeOccupancy d X a = 0) =
        emptyLeastPrimeClasses d X := by
    ext a
    simp only [Finset.mem_filter, Finset.mem_range, reducedResidues,
      emptyLeastPrimeClasses]
    constructor
    · rintro ⟨⟨ha_lt, ha_coprime⟩, hzero⟩
      exact ⟨ha_lt, ha_coprime,
        (primeOccupancy_eq_zero_iff_cutoff_lt_least hd ha_coprime).mp hzero⟩
    · rintro ⟨ha_lt, ha_coprime, hleast⟩
      exact ⟨⟨ha_lt, ha_coprime⟩,
        (primeOccupancy_eq_zero_iff_cutoff_lt_least hd ha_coprime).mpr hleast⟩
  rw [emptyMass_eq_card, hsets]

end

end Erdos971LeanAudit

/-! ===== Inlined from Erdos971LeanAudit/Reduction.lean ===== -/


/-!
# A single certificate theorem for the proposed Erdős 971 moment method

The theorem in this file contains all finite/combinatorial reasoning.  To use it for
primes in residue classes one must instantiate the hypotheses with analytic estimates.
-/

namespace Erdos971LeanAudit

open scoped BigOperators

noncomputable section

/-- The complete finite reduction used by the candidate proof.

The analytic layer has to provide:

* `hPair`: a lower bound for the second factorial moment;
* `hTriple`: an upper bound for the third factorial moment;
* `hTotal`: prime-number-theorem control of total mass at the base cutoff;
* `hIncrement`: control of primes added between the base and enlarged cutoffs.

Everything else is elementary and is proved in `Combinatorial.lean`. -/
theorem moment_method_with_extension {α : Type*}
    (S : Finset α) (N₀ N₁ : α → ℕ)
    (T : ℕ) (hT : 3 ≤ T)
    (pairConst tripleConst doubleConst massError extensionConst : ℝ)
    (hPair : pairConst * classMass S ≤ pairMoment S N₀)
    (hTriple : tripleMoment S N₀ ≤ tripleConst * classMass S)
    (hGap :
      (((T : ℝ) - 2) * pairWeight T) * (doubleConst * classMass S) +
          3 * (tripleConst * classMass S) ≤
        ((T : ℝ) - 2) * (pairConst * classMass S))
    (hTotal : totalMass S N₀ ≤ (1 + massError) * classMass S)
    (hmono : ∀ a ∈ S, N₀ a ≤ N₁ a)
    (hIncrement : incrementMass S N₀ N₁ ≤ extensionConst * classMass S) :
    (doubleConst - massError - extensionConst) * classMass S ≤ emptyMass S N₁ := by
  have hDouble : doubleConst * classMass S ≤ doubleMass S N₀ :=
    doubleMass_lower_bound_of_moments S N₀ T hT pairConst tripleConst doubleConst
      hPair hTriple hGap
  have hBase : (doubleConst - massError) * classMass S ≤ emptyMass S N₀ :=
    emptyMass_lower_bound S N₀ massError doubleConst hTotal hDouble
  have hExtended := emptyMass_lower_bound_after_extension S N₀ N₁
    (doubleConst - massError) extensionConst hmono hBase hIncrement
  exact hExtended

end

end Erdos971LeanAudit

/-! ===== Inlined from Erdos971LeanAudit/PrimeReduction.lean ===== -/


/-!
# Prime-residue specialization of the finite moment reduction

This file specializes `moment_method_with_extension` to prime occupancies modulo `d`
and rewrites its conclusion as a cardinality statement about least congruent primes.
All quantitative analytic number theory remains in the hypotheses.
-/

namespace Erdos971LeanAudit

noncomputable section

/-- Assuming the required second-moment, third-moment, total-incidence, and
interval-increment estimates for the prime occupancies at cutoffs `X₀ ≤ X₁`,
the finite argument yields many reduced residue classes whose least congruent
prime is greater than `X₁`.

This is the strongest theorem in the compiled audit scaffold that is specialized
to the arithmetic objects in Erdős Problem 971. -/
theorem prime_moment_method_to_least_prime_classes
    {d X₀ X₁ T : ℕ} (hd : d ≠ 0) (hT : 3 ≤ T) (hcut : X₀ ≤ X₁)
    (pairConst tripleConst doubleConst massError extensionConst : ℝ)
    (hPair :
      pairConst * classMass (reducedResidues d) ≤
        pairMoment (reducedResidues d) (primeOccupancy d X₀))
    (hTriple :
      tripleMoment (reducedResidues d) (primeOccupancy d X₀) ≤
        tripleConst * classMass (reducedResidues d))
    (hGap :
      (((T : ℝ) - 2) * pairWeight T) *
            (doubleConst * classMass (reducedResidues d)) +
          3 * (tripleConst * classMass (reducedResidues d)) ≤
        ((T : ℝ) - 2) *
          (pairConst * classMass (reducedResidues d)))
    (hTotal :
      totalMass (reducedResidues d) (primeOccupancy d X₀) ≤
        (1 + massError) * classMass (reducedResidues d))
    (hIncrement :
      incrementMass (reducedResidues d)
          (primeOccupancy d X₀) (primeOccupancy d X₁) ≤
        extensionConst * classMass (reducedResidues d)) :
    (doubleConst - massError - extensionConst) * (d.totient : ℝ) ≤
      ((emptyLeastPrimeClasses d X₁).card : ℝ) := by
  have hFinite := moment_method_with_extension
      (reducedResidues d)
      (primeOccupancy d X₀)
      (primeOccupancy d X₁)
      T hT pairConst tripleConst doubleConst massError extensionConst
      hPair hTriple hGap hTotal
      (fun _a _ha ↦ primeOccupancy_mono hcut)
      hIncrement
  rw [emptyMass_primeOccupancy_eq_target_card hd] at hFinite
  simpa [classMass, reducedResidues_card] using hFinite

end

end Erdos971LeanAudit
