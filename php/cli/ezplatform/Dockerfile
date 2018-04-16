FROM klabs/php_cli:7.2
USER root

RUN apt-get update && apt-get install -y \
    php7.2-redis \
    php7.2-apcu

# Custom PHP variables
RUN curl -L -o /etc/php/7.2/cli/conf.d/custom_vars.ini https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/php/custom_vars_ezplatform.ini && \
    cp /etc/php/7.2/cli/conf.d/custom_vars.ini /etc/php/7.2/apache2/conf.d/custom_vars.ini
    
USER site:site
