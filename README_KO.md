# 에르되시 문제 971 포럼 업로드 패키지 안내

## 가장 중요한 상태 표시

이 패키지는 **검증 요청용 후보 증명**이다. 아직 수학계에서 승인된 완결 증명으로
표현해서는 안 된다.

Lean 파일이 오류 없이 빌드되면 다음 내용이 확인된다.

- 두 번째·세 번째 factorial moment 추정과 총 소수 incidence 추정 등을 가정하면,
  양의 비율의 잉여류에서 최소 합동소수가 지정된 cutoff보다 크다는 결론이 따라온다.
- 빈 prime occupancy와 최소 합동소수 부등식 사이의 연결이 형식적으로 성립한다.
- 컴파일된 핵심 파일에 `sorry`, `admit`, 프로젝트 고유 `axiom`이 없다.

그러나 다음 해석적 수론 입력은 아직 Lean으로 증명되지 않았다.

- Friedlander-Goldston 개별 모듈러스 variance 하한의 정확한 특수화
- 세 선형식 `p`, `p+rq`, `p+sq`에 대한 균일한 상한체
- singular series의 `r,s` 평균과 smooth modulus에서의 국소 인자 상쇄
- cutoff 정규화 및 소수정리 기반 총량·증분 추정

따라서 포럼에서는 “문제를 해결했다”가 아니라 **“후보 무조건부 증명과 Lean으로
검증된 유한 환원을 올리니, 분석적 핵심 두 지점을 검토해 달라”**고 표현하는 것이
정확하다.

## 권장 업로드 파일

1. `Erdos971_candidate_verification_note.pdf`
2. `erdos971-forum-package.zip` 전체 패키지
3. 필요하면 `FORUM_POST.md`의 본문을 게시글에 복사

LaTeX 원문은 `source/erdos971_candidate.tex`, Lean 핵심은
`lean/Erdos971Forum.lean`에 있다.

현재 로컬 빌드·공리 감사·PDF 검증 결과는 `VERIFICATION.md`에 기록되어 있다.

## Lean 검증 방법

Lean 4.27.0과 mathlib 4.27.0을 사용한다.

```bash
cd lean
chmod +x check_source.sh
./check_source.sh
```

또는 다음 명령을 순서대로 실행한다.

```bash
lake update
lake build
lake env lean AnalyticTargets.lean
lake env lean AuditAxioms.lean
```

`AuditAxioms.lean` 출력에 `sorryAx`가 없어야 한다. `propext`, `Quot.sound`,
`Classical.choice` 등은 고전적 mathlib 증명에서 나타날 수 있는 기반 의존성이다.

## PDF 작성자와 AI 지원 고지

PDF와 PDF 메타데이터의 작성자는 `Kyungmin`으로 설정되어 있다. 본문에는
후보 증명 전략의 연구와 검증 패키지 작성에 OpenAI GPT-5.6 Pro의 상당한
지원을 사용했다는 고지가 포함되어 있다. PDF를 다시 생성하려면:

```bash
cd source
chmod +x build_pdf.sh
./build_pdf.sh
```

스크립트는 `pdflatex`가 있으면 이를 사용하고, 없으면 `tectonic`으로 자동
대체한다.

## GitHub Actions

전체 패키지 폴더를 GitHub 저장소 루트로 올리면
`.github/workflows/lean.yml`이 `lean/` 아래 Lake 프로젝트를 자동 검증한다.

## 포럼에서 요청해야 할 핵심 검증

- variance 하한이 정확히 본문의 중심화와 범위에서 각 개별 `q`에 대해 적용되는가?
- diagonal 항과 평균 제곱항의 상쇄가 임의의 smooth `q`에 대해 균일한가?
- proper prime power 제거 오차가 실제로 `o(X log q)`인가?
- 3-tuple upper sieve가 `rq,sq=O(X)`인 가변 shift에도 절대상수로 균일한가?
- nonadmissible 패턴에 대한 `T_q(r,s) ≤ 3` 처리가 정확한가?
- `q`의 소인수에서 생기는 `(q/φ(q))^2` 인자와 shift 쌍 수의 상쇄가 정확한가?
- floor, strict inequality, 실수 cutoff로의 변환에 누락이 없는가?

이 항목 중 특히 variance 적용 또는 3-tuple sieve/singular-series 부분이 실패하면
후보 완결 증명은 성립하지 않는다. 반대로 모두 통과하면 무조건부 긍정 답변이
도출되는 구조다.
