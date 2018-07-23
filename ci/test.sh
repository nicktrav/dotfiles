#!/usr/bin/env bash
# shellcheck disable=SC1090

# Lint the shell scripts in .dotfiles
# Inspiration taken from jessfraz/dotfiles

set -eou pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

# Colours
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# All files in this repo that aren't git files
files=$(
  find "$DOTFILES_DIR" -type f -not -iwholename '*git*' \
    | sort -u
)

# Variable to store the files that don't pass ShellCheck
FAILURES=()

# For each file, if the file is a bash script, run it through ShellCheck.
# Print the outcome of the linting. In the case that the file does not pass,
# add the file to the list of failures.
for file in $files; do
  if file "$file" | grep --quiet 'shell script'; then
    echo -n "$file - "
    if shellcheck "$file" > /dev/null; then
      echo -e "${GREEN}PASS${NC}"
    else
      echo -e "${RED}FAIL${NC}"
      FAILURES+=("$file")
    fi
  fi
done

count=${#FAILURES[@]}
if [ "$count" -gt 0 ]; then
  printf '\nFound %s files with issues!\n' "$count"
  exit 1
else
  printf '\nPass!\n'
fi
