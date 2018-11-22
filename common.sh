#!/usr/bin/env bash

# Environment variables

export DEV_DIR=~/Development
export DOTFILES_DIR=~/Development/dotfiles

# Functions

function green() {
  printf '\e[32m%s\e[39m\n' "$1"
}

function magenta() {
  printf '\e[35m%s\e[39m\n' "$1"
}
