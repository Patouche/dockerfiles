FROM sonarqube:7.8-community

ARG SONAR_SCANNER_CLI='sonar-scanner-cli-3.3.0.1492-linux.zip'
ARG SONAR_SCANNER_DIR='/opt'
LABEL maintainer="patrick.allain@soat.fr"

USER root

RUN \
    mkdir "${SONAR_SCANNER_DIR}/sonar-scanner-cli" || true && \
    curl -o ${SONAR_SCANNER_DIR}/${SONAR_SCANNER_CLI} "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_CLI}" && \
    unzip ${SONAR_SCANNER_DIR}/${SONAR_SCANNER_CLI} -d ${SONAR_SCANNER_DIR} && \
    mv ${SONAR_SCANNER_DIR}/sonar-scanner-*-linux/* ${SONAR_SCANNER_DIR}/sonar-scanner-cli && \
    ln -s ${SONAR_SCANNER_DIR}/sonar-scanner-cli/bin/sonar-scanner /usr/local/bin/sonar-scanner

COPY plugins.sh "${SONARQUBE_HOME}/extensions/plugins.sh"


RUN \
    chmod +x "${SONARQUBE_HOME}/extensions/plugins.sh" && \
    bash "${SONARQUBE_HOME}/extensions/plugins.sh"
USER sonarqube