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

FROM php-tool-base:php72

LABEL MAINTAINER="Mariano Custiel <jmcustiel@gmail.com>"

ARG DEBUG_IDEKEY=ECLIPSE

RUN apt-get update && \
        apt-get install --yes --no-install-recommends \

        libsodium-dev libc-client-dev libkrb5-dev \
    && rm -r /var/lib/apt/lists/*

RUN pecl install ast && docker-php-ext-enable ast
RUN pecl install imagick-3.4.3 && docker-php-ext-enable imagick
RUN pecl install redis-4.1.1 && docker-php-ext-enable redis
#RUN pecl install ssh2-1.1.2 && docker-php-ext-enable ssh2
RUN pecl install xdebug-2.7.2

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd 

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap 
RUN docker-php-ext-install gmp 
RUN docker-php-ext-install hash 
RUN docker-php-ext-install json 
RUN docker-php-ext-install phar 
RUN docker-php-ext-install readline 
RUN docker-php-ext-install recode 
RUN docker-php-ext-install sodium 
RUN docker-php-ext-install tokenizer 
RUN docker-php-ext-install wddx 
RUN docker-php-ext-install xmlrpc 

RUN CFLAGS="-I/usr/src/php"  docker-php-ext-install xmlreader 
RUN docker-php-ext-install zend_test 

RUN wget -O /usr/local/bin/php-cs-fixer https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v2.19.1/php-cs-fixer.phar && \
    chmod +x /usr/local/bin/php-cs-fixer

RUN wget -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-8.5.8.phar && \
    chmod +x /usr/local/bin/phpunit

RUN wget -O /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd-4.1.0.phar && \
    chmod +x /usr/local/bin/phpcpd

RUN wget -O /usr/local/bin/codecept http://codeception.com/codecept.phar && \
    chmod +x /usr/local/bin/codecept

RUN wget -O /usr/local/bin/box https://github.com/box-project/box/releases/download/3.0.0/box.phar && \
    chmod +x /usr/local/bin/box

RUN composer global require phan/phan
RUN composer global require phpstan/phpstan --prefer-dist
RUN composer global require symfony/console:^5.0
RUN composer global require phing/phing

RUN composer global require phploc/phploc
RUN composer global require phpmd/phpmd
RUN composer global require squizlabs/php_codesniffer
RUN composer global require pear/archive_tar
RUN composer global require codeception/codeception
RUN composer global require sensiolabs/security-checker
RUN composer global require phpmetrics/phpmetrics

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
