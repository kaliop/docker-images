# Terraform stack

This image provides a cli environment with the following tools installed:

- [awscli](https://github.com/aws/aws-cli)
- [ansible](https://docs.ansible.com/ansible/latest/index.html)
- [molecule](https://molecule.readthedocs.io/en/latest/)
- [packer](https://packer.io/)
- [terraform](https://www.terraform.io/)

## How to use this image?

When building an infrastructure, we usually pile up steps, each requiring its own tools.
The first goal of this image is to avoid having to install them on the host system.

Another goal is to make sure all developers will use the same versions.

Typically, this image can be used within your project using docker-compose:

```yaml
version: "3"

services:
  cli:
    image: klabs/terraform:ansible-2.9.5_packer-1.5.4_terraform-0.12.20
    user: ${UID:-1000}:${GID:-1000}
    environment:
      SSH_AUTH_SOCK: /var/run/ssh
    volumes:
      - $HOME/.aws:/home/terraform/.aws:ro
      - $HOME/.aws:/root/.aws:ro
      - /var/run/docker.sock:/var/run/docker.sock
      - $SSH_AUTH_SOCK:/var/run/ssh
      - .:/app
``` 

And then run `docker-compose run cli`.

The above example assumes you have `ssh-agent` running.
It also let you handle your docker daemon from the container.
The `UID/GID` to use can be set by exporting environment variables or using an [.env file](https://docs.docker.com/compose/env-file/).

## How to build your own version?

```shell
git clone https://github.com/kaliop/docker-images.git
cd docker-images/terraform

docker build -t my-image \
    --build-arg ANSIBLE_VERSION=2.9.5 \
    --build-arg PACKER_VERSION=1.5.4 \
    --build-arg TERRAFORM_VERSION=0.12.20 \
    .
```

