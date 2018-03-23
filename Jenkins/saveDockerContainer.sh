#!/bin/bash

set -euo pipefail

backup_date=$(date -u +%Y.%m.%d-%H.%M.%S)

docker commit -m "Created on $backup_date" itkjenkins
docker image save jenkins | gzip > jenkins-docker_image-${backup_date}.tar.gz
