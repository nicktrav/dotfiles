#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DISTRO="$1"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/common.sh"

green "Running setup for distro $DISTRO"
. "$DOTFILES_DIR/$DISTRO/setup.sh"

green 'Installing tmux plugins'
. "$DOTFILES_DIR/install-tmux-plugins.sh"

green "Installing vim colors"
mkdir -p ~/.vim/colors
cp "$DOTFILES_DIR"/colors/*.vim ~/.vim/colors/

green "Installing dotfiles"
. "$DOTFILES_DIR/common/dotfiles.sh"
ln -sfn "$DOTFILES_DIR/$DISTRO/.bash_local" ~/.bash_local
