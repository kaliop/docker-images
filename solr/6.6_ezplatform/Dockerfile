FROM solr:6.6

MAINTAINER Kaliop
LABEL solr.version=6.6

ENV DEBIAN_FRONTEND noninteractive

ARG DOCKER_TIMEZONE=Europe/Paris

USER root

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Create a new core for eZPlatform : see https://doc.ezplatform.com/en/2.0/guide/search/#solr-bundle
ARG SOLR_CORE_DIR=/opt/solr/server/solr/ezplatform
COPY coreconfig.sh /root/
RUN bash /root/coreconfig.sh
COPY ezsolr/ez/ $SOLR_CORE_DIR/
COPY core.properties $SOLR_CORE_DIR/
RUN chown -R solr:solr $SOLR_CORE_DIR

USER $SOLR_USER

CMD ["solr-foreground"]
