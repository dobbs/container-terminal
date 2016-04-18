#!/bin/bash

curl -L https://github.com/hashicorp/vault/archive/v0.5.2.tar.gz \
    | tar zxf - -C /src --strip-components=1

source /orig_build_environment.sh
