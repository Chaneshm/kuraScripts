#!/bin/bash

echo "Hello, please enter the package which you would like to search."
read option
comparer="$( (apt-cache policy $option) | grep $option | cut -d ":" -f 1 | cut -d " " -f 1)"
if [[ $option == $comparer ]]
then
    echo "The package $option is installed on this computer!"
else
    echo "The package $option is not installed on this computer!"
fi