#!/bin/bash 

# buildscript3.sh
# sudo buildscript3.sh
# Chanesh Mahadeo 8/18/2022
# This script is designed for two specfic functions. One is create a user and add them to the GitAcc group
# The other, and more impressive part of this script is its function to fully automate a github add commit and push
# The commit section works by first asking for user input for the user that the script will run under.
# The script then checks with the /etc/passwd database to check if the user exists on this computer.
# Then, if the user chooses to make a commit it asks for a working github directory. This can be absolute path or relative.
# The script will then ask what the user wants to commit. This can be either a file or folder.
# The logic will decipher whether it is a file or folder and then send it to the right function.
# The script then determine whether or not the file or folder contains sensitive information.
# If it doesnt not then it goes right to adding commiting and pushing.
# If the file is a folder it will parse the ENTIRE tree down from where it is adding, meaning if you want to commit a folder
# and there is more folders within, it will parse through all contents.
# If it detects a file, it will just parse the input file.
# Once cleaned, the file or folder is added, commited with the aformentioned comment, and then pushed to github.
# The git log shows that the inputed users info was the one who made the commit if you want to verify that it ran under
# a certain users permissions. 

# I apologize if this is a bit overkill and hard to read.

# improvement I want to make in the future is instead of one x I replace it with the same length of x's
# honestly I could have just wrote a function for it but I got lazy.


#You need to be a superuser to run the script!!
#Due to the nature of account creation you must be superuser
if [ $UID != 0 ]; 
then
    echo "You need to be a superuser"
    exit 1
fi

echo "Welcome to My build script!"
sleep 0.5s
echo "Are you here to add user or make a commit?"
echo "1. Add User"
echo "2. Make a commit"
read option
if [[ $option -eq 1 ]]
then
    # Allows the user to create a local user and adds it to the GitAcc group
    
    echo "We will now create your user. Please enter your full name: First Last"
    read name
    echo "Please enter your Shell of choice."
    read usrshell
    echo "Enter your Password"
    read -s usrpassword
    usrname="$(echo "$(echo $name | cut -b 1)$(echo $name | cut -d " " -f 2)")"
    useradd -g GitAcc -s $usrshell $usrname
    echo $usrname:$usrpassword | chpasswd
else
    # Section for making the commit
    echo "Alright, to get your commit started, What is the name of your user?"
    read usrname
    grep -q $usrname /etc/passwd
    buffer=$?
    if [ $buffer -eq 0 ]
    then
        echo "User Found, lets move the to next steps"
        sleep 0.5s
    else
        echo "Couldnt find the user $usrname."
        sleep 0.5s
        echo "Please make sure you typed the name in correctly."
        exit 1
    fi
    echo ""
    echo "Its time to make a commit. Are you ready? y/n"
    read option
    filler="x"
    case ${option,,} in
        y) echo "Please specify the location of the directory you'd like to make the commit"
           read directory
           cd $directory
           echo "Now please type the name of the file or folder including extension that you would like to commit"
           echo "If youd like to commit the whole directory, just type '.'"
           read file
           echo "Please enter your commit message"
           read message
           sleep 0.5s
           echo "First we must make sure this file or directory doesnt contain anything important"
           if [ -d $file ] ; then
            echo "$file is a directory";
            x=0
            while [ x=0 ]
            do
                # Used to scan directory and any folders within recursively to find any sensitive info
                git grep -rq -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file || git grep -rq -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file || git grep -rq -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file
                buffer=$?
                if [[ buffer -eq 0 ]]
                then
                    echo "Found sensitive information in this folder"
                    echo "Would you like to data mask all files? y/n"
                    read option
                    case ${option,,} in 
                        y)  # This entire section is the logic for recursively searching the entire file tree
                            # Please note that there is arithmatic used here which requires the phone number
                            # search to be done before the Social Security search
                            # phone numbers
                            iterator=$(git grep -ir -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file | wc -l)
                            for (( i=1; i<=$iterator; i++ )) 
                            do
                                
                                sanitizer=$(git grep -ir -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file | cut -d':' -f2 | head -n $i | tail -1)
                                cd $file
                                git grep -l $sanitizer | xargs sed -i "s/$sanitizer/x/g"
                                cd $directory
                            done

                            # Social security
                            iterator=$(git grep -ir -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file | wc -l)
                            for (( i=1; i<=$iterator; i++ )) 
                            do
                                
                                sanitizer=$(git grep -ir -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file | cut -d':' -f2 | head -n $i | tail -1)
                                cd $file
                                git grep -l $sanitizer | xargs sed -i "s/$sanitizer/x/g"
                                cd $directory
                            done

                            # emails
                            iterator=$(git grep -ir -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file | wc -l)
                            for (( i=1; i<=$iterator; i++ )) 
                            do
                                
                                sanitizer=$(git grep -ir -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file | cut -d':' -f2 | head -n $i | tail -1)
                                cd $file
                                git grep -l $sanitizer | xargs sed -i "s/$sanitizer/x/g"
                                cd $directory
                            done
                        echo "Done cleaning folder"
                        cd ..
                        sleep 1s
                        break
                        ;;
                        n) echo "Please handle the sensitive information before commiting!"
                        exit 1
                        ;;
                    esac


                else
                    echo "Folder is safe to push"
                    break
                fi
            done
           else
                if [ -f $file ]; then
                    echo "$file is a file";
                    # scans file for any sensitive information
                    grep -q -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file || grep -q -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file || grep -q -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file
                    buffer=$?
                    if [[ buffer -eq 0 ]]
                    then
                        echo "Found sensitive information in this folder"
                        echo "Would you like to datamask? y/n "
                        read option
                        case ${option,,} in
                            y)  # functions to datamask the file
                                # phone numbers
                                iterator=$(grep -i -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file | wc -l)
                                for (( i=1; i<=$iterator; i++ )) 
                                do
                                    sanitizer=$(grep -i -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file | head -n $i | tail -1)
                                    sed -i "s/$sanitizer/$filler/g" $file
                                done

                                # Social security
                                iterator=$(grep -i -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file | wc -l)
                                for (( i=1; i<=$iterator; i++ )) 
                                do
                                    sanitizer=$(grep -i -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file | head -n $i | tail -1)
                                    
                                    sed -i "s/$sanitizer/$filler/g" $file
                                done

                                # emails
                                iterator=$(grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file | wc -l)
                                for (( i=1; i<=$iterator; i++ )) 
                                do
                                    sanitizer=$(grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file | head -n $i | tail -1)
                                    
                                    sed -i "s/$sanitizer/$filler/g" $file
                                done
                            echo "File cleaned"
                            ;;
                            n) echo "Please handle the sensitive material before commiting!"
                                exit 1
                            ;;
                        esac
                    else
                        echo "File is safe to push"
                        sleep 1s
                        break
                    fi
                else
                    echo "$file is not valid";
                    exit 1
                fi
            fi
           echo "Alright, lets attempt to make your commit"
           cd $directory
           su -c "git add $file" $usrname
           buffer=$?
           if [[ $buffer -eq 0 ]]
           then
                echo "Git add successfull. Attempting commit..."
                sleep 0.5s
                su -c "git commit -m "$message"" $usrname
                buffer=$?
                if [[ $buffer -eq 0 ]]
                then
                    echo "Commit successful!"
                    sleep 1s
                    echo "Attempting push..."
                    su -c "git push" $usrname
                    buffer=$?
                    if [[ $buffer -eq 0 ]]
                    then
                        echo "Successful push. Have a nice day!"
                        sleep 1s
                        exit 0

                    else
                        echo "Something went wrong. Please handle the error."
                        exit 1
                    fi
                else
                    echo "ERROR: Something went wrong. OR: Nothing to commit"
                    exit 1

                fi
           else
                echo "ERROR: Something went wrong. Please make sure you entered your info properly."
                sleep 1s
                exit 1
           fi
        ;;
        n) echo "Come back when you are ready!"
        exit 0
        ;;
        *) echo "INVALID OPTION: Please select y/n"
        exit 1
        ;;
    esac
fi
