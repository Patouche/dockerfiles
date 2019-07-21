ARG SONAR_VERSION=7.8-community
FROM sonarqube:${SONAR_VERSION}

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

ARG SONAR_SCANNER_CLI_VERSION='3.3.0.1492'
ARG SONAR_SCANNER_DIR='/opt'

USER root

RUN \
    curl -sSL -o ${SONAR_SCANNER_DIR}/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux.zip && \
    unzip ${SONAR_SCANNER_DIR}/sonar-scanner-cli.zip -d ${SONAR_SCANNER_DIR} > /dev/null && \
    mv ${SONAR_SCANNER_DIR}/sonar-scanner-${SONAR_SCANNER_CLI_VERSION}-linux ${SONAR_SCANNER_DIR}/sonar-scanner-cli && \
    ln -s ${SONAR_SCANNER_DIR}/sonar-scanner-cli/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm ${SONAR_SCANNER_DIR}/sonar-scanner-cli.zip

COPY plugins.sh ${SONARQUBE_HOME}/extensions/plugins.sh

RUN \
    chmod +x ${SONARQUBE_HOME}/extensions/plugins.sh && \
    bash ${SONARQUBE_HOME}/extensions/plugins.sh > /dev/null

USER sonarqube