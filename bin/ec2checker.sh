#!/bin/bash

# This script checks if the designated Kura ec2 is up and running
# Depending on the ping return value it will connect if up and inform you the ec2 is down 
# if it is
ping -c1 ec2-3-82-96-71.compute-1.amazonaws.com
pingResponse=$?
if [ $pingResponse -eq 0 ];then
    echo "EC2 is up"
    echo "Connecting.."
    ssh -i Cali1.pem ubuntu@3.82.96.71
else
    echo "EC2 is not up"
fi