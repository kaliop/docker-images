# PHP 5.6 CLI Docker image

This is a command-line image that can be used for your projects. All shell commands should be run from here.

Image is built from Debian jessie.

Available software packages are:

* PHP 5.6
* ImageMagick 6.7
* Composer
* GIT
* Curl
* Vim
* Cron
* Mysql client
* JAVA (OpenJDK 7)

The user account you should use to run any operation within the container is: 'site'.

    ``` sh
    docker exec -ti <id of the container> su site
    ```

site user can be mapped to the host user by setting the DEV_UID and DEV_GID environment variables:
 
     ``` sh
      docker run -e DEV_UID=$(id -u) -e DEV_GID=$(id -g) klabs/php_cli:5.6
      ```


Git completion and Git prompt are installed in order to make Git usage easier inside the container.

Some useful bash functions are also added. For more information see [https://github.com/kaliop/docker-images/blob/master/build_files/cli/profile/.bashrc_append](https://github.com/kaliop/docker-images/blob/master/build_files/cli/profile/.bashrc_append) 
 

The default directory is '/var/www/'.

## How to run the container

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the docker run command :


    ``` sh
    docker run klabs/php_cli:5.6
    ```
