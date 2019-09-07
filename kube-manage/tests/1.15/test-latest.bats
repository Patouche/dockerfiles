#!/usr/bin/env bats

# Export to prevent several curl call
export KUBECTL_LATEST_VERSION=${KUBECTL_LATEST_VERSION:-$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)}

@test "should kubectl be installed with ${KUBECTL_LATEST_VERSION} version : 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'" {
    run docker run --rm ${IMAGE_NAME} kubectl version --client=true --short=true
    [ "$status" -eq 0 ]
    [ "$output" = "Client Version: ${KUBECTL_LATEST_VERSION}" ]
}
