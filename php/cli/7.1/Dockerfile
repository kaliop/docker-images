FROM klabs/php:7.1
MAINTAINER Kaliop

LABEL php.version=7.1

ARG DOCKER_TIMEZONE=Europe/Paris
ARG DOCKER_LOCALE=fr_FR.UTF-8

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Base packages
# Mysql client, useful for db dumps and such
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    bash-completion \
    git \
    cron \
    mysql-client \
    php7.1-mbstring;

# Configure locale for date, time & currency php functions
# -----------------------------------------------------------------------------
RUN dpkg-reconfigure locales && \
    echo $DOCKER_LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $DOCKER_LOCALE && \
    /usr/sbin/update-locale LANG=$DOCKER_LOCALE

ENV LC_ALL $DOCKER_LOCALE
ENV LANG $DOCKER_LOCALE
ENV LANGUAGE $DOCKER_LOCALE

# Composer global install
# -----------------------------------------------------------------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && \
    mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
    chmod 755 /usr/local/bin/composer

# Local user
# -----------------------------------------------------------------------------
RUN mkdir /tmp/profile && \
    curl -s -o /tmp/profile/.bashrc_append https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/cli/profile/.bashrc_append && \
    curl -s -o /tmp/profile/.gitconfig https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/cli/profile/.gitconfig && \
    curl -s -o /tmp/profile/.vimrc_append https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/cli/profile/.vimrc_append

# nb: the 1000 used here for user id and group id is later on replaced by the code in bootstrap.sh...
RUN addgroup --gid 1000 site && \
    adduser --uid 1000 --ingroup site --home /home/site --shell /bin/bash --disabled-password --gecos "" site && \
    sed -i '$ a site   ALL=\(ALL:ALL\) NOPASSWD: ALL' /etc/sudoers

RUN curl -s -o /home/site/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && \
    curl -s -o /home/site/.git-prompt.sh -OL https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh && \
    cp /etc/skel/.* /home/site/; \
    cat /tmp/profile/.bashrc_append >> /home/site/.bashrc && \
    cat /tmp/profile/.vimrc_append >> /home/site/.vimrc && \
    cp /tmp/profile/.gitconfig /home/site/ && \
    mkdir -p /home/site/.composer && \
    mkdir -p /home/site/.ssh && \
    chown -R site:site /home/site/ && \
    find /tmp/ -type f -name '.*' -maxdepth 1  -delete

# NVM userland install (https://github.com/creationix/nvm#install-script)
RUN mkdir /home/site/.nvm/ && \
    export NVM_DIR="/home/site/.nvm" && \
    export PROFILE="/home/site/.bashrc" && \
    export NODE_VERSION="8.11.3" && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    chown -R site:site /home/site/.nvm
    
# Install fixuid (https://github.com/boxboat/fixuid) to map host user id with container 'site' user id (used in bootstrap.sh)
RUN USER=site && \
    GROUP=site && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

# -----------------------------------------------------------------------------

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -s -o /run/bootstrap.sh https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/cli/php_cli_bootstrap.sh && \
    chmod 755 /run/bootstrap.sh

USER site:site
WORKDIR /var/www/

CMD ["/run/bootstrap.sh"]
