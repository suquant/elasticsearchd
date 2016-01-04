FROM alpine:3.2

ENV JAVA_VERSION=7.79.2.5.6-r0 \
    ELASTICSEARCH_VERSION=1.7.4 \
    ES_CLUSTER=elasticsearch \
    ES_HEAP_SIZE=1g \
    ES_MAX_OPEN_FILES=65536 \
    ES_STORE_TYPE=niofs

# install common packages
RUN apk update && \
    apk add curl openjdk7-jre-base=$JAVA_VERSION && \
    curl -sSLO "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz" &&\
    tar -xzf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
    rm -rf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
    mv elasticsearch-${ELASTICSEARCH_VERSION} /elasticsearch && \
    /elasticsearch/bin/plugin -i elasticsearch/marvel/latest

VOLUME ["/data"]

EXPOSE 9200 9300

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
CMD ""