Solr 4.10 Docker image for eZ Publish
=====================================

This image runs a 4.10 SOLR server with java 7 installed.
  
The SOLR schema & binaries are the ones provided by ezsystems in [ezfind extension](https://github.com/ezsystems/ezfind/tree/master/java).

This image is therefore intended at being used with eZ Publish 4 or 5.

Solr data folder can be mounted from host system in /opt/solr/data to persist data when the container is restarted.

Solr will run on port 8983 but you can change the default port when running the container.

How to run the container
--------------------------------

* If you are working behind a corporate http proxy, run the [klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the basic run Docker command :


	``` sh
    docker run klabs/solr_ezfind
    ```


How to restart solr daemon
--------------------------------

* Enter the container

* Run the solr init.d startup command with restart option :

``` sh
/etc/init.d/solr restart
```