#!bin/bash
echo " to print all the varables passed to the script are $@"
echo " the num of var pass to script are $# "
echo " the name of the current script is $0" 
echo " current working directory is $PWD "
echo " current user home directory is $HOME "
echo " PID is of the current script is $$ "
sleep 100 &
echo " PID is of the current script is $! "