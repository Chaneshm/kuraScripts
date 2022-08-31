learnerGrades = open('grades.txt', 'r')
f = open('fail.txt', 'w')
p = open('pass.txt', 'w')
for line in learnerGrades:
    line_split = line.split()
    if line_split[2] == 'fail':
        # print(line)
        
        f.write(line)
        
    if line_split[2] == 'pass':
        
        p.write(line)
        

f.close()
p.close()
learnerGrades.close()