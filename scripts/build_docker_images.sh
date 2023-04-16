#!/bin/bash

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

for DOCKER_FILE in $(find docker -name Dockerfile)
do
    DIR_NAME=$(dirname $DOCKER_FILE)
    DOCKER_NAME=$(basename $DIR_NAME)

    TAG="us.gcr.io/broad-dsp-lrma/$DOCKER_NAME:$BRANCH_NAME"

    docker build -t $TAG $DOCKER_FILE
    gcloud auth configure-docker -q
    docker push $TAG
done
