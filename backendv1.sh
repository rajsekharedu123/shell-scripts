#!bin/bash
LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

echo "$LOGS_FOLDER"
echo "$SCRIPT_NAME"
echo "$TIMESTAMP"
echo "$LOG_FILE"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then echo "please loggin with root/sudo"
    exit 1
    fi
}
VALIDATE(){
    if [ $1 -ne 0 ]
    then echo -e "$2 $R fail $N" | tee -a $LOG_FILE
    else
    echo -e "$2 $G pass $N" | tee -a $LOG_FILE
    fi
}

CHECK_ROOT
echo -e "$0 $G script started executing $N"

dnf module disable nodejs -y &>>LOG_FILE
VALIDATE $? "disable nodejs" 

dnf module enable nodejs:20 -y
VALIDATE $? "denable nodejs:20"