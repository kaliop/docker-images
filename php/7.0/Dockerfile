FROM debian:jessie
MAINTAINER Kaliop
LABEL php.version=7.0

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    curl \
    apt-transport-https

# Adding dotdeb repository for PHP 7.0
# -----------------------------------------------------------------------------
RUN curl https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
		echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list

# PHP packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    curl \
    php7.0 \
    php7.0-readline \
    php7.0-mysql \
    php7.0-json \
    php7.0-xsl \
    php7.0-intl \
    php7.0-mcrypt \
    php7.0-curl \
    php7.0-imagick \
    php7.0-gd \
    php7.0-xmlrpc \
    php7.0-memcached \
    php7.0-xdebug \
    php7.0-mbstring

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
RUN curl -L -o /etc/php/7.0/cli/conf.d/custom_vars.ini https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/php/custom_vars.ini && \
    cp /etc/php/7.0/cli/conf.d/custom_vars.ini /etc/php/7.0/apache2/conf.d/custom_vars.ini

# remove default xdebug config
RUN rm /etc/php/7.0/cli/conf.d/20-xdebug.ini
RUN rm /etc/php/7.0/apache2/conf.d/20-xdebug.ini

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]