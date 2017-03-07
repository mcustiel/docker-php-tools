#!/bin/bash

CURDIR=$(dirname $0)

docker build $CURDIR -t php-tools
docker build $CURDIR/php5 -t php-tools:php5
