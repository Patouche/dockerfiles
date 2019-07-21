# Sonarqube


This image is based on the [official sonarqube image](https://hub.docker.com/_/sonarqube/). Several plugins and the latest sonar-scanner cli tools is just added.

## Plugins

You can set your own plugins modifying the [plugins.sh](./plugins.sh) file. In this file, there is 2 sections. One for community plugins and one for official.

**Official :** This plugin are installed first. It will retrieve the jar to download from the [update center](https://update.sonarsource.org/update-center.properties).
**Community :** This plugin will be installed only if the plugin is not already present in the current plugins directory.

