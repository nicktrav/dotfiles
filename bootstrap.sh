#!/bin/bash

# Clones this repo into place and runs setup.sh

if [ -z "${DISTRO}" ]; then DISTRO='chromeos'; fi
if [ -z "${BRANCH}" ]; then BRANCH='master'; fi

mkdir -p ~/Development/dotfiles && \
  cd ~/Development/dotfiles && \
  git clone https://github.com/nicktrav/dotfiles.git . && \
  git checkout "$BRANCH" && \
  ./install.sh "$DISTRO"
