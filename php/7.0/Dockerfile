FROM debian:stretch
MAINTAINER Kaliop
LABEL php.version=7.0

# Base packages
# Java (used for eg. eZTika indexing)
# poppler-utils used for pdftotext binary (note that eztika is a much better option!)
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    wget \
    curl \
    netcat \
    jpegoptim \
    imagemagick \
    sudo \
    vim \
    nano \
    poppler-utils \
    openjdk-8-jre-headless \
    pwgen \
    locales \
    unzip

# Adding dotdeb repository for PHP 7.0
# -----------------------------------------------------------------------------
#RUN curl https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://www.dotdeb.org/dotdeb.gpg && \
		echo "deb http://packages.dotdeb.org stretch all" > /etc/apt/sources.list.d/dotdeb.list

# PHP packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    php7.0 \
    php7.0-cli \
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