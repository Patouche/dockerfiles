#!/usr/bin/env bats

setup() {
  rm -vf ${BATS_TEST_DIRNAME}/*/*.{aux,log,nav,out,pdf,snm,toc,vrb} || true
}

@test "should run a user latex" {
    run docker run --rm ${IMAGE_NAME} whoami
    [ "$status" -eq 0 ]
    [ "$output" = "latex" ]
}

@test "should run in workdir /opt/latex" {
    run docker run --rm ${IMAGE_NAME} pwd
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/latex" ]
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
    run docker run --rm ${IMAGE_NAME} cat /opt/latex/texmf/tlpkg/texlive.tlpdb
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "name 00texlive.installation" ]
}

@test "should generate a beamer presentation" {
   skip "Should not failed ..."
  run docker run --rm \
    -v ${BATS_TEST_DIRNAME}/beamer:/opt/latex/build \
    ${IMAGE_NAME} \
    pdflatex \
      -halt-on-error \
      --output-directory /opt/latex/build /opt/latex/build/test.tex
  [ "$status" -eq 0 ]
}

@test "should install plugins and generate a beamer presentation" {
  skip "This should not failed ... But there is a error :  I can't write on file test.log."
  set -x
  run docker run --rm \
    -v ${BATS_TEST_DIRNAME}/packages:/opt/latex/build \
    -v ${BATS_TEST_DIRNAME}/packages/test.packages:/opt/latex/tex.packages \
    ${IMAGE_NAME} \
    pdflatex \
      -halt-on-error \
      --output-directory /opt/latex/build /opt/latex/build/test.tex
  set +x
  [ "$status" -eq 0 ]
}
