FROM klabs/php:7.1
MAINTAINER Kaliop
LABEL nginx.version=1.12 \
      php.version=7.1 \
      application.type=PHP-FPM

ARG DOCKER_TIMEZONE=Europe/Paris
ARG DOCKER_LOCALE=fr_FR.UTF-8

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Base packages
# Java (used for eg. eZTika indexing)
# poppler-utils used for pdftotext binary (note that eztika is a much better option!)
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    pwgen \
    sudo \
    nano \
    unzip \
    locales \
    imagemagick \
    jpegoptim \
    poppler-utils \
    openjdk-7-jre-headless;

# locale for date, time & currency php functions
# -----------------------------------------------------------------------------
RUN dpkg-reconfigure locales && \
    echo $DOCKER_LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $DOCKER_LOCALE && \
    /usr/sbin/update-locale LANG=$DOCKER_LOCALE

ENV LC_ALL $DOCKER_LOCALE
ENV LANG $DOCKER_LOCALE
ENV LANGUAGE $DOCKER_LOCALE

# Install Nginx & PHP
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nginx \
    php7.1-fpm

# Local user
# => to try : run container with --user option to set root user id with host user id
# -----------------------------------------------------------------------------
# nb: the 1013 used here for user id and group id is later on replaced by the code in bootstrap.sh...
RUN addgroup --gid 1013 site && \
    adduser --system --uid=1013 --gid=1013 \
        --home /home/site --shell /bin/bash site && \
    adduser site site && \
    adduser site www-data && \
    mkdir -p /home/site/.ssh; \
    cp /etc/skel/.* /home/site/; \
    chown -R site:site /home/site;

# Nginx config
# -----------------------------------------------------------------------------
RUN sed -i -e"s/worker_processes  1/worker_processes 4/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
    sed -i -e's|user www-data;|user site;|g' /etc/nginx/nginx.conf && \
    chmod 755 -R /var/log/nginx

# PHP config
# -----------------------------------------------------------------------------
# We set a unique service name for php-fpm to be able to use the same bootstrap script
RUN sed -rie 's|user = www-data|user = site|g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -rie 's|listen.owner = www-data|listen.owner = site|g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -rie 's|\/run\/php\/php7.1-fpm.sock|\/run\/php\/php-fpm.sock|g' /etc/php/7.1/fpm/pool.d/www.conf && \
    mv /etc/init.d/php7.1-fpm /etc/init.d/php-fpm


# Disable xdebug
RUN rm /etc/php/7.1/fpm/conf.d/20-xdebug.ini

# Custom PHP-FPM error log folder
RUN mkdir /var/log/php/ && \
    chmod 755 -R /var/log/php/ && \
    sed -rie 's|error_log = /var/log/php7.1-fpm.log|error_log = /var/log/php/php7.1-fpm.log|g' /etc/php/7.1/fpm/php-fpm.conf

# Vhost config
# -----------------------------------------------------------------------------
# default & controlpanel
RUN rm /etc/nginx/sites-enabled/default && \
    curl -L -o /etc/nginx/sites-enabled/010-default https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/010-default && \
    curl -L -o /etc/nginx/conf.d/010-controlpanel.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/controlpanel.conf

RUN curl -L -o /tmp/controlpanel.tar.gz https://github.com/kaliop/docker-images/raw/master/build_files/controlpanel.tar.gz && \
    tar -zxf /tmp/controlpanel.tar.gz -C /home/site/ && \
    rm /tmp/controlpanel.tar.gz

# Run composer install for phpmemadmin vendors
RUN cd /home/site/controlpanel/phpmemadmin && \
    curl -sS https://getcomposer.org/installer | php -- && \
    php composer.phar install --no-dev --ignore-platform-reqs
    
# dynamic vhosts
# a2ensite is run in bootstrap.sh for these as they could also be mounted as volume at run time
RUN curl -L -o /etc/nginx/sites-enabled/001-unique-vhost https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/001-unique-vhost && \
    curl -L -o /etc/nginx/sites-enabled/002-dynamic-vhost-ez5 https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/002-dynamic-vhost-ez5 && \
    curl -L -o /etc/nginx/sites-enabled/003-dynamic-vhost-ez4 https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/003-dynamic-vhost-ez4 && \
    curl -L -o /etc/nginx/ez5-common https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/ez5-common && \
    curl -L -o /etc/nginx/environment_common https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/environment_common && \
    curl -L -o /etc/nginx/fastcgi_common https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/vhosts/fastcgi_common

# -----------------------------------------------------------------------------

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


RUN curl -o /root/bootstrap.sh https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/nginx/nginx_bootstrap.sh && \
    chmod 755 /root/bootstrap.sh

EXPOSE 443
EXPOSE 80
EXPOSE 82

WORKDIR /var/www/

CMD ["/root/bootstrap.sh"]
