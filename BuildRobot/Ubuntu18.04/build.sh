#!/bin/bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t insighttoolkit/ci-linux-ubuntu18.04 $DIR
