#!/usr/bin/env bash

set -e
set +x

DOCKER_IMAGE=$1

# Build
docker build "$DOCKER_IMAGE" -t "patouche/$DOCKER_IMAGE"

# Test
if [ -e "$DOCKER_IMAGE/test.sh" ] ; then
  chmod +x "$DOCKER_IMAGE/test.sh"
  "$DOCKER_IMAGE/test.sh" "patouche/$DOCKER_IMAGE"
fi
