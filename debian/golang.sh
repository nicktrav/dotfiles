#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Installing Golang ...'

TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://dl.google.com/go/$TARBALL"

pushd /tmp
  curl -L -O "$URL"
  sudo tar xzf "$TARBALL" -C /usr/local
  rm "$TARBALL"
popd
