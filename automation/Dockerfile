ARG PACKER_VERSION=1.4.0
ARG DOCKER_VERSION=18.09.6

FROM hashicorp/packer:${PACKER_VERSION} as packer
FROM docker:${DOCKER_VERSION} as docker

FROM python:3.6.8-slim-stretch
MAINTAINER Kaliop

ENV ANSIBLE_VERSION=2.8
ENV MOLECULE_VERSION=2.20.0
ENV TESTINFRA_VERSION=3.0.4
ENV DOCKER_COMPOSE_VERSION=1.24.0
ENV LOCALE=fr_FR.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    locales \
    curl \
    wget \
    gcc \
    jq \
    git

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
COPY --from=docker /usr/local/bin/docker /home/site/local/bin/docker

# Install packer
COPY --from=packer /bin/packer /home/site/local/bin/packer

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# clear pip & apt cache folders
RUN rm -Rf /root/.cache/pip && \
    apt clean autoclean && \
    apt autoremove -y && \
    rm -f /var/cache/apt/archives/*.deb && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]