#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Linking dotfiles'

cd "$DOTFILES_DIR"

mkdir -p "$HOME/bin"
for file in $(find bin/ -type f -not -name ".*.swp");
do
  src=$(realpath $file)
  dst="$HOME/bin/$(basename $file)"
  sudo ln -sfn "$src" "$dst"
done

# add aliases for dotfiles
FILES=$(find . -maxdepth 1 -name ".*" -not -name ".git" -not -name ".*.swp" -type f)
for file in $FILES
do
  src=$(realpath $file)
  dst="$HOME/$(basename $file)"
  sudo ln -sfn "$src" "$dst"
done
