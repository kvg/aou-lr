#!/bin/bash

set -euxo pipefail

DOCKER_REPO="aou-lr"
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

for DOCKER_FILE in $(find docker -name Dockerfile)
do
    DIR_NAME=$(dirname $DOCKER_FILE)
    DOCKER_NAME=$(basename $DIR_NAME)

    TAG="us-central1-docker.pkg.dev/broad-dsp-lrma/$DOCKER_REPO/$DOCKER_NAME:$BRANCH_NAME"

    #docker build -t $TAG $DIR_NAME && \
    #    gcloud config set account aou-lr-docker-builder@broad-dsp-lrma.iam.gserviceaccount.com && \
    #    gcloud auth configure-docker -q us-central1-docker.pkg.dev && \
    #    docker push $TAG

    docker build -t $TAG $DIR_NAME && docker push $TAG
done
