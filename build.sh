#!/bin/bash

set -e 
set -u

CURDIR=$(dirname $0)

docker build --build-arg PHP_DOCKER_IMAGE_TAG=7.2-cli-stretch -f Dockerfile_base $CURDIR -t php-tool-base:php7
docker build $CURDIR -t php-tools
docker build --build-arg PHP_DOCKER_IMAGE_TAG=5.6-cli-stretch -f Dockerfile_base $CURDIR -t php-tool-base:php5
docker build $CURDIR/php5 -t php-tools:php5

