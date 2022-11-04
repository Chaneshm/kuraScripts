#!/bin/bash

# This script is meant to be used as userdata for launching a jenkins ec2 for deployment 2

if [ $UID != 0 ]; then
    echo "Run again with admin permissions"
    exit 1
fi
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | gpg --batch --yes --dearmor -o /usr/share/keyrings/jenkins.gpg
sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && echo "Jenkins Repo Added"
apt-get update
apt-get install default-jre -y && apt-get install jenkins -y && apt-get install python3-pip -y && apt-get install python3.10-venv -y
apt-get install unzip -y
systemctl start jenkins && sleep 5s
usermod -aG sudo jenkins
sudo su jenkins
cd ~
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
pip install awsebcli --upgrade --user
echo "export PATH=~/.local/bin/:$PATH" > .bashrc
source ./.bashrc

eb create

exit 0