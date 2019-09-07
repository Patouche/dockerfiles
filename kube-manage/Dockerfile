FROM alpine:3.10

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

# https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG KUBE_USER=kube
ARG KUBE_GROUP=kube
ARG KUBE_HOME=/cluster
ARG KUBECTL_VERSION=1.15.3
ARG HELM_VERSION=2.14.3
ARG RANCHER_CLI_VERSION=2.2.0
ARG TARGET_BIN_DIR=/usr/local/bin

RUN \
    apk add --no-cache sed openssh openssl curl ca-certificates zsh jq git vim

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
    git clone --depth=1 --branch master https://github.com/robbyrussell/oh-my-zsh.git /opt/oh-my-zsh && \
    rm -f /var/cache/apk/*

WORKDIR ${KUBE_HOME}
USER ${KUBE_USER}

COPY vimrc .virmrc
COPY zshrc .zshrc

RUN \
    mkdir -p .oh-my-zsh/cache

CMD [ "zsh" ]
# DO IT IN USER K8S - MANAGE

#     chmod +x /usr/bin/helm && \
#     rm -rf linux-amd64 && \
#     apk del curl && \
#     