#!/usr/bin/env bats


@test "should kubectl be installed with 1.14.4 version" {
    run docker run --rm ${IMAGE_NAME} kubectl version --client=true --short=true
    [ "$status" -eq 0 ]
    [ "$output" = "Client Version: v1.14.4" ]
}
