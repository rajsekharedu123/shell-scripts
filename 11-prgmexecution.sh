#!bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo " pls execute the script with root user "
    exit 1
else
    echo " user logged in a root user" 
fi

echo "prgm continue"