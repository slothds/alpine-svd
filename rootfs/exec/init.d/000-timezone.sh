#!/bin/bash

if [ ! -f /etc/timezone ];then
    if [ ! -f /etc/localtime ];then
        cp cp /usr/share/zoneinfo/UTC /etc/localtime
    fi
    echo 'UTC' > /etc/timezone
fi

if [ -n ${TZ} -a "$(cat /etc/timezone)" != ${TZ} ];then
    if [ -f /usr/share/zoneinfo/${TZ} ];then
        cp /usr/share/zoneinfo/${TZ} /etc/localtime
        echo "${TZ}" > /etc/timezone
    else
        echo "WARNING: ${TZ} is wrong time zone."
    fi
fi
