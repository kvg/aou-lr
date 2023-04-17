#!/bin/bash

set -euxo pipefail

DOCKER_REPO="aou-lr"
#gcloud artifacts repositories create $DOCKER_REPO \
#    --repository-format=docker \
#    --location=us-central1 \
#    --description="Docker repository for AoU LR work"

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

for DOCKER_FILE in $(find docker -name Dockerfile)
do
    DIR_NAME=$(dirname $DOCKER_FILE)
    DOCKER_NAME=$(basename $DIR_NAME)

    TAG="us-central1-docker.pkg.dev/broad-dsp-lrma/$DOCKER_REPO/$DOCKER_NAME:$BRANCH_NAME"

    docker build -t $TAG $DIR_NAME && \
        gcloud auth configure-docker -q us-central1-docker.pkg.dev && \
        docker push $TAG
done
