#!/bin/bash
# This is a shell script to accept two filenames as arguments. First file will be having the username and the second file will be having the passwords for it.
# If the number of usernames doesn't match with number of passwords it will not create any users, if it matches it will create user with corresponding password.

userLineCount=$(cat $1 | wc -l )
passwordLineCount=$(cat $2 | wc -l )

if [ "$userLineCount" -eq "$passwordLineCount" ];
then
	while read -r -u 4 username && read -r -u 5 password; do
  		sudo useradd $username
		sudo echo -e "$password\n$password" | passwd $username
	done 4<$1 5<$2
else
	printf "The count of users and passwords do not match!"
fi
