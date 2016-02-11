FROM alpine:edge
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN apk update && apk upgrade &&\
    apk add curl openjdk7-jre-base=$JAVA_VERSION &&\
    curl -sSLO "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz" &&\
    tar -xzf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz &&\
    rm -rf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz &&\
    mv elasticsearch-${ELASTICSEARCH_VERSION} /elasticsearch &&\
    /elasticsearch/bin/plugin -i elasticsearch/marvel/latest &&\
    rm -rf /var/cache/apk/*

ENV JAVA_VERSION=7.91.2.6.3-r1 \
    ELASTICSEARCH_VERSION=1.7.5 \
    ES_CLUSTER=elasticsearch \
    ES_HEAP_SIZE=1g \
    ES_MAX_OPEN_FILES=65536 \
    ES_STORE_TYPE=niofs

VOLUME ["/data"]

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
CMD ""

EXPOSE 9200 9300