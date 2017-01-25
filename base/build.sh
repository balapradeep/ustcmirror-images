#!/bin/bash

set -e
tag='ustcmirror/base:debian'

cat << EOF > Dockerfile
FROM debian:jessie-slim
MAINTAINER Jian Zeng <anonymousknight96 AT gmail.com>
RUN echo 'Asia/Shanghai' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ADD ["entry.sh", "savelog", "/usr/local/bin/"]
EOF

docker build -t "$tag" .
docker push "$tag"

########################################

tag='ustcmirror/base:alpine'

cat << EOF > Dockerfile
FROM alpine:3.5
MAINTAINER Jian Zeng <anonymousknight96 AT gmail.com>
RUN apk update && apk add --update bash tzdata && rm -rf /var/cache/apk/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ADD ["entry.sh", "savelog", "/usr/local/bin/"]
EOF

docker build -t "$tag" .
docker push "$tag"

rm Dockerfile
