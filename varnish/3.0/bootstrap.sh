#!/bin/bash

echo "Bootstraping Varnish 3.. "

service varnish start

service varnishncsa start

tail -f /dev/null

