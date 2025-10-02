#!bin/bash
USERID=$(id -u)
check_root


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
    if [ $1 -ne 0]
    then 
        echo "$2 installation failed"
    else
       echo "$2 installation sucessful" 
}


for package in $@
do

dnf list install $package
    if [ $? -ne 0 ]
    then 
       echo "$package is not installed ....will install now"
       dnf install $package -y
       validate_install $?  $package
    else
        echo "$package is already installed"

done



