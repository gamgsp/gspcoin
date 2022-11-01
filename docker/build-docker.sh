#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-gspcoin/gspcoind-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/gspcoind docker/bin/
cp $BUILD_DIR/src/gspcoin-cli docker/bin/
cp $BUILD_DIR/src/gspcoin-tx docker/bin/
strip docker/bin/gspcoind
strip docker/bin/gspcoin-cli
strip docker/bin/gspcoin-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
