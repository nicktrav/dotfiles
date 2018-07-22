#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

green "Installing shellcheck ..."

pushd /tmp
  tarball="shellcheck-v$SHELLCHECK_VERSION.linux.x86_64.tar.xz"
  url="https://storage.googleapis.com/shellcheck/$tarball"
  curl -O -L "$url"

  tar -xJf "$tarball"
  sudo cp "shellcheck-v$SHELLCHECK_VERSION/shellcheck" /usr/local/bin/

  rm "$tarball"
popd
