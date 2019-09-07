#!/usr/bin/env bats


@test "should git be installed" {
    run docker run --rm ${IMAGE_NAME} which git
    [ "$status" -eq 0 ]
}

@test "should go be installed" {
    run docker run --rm ${IMAGE_NAME} which go
    [ "$status" -eq 0 ]
}

@test "should node be installed" {
    run docker run --rm ${IMAGE_NAME} which node
    [ "$status" -eq 0 ]
}

@test "should npm be installed" {
    run docker run --rm ${IMAGE_NAME} which npm
    [ "$status" -eq 0 ]
}

@test "should yarn be installed" {
    run docker run --rm ${IMAGE_NAME} which yarn
    [ "$status" -eq 0 ]
}

@test "should serverless be installed" {
    run docker run --rm ${IMAGE_NAME} which serverless
    [ "$status" -eq 0 ]
}

