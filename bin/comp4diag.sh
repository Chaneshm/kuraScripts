#!/bin/bash



#You need to be a superuser to run the script!!
if [ $UID != 0 ]; 
 then
	echo "You need to be a superuser"
        exit 1
fi
echo "We will now create your user. Please enter your full name: First Last"
read name
echo "Please enter your Shell of choice."
read usrshell
echo "Please enter your Group"
read usrgroup
echo "Enter your Password"
read -s usrpassword
usrname="$(echo "$(echo $name | cut -b 1)$(echo $name | cut -d " " -f 2)")"
groupadd $usrgroup
useradd -g $usrgroup -s $usrshell $usrname
echo $usrname:$usrpassword | chpasswd