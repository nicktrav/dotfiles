#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Linking dotfiles'

mkdir -p "$HOME/bin"
find "$DOTFILES_DIR/bin" -type f -not -name "*.swp" \
  -exec bash -c 'ln -sfn $1 $HOME/bin/$(basename $1)' _ {} \;

find "$DOTFILES_DIR" -maxdepth 1 -type f -name ".*" -not -name ".git" -not -name "*.swp" \
  -exec bash -c 'ln -sfn $1 $HOME/$(basename $1)' _ {} \;
