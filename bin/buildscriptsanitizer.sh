#!/bin/bash

#Sanitizer for build script 3

# note that phone number scan must be ran before Social Security scan to elimate possibility of having 
# faulty masking.

echo "Please enter your file name and extension youd like to sanitize"
read file
filler="x"


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


# # finds social security numbers
# # sanitizer=$(grep -i -o '[0-9]\{3\}-\{0,1\}[0-9]\{2\}-\{0,1\}[0-9]\{4\}' $file)
# sed -i "s/$sanitizer/$filler/g" $file
# # finds emails
# sanitizer=$(grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' $file)
# sed "s/$sanitizer/$filler/g" $file
# # finds phone numbers
# sanitizer=$(grep -i -o '\(([0-9]\{3\})\|[0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' $file)
# sed "s/$sanitizer/$filler/g" $file