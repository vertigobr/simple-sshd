#!/bin/sh
BASEREPO="192.168.1.4/repos"
EPELREPO="http://192.168.1.4/repos/epel/7/x86_64"
docker build \
    --build-arg="BASEREPO=$BASEREPO" \
    --build-arg="EPELREPO=$EPELREPO" \
    -t vertigo/docker-base .
