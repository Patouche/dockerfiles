#!/usr/bin/env bats

setup() {
  rm -vf ${BATS_TEST_DIRNAME}/*/*.{aux,log,nav,out,pdf,snm,toc,vrb} || true
}

@test "should have tex installed with 3.14159265 version" {
    run docker run --rm ${IMAGE_NAME} tex --version
    [ "$status" -eq 0 ]
    [[ "$output" = *"TeX 3.14159265"* ]]
}

@test "should have pdflatex installed with 3.14159265 version" {
    run docker run --rm ${IMAGE_NAME} pdflatex --version
    [ "$status" -eq 0 ]
    [[ "$output" = *"pdfTeX 3.14159265"* ]]
}

@test "should tlmgr have been initialized" {
    run docker run --rm ${IMAGE_NAME} cat /latex/texmf/tlpkg/texlive.tlpdb
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "name 00texlive.installation" ]
}

@test "should generate a beamer presentation" {
   skip "Should not failed ..."
  run docker run --rm \
    -v ${BATS_TEST_DIRNAME}/beamer:/latex/build \
    ${IMAGE_NAME} \
    pdflatex \
      -halt-on-error \
      --output-directory /latex/build /latex/build/test.tex
  [ "$status" -eq 0 ]
}
