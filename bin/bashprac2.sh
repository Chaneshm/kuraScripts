#!/bin/bash


echo "Please enter a number"

read n

output=""
for (( i=1; i<=$n; i++ ))
do
    seq -s " " $i
done
