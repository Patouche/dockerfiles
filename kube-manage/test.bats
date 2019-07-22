#!/usr/bin/env bats


@test "should run as user kube" {
    run docker run --rm ${IMAGE_NAME} whoami
    [ "$status" -eq 0 ] 
    [ "${lines[0]}" == "kube" ]
}

@test "should run in /kube" {
    run docker run --rm ${IMAGE_NAME} pwd
    [ "$status" -eq 0 ] 
    [ "${lines[0]}" == "/kube" ]
}

@test "should run with zsh shell" {
    run docker run --rm ${IMAGE_NAME} grep 'kube' /etc/passwd
    [ "$status" -eq 0 ]
    [[ "$output" == *"/zsh" ]]
}

@test "should kubectl be installed with 1.15.1 version" {
    run docker run --rm ${IMAGE_NAME} kubectl version --client=true --short=true
    [ "$status" -eq 0 ]
    [ "$output" = "Client Version: v1.15.1" ]
}

@test "should helm be installed with 2.14.2 version" {
    run docker run --rm ${IMAGE_NAME} helm version -c --short
    [ "$status" -eq 0 ]
    [ "$output" = "Client: v2.14.2+ga8b13cc" ]
}

@test "should rancher be installed with 2.2.0 version" {
    run docker run --rm ${IMAGE_NAME} rancher --version
    [ "$status" -eq 0 ]
    [ "$output" = "rancher version v2.2.0" ]
}

@test "should zsh be installed with 5.7.1 version" {
    run docker run --rm ${IMAGE_NAME} zsh --version
    [ "$status" -eq 0 ]
    [[ "$output" == "zsh 5.7.1"* ]]
}

@test "should git be installed with 2.22.0 version" {
    run docker run --rm ${IMAGE_NAME} git --version
    [ "$status" -eq 0 ] 
    [ "$output" = "git version 2.22.0" ]
}

@test "should vim be installed with 8.1 version" {
    run docker run --rm ${IMAGE_NAME} vim --version
    [ "$status" -eq 0 ] 
    [[ "${lines[0]}" == "VIM - Vi IMproved 8.1"* ]]
}