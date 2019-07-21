#!/usr/bin/env bats


@test "should run as user kube-cli" {
    run docker run --rm ${IMAGE_NAME} whoami
    [ "$status" -eq 0 ] 
    [ "${lines[0]}" == "kube-cli" ]
}

@test "should run in /opt/kube" {
    run docker run --rm ${IMAGE_NAME} pwd
    [ "$status" -eq 0 ] 
    [ "${lines[0]}" == "/opt/kube" ]
}

@test "should run with zsh shell" {
    run docker run --rm ${IMAGE_NAME} grep 'kube-cli' /etc/passwd
    [ "$status" -eq 0 ]
    [[ "$output" == *"/zsh" ]]
}

@test "should kubectl be installed in version 1.15.1" {
    run docker run --rm ${IMAGE_NAME} kubectl version --client=true --short=true
    [ "$status" -eq 0 ]
    [ "$output" = "Client Version: v1.15.1" ]
}

@test "should helm be installed in version 2.14.2" {
    run docker run --rm ${IMAGE_NAME} helm version -c --short
    [ "$status" -eq 0 ]
    [ "$output" = "Client: v2.14.2+ga8b13cc" ]
}

@test "should rancher be installed in version 2.2.0" {
    run docker run --rm ${IMAGE_NAME} rancher --version
    [ "$status" -eq 0 ]
    [ "$output" = "rancher version v2.2.0" ]
}

@test "should zsh be installed in version 5.7.1" {
    run docker run --rm ${IMAGE_NAME} zsh --version
    [ "$status" -eq 0 ]
    [[ "$output" == "zsh 5.7.1"* ]]
}

@test "should git be installed in version 2.22.0" {
    run docker run --rm ${IMAGE_NAME} git --version
    [ "$status" -eq 0 ] 
    [ "$output" = "git version 2.22.0" ]
}

@test "should vim be installed in version 8.1" {
    run docker run --rm ${IMAGE_NAME} vim --version
    [ "$status" -eq 0 ] 
    [[ "${lines[0]}" == "VIM - Vi IMproved 8.1"* ]]
}