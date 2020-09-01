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

FROM php-tool-base:php73

LABEL MAINTAINER="Mariano Custiel <jmcustiel@gmail.com>"

ARG DEBUG_IDEKEY=ECLIPSE

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        libsodium-dev libc-client-dev libkrb5-dev \
    && rm -r /var/lib/apt/lists/*

RUN pecl install xdebug-2.7.2
#RUN pecl install ssh2-1.1.2 && docker-php-ext-enable ssh2
RUN pecl install ast && docker-php-ext-enable ast

RUN docker-php-ext-install gmp 
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap 
RUN docker-php-ext-install phar 
RUN docker-php-ext-install sodium 

RUN CFLAGS="-I/usr/src/php"  docker-php-ext-install xmlreader 
RUN docker-php-ext-install zend_test 

RUN wget -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-9.3.8.phar && \
    chmod +x /usr/local/bin/phpunit

RUN wget -O /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd-6.0.2.phar && \
    chmod +x /usr/local/bin/phpcpd

RUN wget -O /usr/local/bin/codecept http://codeception.com/codecept.phar && \
    chmod +x /usr/local/bin/codecept

RUN composer global require phan/phan

RUN composer global require phpstan/phpstan --prefer-dist

# RUN echo "xdebug.remote_enable=on" > $PHP_INI_DIR/conf.d/xdebug.ini \
# 	&& echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo "xdebug.idekey=\"$DEBUG_IDEKEY\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.remote_handler=dbgp' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.profiler_enable=0' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.profiler_output_dir="/var/www/html/"' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.cli_color=1' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& echo 'xdebug.var_display_max_depth=10' >> /usr/local/etc/php/conf.d/xdebug.ini \
# 	&& docker-php-ext-enable xdebug

RUN chmod -R 0777 $COMPOSER_HOME
