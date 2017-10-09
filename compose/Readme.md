Docker stack docker-compose library
===================================

This folder contains some docker-compose examples that you can copy in your own project as a starting point.

Remember that **you will need to adapt these docker-compose files for them to work and for your project needs**.

Images tags
===============

Images listed in your docker-compose file should always contain a tag (Ex: apache:7.1).

This tag refers to the version of the service that you want to use.

You can find all available tags in the Build Details section of each image on Docker Hub. 

**Always check that you are using the appropriate service version for your project**.


Environment variables
=====================

If a file called '.env' is found in the same directory as your docker-compose.yml file, all variables defined in this .env file can 
be used in your docker-compose.yml.

**THESE VARIABLES WILL NOT BE AUTOMATICALLY PASSED THROUGH TO YOUR CONTAINERS !** 
 
If you want them to be passed to your containers, you will need to include this file (or any other file containing environment variable)
 in the _env_file_ directive.

Persisting data
==============

If you want data created inside your containers to persist, such as mysql databases or solr index for example, you will need to create a volume mounted in the correct destination folder.

Here are the destination folders you can use : 

MYSQL
----

Mount a volume into **/var/lib/mysql/**

SOLR
----

Mount a volume into /**opt/solr/data/**


Networking
=========

Todo (networks, extra_hosts)

