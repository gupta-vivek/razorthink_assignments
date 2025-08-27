#!/bin/bash
# This is a Shell Script to accept a filename and path(dir path) as command line argument and find whether the file is present in the
# given path. If it is present , it will delete the file otherwise it will archive the given directory.

if [ -f $2/$1 ];
then
   rm $2/$1
   printf "\nFile exists and has been removed."
else
   printf "\nFile $1 does not exist.\nMade an archive of the directory\n"
   tar -cPf $1.tar $2
fi
