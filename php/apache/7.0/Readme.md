# Apache/php 7.0 web server

Apache web server image to run your PHP project.

Image is built on Debian Jessie.

Available software packages installed are:

* Apache 2.4
* PHP 7.0
* ImageMagick 6.7
* JAVA (OpenJDK 7)
* Curl
* Nano

## Apache config

Apache listens on ports:
* 80 (dev vhost)
* 82 (demo vhost)
* 88 (controlpanel vhost)
* 443 (SSL)

Those can be remapped when running the container.

A controlpanel is available when running the container, providing links to access different tools such as : 

- PHP Info
- Memcached Info
- Memcached Admin
- Solr Admin GUI
- PhpMyAdmin
- Varnish agent

Some virtual hosts are also burned into the image to provide easy access to your project with a dynamic DocumentRoot.

These virtual hosts will allow you to run eZ Publish (5 & Platform), Drupal or Symfony projects (DocumentRoot is /var/www/path_to_your_project_folder/web/).

You can override these virtual hosts by mounting your own virtual hosts (with the same file name) as volume when running the container.

The available virtual hosts file are available [here](https://github.com/kaliop/docker-images/tree/master/build_files/apache/vhosts).

## How to run the container

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)

* Run the container

You can run the container with the docker run command :


	``` sh
    docker run -p 80:80 -p 88:88 -p 82:82 klabs/apache:7.0
    ```
