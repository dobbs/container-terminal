#!/bin/sh

name=$1
drill @$(hostname) $name | grep -A1 'ANSWER SECTION:' | grep -q $name
