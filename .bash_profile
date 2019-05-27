#!/usr/bin/env bash
# shellcheck disable=SC1090

# Source all dotfiles
for file in ~/.{bash_prompt,aliases,functions,docker_functions,paths}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

# Case-insensitive globbing
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Use vim for editing
export VISUAL=vim
export EDITOR="$VISUAL"

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# Do not store duplicate commands in bash history, as well commands that start
# with a space
export HISTCONTROL=ignoreboth

# Fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Supercharge fzf with ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.pants}/*"'

# OS specific configuration
if [ -f ~/.bash_os_specific ]; then
  # shellcheck source=/dev/null
  source ~/.bash_os_specific
fi

# Local customized path and environment settings, etc.
# This file isn't checked in, and should be provided instead.
if [ -f ~/.bash_local ]; then
  # shellcheck source=/dev/null
  source ~/.bash_local
fi

# Paths that specific tools set (e.g. GCP)
if [ -f ~/.paths ]; then
  # shellcheck source=/dev/null
  source ~/.paths
fi

# Add utility scripts to path
export PATH=$HOME/bin:$PATH

# Golang
export GOPATH="$HOME/Development/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Java
export M2_HOME=/usr/local/src/maven
export MAVEN_HOME="$M2_HOME"
if [ -s "$HOME/.jabba/jabba.sh" ]; then
  source "$HOME/.jabba/jabba.sh"
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
if hash "rustc" &> /dev/null; then
  _sysroot=$(rustc --print sysroot)
  export RUST_SRC_PATH="$_sysroot/lib/rustlib/src/rust/src/"
fi
