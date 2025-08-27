#!/bin/bash

# Write a script to give me a list of all files in a directory hierarchy sorted by size. This implies that you should give me just the file names, and not the 
# complete path, for all files in the specified directory as well as the sub­directories underneath. If there are any files with size zero, ask the user whether 
# to delete those files (giving relative path name for the file, relative to current directory), and delete them if the user says yes. The script should allow 
# for directories to be specified as command line parameters, and use the current directory as default if no directory is specified on the command line.  
# Check if any of the file name ends with '<Terminating_String>', rename the file by removing <Terminating_String>. if the file­name is '<Terminating_String>' 
# rename it to 'razorthink_<WORKING_DIRECTORY>'.  
# Example: if scriptname is 'cleandir', usage should be 'cleandir <Directory_To_Be_Listed> <Terminating_String>'

# To check if terminating string is provided as a command line argument.
if [ -z "$2" ]
  then
    ter="noTerminatingString"
else
    ter=$2
fi
echo "Terminating String = $ter"

# Renaming string
dir_pwd=$(pwd)
re="razorthink$dir_pwd"
re=$(echo "$re" | sed -e s@\/@-@g)
echo "Renaming String = $re"

# To check if directory is given as a command line argument.
if [ -z "$1" ]
  then
    dir=$(pwd)
    echo "Path = $dir"
else
    dir="$1"
    echo "Path = $dir"
fi

# To list all the files in a directory as well as subdirectory sorted by size and store it in a file 'filelist.txt'.
ls -RSlr "$dir"| grep ^- | tr -s ' ' | cut -d ' ' -f 9 > filelist.txt

# Loop to go through folders recursively.
print_folder_recurse() {
    
    for i in "$1"/*;do
        
        if [ -d "$i" ];then
            print_folder_recurse "$i"
        
        elif [ -f "$i" ]; then
            fileSize=$(wc -l "$i" | cut -d' ' -f1)
            completeFileName=$(echo "$i"| rev | cut -d'/' -f1 | rev)
            
            # To check if file size is zero and delete the file, if the user says 'yes'.
            if [ "$fileSize" = "0" ];then
                echo "File Path: $i"
                echo -e "The size of the file $completeFileName is zero.\nEnter \"yes\" to remove the file:"
                read response
                
                if [ "$response" = "yes" ];then
                    echo "File Removed!"
                    rm $i
                fi
            fi

            # To rename if the file name is <terminating_string>.
            if [[ "$completeFileName" = "$ter" ]]; then
                echo "$completeFileName - File found with terminating character and has been renamed."
                movePath=$(echo $i | sed -e "s@$ter@$re@")
                mv "$i" "$movePath"

            # To rename if the file name is ending with <terminating_string>.    
            elif [[ "$completeFileName" =~ "$ter"$ ]]; then 
                echo "$completeFileName - File found with terminating character and has been renamed."
                movePath=$(echo $i | sed -e "s@$ter@ @")
                mv "$i" "$movePath"
            fi
        fi
    done
}

print_folder_recurse $dir