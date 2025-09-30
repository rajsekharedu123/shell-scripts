#!bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo " pls loggin with sudo "
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "mysql is not installed ....installing now"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then 
    echo "mysql is installed fail"
    else
        echo "mysql is sucess"
    fi
else
echo "mysql is already installed ....installing now" 
fi   