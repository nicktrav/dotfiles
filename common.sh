#!/usr/bin/env bash

set euo -pipefail

# Environment variables

export DEV_DIR=~/Development
export DOTFILES_DIR=~/Development/dotfiles

# Versions

export JAVA_VERSION=10

# Functions

function green() {
  echo -e "\e[32m"$1"\e[39m"
}

function magenta() {
  echo -e "\e[35m"$1"\e[39m"
}
