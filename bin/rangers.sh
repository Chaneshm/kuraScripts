#!/bin/bash  

echo "Which one is your favorite power ranger?"
echo "Pink"
echo "Black"
echo "Red"
echo "Blue"

read ranger;

case ${ranger} in
    pink) echo "Sometimes cute";;
    black) echo "Swag level 100";;
    red) echo "Born leader";;
    blue) echo "Is a nerd";;
    *) echo "$ranger is not an OG ranger.";;
esac
exit 0