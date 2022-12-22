#!/usr/bin/env bash

set -exu

OS=$1
ARCH=$2
VER=$3

mkdir -p artifacts

docker buildx build --platform="$OS/$ARCH" -f build/ubuntu-focal/Dockerfile -t "pgx-ubuntu-focal-$ARCH" .

docker run \
  -v "$PWD":/home/docker/pkg \
  -v "$PWD/artifacts":/artifacts \
  -e PG_VERSION="$VER" \
  "pgx-ubuntu-focal-$ARCH" ./scripts/package.sh
