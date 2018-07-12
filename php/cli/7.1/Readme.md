# PHP 7.1 CLI Docker image

This is a command-line image that can be used for your projects. All shell commands should be run from here.

Image is built from Debian Stretch.

Available software packages are:

* PHP 7.1
* ImageMagick 6.7
* Composer
* GIT
* Curl
* Vim
* Cron
* Mysql client
* JAVA (OpenJDK 7)
* Nodejs 

Git completion and Git prompt are installed in order to make Git usage easier inside the container.

Some useful bash functions are also added. For more information see [https://github.com/kaliop/docker-images/blob/master/build_files/cli/profile/.bashrc_append](https://github.com/kaliop/docker-images/blob/master/build_files/cli/profile/.bashrc_append) 

The default directory is '/var/www/'.

## How to run the container

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the docker run command :


   ``` sh
        docker run klabs/php_cli:7.1
   ```
    
    
## How to map host user with container 'site' user

The default user used to run the container is the site user, created with uid 1000 and gid 1000.

In order to map your local host user with the site user, you have to run the container with the user parameter, 
and the value of your host user id.

Example : 

   ``` sh
        docker run --user=$(id -u):$(id -g) klabs/php_cli:7.1
   ```

The site user uid and gid will then be replaced when container starts with your host user uid and gid.

All files with owner id 1000 will also be chowned.

If you use docker-compose to run this image, you can use a .env file containing your host user uid and gid in environment variables, 
and use these variables in the user directive of your docker-compose file.

As site is the default user in the container, you just have to run bash to enter the container as site.

Example : 

   ``` sh
        docker exec -ti cli bash
   ```

Exemple : 

   ``` sh
        #env file
        DEV_UID=1001
        DEV_GID=1001
      
        #docker-compose.yml
        user: ${DEV_UID:-1000}:${DEV_GID:-1000}
   ```

## How to use your host ssh agent into the container

In order to use ssh inside the container, it is recommended to mount your host's ssh agent file into the container.

Your host SSH agent socket path is already defined in the SSH_AUTH_SOCK environment variable.

You therefore need to mount this socket as a volume into the container, 
and then define the SSH_AUTH_SOCK environment variable inside the container with the value of the destination path :     
 

   ``` sh
       docker run --user=$(id -u):$(id -g) -v "${SSH_AUTH_SOCK}:/ssh-agent:ro" -e "SSH_AUTH_SOCK=/ssh-agent" klabs/php_cli:7.1
   ```
   
To check that your host ssh-agent has been correctly mounted into the container, enter the container and type: 

   ``` sh
       ssh-add -l
         
       #You should see something like :
       2048 eb:f5:ff:5b:bb:64:2f:8d:66:5e:c1:6d:75:74:e5:4c user@workstation (RSA)

   ```

