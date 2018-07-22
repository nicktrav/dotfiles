#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green "Setting up tilix window manager"

TILIX_CONF_DIR=~/.config/tilix/schemes

# Install tilix - this requires stretch-backports
grep -qF stretch-backport /etc/apt/sources.list || \
  sudo bash -c "echo 'deb http://deb.debian.org/debian stretch-backports main contrib non-free' >> /etc/apt/sources.list"
sudo apt-get update && sudo apt-get install --yes tilix

mkdir -p "$TILIX_CONF_DIR"
cp "$DOTFILES_DIR/colors/nickt-tilix.json" "$TILIX_CONF_DIR/"
