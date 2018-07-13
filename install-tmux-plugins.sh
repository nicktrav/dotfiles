#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/common.sh"

function install_plugin() {
  plugin=$1
  repo=$2

  magenta "Installing $plugin"
  _DIR="$PLUGINS_DIR/$plugin"
  if [ -d "$_DIR" ]; then
    magenta "Pulling latest version"
    pushd "$_DIR"
      git checkout master && git pull
    popd
  else
    magenta "Cloning latest version"
    git clone "$repo" "$_DIR"
  fi
}

green "Creating .tmux directory"
TMUX_DIR=~/.tmux
mkdir -p $TMUX_DIR

green "Creating plugins directory"
PLUGINS_DIR="$TMUX_DIR/plugins"
mkdir -p $PLUGINS_DIR

green "Installing tmux plugins"
install_plugin tpm https://github.com/tmux-plugins/tpm
install_plugin vim-tmux https://github.com/tmux-plugins/vim-tmux
install_plugin tmux-cpu https://github.com/tmux-plugins/tmux-cpu
install_plugin tmux-battery https://github.com/tmux-plugins/tmux-battery
install_plugin vim-tmux-navigator https://github.com/christoomey/vim-tmux-navigator
install_plugin tmux-mem-cpu-load https://github.com/thewtex/tmux-mem-cpu-load
install_plugin tmux-yank https://github.com/tmux-plugins/tmux-yank
