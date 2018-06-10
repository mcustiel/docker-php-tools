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

FROM composer:1.6
MAINTAINER Mariano Custiel <jmcustiel@gmail.com>

# phars directory
ENV PHARS_DIR /opt/phars
RUN mkdir -p $PHARS_DIR
ENV PATH $PHARS_DIR:$PATH

ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

# Xdebug
RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev
RUN pecl install xdebug-2.6.0 && docker-php-ext-enable xdebug

# PHP Configuration
COPY ./config/phar-writable.ini /usr/local/etc/php/conf.d

# Parallel downloads for composer
RUN composer global require hirak/prestissimo 

# PHP tools
RUN composer global require phing/phing
RUN composer global require kherge/box --prefer-source
RUN composer global require phpunit/phpunit:~6.0
RUN composer global require phpunit/dbunit:~3.0
RUN composer global require sebastian/phpcpd:~3.0
RUN composer global require phploc/phploc
RUN composer global require phpmd/phpmd
RUN composer global require squizlabs/php_codesniffer
RUN composer global require pear/archive_tar
RUN composer global require friendsofphp/php-cs-fixer
RUN composer global require codeception/codeception
RUN composer global require phpmetrics/phpmetrics
RUN composer global require sensiolabs/security-checker

RUN composer global require sebastian/phpdcd

RUN curl -L http://phpdoc.org/phpDocumentor.phar -o $PHARS_DIR/phpDocumentor
RUN chmod +x $PHARS_DIR/phpDocumentor

RUN composer global require phpstan/phpstan --prefer-dist

# CS config for SF2 standards
RUN composer global require escapestudios/symfony2-coding-standard
RUN phpcs --config-set installed_paths $COMPOSER_HOME/vendor/escapestudios/symfony2-coding-standard

RUN chmod -R 0777 $COMPOSER_HOME

ENTRYPOINT []

