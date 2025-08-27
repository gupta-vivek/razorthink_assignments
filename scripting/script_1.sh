#!/bin/sh
# This is a Shell Script to create a folder with timestamp as folder name and move a file 'test' from /tmp to the newly created folder.

foldername=$(date +%Y%m%d_%H%M%S)
mkdir $foldername
mv /tmp/test ~/Vivek/Scripting/script_1/$foldername