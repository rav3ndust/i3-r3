#!/bin/bash
#####
# logout script for nightshadeWM

# ask the user for the input
dialog --title "Log Out" --backtitle "nightshadeWM Logout" --yesno "Hi, $USER! Are you sure you would like to log off of your computer?" 0 0

# define functions
#######################
# this function runs when the user selects YES on the dialog box
function yesLogout {
	notify-send "nightshadeWM Logout" "logging out in 5 seconds..."
	sleep 5 
	loginctl kill-user $USER;;
}
# this function runs when the user clicks NO on the dialog box
function noLogout {
	notify-send "nightshadeWM Logout" "Not logging out."
	exit;;
}
# this function runs if the user hits the esc key or cancels in another way
function escSeq {
	notify-send "nightshadeWM Logout" "Logout cancelled by user input"
	exit;;
}
# get the exit status. 
# an exit status of 0 indicates a YES answer. 
# an exit status of 1 means the user hit the NO answer. 
# an exit status of 255 indicates the user hit the Esc key. 
userChoice=$?
case $userChoice in 
	0) yesLogout
	1) noLogout
	255) escSeq
esac
