#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo docker run --rm -i \
  --name df-shellcheck \
  -v "$DIR:/usr/src:ro" \
  --workdir /usr/src \
  r.j3ss.co/shellcheck ./test.sh
