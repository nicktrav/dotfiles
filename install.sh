#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DISTRO="$1"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/common.sh"

green 'Installing tmux plugins'
. "$DOTFILES_DIR/install-tmux-plugins.sh"

green "Installing vim colors"
mkdir -p ~/.vim/colors
find "$DOTFILES_DIR/colors" -maxdepth 1 -type f -name "*.vim" \
  -exec bash -c 'ln -sfn $1 $HOME/.vim/colors/$(basename $1)' _ {} \;

green "Installing dotfiles"
find "$DOTFILES_DIR" -maxdepth 1 -type f -name ".*" -not -name ".git" -not -name "*.swp" \
  -exec bash -c 'ln -sfn $1 $HOME/$(basename $1)' _ {} \;

mkdir -p "$HOME/bin"
find "$DOTFILES_DIR/bin" -type f -not -name "*.swp" \
  -exec bash -c 'ln -sfn $1 $HOME/bin/$(basename $1)' _ {} \;

ln -sfn "$DOTFILES_DIR/$DISTRO/.bash_os_specific" ~/.bash_os_specific

ln -sfn "$DOTFILES_DIR/.paths" ~/.paths

green "Linking Alacritty dotfiles"
. "$DIR/alacritty/install.sh"
