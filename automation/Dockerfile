FROM debian:9.6

MAINTAINER Kaliop

ARG ANSIBLE_VERSION=2.6.7
ARG MOLECULE_VERSION=2.19.0
ARG VENV_ROOT=/home/automation/virtualenv
ARG LOCALE=fr_FR.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    locales \
    python3.5-minimal \
    python3-pip

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure locale for date and time
RUN dpkg-reconfigure locales && \
    echo $LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $LOCALE && \
    /usr/sbin/update-locale LANG=$LOCALE

ENV LC_ALL $LOCALE
ENV LANG $LOCALE

# Create automation user
RUN addgroup --gid 1000 automation && \
    adduser --uid 1000 --ingroup automation --home /home/automation --shell /bin/bash --disabled-password --gecos "" automation

USER automation:automation

# Install tools via pip
RUN pip3 install molecule==${MOLECULE_VERSION} && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    pip3 install docker-py

# Setup userland local PATH & clear home .cache folder
RUN echo "export PATH=/home/automation/.local/bin/:$PATH" >> /home/automation/.bashrc && \
    rm -rf /home/automation/.cache/*

WORKDIR /home/automation/

CMD ["/bin/bash"]