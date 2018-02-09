#!/bin/sh

echo [`date`] Bootstrapping Solr 6.6...

# Make sure data dir is writable by solr user
chown -R solr:solr /opt/solr/server/solr/ezplatform/data

echo [`date`] Starting the service

service solr start

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"