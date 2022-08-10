#!/bin/bash

# Chanesh Mahadeo
# 8/2/2022
# This script works by first echoing the command output for apt update into a file then 
# runs the command itself in order to update. This should be done under root in the crontab so password is not required.
# Please name this file updatescript.sh
# Please chmod +x updatescript.sh
# Crontab entry :
# 0 23 * * 5 root /home/bin/updatescript.sh



# This line outputs the text of whats being updated to a file aswell as creating it.
echo $(sudo apt update) > /home/update$(date +'%m-%d-%Y').txt
# This line executes the update
sudo apt update
# The below line allows for better readability of the text file by adding a gap between entries.
echo "" >> /home/update$(date +'%m-%d-%Y').txt
# The below line appends the upgrade output to the text file
echo $(sudo apt upgrade -y) >> /home/update$(date +'%m-%d-%Y').txt
# The below line executes the upgrade, aswell as cleaning the system. -y option allows for seamlessness.
sudo apt upgrade -y && sudo apt autoremove && sudo apt autoclean
