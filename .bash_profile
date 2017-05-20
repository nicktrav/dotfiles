#!/usr/bin/env bash

#set -euo pipefail

# Source all dotfiles
for file in ~/.{bash_prompt,aliases,functions,docker_functions}; do
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
