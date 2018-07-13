#!/usr/bin/env bash

set euo -pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Installing fonts ...'

sudo apt-get install -y \
  fonts-powerline \
  fonts-inconsolata
