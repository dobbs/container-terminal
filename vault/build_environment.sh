#!/bin/bash

TINI_VERSION=v0.9.0
curl -Lo /src/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static\
 && curl -Lo /src/tini.asc https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc-static\
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0527A9B7 \
 && gpg --verify /src/tini.asc \
 && chmod +x /src/tini

curl -L https://github.com/hashicorp/vault/archive/v0.5.2.tar.gz \
    | tar zxf - -C /src --strip-components=1

source /orig_build_environment.sh
