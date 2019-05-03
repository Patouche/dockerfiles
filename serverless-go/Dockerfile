ARG GO_VERSION="1.12.0"
FROM golang:${GO_VERSION}-stretch

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

ARG SERVERLESS_VERSION="1.41.1"
ARG NODE_VERSION="node_10.x"

ENV SERVERLESS serverless@${SERVERLESS_VERSION}
ENV GOPATH /go
ENV PATH $GOPATH/bin:/root/.yarn/bin:$PATH

# Install git / curl / node / npm / 
RUN \
    apt-get update && \
    apt-get install -y git ca-certificates apt-transport-https curl gcc g++ make
RUN \
    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NODE_VERSION} stretch main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/${NODE_VERSION} stretch main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y nodejs yarn
RUN \
    npm install -g ${SERVERLESS}