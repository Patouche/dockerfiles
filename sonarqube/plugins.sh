#!/bin/bash

OFFICIAL_PLUGINS=(
  "ansible"
  "checkstyle"
  "cobertura"
  "cssfamily"
  "findbugs"
  "flex"
  "go"
  "groovy"
  "guavamigration"
  "jacoco"
  "javai18n"
  "javascript"
  "java"
  "jdepend"
  "kotlin"
  "l10nfr"
  "ldap"
  "lua"
  "mutationanalysis"
  "php"
  "pitest"
  "pmd"
  "python"
  "ruby"
  "scmcvs"
  "scmgit"
  "scmsvn"
  "shellcheck"
  "smells"
  "sonarscala"
  "status"
  "typescript"
  "vbnet"
  "webdriver"
  "web"
  "xanitizer"
  "xml"
  "yaml"
)

COMMUNITY_PLUGINS=(
    "https://github.com/checkstyle/sonar-checkstyle/releases/download/4.21/checkstyle-sonar-plugin-4.21.jar"
    "https://github.com/davidetaibi/sonarqube-anti-patterns-code-smells/releases/download/0.7/sonar-codesmellsantipatterns-plugin-0.7.jar"
    "https://github.com/devcon5io/mutation-analysis-plugin/releases/download/v1.4/mutation-analysis-plugin-1.4.jar"
    "https://github.com/galexandre/sonar-cobertura/releases/download/2.0/sonar-cobertura-plugin-2.0.jar"
    "https://github.com/Inform-Software/sonar-groovy/releases/download/1.6/sonar-groovy-plugin-1.6.jar"
    "https://github.com/jensgerdes/sonar-pmd/releases/download/3.2.1/sonar-pmd-plugin-3.2.1.jar"
    "https://github.com/kwoding/sonar-webdriver-plugin/releases/download/sonar-webdriver-plugin-1.0.4/sonar-webdriver-plugin-1.0.4.jar"
    "https://github.com/sbaudoin/sonar-yaml/releases/download/v1.4.3/sonar-yaml-plugin-1.4.3.jar"
    "https://github.com/QualInsight/qualinsight-plugins-sonarqube-smell/releases/download/qualinsight-plugins-sonarqube-smell-4.0.0/qualinsight-sonarqube-smell-plugin-4.0.0.jar"
    "https://github.com/sbaudoin/sonar-shellcheck/releases/download/v2.1.0/sonar-shellcheck-plugin-2.1.0.jar"
    "https://github.com/spotbugs/sonar-findbugs/releases/download/3.9.4/sonar-findbugs-plugin-3.9.4.jar"
    "https://github.com/SonarSecurityCommunity/dependency-check-sonar-plugin/releases/download/1.1.5/sonar-dependency-check-plugin-1.1.5.jar"
    "https://github.com/ZoeThivet/sonar-l10n-fr/releases/download/1.15.1/sonar-l10n-fr-plugin-1.15.1.jar"
    "https://github.com/SonarSource/SonarJS/releases/download/5.2.1.7778/sonar-javascript-plugin-5.2.1.7778.jar"
    "https://github.com/SonarSource/sonar-go/releases/download/1.1.1.2000/sonar-go-plugin-1.1.1.2000.jar"
)

function __install_plugin() {
    pb=$(basename ${1})
    if [ ! -e "${SONARQUBE_HOME}/extensions/plugins/${pb%-*}"* ]; then
        echo "  -> Install plugin : ${pb} (${1})";
        curl -sSL -o "${SONARQUBE_HOME}/extensions/plugins/${pb}" "${1}";
    else
        echo "  -> Skip to install plugin (plugin already installed) : ${pb}";
    fi 
}

# Remove all plugins
echo "== REMOVE ALL PLUGINS =="
rm -v ${SONARQUBE_HOME}/extensions/plugins/*.jar

# Install update center plugins
PROP_FILE="${SONARQUBE_HOME}/extensions/update-center.properties"
curl -sSL -o "${PROP_FILE}" https://update.sonarsource.org/update-center.properties

# List all others plugins
echo "== AVAILABLE OFFICIAL PLUGINS =="
all_plugins=$(grep '\.versions=' "${PROP_FILE}" | sed -r 's/\.versions.*$//g' | sort)
for p in ${all_plugins[*]}; do
    show=0
    for o in ${OFFICIAL_PLUGINS[*]}; do if [ "${o}" == "${p}" ]; then show=1; break; fi; done
    if [ ${show} -eq 0 ]; then echo "  - ${p}"; fi
done

echo "== INSTALLING OFFICIAL PLUGINS =="
for pn in ${OFFICIAL_PLUGINS[*]}; do
    pv=$(grep "^${pn}\.versions=" "${PROP_FILE}" | cut -d'=' -f2 | grep -o '[^,]*$')
    pu=$(grep "^${pn}\.${pv}\.downloadUrl=" "${PROP_FILE}" | cut -d'=' -f2)
    pc=$(grep "^${pn}\.${pv}\.requiredSonarVersions=" "${PROP_FILE}" | cut -d'=' -f2 | grep -o "${SONAR_VERSION}")
    if [ "${pc}" == "${SONAR_VERSION}" ]; then
        __install_plugin "${pu//\\/}"
    else
        echo "  -> Skip to install plugin : ${pn} (incompatible sonar version)";
    fi
done

echo "== INSTALLING COMMUNITY PLUGINS =="
for url in ${COMMUNITY_PLUGINS[*]}; do
    __install_plugin "${url}"
done