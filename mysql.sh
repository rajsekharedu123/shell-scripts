#!bin/bash
LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME/$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then echo "please loggin with root/use sudo"
    exit 1
    fi
}
VALIDATE(){
    if [ $1 -ne 0 ]
    then echo -e "$R $2 FAILED $N"
    else
         echo -e "$G $2 PASS $N"  
    fi      
}

echo "$0 script started exceuting "
CHECK_ROOT

dnf install mysql-server -y
VALIDATE $? "installation of mysql-server"
