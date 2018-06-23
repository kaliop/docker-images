FROM klabs/php:5.4
MAINTAINER Kaliop
LABEL apache.version=2.2 \
      php.version=5.4

ARG DOCKER_TIMEZONE=Europe/Paris
ARG DOCKER_LOCALE=fr_FR.UTF-8

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# locale for date, time & currency php functions
# -----------------------------------------------------------------------------
RUN dpkg-reconfigure locales && \
    echo $DOCKER_LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $DOCKER_LOCALE && \
    /usr/sbin/update-locale LANG=$DOCKER_LOCALE

ENV LC_ALL $DOCKER_LOCALE
ENV LANG $DOCKER_LOCALE
ENV LANGUAGE $DOCKER_LOCALE

# Apache
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2

# Local user
# => to try : run container with --user option to set root user id with host user id
# -----------------------------------------------------------------------------
# nb: the 1013 used here for user id and group id is later on replaced by the code in bootstrap.sh...
RUN addgroup --gid 1013 site && \
    adduser --system --uid=1013 --gid=1013 \
        --home /home/site --shell /bin/bash site && \
    adduser site site && \
    adduser site www-data && \
    cp /etc/skel/.* /home/site/; \
    chown -R site:site /home/site;

# Apache config
# -----------------------------------------------------------------------------
ENV APACHE_RUN_USER site
ENV APACHE_RUN_GROUP site
ENV APACHE_LOG_DIR /var/log/apache2/sites
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR  /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN sed -rie 's|export APACHE_RUN_USER=.*|export APACHE_RUN_USER=site|g' /etc/apache2/envvars && \
    sed -rie 's|export APACHE_RUN_GROUP=.*|export APACHE_RUN_GROUP=site|g' /etc/apache2/envvars && \
    sed -rie 's|export APACHE_LOG_DIR=.*|export APACHE_LOG_DIR=/var/log/apache2|g' /etc/apache2/envvars && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# For Apache 2.2, we also need to add NameVirtualHost in ports.conf
RUN rm /etc/apache2/ports.conf && \
    curl -o /etc/apache2/ports.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/ports.conf && \
    sed -i '/Listen 80/i \NameVirtualHost *:80' /etc/apache2/ports.conf && \
    sed -i '/Listen 82/i \NameVirtualHost *:82' /etc/apache2/ports.conf

RUN a2enmod rewrite headers vhost_alias proxy_http proxy ssl info status

# vhost config
# -----------------------------------------------------------------------------
# default & controlpanel
RUN curl -L -o /etc/apache2/sites-available/099-default.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/099-default.conf && \
    curl -L -o /tmp/010-controlpanel.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/010-controlpanel.conf && \
    cat /tmp/010-controlpanel.conf >> /etc/apache2/apache2.conf && \
    rm /tmp/010-controlpanel.conf

RUN curl -L -o /tmp/controlpanel.tar.gz https://github.com/kaliop/docker-images/raw/master/build_files/controlpanel.tar.gz && \
    tar -zxf /tmp/controlpanel.tar.gz -C /home/site/ && \
    rm /tmp/controlpanel.tar.gz

RUN  a2dissite 000-default && \
     a2ensite 099-default.conf

# dynamic vhosts
# a2ensite is run in bootstrap.sh for these as they could also be mounted as volume at run time
RUN curl -L -o /etc/apache2/sites-available/001-dynamic-vhost-ez5.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/001-dynamic-vhost-ez5.conf && \
    curl -L -o /etc/apache2/sites-available/003-dynamic-vhost-ez4.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/003-dynamic-vhost-ez4.conf && \
    curl -L -o /etc/apache2/sites-available/005-dynamic-vhost-wp.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/005-dynamic-vhost-wp.conf && \
    curl -L -o /etc/apache2/sites-available/098-dynamic-vhost.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/098-dynamic-vhost.conf && \
    curl -L -o /etc/apache2/sites-available/ez5-common.conf https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/vhosts/ez5-common.conf

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get bootstrap script
RUN curl -o /root/bootstrap.sh https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/apache/apache_bootstrap.sh && \
    chmod 755 /root/bootstrap.sh

EXPOSE 443
EXPOSE 80
EXPOSE 82

WORKDIR /var/www/

CMD ["/root/bootstrap.sh"]
