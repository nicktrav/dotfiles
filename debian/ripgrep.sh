#!/usr/bin/env bash

set euo -pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

green "Installing ripgrep"

RIPGREP_DIR="$DEV_DIR/ripgrep"
[ -d "$RIPGREP_DIR" ] || git clone https://github.com/BurntSushi/ripgrep.git "$RIPGREP_DIR"

cd "$RIPGREP_DIR"
git checkout "$RIPGREP_VERSION"

cargo build --release
sudo cp ./target/release/rg /usr/local/bin/
