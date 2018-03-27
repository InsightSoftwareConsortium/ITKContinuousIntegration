#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]
then
  echo "Usage: $0 output_directory"
  exit -1
fi

if [[ ! -d $1 ]]
then
  echo "Argument must be an existing folder. Got $1"
  exit -2
fi


backup_date=$(date -u +%Y.%m.%d-%H.%M.%S)

docker commit -m "Created on $backup_date" itkjenkins
docker image save jenkins | gzip > $1/jenkins-docker_image-${backup_date}.tar.gz
