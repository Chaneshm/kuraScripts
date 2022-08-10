#!/bin/bash

x=1
i=7
touch kura_emails.csv
while [ $i -lt 12 ] 
do
    echo "$(sed -n "$x{p;q}" kura_labs.txt),$(sed -n "$i{p;q}" kura_labs.txt)" >> kura_emails.csv
    x=$(( $x + 1 ));i=$(( $i + 1 ));
done
exit 0