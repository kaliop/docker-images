FROM python:3.6.8-slim-stretch

MAINTAINER Kaliop

ARG ANSIBLE_VERSION=2.8
ARG MOLECULE_VERSION=2.20.0
ARG TESTINFRA_VERSION=3.0.4
ARG DOCKER_VERSION=18.09.1
ARG PACKER_VERSION=1.4.0
ARG DOCKER_COMPOSE_VERSION=1.24.0
ARG LOCALE=fr_FR.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    locales \
    curl \
    gcc \
    jq \
    unzip \
    git

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure locale for date and time
RUN dpkg-reconfigure locales && \
    echo $LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $LOCALE && \
    /usr/sbin/update-locale LANG=$LOCALE

ENV LC_ALL $LOCALE
ENV LANG $LOCALE

# Install molecule, testinfra & ansible via pip
RUN pip3 install molecule==${MOLECULE_VERSION} && \
    pip3 install testinfra==${TESTINFRA_VERSION} && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    pip3 install docker-py

# Install docker client
RUN mkdir -p /tmp/download && \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xz -C /tmp/download && \
    mv /tmp/download/docker/docker /usr/local/bin/ && \
    rm -rf /tmp/download

# Install packer
RUN curl -L -o /tmp/packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip /tmp/packer.zip -d /usr/local/bin/ && \
    rm /tmp/packer.zip

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# clear pip .cache folder
RUN rm -Rf /root/.cache/pip

CMD ["/bin/bash"]