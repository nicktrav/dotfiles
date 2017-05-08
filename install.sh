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
echo "Installing RCM, for dotfile management"
brew tap thoughtbot/formulae
brew install rcm

echo "---------------------------------------------------------"
echo "Cloning Nick's dotfiles insto .dotfiles"
DOTFILES_DIR=~/.dotfiles
if [ ! -d $DOTFILES_DIR ]; then
  mkdir "$DOTFILES_DIR"
  git clone https://github.com/nicktrav/dotfiles.git "$DOTFILES_DIR"
fi

pushd $DOTFILES_DIR
  echo "running RCM's rcup command"
  echo "This will symlink the rc files in .dofiles"
  echo "with the rc files in $HOME"

  git checkout master
  git reset --hard origin/master
  git pull

  rcup
popd
