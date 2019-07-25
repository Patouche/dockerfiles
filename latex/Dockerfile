FROM debian:stretch

LABEL maintainer="Patrick Allain <patralla@gmail.com>"

ARG LATEX_HOME=/latex
ARG LATEX_USER=latex
ARG LATEX_GROUP=latex

# Setup environment
ENV LATEX_HOME /latex
ENV LANG="C.UTF-8"

# Install latex
RUN \
  apt-get update -y && \
  apt-get install -y --no-install-recommends \
    inotify-tools \
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
    texlive-fonts-extra \
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

# Configure tlmgr
RUN \
  tlmgr init-usertree && \
  tlmgr update --self && \
  mkdir ${LATEX_HOME} && \
  groupadd ${LATEX_GROUP} && \
  useradd --gid ${LATEX_GROUP} --home-dir ${LATEX_HOME} ${LATEX_USER} && \
  chown ${LATEX_USER}:${LATEX_GROUP} ${LATEX_HOME}

WORKDIR ${LATEX_HOME}
USER ${LATEX_USER}

RUN \
  tlmgr init-usertree && \
  tlmgr update --self

