#!/bin/sh

echo [`date`] Bootstrapping the Web server...

function clean_up {
    # Perform program exit housekeeping
    echo [`date`] Stopping the service...
    service apache2 stop
    exit
}

# Fix UID & GID for user 'site'
echo [`date`] Fixing filesystem permissions...

ORIGPASSWD=$(cat /etc/passwd | grep site)
ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
ORIG_HOME=$(echo "$ORIGPASSWD" | cut -f6 -d:)
DEV_UID=${DEV_UID:=$ORIG_UID}
DEV_GID=${DEV_GID:=$ORIG_GID}

if [ "$DEV_UID" -ne "$ORIG_UID" ] || [ "$DEV_GID" -ne "$ORIG_GID" ]; then

    # note: we allow non-unique user and group ids...
    groupmod -o -g "$DEV_GID" site
    usermod -o -u "$DEV_UID" -g "$DEV_GID" site

    chown "${DEV_UID}":"${DEV_GID}" "${ORIG_HOME}"
    chown -R "${DEV_UID}":"${DEV_GID}" "${ORIG_HOME}"/.*

fi

chown -R site:site /var/lock/apache2

echo [`date`] Starting the service

# Enable all Virtual Hosts with a name starting with '0' found in /etc/apache2/sites-available/
VHOST_FILES=/etc/apache2/sites-available/0*
for f in $VHOST_FILES
do
	VHOST=`basename $f`
  a2ensite -q $VHOST
done

# Allow other script to be executed at run
if [ -x "/run/startup.sh" ];then
    echo "Executing startup script /run/startup.sh ..."
    /run/startup.sh
fi

trap clean_up SIGTERM

service apache2 restart


echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"