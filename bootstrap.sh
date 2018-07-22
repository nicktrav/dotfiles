#!/usr/bin/env bash

# Clones this repo into place and runs setup.sh

mkdir -p ~/Development/dotfiles && \
  cd ~/Development/dotfiles && \
  git clone https://github.com/nicktrav/dotfiles.git . && \
  git checkout nickt.shellcheck && \
  ./install.sh "$@"
