#!/bin/sh

echo [`date`] Bootstrapping the CLI container ...

function clean_up {
    # Perform program exit housekeeping
    echo [`date`] Stopping the container...
    exit
}

trap clean_up SIGTERM

# UID/GID map to unknown user/group, $HOME=/ (the default when no home directory is defined)

echo [`date`] Fixing filesystem permissions...
eval $( fixuid )

# Temporary fix for /home/site/.ssh/ folder not being chowned by fixuid if volumes are mounted in /home/site/
# See fixuid issue : https://github.com/boxboat/fixuid/issues/2
sudo chown site:site /home/site/.ssh/

# UID/GID now match user/group, $HOME has been set to user's home directory

# Composer config
if [ "$GITHUB_OAUTH" ]; then
	echo Bootstraping composer github config
	echo '{ "config": { "github-oauth": { "github.com": "'$GITHUB_OAUTH'" } } }' > /home/site/.composer/config.json
fi

if [ "$COMPOSER_HTTP_AUTH_DOMAIN" ] && [ "$COMPOSER_HTTP_AUTH_LOGIN" ] && [ "$COMPOSER_HTTP_AUTH_PASSWORD" ]; then
	echo Bootstraping composer http-basic auth config
	echo '{ "http-basic": { "'$COMPOSER_HTTP_AUTH_DOMAIN'": { "username": "'$COMPOSER_HTTP_AUTH_LOGIN'", "password": "'$COMPOSER_HTTP_AUTH_PASSWORD'" } } }' > /home/site/.composer/auth.json
fi

if [ -d /tmp/cron.d ]; then
	echo [`date`] Installing crontabs...
	for user in `ls /tmp/cron.d`; do
	    sudo crontab -u "$user" "/tmp/cron.d/$user"
	done

	sudo cron
fi

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"