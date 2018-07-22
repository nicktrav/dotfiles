#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" 
source "$DIR/../common.sh"

green 'Installing Rust ...'

curl -Ssf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"
rustup component add rustfmt-preview
cargo install rusty-tags --force
rustup component add rust-src
