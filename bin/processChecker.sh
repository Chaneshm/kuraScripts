#!/bin/bash



echo "What would you like as your memory buffer?"
read buffer
ps --format %mem,pid,cmd --sort -%mem | head | tail -n +2 | nl

# sed -n "$a{p;q}"
