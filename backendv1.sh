#!bin/bash
LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/LOG_SCRIPT_NAME-TIMESTAMP.log"


echo "$LOGS_FOLDER"
echo "$SCRIPT_NAME"
echo "$TIMESTAMP"
echo "$LOG_FILE"

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then echo "please loggin with root/sudo"
    exit 1
    fi
}
VALIDATE(){
    if [ $1 -ne 0 ]
    then echo "$2 fail"
    else
    echo "$2 pass" 
    fi
}

CHECK_ROOT

dnf module disable nodejs -y
VALIDATE $? "disable nodejs"

#dnf module enable nodejs:20 -y
#VALIDATE $? "denable nodejs:20"