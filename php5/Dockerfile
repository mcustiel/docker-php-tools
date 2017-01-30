# This file is part of mcustiel/docker-php-tools.
#
# php-simple-conversion is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# php-simple-conversion is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with mcustiel/docker-php-tools.  If not, see <http://www.gnu.org/licenses/>.

FROM composer/composer:php5
MAINTAINER Mariano Custiel <jmcustiel@gmail.com>

# Xdebug
RUN pecl install xdebug-2.5.0 && docker-php-ext-enable xdebug

# PHP tools
RUN composer global require phing/phing
RUN composer global require phpunit/phpunit
RUN composer global require phpunit/dbunit
RUN composer global require sebastian/phpcpd
RUN composer global require phploc/phploc
RUN composer global require phpmd/phpmd
RUN composer global require squizlabs/php_codesniffer
RUN composer global require pear/archive_tar
RUN composer global require friendsofphp/php-cs-fixer
RUN composer global require codeception/codeception

# CS config for SF2 standards
RUN composer global require escapestudios/symfony2-coding-standard
RUN phpcs --config-set installed_paths $COMPOSER_HOME/vendor/escapestudios/symfony2-coding-standard

ENTRYPOINT []
