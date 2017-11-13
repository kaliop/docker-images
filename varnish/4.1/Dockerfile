FROM debian:jessie
MAINTAINER Kaliop
LABEL varnish.version=4.1

ENV TERM xterm-color

ARG DOCKER_TIMEZONE=Europe/Paris

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    debian-archive-keyring \
    curl \
    htop \
    procps \
    net-tools;

# varnish
# -----------------------------------------------------------------------------
RUN curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | apt-key add - && \
    echo "deb https://packagecloud.io/varnishcache/varnish41/debian/ jessie main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
    varnish varnish-agent;

# Default services configuration & fix user group for varnishncsa.pid
RUN curl -o /etc/default/varnish https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/varnish/etc/default/varnish && \
    curl -o /etc/default/varnishncsa https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/varnish/etc/default/varnishncsa && \
    curl -o /etc/init.d/varnishncsa https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/varnish/etc/init.d/varnishncsa  && \
    chmod +x /etc/init.d/varnishncsa

#User & Password for Varnish Agent
RUN echo "varnish:CacheMeIfYouCan" > /etc/varnish/agent_secret

# Filebeat
# -----------------------------------------------------------------------------
RUN curl -L https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y filebeat

COPY filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod 644 /etc/filebeat/filebeat.yml


RUN curl -o /root/bootstrap.sh https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/varnish/varnish_bootstrap.sh && \
    chmod 755 /root/bootstrap.sh

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 81
EXPOSE 6082

CMD ["/root/bootstrap.sh"]