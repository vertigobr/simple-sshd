#!/bin/sh
ENVBASH=$1
ENVBASH=${ENVBASH:-"zsh"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -ti vertigo/simple-sshd:latest $ENVBASH ${@:2}
