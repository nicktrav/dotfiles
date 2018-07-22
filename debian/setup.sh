#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 

. "$DIR/update_system.sh"
. "$DIR/fonts.sh"
. "$DIR/rust.sh"
. "$DIR/tmux.sh"
. "$DIR/ctags.sh"
. "$DIR/java.sh"
