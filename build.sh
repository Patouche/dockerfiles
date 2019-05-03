#!/usr/bin/env bash

set -e
set +x

DOCKER_IMAGE=$1

# Docker image version
DOCKER_IMG_VERSION="latest"
if [ -e "${DOCKER_IMAGE}/version.txt" ] ; then
  DOCKER_IMG_VERSION=$(cat "$DOCKER_IMAGE/version.txt")
fi

# Build image
docker build "${DOCKER_IMAGE}" -t "patouche/${DOCKER_IMAGE}:${DOCKER_IMG_VERSION}"

# Test image
if [ -e "${DOCKER_IMAGE}/test.sh" ] ; then
  chmod +x "${DOCKER_IMAGE}/test.sh"
  "${DOCKER_IMAGE}/test.sh" "patouche/${DOCKER_IMAGE}:${DOCKER_IMG_VERSION}"
fi
