# PHP 5.6 Base Docker image

This is the base PHP image used as parent image for apache & cli images, built from Debian Jessie

This image can be used as base image for images in Dockerfiles needing php.

Example from Apache_php56 Dockerfile: 


    FROM klabs/php56
    LABEL apache.version=2.4