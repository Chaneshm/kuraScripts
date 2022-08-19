#!/bin/bash

# This script is to test my abilities with networking. 
# It works first by creating a file with the name of user input, then copying it to a Kura EC2
# It then remotely runs the command find $fileName and depending on the return signal 
# tells you if it exists or not.
echo "Please enter the filename you would like to use"
read fileName

touch $fileName.txt && echo "File created"
scp -i Cali1.pem "$fileName.txt" ubuntu@ec2-3-82-96-71.compute-1.amazonaws.com:~/Chanesh && echo "File Moved to EC2"
echo "Attempting to scan directory"
ssh -i Cali1.pem -t ubuntu@3.82.96.71 "find ~/Chanesh/$fileName.txt"
response=$?
if [ $response -eq 0 ];then
    echo "File Exists on EC2"
else
    echo "File Does not exist on EC2"
fi