FROM klabs/apache:7.2

MAINTAINER Kaliop
LABEL apache.version=2.4 \
      php.version=7.2 \
      description=ezplatform

RUN apt-get update && apt-get install -y \
    php7.2-redis \
    php7.2-apcu
