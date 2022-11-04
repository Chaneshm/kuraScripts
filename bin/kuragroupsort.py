#This script is in order to make new groups since we've had the same one since August. 
#You will need a bank of the roster in a file names kuranamebank.txt
#You will also need to create an empty kuragroups.txt
#Both of these files must be within the same working directory as this script.
#Please note that some groups may have less than 5, Ive yet to add a case for this but you can figure it out. :D
import random

with open('kuranamebank.txt', 'r') as file:
    gNum = 1
    groups = [f'Group {gNum}']
    data = file.read().split('\n')
    random.shuffle(data)
    buffer = []
    for count,i in enumerate(data):
        
        if len(groups) % 6 == 0:
            gNum += 1
            groups.append(f'Group {gNum}')
        groups.append(i)
            
            
with open('kuragroups.txt', 'w') as file:
    for i in groups:
        file.write("%s\n" % i)
print("Done. Enjoy Tyrone.")