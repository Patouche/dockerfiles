#!/usr/bin/env bats


@test "should go be installed with version 1.12" {
    run docker run --rm ${IMAGE_NAME} go version
    [ "$status" -eq 0 ]
    [[ "$output" == *"go1.12 linux/amd64" ]]
}

@test "should node be installed with version 10.16.0" {
    run docker run --rm ${IMAGE_NAME} node --version
    [ "$status" -eq 0 ]
    [ "$output" = "v10.16.0" ]
}

@test "should npm be installed with version 6.9.0" {
    run docker run --rm ${IMAGE_NAME} npm --version
    [ "$status" -eq 0 ]
    [ "$output" = "6.9.0" ]
}

@test "should yarn be installed with version 1.17.3" {
    run docker run --rm ${IMAGE_NAME} yarn --version
    [ "$status" -eq 0 ]
    [ "$output" = "1.17.3" ]
}

@test "should serverless be installed with version 1.41.1" {
    run docker run --rm ${IMAGE_NAME} serverless --version
    [ "$status" -eq 0 ]
    [ "$output" = "1.41.1" ]
}


