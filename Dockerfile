FROM alpine:3.8

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update

ENV FILEBEAT_VERSION=6.8.2

RUN apk add --no-cache -t .build-deps wget \
  && apk add --no-cache libc6-compat \
  && wget -q -O /tmp/filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
  && cd /tmp \
  && tar xzvf filebeat.tar.gz \
  && cd filebeat-* \
  && cp filebeat /bin \
  && mkdir -p /etc/filebeat \
  && cp filebeat.yml /etc/filebeat/filebeat.example.yml \
  && rm -rf /tmp/filebeat* \
  && apk del --purge .build-deps

