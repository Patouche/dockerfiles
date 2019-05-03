#!/usr/bin/env bash

set -e
set -x

DOCKER_IMAGE=$1

# Docker image version
DOCKER_IMG_VERSION="latest"
if [ -e "${DOCKER_IMAGE}/version.txt" ] ; then
  DOCKER_IMG_VERSION=$(cat "$DOCKER_IMAGE/version.txt")
fi

# Build
if [[ "${TRAVIS_BRANCH}" == 'master' ]] ; then    
    echo "Deploying image '${DOCKER_IMAGE}' on docker hub (DockerID='${DOCKER_USERNAME}')."
    echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
    docker push "${DOCKER_USERNAME}/${DOCKER_IMAGE}:${DOCKER_IMG_VERSION}"
else
    echo "Skipping docker hub deployment on branch '${TRAVIS_BRANCH}'. Only made on 'master' branch."
fi
