FROM debian:stretch

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

# Setup environment
ENV LATEX_HOME /opt/latex

# Update all package
RUN apt-get update -y

# Install latex
RUN apt-get install -y --no-install-recommends \
  tex-common \
  texlive-base \
  texlive-binaries \
  texlive-htmlxml \
  texlive-latex-base \
  texlive-luatex \
  texlive-pictures \
  texlive-pstricks \
  texlive-publishers \
  texlive-fonts-recommended \
  texlive-generic-recommended \
  texlive-generic-recommended \
  texlive-latex-recommended \
  texlive-xetex \
  texlive-extra-utils \
  texlive-latex-extra \
  texlive-plain-extra \
  texlive-formats-extra \
  texlive-lang-english \
  texlive-lang-french \
  wget \
  xzdec

# Set Lang
ENV LANG="C.UTF-8"

# Run tlmgr
RUN tlmgr init-usertree \
    && tlmgr update --self

# Setup entrypoint to support package installation
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod ugo+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
