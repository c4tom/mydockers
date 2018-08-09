#!/bin/bash

CONTAINER1=""

case $1 in
 start)

  $0 stop

  echo ""
  echo "  Start container $CONTAINER1"
  #sudo docker run -d --name $CONTAINER ...
 
echo ""
  echo "  Start Redmine container"
  sudo docker run -d --name redmine --link mysql_ose:mysql_ose -e REDMINE_DB_MYSQL=mysql_ose -e REDMINE_DB_PASSWORD=redhat123 -p 3000:3000 redmine
  echo ""
  echo "  Wait until redmine be ready (wget required)"
  wget -w 5 --retry-connrefused --tries=60  http://localhost:3000 2> /dev/null

  if [ $? -eq 0 ]
  then
     echo ""
     sudo docker ps 
     echo ""
     echo "  You can now use your browser to accesss: http://localhost:3000"
   else
     echo ""
     echo " ERROR: Timeout waiting for readmine"
   fi

  ;;

 stop)
  echo ""
  echo "  Stopping containers "
  sudo docker stop $CONTAINER1 2> /dev/null
  sudo docker rm $CONTAINER1 2> /dev/null
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
