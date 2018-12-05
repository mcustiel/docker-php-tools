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

FROM php:5.6-cli-stretch
MAINTAINER Mariano Custiel <jmcustiel@gmail.com>

# phars directory
ENV PHARS_DIR /opt/phars
RUN mkdir -p $PHARS_DIR
ENV PATH $PHARS_DIR:$PATH

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
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
        libcurl4-gnutls-dev \
        libssl-dev \
        libenchant-dev \
        libgmp-dev \
        libc-client-dev \
        libkrb5-dev \
        libpspell-dev \
        libaspell-dev \
        aspell-en \
        aspell-de \
        aspell-es \
        libxml2-dev \
        libtidy-dev \
        librecode-dev \
        libsnmp-dev \
        libreadline-dev \
        libedit-dev \
    && rm -r /var/lib/apt/lists/*

RUN pecl install xdebug-2.5.3
RUN pecl install ssh2-0.13 && docker-php-ext-enable ssh2
RUN pecl install redis-4.1.1 && docker-php-ext-enable redis
RUN pecl install imagick-3.4.3 && docker-php-ext-enable imagick

RUN docker-php-ext-install bcmath 
RUN docker-php-ext-install bz2 
RUN docker-php-ext-install calendar 
RUN docker-php-ext-install ctype 
RUN docker-php-ext-install curl 
RUN docker-php-ext-install dba 
RUN docker-php-ext-install dom 
RUN docker-php-ext-install enchant
RUN docker-php-ext-install exif 
RUN docker-php-ext-install fileinfo 
#RUN docker-php-ext-install filter
RUN docker-php-ext-install ftp 
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd 
RUN docker-php-ext-install gettext
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
RUN docker-php-ext-install gmp 
RUN docker-php-ext-install hash 
RUN docker-php-ext-install iconv 
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap 
# RUN docker-php-ext-install interbase 
RUN docker-php-ext-install intl 
RUN docker-php-ext-install json 
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && docker-php-ext-install ldap
RUN docker-php-ext-install mbstring 
RUN docker-php-ext-install mcrypt 
#RUN docker-php-ext-install mssql 
RUN docker-php-ext-install mysql 
RUN docker-php-ext-install mysqli 
#RUN docker-php-ext-install oci8 
#RUN docker-php-ext-install odbc 
RUN docker-php-ext-install opcache 
RUN docker-php-ext-install pcntl 
RUN docker-php-ext-install pdo 
#RUN docker-php-ext-install pdo_dblib 
#RUN docker-php-ext-install pdo_firebird 
RUN docker-php-ext-install pdo_mysql 
#RUN docker-php-ext-install pdo_oci 
#RUN docker-php-ext-install pdo_odbc 
#RUN docker-php-ext-install pdo_pgsql 
#RUN docker-php-ext-install pdo_sqlite 
#RUN docker-php-ext-install pgsql 
#RUN docker-php-ext-install phar 
RUN docker-php-ext-install posix 
RUN docker-php-ext-install pspell 
RUN docker-php-ext-install readline 
RUN docker-php-ext-install recode 
#RUN docker-php-ext-install reflection 
RUN docker-php-ext-install session 
RUN docker-php-ext-install shmop 
RUN docker-php-ext-install simplexml 
RUN docker-php-ext-install snmp 
RUN docker-php-ext-install soap 
RUN docker-php-ext-install sockets 
#RUN docker-php-ext-install spl 
#RUN docker-php-ext-install standard 
#RUN docker-php-ext-install sybase_ct 
RUN docker-php-ext-install sysvmsg 
RUN docker-php-ext-install sysvsem 
RUN docker-php-ext-install sysvshm 
RUN docker-php-ext-install tidy 
RUN docker-php-ext-install tokenizer 
RUN docker-php-ext-install wddx 
RUN docker-php-ext-install xml 
RUN docker-php-ext-install xmlreader 
RUN docker-php-ext-install xmlrpc 
RUN docker-php-ext-install xmlwriter 
RUN docker-php-ext-install xsl 
RUN docker-php-ext-install zip

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

RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && docker-php-ext-enable xdebug

RUN chmod -R 0777 $COMPOSER_HOME

VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT []

