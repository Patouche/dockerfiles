#!/usr/bin/env bash

set -e

# If there are a mounted file fpr tex packages, then we want to isntall them
if [[ -e /opt/latex/tex.packages ]]; then
  for p in $(cat /opt/latex/tex.packages) ; do
    echo "Install text package : ${p}"
    ls -al /opt/latex/texmf/web2c/
    #sudo env PATH="$PATH" tlmgr
    tlmgr install "${p}"
  done
fi

exec "$@"
