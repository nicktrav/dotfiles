#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Installing dependencies ...'

sudo apt-get update && sudo apt-get --yes upgrade
sudo apt-get install --yes \
  gcc \
  git \
  htop \
  libxtst6 \
  make \
  software-properties-common \
  tar \
  xserver-xephyr \
  vim

mkdir -p "$DEV_DIR"
