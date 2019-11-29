ARG PACKER_VERSION=1.4.0
ARG DOCKER_VERSION=18.09.6

FROM hashicorp/packer:${PACKER_VERSION} as packer
FROM docker:${DOCKER_VERSION} as docker

FROM python:3.6.8-slim-stretch

LABEL com.kaliop.vendor=Kaliop

ENV ANSIBLE_VERSION=2.8
ENV MOLECULE_VERSION=2.20.0
ENV TESTINFRA_VERSION=3.0.4
ENV DOCKER_COMPOSE_VERSION=1.24.0
ENV LOCALE=fr_FR.UTF-8

RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      curl \
      gcc \
      git \
      zip \
      jq \
      locales \
      wget \
      linkchecker \
      python-apt \
  && rm -f /var/cache/apt/archives/*.deb \
  && rm -rf /var/lib/apt/lists/*

# Configure locale for date and time
RUN dpkg-reconfigure locales && \
    echo $LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $LOCALE && \
    /usr/sbin/update-locale LANG=$LOCALE

ENV LC_ALL $LOCALE
ENV LANG $LOCALE

# Install molecule, testinfra & ansible via pip
RUN  pip3 install \
      ansible==${ANSIBLE_VERSION} \
      docker-py \
      molecule==${MOLECULE_VERSION} \
      testinfra==${TESTINFRA_VERSION} \
  \
  && rm -Rf /root/.cache/pip

# Install docker client
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

# Install packer
COPY --from=packer /bin/packer /usr/local/bin/packer

# Install docker-compose
RUN  curl \
        -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose \
  && chmod a+x /usr/local/bin/docker-compose


CMD ["/bin/bash"]