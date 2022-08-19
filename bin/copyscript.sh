#!/bin/bash

# Added pull before push to keep things in working order.

cp -r /home/chanesh/bin /home/chanesh/kuraScripts/

cd /home/chanesh/kuraScripts/

git add .
git commit -m "update bin repo"
git pull
git push
echo "Done."