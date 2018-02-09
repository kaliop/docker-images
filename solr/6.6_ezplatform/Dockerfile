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
ARG SOLR_ROOT_DIR=/opt/solr
ARG SOLR_CORE_DIR=$SOLR_ROOT_DIR/server/solr/ezplatform
COPY coreconfig.sh /root/
RUN bash /root/coreconfig.sh
COPY ezsolr/ez/ $SOLR_CORE_DIR/
COPY core.properties $SOLR_CORE_DIR/
RUN chown -R solr:solr $SOLR_CORE_DIR

# Install Solr as service
RUN cp $SOLR_ROOT_DIR/bin/init.d/solr /etc/init.d/solr && \
    cp $SOLR_ROOT_DIR/bin/solr.in.sh /etc/default/solr.in.sh && \
    chmod 755 /etc/init.d/solr && \
    chown root:root /etc/init.d/solr && \
    update-rc.d solr defaults && \
    update-rc.d solr enable

COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

CMD ["/root/bootstrap.sh"]
