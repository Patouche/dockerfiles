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

@test "should have sonarqube installed with 7.8 version " {
    run docker run --rm ${IMAGE_NAME} ls /opt/sonarqube/lib/sonar-application-7.8.jar
    [ "$status" -eq 0 ]
}

@test "should have sonarqube 36 plugins installed" {
    run docker run --rm ${IMAGE_NAME} ls /opt/sonarqube/extensions/plugins/
    [ "$status" -eq 0 ]
    total=$(echo "$output" | grep -v README.txt | wc -l)
    [[ "$total" == "33" ]]
}

@test "should have sonar-scanner installed with version" {
    run docker run --rm ${IMAGE_NAME} sonar-scanner --version
    [ "$status" -eq 0 ]
    [ "${lines[2]}" = "INFO: SonarQube Scanner 3.3.0.1492" ]
}