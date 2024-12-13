#!/bin/sh

sudo docker compose up -d

export SHOULD_QUIT=0

function QUIT() {
    echo Bye!
    export SHOULD_QUIT=1
}

trap QUIT SIGINT

while [ $SHOULD_QUIT -eq 0 ]
do
    sudo docker compose attach shell
    sleep 3
done
