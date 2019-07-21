#!/usr/bin/env bats

teardown() {
  rm -v ${BATS_TEST_DIRNAME}/*/*.{aux,log,nav,out,pdf,snm,toc,vrb} || true >&3
}

@test "Invoke pdflatex on beamer presentation" {
  run docker run \
    --rm \
    --user ${UID}:1000 \
    -v ${BATS_TEST_DIRNAME}/test-beamer:/opt/latex/build \
    ${IMAGE_NAME} \
    pdflatex \
      -halt-on-error \
      --output-directory /opt/latex/build /opt/latex/build/test.tex
  [ "$status" -eq 0 ]
}

@test "Invoke pdflatex on beamer presentation with extra package installation" {
  run docker run \
    --rm \
    --user ${UID}:1000 \
    -v ${BATS_TEST_DIRNAME}/test-packages:/opt/latex/build \
    -v ${BATS_TEST_DIRNAME}/test-packages/test.packages:/opt/latex/tex.packages \
    ${IMAGE_NAME} \
    pdflatex \
      -halt-on-error \
      --output-directory /opt/latex/build /opt/latex/build/test.tex
  [ "$status" -eq 0 ]
}
