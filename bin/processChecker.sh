#!/bin/bash
# Chanesh Mahadeo
# 8/11/2022
# This script takes in the users buffer for what memory they want to limit processes to
# It then creates a file and momentarily stores the current processes in order of memory usage
# The script then displays any processes that are at or above the users desired buffer
# The user can then type out the PID of the process they want to eliminate 
# The system will refresh this process every 10 seconds until the user quits out of the script.

# WHAT BREAKS:
# If neither 0,x, or the PID is input when prompted for it will give an error but code will continue
# If a non numerical character is given as the buffer the script considers it as 0
# Room for improvement but I forgot it was due today!

echo "What would you like as your memory buffer 0-100 ?"
# Read user buffer
read buffer

# Just used to sustain loop
refresh=1
while [ $refresh = 1 ]
do
    # create and store the current processes into a readable file ordered most to least usage
    ps -a --format %mem,pid,cmd --sort -%mem | head | tail -n +2 | nl > ~/processbuffer.txt
    echo "P# %MEM PID CMD"
    # for loop to parse through file
    for i in {1..10}
    do
        # grab value of %MEM for each line in the file
        memTemp=$(echo $(sed -n "$i{p;q}" processbuffer.txt) | sed -r 's/^([^.]+).$/\1/; s/^[^0-9]([0-9]+).*$/\1/' | cut -d " " -f 2 | cut -d "." -f 1 )
        # only print if the %MEM is at or ABOVE the buffer
        if [[ $memTemp -ge $buffer ]]
        then
            echo $(sed -n "$i{p;q}" processbuffer.txt)
        fi
    done 
    echo "These processes exceed the buffer, if you wish to terminate"
    echo "Please enter the PID of the process you'd like to kill or "x" to continue monitoring."
    echo "To exit type "0""
    read pNum
    if [[ $pNum -ne 0 ]]
    then
        # destroy process 
        kill $pNum && echo "Process Destroyed."
    fi
    if [ $pNum -eq 0 ]
    then
        echo "Exiting"
        break
    fi
    # refreshes file and prompts user with new list
    echo "System will refresh in 10 seconds"
    sleep 10s
done