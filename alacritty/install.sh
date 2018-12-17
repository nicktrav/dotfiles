#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ALACRITTY_DIR="$HOME/.config/alacritty"

# create dir, if it doesn't exist
mkdir -p "$ALACRITTY_DIR"

# remove file if already exists
rm -f "$ALACRITTY_DIR/alacritty.yml"

# relink the dotfile
ln -s "$DIR/alacritty.yml" "$ALACRITTY_DIR/alacritty.yml"
