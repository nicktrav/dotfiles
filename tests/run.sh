#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo docker run --rm -i \
  --name df-shellcheck \
  -v "$DIR/../:/root/Development/dotfiles:ro" \
  --workdir /root/Development/dotfiles \
  r.j3ss.co/shellcheck tests/test.sh
