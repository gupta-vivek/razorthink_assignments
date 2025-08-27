#/bin/bash

# Script takes filename as argument. The file given as argument would contain absolute path of files/folders in current system to be backed up. 
# Create folder in current working directory with name YYYY­mm­dd­HH­mm­ss and create copy of all folders and files with ownership, timestamp, permissions 
# and full path information in created folder.  
# For example if argument is backup.txt and backup.txt contains:  
# /etc/hosts
# /var/lib/mysql   
# then create folder 2015­09­27­18­52­41 and create sub­folder /etc and sub­tree /var/lib/mysql inside folder 2015-­09-­27-­18-­52-­41. Then copy file /etc/hosts and complete
# contents of folder /var/lib/mysql to newly created /etc/hosts and /var/lib/mysql folders. This is all assuming user tried to run script file for backup at 
# 06:52:41pm on 27th September,2015. Archive all folders whose backup date is less than 06:52:41pm on 27th September,2015. Execute this shell script as cron job.

foldername=$(date +%Y%m%d%H%M%S)
# count variable is just used for naming the backup file.
count=1
mkdir $foldername
offset=10

while read -r -u 4 path; do
	cd $foldername
	tar cvpfz backup-"$count".gz $path
	tar xpvzf backup-"$count".gz
	
	modificationDate=$(stat -c '%y' "$path" | cut -d' ' -f1)
	echo "Modification Date = $modificationDate"
	
	# if modification date is older than 10 days, archive is created.
	difference=$(/usr/bin/dateutils.ddiff $modificationDate today)
	if [ $difference -lt $offset ];then
    	rm backup-"$count".gz
    fi

done 4<$1