#!/bin/sh
if [ -z ${HOST_VOL} ]; then
   HOST_VOL=${HOME}
fi

mkdir -p $HOST_VOL/topics/arduino > /dev/null 2>&1

docker run \
    -it \
    --rm \
    --privileged \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev:/dev \
    -v $HOST_VOL/topics:/topics \
    -v $HOST_VOL/topics/arduino:/home/docker/Arduino \
    -v ${HOST_VOL}:/export \
    -e USER=$USER -e USERID=$UID \
    --name arduino \
    tunstall/arduino_esp8266 \
    /bin/bash
