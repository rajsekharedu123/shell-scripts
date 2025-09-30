#!bin/bash
USID=$(id -u)

if [ $USID -ne 0 ]
then 
    echo " user is not a root user "
fi
