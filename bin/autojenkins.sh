#!/bin/bash

if [ $UID != 0 ]; then
    echo "Run again with admin permissions"
    exit 1
fi
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | gpg --batch --yes --dearmor -o /usr/share/keyrings/jenkins.gpg && echo "Jenkins Keyring Added"
sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && echo "Jenkins Repo Added"
apt-get update
#Install java, Jenkins, pip and venv in that order
apt-get install default-jre -y && echo "Installed Java Runtime Engine" && apt-get install jenkins -y && echo "Installed Jenkins" && apt-get install python3-pip -y && echo "Installed Python pip" && apt-get install python3.10-venv -y && echo "Installed Python venv"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
#Start the Jenkins service
systemctl start jenkins && echo "Jenkins Started"
#successful
echo "Installation successful"
exit 0
