#!/bin/bash
#####
# logout script for nightshadeWM
#####
# define functions
#######################
# we need to make a function that is called when the user clicks on nsLauncher. 
# alertBox will ask the user whether or not they are sure they want to logout. 
function alertBox {
	dialog --title "Log Out" --backtitle "nightshadeWM Logout" --yesno "Hi, $USER! Are you sure you would like to log off of your computer?" 0 0
}
# this function runs when the user selects YES on the dialog box
# i3exit script runs after 5 secs 
function yesLogout {
	notify-send "nightshadeWM Logout" "logging out in 5 seconds..."
	sleep 5 
	i3-msg exit   
}
# this function runs when the user clicks NO on the dialog box
function noLogout {
	notify-send "nightshadeWM Logout" "Not logging out."
	exit
}
# this function runs if the user hits the esc key or cancels in another way
function escSeq {
	notify-send "nightshadeWM Logout" "Logout cancelled by user input"
	exit
}
#####
# now we run the script. call alertBox to confirm the logout 
alertBox 
# get the exit status. 
# an exit status of 0 indicates a YES answer. 
# an exit status of 1 means the user hit the NO answer. 
# an exit status of 255 indicates the user hit the Esc key. 
userChoice=$?
case $userChoice in 
	0) yesLogout;;
	1) noLogout;;
	255) escSeq;;
esac
