# MYSQL
=======

This Docker Image runs Mysql 5.6.

It has been forked from the official Mysql Docker container, with minimal changes:

- set timezone the same as the other containers

- change the user-id/group-id of the mysql user, to ease the sharing of data in mounted volumes

More docs at: https://hub.docker.com/_/mysql/

## How to run the container

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)

* Run the container

You can run the container with the docker run command :


	``` sh
    docker run -p 3307:3306 klabs/mysql:5.6
	```