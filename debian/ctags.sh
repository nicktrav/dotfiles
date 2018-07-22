#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

green 'Building ctags ...'

CTAGS_DIR=~/Development/ctags
rm -rf "$CTAGS_DIR" && \
  mkdir "$CTAGS_DIR" && \
  cd "$CTAGS_DIR" && \
  git clone https://github.com/universal-ctags/ctags.git . && \
  ./autogen.sh && \
  ./configure && \
  make && \
  sudo make install
