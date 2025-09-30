#!bin/bash

echo " this is the start of the program "

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Please loggin with the root or root previlages "
    exit 1
fi

dnf list installed git

if [ $? -ne 0 ]
then 
    echo "Git is not installed , will install now"
    dnf install git -y
    if [ $? -ne 0 ]
    then 
        echo "Git is installed , fail"
        exit 1
    else
        echo "Git is installed success "
    fi
else
    echo "Git is already installed "

fi
