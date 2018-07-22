#!/usr/bin/env bash

# Clones this repo into place and runs setup.sh

 [[ -z "${DISTRO}" ]] && BRANCH='chromeos'
 [[ -z "${BRANCH}" ]] && DISTRO='master'

mkdir -p ~/Development/dotfiles && \
  cd ~/Development/dotfiles && \
  git clone https://github.com/nicktrav/dotfiles.git . && \
  git checkout "$BRANCH" && \
  ./install.sh "$DISTRO"
