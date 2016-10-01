#!/bin/sh

consul-template \
    -once \
    -consul consul:8500 \
    -template "/etc/dnsmasq.ctmpl:/etc/dnsmasq.conf"

mkdir -p /etc/dnsmasq.d
