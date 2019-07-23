# Kube Manage

This image is made for k8s cluster administration. So, it contains several tools that will help you to managed your cluster. The base image is a [alpine](https://hub.docker.com/_/alpine)

## Images :

* [patouche/kube-manage:latest patouche/kube-manage:1.15](https://github.com/Patouche/dockerfiles/blob/master/kube-manage/Dockerfile) with kubectl in 1.15.X
* [patouche/kube-manage:1.14](https://github.com/Patouche/dockerfiles/blob/master/kube-manage/Dockerfile) with kubectl in 1.14.X
* [patouche/kube-manage:1.13](https://github.com/Patouche/dockerfiles/blob/master/kube-manage/Dockerfile) with kubectl in 1.13.X
* [patouche/kube-manage:1.12](https://github.com/Patouche/dockerfiles/blob/master/kube-manage/Dockerfile) with kubectl in 1.12.X

All images will also contains basic tools such as :
* ssh
* curl
* zsh
* git
* rancher-cli
* helm
* jq
* httpie

## Usage :

Each image will run as describe bellow :

```
docker run --rm -ti \
    -v $HOME/.kube/config:/cluster/.kube/config \
    patouche/kube-manage:latest
```