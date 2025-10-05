#!bin/bash
LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then echo "please loggin with root/use sudo" | tee -a &>>$LOG_FILE
    exit 1
    fi
}
VALIDATE(){
    if [ $1 -ne 0 ]
    then echo -e "$2 $R FAILED $N" | tee -a $LOG_FILE
    else
         echo -e "$2 $G PASS $N"  | tee -a $LOG_FILE
    fi      
}

echo "$0 script started exceuting "
CHECK_ROOT

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "installation of mysql-server" 

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "enabled mysql is "

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "started mysql is "

mysql -h mysql.gaws81s.icu -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE
if [ $? -ne 0 ]
then echo "password not set...setting now"
mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "set-root-pass is "
else
echo "password already set..."
fi
