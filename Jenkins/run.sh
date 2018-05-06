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

nginx_container_name=mynginx
check_container $nginx_container_name

jenkins_container_name=itkjenkins
check_container $jenkins_container_name

jnlp_port=50000

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run --restart unless-stopped -p $jnlp_port:$jnlp_port -p 8080:8080 -v $HOME/itkjenkins:/var/jenkins_home --name $jenkins_container_name -d jenkins

docker run -p 443:443 -p 80:80 -v $SSL_CERT:/etc/ssl/your_domain_name.pem -v $SSL_KEY:/etc/ssl/your_domain_name.key -v $DIR/nginx.conf:/etc/nginx/conf.d/default.conf --name $nginx_container_name --link itkjenkins:itkjenkins -d nginx
