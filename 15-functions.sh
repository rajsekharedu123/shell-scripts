#!bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "pls loggin with sudo"
    exit 1
fi    

vlaidate()
{ 
    if [ $1 -ne 0 ]
    then 
        echo " $2  cmd failed "
    else
        echo " $2  cmd sucess " 
}

dnf list installed git

vlaidate $? git-check 

dnf install git -y

vlaidate $? git-installation 

