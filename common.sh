#!/usr/bin/env bash

set -euo pipefail

# Environment variables

export DEV_DIR=~/Development
export DOTFILES_DIR=~/Development/dotfiles

# Versions

export FZF_VERSION=0.17.4
export GO_VERSION=1.11
export JAVA_VERSION=10
export SHELLCHECK_VERSION=0.4.7
export RIPGREP_VERSION=0.8.1

# Functions

function green() {
  printf '\e[32m%s\e[39m\n' "$1"
}

function magenta() {
  printf '\e[35m%s\e[39m\n' "$1"
}
