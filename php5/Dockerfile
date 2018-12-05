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
FROM php:5.6-stretch
MAINTAINER Mariano Custiel <jmcustiel@gmail.com>

ENV PHARS_DIR /opt/phars
RUN mkdir $PHARS_DIR
ENV PATH $PHARS_DIR:$PATH

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        libssh2-1-dev \
        gzip \
        zip \
        git \
	zlib1g-dev \
	libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libbz2-dev \
        libxslt-dev \
        libldap2-dev \
        curl \
        git \
        subversion \
        unzip \
        openssh-client \
        wget \
        imagemagick \
        libgraphicsmagick1-dev \
        libmagickwand-dev \
    && rm -r /var/lib/apt/lists/*

# Xdebug
RUN pecl install xdebug-2.5.3
RUN pecl install ssh2-0.13 && docker-php-ext-enable ssh2
RUN pecl install redis-4.1.1 && docker-php-ext-enable redis
RUN pecl install imagick-3.4.3 && docker-php-ext-enable imagick

RUN docker-php-ext-install bcmath mcrypt zip bz2 mbstring pcntl xsl \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
&& docker-php-ext-install ldap


# PHP Configuration
COPY ./config/phar-writable.ini /usr/local/etc/php/conf.d

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Setup composer
RUN  php -r "copy('https://getcomposer.org/download/1.6.3/composer.phar', '/usr/local/bin/composer');" \
    && php -r "if (hash_file('SHA384', '/usr/local/bin/composer') === '657f1ec4b4e0c765254d9812a841e306e7a1588a9808d4148b17d11d56549f12f0a547b7c03eeb8149b71a93a89d0267') { echo 'Composer 1.6.3 verified'; } else { echo 'Composer 1.6.3 corrupt'; exit(1); } echo PHP_EOL;" \
    && chmod +x /usr/local/bin/composer

# Parallel downloads for composer
RUN composer global require hirak/prestissimo

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
RUN composer global require phpmetrics/phpmetrics
RUN composer global require sensiolabs/security-checker
RUN composer global require kherge/box --prefer-source
RUN composer global require sebastian/phpdcd

RUN curl -L http://phpdoc.org/phpDocumentor.phar -o $PHARS_DIR/phpDocumentor
RUN chmod +x $PHARS_DIR/phpDocumentor

# CS config for SF2 standards
RUN composer global require escapestudios/symfony2-coding-standard
RUN phpcs --config-set installed_paths $COMPOSER_HOME/vendor/escapestudios/symfony2-coding-standard

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Disable Populating Raw POST Data
# Not needed when moving to PHP 7.
# http://php.net/manual/en/ini.core.php#ini.always-populate-raw-post-data
RUN echo "always_populate_raw_post_data=-1" > $PHP_INI_DIR/conf.d/always_populate_raw_post_data.ini

RUN docker-php-ext-enable xdebug

RUN chmod -R 0777 $COMPOSER_HOME

VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT []

