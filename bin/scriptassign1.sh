#!/bin/bash 

echo "What address would you like to connect to? (1-10)"
echo -n "192.168.0."
read a
ssh -i private.pem ubuntu@"$(sed -n "$a{p;q}" iplist.txt)"