#!/bin/bash

a=$1
b=$2
if [ $a == $b ]
then
    echo "Safe!"
else
    echo "SOMETHINGS WRONG!"
fi
exit 0