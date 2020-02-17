FROM alpine:3.11

LABEL com.kaliop.vendor=Kaliop

WORKDIR /app

ARG ANSIBLE_VERSION=2.9.5
ARG AWSCLI_VERSION=1.18.0
ARG PACKER_VERSION=1.5.4
ARG TERRAFORM_VERSION=0.12.20

RUN  set -x \
  \
  && apk add --no-cache --virtual deps \
    build-base \
    curl \
    libffi-dev \
    openssl-dev \
    python3-dev \
    unzip \
  && apk add --no-cache \
    bash \
    docker-cli \
    libffi \
    openssl \
    openssh-client \
    python3 \
    sudo \
  \
  && curl -SLO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && curl -SLO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
  && grep linux_amd64 terraform_${TERRAFORM_VERSION}_SHA256SUMS | sha256sum -c \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm terraform_${TERRAFORM_VERSION}_SHA256SUMS \
  \
  && curl -SLO https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
  && curl -SLO https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
  && grep linux_amd64 packer_${PACKER_VERSION}_SHA256SUMS | sha256sum -c \
  && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
  && mv packer /usr/local/bin/ \
  && rm packer_${PACKER_VERSION}_linux_amd64.zip \
  && rm packer_${PACKER_VERSION}_SHA256SUMS \
  \
  && pip3 install -U \
    ansible==${ANSIBLE_VERSION} \
    awscli==${AWSCLI_VERSION} \
    pip \
  && rm -rf /root/.cache/pip \
  \
  && echo "alias ll='ls -lhF --color'" >> /etc/profile.d/aliases.sh \
  \
  && echo 'Set disable_coredump false' > /etc/sudo.conf \
  && addgroup -g 1000 terraform \
  && adduser -u 1000 -G terraform -D terraform \
  && echo "terraform ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  \
  && curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz \
    | tar -C /usr/local/bin -xzf - \
  && chmod 4755 /usr/local/bin/fixuid \
  && mkdir -p /etc/fixuid \
  && printf "user: terraform\ngroup: terraform\npaths:\n  - /app\n" > /etc/fixuid/config.yml \
  \
  && apk del deps

USER terraform:terraform

ENTRYPOINT [ "fixuid" ]
CMD [ "-q", "ash", "-l" ]
