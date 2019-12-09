FROM debian:buster
MAINTAINER Kaliop

ENV DEBIAN_FRONTEND noninteractive

# Base packages
# Ansible requirements for targets: python and sudo
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
  openssh-server \
  sudo \
  python \
  python-apt

# Create empty authorized keys file. Authorized_keys will be added in bootstrap.sh
RUN mkdir /root/.ssh/ && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/*

# -----------------------------------------------------------------------------
# DO NOT clear archives in apt cache folder as a primed apt cache is needed for the 1st Ansible step


COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

EXPOSE 21 22 80 82 83 443 8983

CMD ["/root/bootstrap.sh"]
