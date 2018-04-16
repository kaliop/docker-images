FROM klabs/php_cli:7.2
USER root

RUN apt-get update && apt-get install -y \
    php7.2-redis \
    php7.2-apcu

USER site:site
