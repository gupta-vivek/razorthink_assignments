#!/bin/bash
# This is a Shell Script to store all the PID's of running processes in the server to a file.

ps -e > pidi.txt
awk '{ print $1 }' pidi.txt > pid.txt
rm pidi.txt