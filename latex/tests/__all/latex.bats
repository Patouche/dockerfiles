#!/usr/bin/env bats

@test "should run a user latex" {
    run docker run --rm ${IMAGE_NAME} whoami
    [ "$status" -eq 0 ]
    [ "$output" = "latex" ]
}

@test "should run in workdir /latex" {
    run docker run --rm ${IMAGE_NAME} pwd
    [ "$status" -eq 0 ]
    [ "$output" = "/latex" ]
}
