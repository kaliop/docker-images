# Deployment base image

This image can be used to run deployment tests in a container with an automation tool that uses ssh connection for provisioning,
 like Ansible for example
 
Image is built from Debian Stretch (9).

Available software packages installed are:

* openssh-server
* sudo
* python
* python-apt


In order to allow ssh connection from host to container, you must mount your own ssh public key as volume in /root/.ssh/authorized_keys_fromhost.

Example : 

```bash
docker run -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys_fromhost --name deployment klabs/deployment
```

To check that SSH connection is working : 

* Get the ip address of your container : 

```bash
docker exec -ti deployment hostname -I
172.17.0.2
```

* Connect as root via ssh : 
```bash
ssh root@172.17.0.2
```