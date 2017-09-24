FROM debian:jessie
MAINTAINER Kaliop
LABEL php.version=7.1

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates wget

# Adding packages.sury.org repository for PHP 7.1
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list


# PHP packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    curl \
    php7.1 \
    php7.1-readline \
    php7.1-mysql \
    php7.1-json \
    php7.1-xsl \
    php7.1-intl \
    php7.1-mcrypt \
    php7.1-curl \
    php7.1-imagick \
    php7.1-gd \
    php7.1-xmlrpc \
    php7.1-memcached \
    php7.1-xdebug \
    php7.1-mbstring

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
RUN curl -L -o /etc/php/7.1/cli/conf.d/custom_vars.ini https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/php/custom_vars.ini && \
    cp /etc/php/7.1/cli/conf.d/custom_vars.ini /etc/php/7.1/apache2/conf.d/custom_vars.ini

# remove default xdebug config
RUN rm /etc/php/7.1/cli/conf.d/20-xdebug.ini
RUN rm /etc/php/7.1/apache2/conf.d/20-xdebug.ini


# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]