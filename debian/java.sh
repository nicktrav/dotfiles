#!/usr/bin/env bash
# shellcheck disable=SC1090

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "$DIR/../common.sh"

green 'Installing Java ...'

# Download and install
URL="https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz"
cd /tmp && rm -rf java* && mkdir java && cd java
rm -rf /var/lib/java* && curl -L -o java.tar.gz "$URL"
sudo tar xzf java.tar.gz -C /var/lib

# Cleanup 
cd "$DIR"
rm -rf /tmp/java* /tmp/openjdk*
