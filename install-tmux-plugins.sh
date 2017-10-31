#!/usr/bin/env bash

set -euo pipefail

echo "Installing reattach-to-user-namespace"
brew install reattach-to-user-namespace

echo "Creating .tmux directory"
TMUX_DIR=~/.tmux
mkdir -p $TMUX_DIR
echo "---------------------------------------------------------"

echo "Creating plugins directory"
PLUGINS_DIR="$TMUX_DIR/plugins"
mkdir -p $PLUGINS_DIR
echo "---------------------------------------------------------"

function install_plugin() {
  plugin=$1
  repo=$2

  echo "Installing $plugin"
  DIR="$PLUGINS_DIR/$plugin"
  if [ -d "$DIR" ]; then
    echo "Pulling latest version"
    pushd "$DIR"
      git checkout master && git pull
    popd
  else
    echo "Cloning latest version"
    git clone "$repo" "$DIR"
  fi
  echo "---------------------------------------------------------"
}

install_plugin tpm https://github.com/tmux-plugins/tpm
install_plugin vim-tmux https://github.com/tmux-plugins/vim-tmux
install_plugin tmux-cpu https://github.com/tmux-plugins/tmux-cpu
install_plugin tmux-battery https://github.com/tmux-plugins/tmux-battery
install_plugin vim-tmux-navigator https://github.com/christoomey/vim-tmux-navigator
install_plugin tmux-mem-cpu-load https://github.com/thewtex/tmux-mem-cpu-load
install_plugin tmux-yank https://github.com/tmux-plugins/tmux-yank
