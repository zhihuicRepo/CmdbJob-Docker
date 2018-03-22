FROM php:5.6.34-fpm
MAINTAINER zhihuic@quarkfinance.com
RUN apt-get update \
    && apt-get install libldb-dev libldap2-dev zlib1g-dev  -y \
    && pecl install redis-3.1.0  \
    && docker-php-ext-enable redis \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && docker-php-ext-install ldap mysql mysqli pcntl  hash zip gettext sockets bcmath 
