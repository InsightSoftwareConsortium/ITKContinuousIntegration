#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]
then
  echo "Usage: $0 archived_image"
  exit -1
fi

zcat $1 | docker image load
