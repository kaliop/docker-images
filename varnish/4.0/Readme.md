Varnish 4 Docker image
=====================

This image runs Varnish 4.0.3 on port 81.

Image is base on Debian Jessie.
  
varnishncsa and varnish-agent (port 6082) are also installed.

varnish-agent credentials are: varnish/CacheMeIfYouCan.


How to run the container
--------------------------------

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the docker run command :


  ``` sh
    docker run -p 81:81 klabs/varnish:4.0
   ```

