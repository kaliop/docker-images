Haproxy Docker image
===================

Haproxy 1.5 image to be used for Symfony based applications, using Varnish for http cache. 

Custom haproxy config will allow you to:

- Access container with hostname 'web' on port 80 [default] using a request header named "Backend" and the value "front"
- Access container with hostname 'varnish' (port 81) using a request header named "Backend" and the value "varnish" 
- Access container with hostname 'web' on port 82 (demo Symfony environment) using a request header named "Backend" and the value "demo" 
- Access Solr Admin GUI in container with hostname 'solr' using "/solr" url

Exposed ports are 80, 443, 8000.


How to run the container
--------------------------------

* If you are working behind a corporate http proxy, run the [klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the docker run command :


  ``` sh
    docker run -p 80:80 -p 443:443 klabs/haproxy
    ```