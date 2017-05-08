#!/usr/bin/env bash

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

function _git_prompt() {
local git_status="`git status -unormal 2>&1`"
# Checks to see if we're in a git repo
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
  # if we're in a repo thats clean, then color it green
  if [[ "$git_status" =~ nothing\ to\ commit ]]; then
    local ansi=$GREEN
    # if the repos dirty, color it red
  elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
    local ansi=$RED
  else
    #Just to be sure, color it red
    local ansi=$RED
  fi

  # Get git branch name
  # checks the output of git status for "On branch " then uses that to set the branch
  if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
    branch=${BASH_REMATCH[1]}
    #test "$branch" != master || branch=' '
  else
    # Detached HEAD.  (branch=HEAD is a faster alternative.)
    branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
  fi
  # prints out " | $branch_name"
  echo -n '| \['"$ansi"'\]'"$branch"'\[\e[0m\] [$(_git_changes)]'
fi
}

function _git_changes {
[[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

local added_symbol="●"
local unmerged_symbol="✗"
local modified_symbol="+"
local clean_symbol="✔"
local has_untracked_files_symbol="…"

local ahead_symbol="↑"
local behind_symbol="↓"

local unmerged_count=0 modified_count=0 has_untracked_files=0 added_count=0 is_clean=""

set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
local behind_count=$1
local ahead_count=$2

# Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R), changed (T), Unmerged (U), Unknown (X), Broken (B)
while read line; do
  case "$line" in
    M*) modified_count=$(( $modified_count + 1 )) ;;
    U*) unmerged_count=$(( $unmerged_count + 1 )) ;;
  esac
done < <(git diff --name-status)

while read line; do
  case "$line" in
    *) added_count=$(( $added_count + 1 )) ;;
  esac
done < <(git diff --name-status --cached)

if [ -n "$(git ls-files --others --exclude-standard)" ]; then
  has_untracked_files=1
fi

if [ $(( unmerged_count + modified_count + has_untracked_files + added_count )) -eq 0 ]; then
  is_clean=1
fi

local leading_whitespace=""
[[ $ahead_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$ahead_symbol$ahead_count"; leading_whitespace=" "; }
[[ $behind_count -gt 0 ]]        && { printf "%s" "$leading_whitespace$behind_symbol$behind_count"; leading_whitespace=" "; }
[[ $modified_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$modified_symbol$modified_count"; leading_whitespace=" "; }
[[ $unmerged_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$unmerged_symbol$unmerged_count"; leading_whitespace=" "; }
[[ $added_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$added_symbol$added_count"; leading_whitespace=" "; }
[[ $has_untracked_files -gt 0 ]] && { printf "%s" "$leading_whitespace$has_untracked_files_symbol"; leading_whitespace=" "; }
[[ $is_clean -gt 0 ]]            && { printf "%s" "$leading_whitespace$clean_symbol"; leading_whitespace=" "; }
}

export _PS1="$YELLOW\u$NO_COLOUR:\w$(_git_prompt)"
export PROMPT_COMMAND='export PS1="${_PS1} $(_git_prompt)\n$ "'

# Use vim for editing
export VISUAL=vim
export EDITOR="$VISUAL"

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# Tmux aliases
tmr() {
  tmux rename-window "$(pwd | sed -n 's/^\/Users\/nickt\/Development\/\([^\/]*\).*$/\1/p')";
}

d() {
  # Only run this if there is actually a directory with this name.
  if [ ! -d ~/Development/"$1" ]; then
    echo 'Project does not exist!'; return 1
  fi

  # Only create the window if it doesn't already exist.
  if [ "$(tmux list-windows | grep "$1" > /dev/null)" -eq 0 ]; then
    echo 'Window already exists!'; return 1
  fi

  # Set up a new window in this session, with a 70-30 vertical split with vim
  # in the first pane. Both panes are switched into the directory.
  tmux new-window -n "$1" -d
  tmux split-window -t "$1" -v -p 25 -d
  tmux send-keys -t vertica.0 "cd ~/Development/$1; clear" C-m
  tmux send-keys -t vertica.0 "vim" C-m
  tmux send-keys -t vertica.1 "cd ~/Development/$1; clear" C-m
}

# Resize a window for development.
rd() {
  tmux split-window -v -p 25
  tmux send-keys -t .1 "cd $(pwd); clear" C-m
  clear
  vim
}

# Other aliases
alias dev='cd ~/Development/; ls -l;'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -FGlhp'                        # Preferred 'ls' implementation
alias ll='ls -la'
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='open -a "Sublime Text"'                        # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias gl='git log --graph'                  # Print a pretty git log
alias macdown='open /Applications/MacDown.app'
alias gpom='git pull origin master'
alias gs='git status'
alias gd='git diff'

# lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

# mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#         displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
mans () {
  man "$1" | grep -iC2 --color=always "$2" | less
}

# showa: to remind yourself of an alias (given some part of it)
# ------------------------------------------------------------
showa () {
  /usr/bin/grep --color=always -i -a1 "$@" ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc;
}
