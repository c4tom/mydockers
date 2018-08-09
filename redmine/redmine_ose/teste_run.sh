#!/bin/bash
MYSQL_CONTAINER="mysql_ose"
RM_CONTAINER="redmine"


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

case $1 in
    start)
        
        echo ""
        echo "  Start MySQL container"
        sudo docker run -d --name $MYSQL_CONTAINER \
        -p 3306:3306 \
        -e MYSQL_USER=admin \
        -e MYSQL_PASSWORD=redhat123 \
        -e MYSQL_DATABASE=redmine \
        registry.access.redhat.com/rhscl/mysql-57-rhel7
        
        echo ""
        echo "Wait until mysql be ready"
        ct_netWaitServiceConnectPort localhost 3306
        
        echo ""
        echo "  Start Redmine container"
        sudo docker run -d --name $RM_CONTAINER \
        --link $MYSQL_CONTAINER:$MYSQL_CONTAINER \
        -e REDMINE_DB_DATABASE=redmine \
        -e REDMINE_DB_USERNAME=admin \
        -e REDMINE_DB_MYSQL=$MYSQL_CONTAINER \
        -e REDMINE_DB_PASSWORD=redhat123 \
        -p 3000:3000 redmine
        
        
        echo ""
        echo "Wait until redmine be ready"
        ct_netWaitServiceConnectPort localhost 3000
        
        if [ $? -eq 0 ]
        then
            echo ""
            sudo docker ps
            echo ""
            echo "You can now use your browser to accesss: http://localhost:3000"
        else
            echo ""
            echo "ERROR: Timeout waiting for readmine"
        fi
        
    ;;
    
    stop)
        echo ""
        echo "Stopping mysql & redmine containers "
        sudo docker stop mysql_ose 2> /dev/null
        #sudo docker rm mysql_ose 2> /dev/null
        sudo docker stop redmine 2> /dev/null
        #sudo docker rm redmine 2> /dev/null
    ;;
    
    status)
        sudo docker ps
    ;;
    
    restart)
        $0 stop
        $0 start
    ;;
    
    *)
        echo ""
        echo "Script for testing Docker redmine containers from the command line"
        echo "  Usage: $0 [ start | stop | status | restart ]"
        echo ""
    ;;
    
esac