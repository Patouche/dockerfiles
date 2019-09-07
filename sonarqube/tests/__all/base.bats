#!/usr/bin/env bats


@test "should run with user sonarqube" {
    run docker run --rm ${IMAGE_NAME} whoami
    [ "$status" -eq 0 ]
    [ "$output" = "sonarqube" ]
}

@test "should run with in workdir /opt/sonarqube" {
    run docker run --rm ${IMAGE_NAME} pwd
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/sonarqube" ]
}

@test "should have sonar-scanner installed" {
    run docker run --rm ${IMAGE_NAME} which sonar-scanner
    [ "$status" -eq 0 ]
}