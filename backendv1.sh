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
echo -e "$0 $G script started executing $N" | tee -a $LOG_FILE

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "disable nodejs" 

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "enable nodejs:20"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "install nodejs"

id expense &>>$LOG_FILE
if [ $? -eq 0 ] 
then echo -e " expense user already present" | tee -a $LOG_FILE
else
echo -e " expense user not present creating now" | tee -a $LOG_FILE
useradd expense &>>$LOG_FILE
VALIDATE $? "useradd expense"
fi


mkdir -p /app &>>$LOG_FILE
VALIDATE $? "creating app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
VALIDATE $? "download software"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "unzip software"
cd /app

npm install
VALIDATE $? "install dependencies software"

cp /home/ec2-user/shell-scripts/backend.service  /etc/systemd/system/backend.service

# load the data before running backend
dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing MySQL Client"

mysql -h mysql.gaws81s.icu -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE
VALIDATE $? "Schema loading"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "Daemon reload"

systemctl enable backend &>>$LOG_FILE
VALIDATE $? "Enabled backend"

systemctl restart backend &>>$LOG_FILE
VALIDATE $? "Restarted Backend"
