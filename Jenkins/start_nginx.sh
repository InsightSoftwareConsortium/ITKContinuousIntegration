#!/bin/bash

if [ ! -d ~/acme-challenge/.well-known/acme-challenge/ ]; then
  mkdir -p ~/acme-challenge/.well-known/acme-challenge/
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$1" == "-k" ]]
then
  docker stop mynginx
  docker rm mynginx
fi

docker run -p 443:443 -p 80:80 -v $SSL_CERT:/etc/ssl/your_domain_name.pem -v $SSL_KEY:/etc/ssl/your_domain_name.key -v ~/acme-challenge:/data/letsencrypt -v $DIR/nginx.conf:/etc/nginx/conf.d/default.conf --name mynginx --link itkjenkins:itkjenkins -d nginx
