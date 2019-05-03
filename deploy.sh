#!/usr/bin/env bash

set -e
set +x

DOCKER_IMAGE=$1

echo "Current branch '${TRAVIS_BRANCH}'"

# Build
if [[ "${TRAVIS_BRANCH}" == "master" ]] ; then
    echo "Deploying image '${DOCKER_IMAGE}' on docker hub"
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    docker build "$DOCKER_IMAGE" -t "patouche/$DOCKER_IMAGE"
else
    echo "Skipping deployment on docker hub. Deployment ins only made on branch 'master'"
fi
