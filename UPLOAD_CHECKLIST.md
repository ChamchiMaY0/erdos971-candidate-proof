# Forum upload checklist

- [ ] Confirm that `Kyungmin` is the desired public author name and that the
      GPT-5.6 Pro assistance disclosure is accurate.
- [ ] Rebuild the PDF with `source/build_pdf.sh`.
- [ ] Run `lean/check_source.sh` on a machine with Lean/Lake and internet access.
- [ ] Confirm that `AuditAxioms.lean` does not report `sorryAx`.
- [ ] If publishing on GitHub, keep `.github/workflows/lean.yml` at the repository root.
- [ ] Recompute `MANIFEST.sha256` after any modification.
- [ ] Upload the PDF and full ZIP.
- [ ] Use the wording in `FORUM_POST.md`; retain the candidate/verification disclaimer.
- [ ] Ask reviewers specifically to check the pointwise variance and three-tuple sieve interfaces.
- [ ] Do not mark the problem solved until the analytic checkpoints receive independent review.
