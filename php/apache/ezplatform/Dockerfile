FROM klabs/apache:7.2

MAINTAINER Kaliop
LABEL apache.version=2.4 \
      php.version=7.2 \
      description=ezplatform

RUN apt-get update && apt-get install -y \
    php7.2-redis \
    php7.2-apcu

# Custom PHP variables
RUN curl -L -o /etc/php/7.2/cli/conf.d/custom_vars.ini https://raw.githubusercontent.com/kaliop/docker-images/master/build_files/php/custom_vars_ezplatform.ini && \
    cp /etc/php/7.2/cli/conf.d/custom_vars.ini /etc/php/7.2/apache2/conf.d/custom_vars.ini
