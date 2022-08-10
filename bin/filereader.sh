#!/bin/bash


option=1
function check () {
echo "Which of the following files would you like to spell check."
echo ls *.txt
read input;
if [[ !(-f "$input")]]
then
    echo "File does not exist, please choose one from the list."
    sleep 1s
    check
fi

aspell -c $input
echo "Spell check done!, would you like to test another file? 1=Yes 2=No"
read option
case $option in
    1) check;;
esac

}
check
echo "Have a nice day!"
exit 0