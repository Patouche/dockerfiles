#!/bin/bash

set +x
set -e

IMAGE_NAME=$1
CUR_DIR=$(readlink -f $(dirname $0))

function __check_cmd() {
    local output=$(docker run --rm ${IMAGE_NAME} ${1})
    if [ -z "${output}" ]; then
        echo "[FAIL] Error during checking command '${1}' on image '${IMAGE_NAME}'. Expecting output should contains '${2}' but this was a empty string." >&2
        exit 1
    fi
    local res=$(echo "${output}" | grep "${2}" | wc -l)
    if [ $res -eq 0 ] ; then
        echo "[FAIL] Error during checking command '${1}' on image '${IMAGE_NAME}'. Expecting output should contains '${2}'. Current output : '${output}'." >&2
        exit 1
    fi
    echo "[SUCCESS] Check of command '${1}' on image '${IMAGE_NAME}' contains '${2}'. Current output : '${output}'."
}

__check_cmd "node --version" "^v10."
__check_cmd "npm --version" "^6."
__check_cmd "yarn --version" "^1."
__check_cmd "go version" "go1.12 linux/amd64"
__check_cmd "serverless --version" "1.41.1"

