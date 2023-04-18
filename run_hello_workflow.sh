#!/bin/bash

set -euxo pipefail

RESOURCES="resources/workflow_options/default.json"
CA="cromshell-alpha -q --hide_logo -t 30 submit -op $RESOURCES -d wdl/wdls.zip"

cd wdl && zip -R wdls '*.wdl' > /dev/null 2>&1 && cd ..

$CA wdl/HelloWorkflow.wdl inputs/HelloWorkflow.json
