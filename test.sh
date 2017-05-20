#!/usr/bin/env bash

# Lint the shell scripts in .dotfiles
# Inspiration taken from jessfraz/dotfiles

set -eou pipefail

# Colours
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# All files in this repo that aren't git files
files=$(
  find . -type f -not -iwholename '*git*' \
    | sort -u
)

# Variable to store the files that don't pass ShellCheck
FAILURES=()

# For each file, if the file is a bash script, run it through ShellCheck.
# Print the outcome of the linting. In the case that the file does not pass,
# add the file to the list of failures.
for file in $files; do
  if file "$file" | grep --quiet 'bash script'; then
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
  echo -e "\nFound $count files with issues!"
  exit 1
else
  echo -e "\nPass!"
fi
