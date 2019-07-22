FROM alpine:3.10

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

# https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG KUBE_USER=kube
ARG KUBE_GROUP=kube
ARG KUBE_HOME=/kube
ARG KUBECTL_VERSION=1.15.1
ARG HELM_VERSION=2.14.2
ARG GO_VERSION=1.12
ARG RANCHER_CLI_VERSION=2.2.0
ARG TARGET_BIN_DIR=/usr/local/bin

RUN \
    apk add --no-cache openssh openssl curl ca-certificates zsh jq git vim musl-dev go

RUN \
    curl -sSL -o ${TARGET_BIN_DIR}/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ${TARGET_BIN_DIR}/kubectl

RUN \
    curl -sSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar xz && \
    install -m 755 linux-amd64/helm ${TARGET_BIN_DIR}/helm && \
    install -m 755 linux-amd64/tiller ${TARGET_BIN_DIR}/tiller && \
    rm -rf linux-amd64

RUN \
    curl -sSL https://github.com/rancher/cli/releases/download/v${RANCHER_CLI_VERSION}/rancher-linux-amd64-v${RANCHER_CLI_VERSION}.tar.gz | tar xz && \
    install -m 755 rancher-v${RANCHER_CLI_VERSION}/rancher ${TARGET_BIN_DIR}/rancher && \
    rm -rf rancher-v${RANCHER_CLI_VERSION}

RUN \
    mkdir ${KUBE_HOME} && \
    addgroup ${KUBE_GROUP} && \
    adduser -D -G ${KUBE_GROUP} -h ${KUBE_HOME} -s $(which zsh) ${KUBE_USER} && \
    chown ${KUBE_USER}:${KUBE_GROUP} ${KUBE_HOME} && \
    curl -sSL -o /tmp/oh-my-zsh.install.sh https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh && \
    su ${KUBE_USER} -c 'sh /tmp/oh-my-zsh.install.sh' > /dev/null 2>&1 && \
    rm /tmp/oh-my-zsh.install.sh && \
    rm -f /var/cache/apk/*

RUN \
    git clone --depth=1 --branch master https://github.com/robbyrussell/oh-my-zsh.git /opt/oh-my-zsh && \
    go get gopkg.in/mikefarah/yq.v2 

WORKDIR ${KUBE_HOME}
USER ${KUBE_USER}

COPY vimrc .virmrc
COPY zshrc .zshrc

CMD [ "zsh" ]
# DO IT IN USER K8S - MANAGE

#     chmod +x /usr/bin/helm && \
#     rm -rf linux-amd64 && \
#     apk del curl && \
#     