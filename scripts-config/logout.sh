#!/bin/bash
#####
# logout script for i3r3wm

# ask the user for the input
dialog --title "Log Out" --backtitle "r3-wm Logout" --yesno "Are you sure you would like to log off of your computer?" 0 0

# get the exit status. 
# an exit status of 0 indicates a YES answer. 
# an exit status of 1 means the user hit the NO answer. 
# an exit status of 255 indicates the user hit the Esc key. 
userChoice=$?
case $userChoice in 
	0) notify-send "i3r3 Logout" "logging out..." && sleep 5 && logout;;
	1) notify-send "i3r3 Logout" "Not logging out." && exit;;
	255) notify-send "i3r3 Logout" "Logout cancelled by user input" && exit;;
esac