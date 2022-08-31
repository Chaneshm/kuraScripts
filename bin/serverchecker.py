import os

# Please note this script assumes both the key and file are within the current working directory.

hostname = "3.83.101.158"
response = os.system("ping -c 1 " + hostname)

if response == 0:
    print("EC2 up and running")
    filename = input("Enter the name including extension of the file you would like to send")
    r = os.system("scp -i Cali1.pem "+ filename + " ubuntu@ec2-3-83-101-158.compute-1.amazonaws.com:~/Chanesh")
    if r == 0:
        print("Successfully sent file to EC2, now sshing..")
        os.system("ssh -i Cali1.pem ubuntu@3.83.101.158")
else:
    print("EC2 not online")