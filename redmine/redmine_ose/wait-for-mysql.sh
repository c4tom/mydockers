#!/bin/bash

ct_netWaitServiceConnectPort() {
    local HOST=$1
    local PORT=$2
    
    while ! nc -w 1 $HOST $PORT 2>/dev/null
    do
        echo -n .
        sleep 1
    done
    echo 'OK'
}

ct_netWaitServiceConnectPort $1 $2