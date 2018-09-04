#!/bin/bash

set -euo pipefail

if [[ ! -d $HOME/itkjenkins ]]
then
  mkdir -p $HOME/itkjenkins
fi

function check_container()
{
  local container_name=$1
  local container_exists=$(docker ps -aq --no-trunc --filter name=^/$container_name$)

  if [[ "$container_exists" ]]
  then
    echo "Container named $container_name already exist. Remove it first."
    exit -1
  fi
}

if [[ ! -f ~/load_keys.sh ]]
then
  echo "Missing ~/load_keys.sh file that defines SSL_CERT, SSL_KEY, and LETSENCRYPT_EMAIL environment variables"
  exit 1
fi
source ~/load_keys.sh

check_container mynginx

jenkins_container_name=itkjenkins
check_container $jenkins_container_name

jnlp_port=50000

docker run --restart unless-stopped -p $jnlp_port:$jnlp_port -p 8080:8080 -v $HOME/itkjenkins:/var/jenkins_home -e "JAVA_OPTS=-Djenkins.slaves.DefaultJnlpSlaveReceiver.disableStrictVerification=true" --name $jenkins_container_name -d jenkins

./start_nginx.sh
