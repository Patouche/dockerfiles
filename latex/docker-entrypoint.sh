#!/bin/bash
set -eo

# If there are a mounted file fpr tex packages, then we want to isntall them
echo "${PATH}"
if [[ -e /opt/latex/tex.packages ]]; then
  for p in $(cat /opt/latex/tex.packages) ; do
    echo "Install text package : ${p}"
    #sudo env PATH="$PATH" tlmgr
    tlmgr install "${p}"
  done
fi

exec "$@"
