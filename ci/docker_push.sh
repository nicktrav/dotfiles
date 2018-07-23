#!/usr/bin/env bash

set -euo pipefail

if [ "$CIRCLE_BRANCH" == "master" ]
then
  apt-get update && apt-get install --yes curl

  VER="17.03.0-ce"
  curl -L -o /tmp/docker-"$VER".tgz https://get.docker.com/builds/Linux/x86_64/docker-"$VER".tgz
  tar -xz -C /tmp -f /tmp/docker-"$VER".tgz
  mv /tmp/docker/* /usr/bin

  docker build -f Dockerfile-debian -t nicktravers/dotfiles:latest .
  docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"
  docker push nicktravers/dotfiles:latest
  docker tag nicktravers/dotfiles:latest nicktravers/dotfiles:"$CIRCLE_SHA1"
  docker push nicktravers/dotfiles:"$CIRCLE_SHA1"
else
  echo 'Ignoring PR branch for docker push.'
fi
