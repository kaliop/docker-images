FROM debian:wheezy
MAINTAINER Kaliop
LABEL php.version=5.4

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    curl \
    php5 \
		php5-mysqlnd \
		php5-json \
		php5-xsl \
		php5-intl \
		php5-mcrypt \
		php5-curl \
		php5-imagick \
		php5-gd \
		php5-xmlrpc \
		php5-memcached \
		php5-xdebug

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
RUN curl -L -o /etc/php5/conf.d/custom_vars.ini https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/php/custom_vars.ini

# remove default xdebug config
RUN rm /etc/php5/conf.d/20-xdebug.ini

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]