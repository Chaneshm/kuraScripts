#This script is in order to make new groups since we've had the same one since August. 
#Please note that some groups may have less than 5, Ive yet to add a case for this but you can figure it out. :D
import random

with open('kuranamebank.txt', 'r') as file:
    gNum = 1
    groups = [f'Group {gNum}']
    data = file.read().split('\n')
    random.shuffle(data)
    buffer = []
    for count,i in enumerate(data):
        groups.append(i)
        if count % 5 == 0 and count != 0:
            gNum += 1
            groups.append(f'Group {gNum}')
with open('kuragroups.txt', 'w') as file:
    for i in groups:
        file.write("%s\n" % i)
print("Done. Enjoy Tyrone.")