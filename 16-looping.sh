#!bin/bash
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"


check_root()
{
    if [ $USERID -ne 0 ]
    then
        echo "Please loggin with sudo/root"
        exit 1
    fi   
}

validate_install()
{
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 installation $R failed"
    else
       echo "$2 installation sucessful" 
    fi   
}

check_root

for package in $@
do

dnf list install $package
    if [ $? -ne 0 ]
    then 
       echo "$package is not installed ....will install now"
       dnf install $package -y
       validate_install $?  $package
    else
        echo -e "$package is already $G installed"
    fi
done



