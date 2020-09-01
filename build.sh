#!/bin/bash

# This file is part of mcustiel/docker-php-tools.
#
# docker-php-tools is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# docker-php-tools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with mcustiel/docker-php-tools.  If not, see <http://www.gnu.org/licenses/>.

set -e 
set -u

CURDIR=$(dirname $0)

echo "Building for PHP 7.3"
docker build --build-arg PHP_DOCKER_IMAGE_TAG=7.3-cli-stretch -f Dockerfile_base $CURDIR -t php-tool-base:php73
docker build $CURDIR/php73 -t php-tools:php73

echo "Building for PHP 7.2"
docker build --build-arg PHP_DOCKER_IMAGE_TAG=7.2-cli-stretch -f Dockerfile_base $CURDIR -t php-tool-base:php72
docker build $CURDIR/php72 -t php-tools:php72

echo "Building for PHP 5.6"
docker build --build-arg PHP_DOCKER_IMAGE_TAG=5.6-cli-stretch -f Dockerfile_base $CURDIR -t php-tool-base:php5
docker build $CURDIR/php5 -t php-tools:php5

