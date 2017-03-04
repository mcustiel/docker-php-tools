#!/bin/bash

docker build $CURDIR -t php-tools
docker build $CURDIR/php5 -t php-tools:php5

