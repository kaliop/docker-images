# Apache/php 5.4 web server

Apache web server image to run your PHP project.

Image is built on Debian Wheezy.

Available software packages installed are:

* Apache 2.2
* PHP 5.4
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

The available virtual host files are listed [here](https://github.com/kaliop/docker-images/tree/master/build_files/apache/vhosts).



## How to run the container

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)

* Run the container

You can run the container with the docker run command :


   ``` sh
    docker run -p 80:80 -p 88:88 -p 82:82 klabs/apache:5.6
   ```

## How to add a new Virtual Host

You can add new virtual hosts by adding it as volume in /etc/apache2/sites-available folder.

**The new virtual hosts filename MUST START WITH '0' !** 

Ex : 

   ``` sh
    docker run -p 80:80 -p 88:88 -p 82:82 -v "005-myvhost.conf:/etc/apache2/sites-available/005-myvhost.conf" klabs/apache:5.6
   ```

## How to override php.ini settings

You can override php.ini settings provided in the image by mounting your own php.ini file in /etc/php5/apache2/conf.d/

**Your php.ini filename must start with a number greater than 20 followed by '-' !**

Ex : 

   ``` sh
    docker run -p 80:80 -p 88:88 -p 82:82 -v "21-my_custom_php_conf.ini:/etc/php5/apache2/conf.d/21-my_custom_php_conf.ini" klabs/apache:5.6
   ```
   
## How to execute additional script at startup

You can run an additional script during container startup.

In order to do so, you have to mount your own startup script (must be executable) in /run/startup.sh

Ex : 

   ``` sh
    docker run -p 80:80 -p 88:88 -p 82:82 -v "startup.sh:/run/startup.sh" klabs/apache:5.6
   ```
   
