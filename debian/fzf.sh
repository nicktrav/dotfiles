#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

FZF_DIR="$DEV_DIR/fzf"
[ -d "$FZF_DIR" ] || git clone https://github.com/junegunn/fzf.git "$FZF_DIR"

pushd "$FZF_DIR"
  git fetch -t && git checkout "$FZF_VERSION"
  make && make install && sudo cp bin/fzf /usr/local/bin/
popd
