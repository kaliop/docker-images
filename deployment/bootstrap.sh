#!/bin/bash

echo [`date`] Bootstrapping the deployment container...

function clean_up {
    # Perform program exit housekeeping
    echo [`date`] Stopping the service
    service ssh stop
}

# /root/.ssh/authorized_keys_fromhost file must be mounted as volume from host
echo [`date`] Adding host ssh keys to /root/.ssh/authorized_keys

if [ -f /root/.ssh/authorized_keys_fromhost ]; then cat /root/.ssh/authorized_keys_fromhost >> /root/.ssh/authorized_keys; fi

echo [`date`] Starting SSHD

trap clean_up SIGTERM

service ssh start

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"
