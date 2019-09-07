#!/usr/bin/env bats


@test "should have sonarqube installed with 7.8 version " {
    run docker run --rm ${IMAGE_NAME} ls /opt/sonarqube/lib/sonar-application-7.8.jar
    [ "$status" -eq 0 ]
}

@test "should have sonarqube 40 plugins installed" {
    run docker run --rm ${IMAGE_NAME} ls /opt/sonarqube/extensions/plugins/
    [ "$status" -eq 0 ]
    total=$(echo "$output" | grep -v README.txt | wc -l)
    [[ "$total" == "40" ]]
}

@test "should have sonar-scanner installed with version 3.3.0.1492" {
    run docker run --rm ${IMAGE_NAME} sonar-scanner --version
    [ "$status" -eq 0 ]
    [ "${lines[2]}" = "INFO: SonarQube Scanner 3.3.0.1492" ]
}