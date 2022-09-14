if [ $UID != 0 ]; then
    echo "Run again with admin permissions"
    exit 1
fi
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | gpg --batch --yes --dearmor -o /usr/share/keyrings/jenkins.gpg && echo "Jenkins Keyring Added"
sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && echo "Jenkins Repo Added"
apt-get update
#Install java, Jenkins, pip and venv in that order
apt-get install default-jre -y && echo "Installed Java Runtime Engine" && apt-get install jenkins -y && echo "Installed Jenkins" && apt-get install python3-pip -y && echo "Installed Python pip" && apt-get install python3.10-venv -y && echo "Installed Python venv"
#Start the Jenkins service
systemctl start jenkins && echo "Jenkins Started"
#successful
echo "Installation successful"
exit 0