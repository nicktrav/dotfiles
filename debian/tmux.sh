#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

green 'Building tmux ...'

sudo apt-get install --yes \
  autogen \
  automake \
  libevent-dev \
  libncurses5-dev \
  pkg-config

cd "$DEV_DIR" && \
  rm -rf tmux && \
  git clone https://github.com/tmux/tmux.git

cd tmux && \
  sh autogen.sh && \
  autoreconf -i --force && ./configure && make && \
  sudo make install
