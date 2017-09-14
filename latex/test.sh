#!/bin/bash -xe

IMAGE_NAME=$1
CUR_DIR=$(readlink -f $(dirname $0))

function __check() {
  if [ ! -e "$CUR_DIR/$1.pdf" ] ; then exit 1; fi
  for ext in aux log nav out pdf snm toc vrb; do rm -f "${CUR_DIR}/$1.${ext}"; done
}

# Test container with installed package
docker run \
  -v ${CUR_DIR}:/opt/latex/build \
  ${IMAGE_NAME} \
  pdflatex \
    -halt-on-error \
    --output-directory /opt/latex/build /opt/latex/build/test.tex
__check "test"

# Test container with installed package
docker run \
  -v ${CUR_DIR}:/opt/latex/build \
  -v ${CUR_DIR}/test.packages:/opt/latex/tex.packages \
  ${IMAGE_NAME} \
  pdflatex \
    -halt-on-error \
    --output-directory /opt/latex/build /opt/latex/build/test.tex
__check "test"
