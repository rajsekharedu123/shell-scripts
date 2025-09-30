#!bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo " pls login with root user "
    exit 1

fi
dnf list installed git
if [ $? -ne 0 ]
then 
    echo "git is not installed , installing now"
else
    echo " git is installed "
fi

 