FROM alpine:edge
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN apk update && apk upgrade &&\
    apk add curl openjdk7-jre-base &&\
    curl -sSLO "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz" &&\
    tar -xzf elasticsearch-1.7.5.tar.gz &&\
    rm -rf elasticsearch-1.7.5.tar.gz &&\
    mv elasticsearch-1.7.5 /elasticsearch &&\
    /elasticsearch/bin/plugin -i elasticsearch/marvel/latest &&\
    rm -rf /var/cache/apk/*

ENV ES_CLUSTER=elasticsearch ES_HEAP_SIZE=1g \
    ES_MAX_OPEN_FILES=65536 ES_STORE_TYPE=niofs

VOLUME ["/data"]

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
CMD ""

EXPOSE 9200 9300