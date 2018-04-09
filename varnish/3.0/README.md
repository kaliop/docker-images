Varnish 3 Docker Image
===================

This image (based on Debian 7) runs Varnish 3.

NB: If you are looking for vmod-curl support, please look at the vmod-curl branch of this repository.

The included vcl is taken from eZ System and augmented with the following abilities:

* Invalidators can force varnish to refresh its cache by hitting Ctrl + F5
* Ability to purge varnish cache matching an url pattern:

```shell
curl -X BAN -I -H "Host: www.example.com" -H "X-Match: /some/.*/regular/expression" http://varnish
```



--------------------------------

* If you are working behind a corporate http proxy, run [the klabs/forgetproxy container](https://registry.hub.docker.com/u/klabs/forgetproxy/)
* Run the container

You can run the container with the docker run command :


  ``` sh
    docker run -p 81:81 klabs/varnish:3.0
   ```
