# 에르되시 문제 971 후보 증명 패키지

**저자:** KyungMin Han  
**AI 지원:** OpenAI GPT-5.6 Pro

이 저장소는 수정된 후보 증명 PDF와, 그 증명의 유한 조합론적 환원을
검증하는 sorry-free Lean 4 파일을 포함한다.

## 주요 파일

- `Erdos971_candidate_verification_note.pdf`: 수정된 PDF. 기존 `blob/main`
  링크가 계속 최신 문서를 열도록 기존 경로를 유지한다.
- `source/erdos971_candidate.tex`: LaTeX 원문.
- `lean/Erdos971Forum.lean`: PDF에 대응하는 Lean 환원 파일. 기존 링크를
  유지하기 위해 기존 경로에 새 설명 헤더를 반영했다.
- `STATUS_AND_SCOPE.md`: 수학적 상태와 Lean 검증 범위.
- `DISCUSSION_POST.md`: 정정 댓글이나 토의에 사용할 별도 문안.
- `VERIFICATION.md`: 빌드 및 공리 감사 기록.

## Lean이 검증하는 범위

Lean 파일은 다음 네 분석적 추정을 명시적 가정으로 받는다.

- 두 번째 factorial moment의 양의 선형 하한;
- 세 번째 factorial moment의 선형 상한;
- 기준 cutoff에서의 전체 소수 incidence 상한;
- 두 cutoff 사이의 incidence 증가량 상한.

이 가정들에서 많은 빈 잉여류 및 최소 합동소수 부등식이 따라오는
유한 환원은 완전히 증명되어 있다. 반면 Friedlander–Goldston variance
정리, 세 선형식 upper sieve, singular-series 평균, PNT 점근식 자체는
아직 Lean으로 형식화되지 않았다.

## 검증 명령

```bash
cd lean
lake update
lake build
lake env lean AnalyticTargets.lean
lake env lean AuditAxioms.lean
```

`AuditAxioms.lean` 출력에는 `sorryAx`가 없어야 한다.
