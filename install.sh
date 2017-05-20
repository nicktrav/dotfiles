#!/usr/bin/env bash

set -euo pipefail

echo "---------------------------------------------------------"
echo "Setting up brew"
brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "Homebrew is already installed!"
else
  echo "Homebrew is not installed, installing now ..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "---------------------------------------------------------"
echo "Installing packages"
packages=(
  "git"
  "tmux"
  "vim"
)

function install_or_update() {
  if command -v "$1"; then
    echo "Upgrading $1"
    brew upgrade "$1" || true
  else
    echo "Installing $1"
    brew install "$1"
  fi
}

for package in "${packages[@]}"
do
  install_or_update "$package"
done

echo "---------------------------------------------------------"
echo "Installing tmux plugins"
./install-tmux-plugins.sh

# TODO
echo "---------------------------------------------------------"
echo "Installing IntelliJ"

echo "---------------------------------------------------------"
echo "Setting up dotfiles"
make dotfiles
