#!/usr/bin/env bash
# "sessionState" by rav3ndust
# this script will run when the user presses the "Session State" button on the panel in nightshadeWM.
#####################
# create some variables for the dialog menus
#####################
: ${SESSIONSTATE_NOTHING=a}
: ${SESSIONSTATE_LOCKSCREEN=b}
: ${SESSIONSTATE_LOGOUT=c}
: ${SESSIONSTATE_SHUTDOWN=d}
#####################
# create a dialog menu to present interactive menus for the user to make a selection. 
#####################
dialog --title "Session State" --backtitle "Session State Menu" \
--radiolist "Hi, $USER! What would you like to do today?" 100 50 100 \
	"a" "Return to the home screen." ON  \
	"b" "Lock the current session." OFF  \
	"c" "Log out of the current session" OFF  \
	"d" "Shut down $HOSTNAME." OFF

#####################
# define some functions
#####################
# This is the function that will run when the "Session State" button is pressed. 
# We want to display a menu to the user allowing them to select what to do next. 
#####################
function sessionStateDialog {		# this function is called when the user clicks the "Session State" button on the panel 
	dialog --title "Session State" --backtitle "Session State Menu" --radiolist "Hi, $USER! What would you like to do today?" 100 50 100 \
	"a" "Return to the home screen." ON \
	"b" "Lock the current session." OFF \
	"c" "Log out of the current session" OFF \
	"d" "Shut down $HOSTNAME." OFF
}
#####################
# these are the functions that will run when individual buttons of the "Session State" menu are selected. 
# the functions call the relevant scripts found in /nightshadeWM/scripts-configs/scripts
#####################
function homeScreenReturn {		# this function will close the Session State menu for the user 
	clear && notify-send "nightshadeWM System Notification" "Session State menu closed."
	exit
}
function lockScreen {          # this function will lock the screen when the "Lock Screen" button is pressed
  cd ~/nightshadeWM/scripts-configs/scripts
  clear && ./locker.sh
}
function logOut {              # this function will log the user out of the session when the button is pressed
  cd ~/nightshadeWM/scripts-configs/scripts
  clear && ./logout.sh
}
function shutDown {            # this function will shut the machine down when the button is pressed
  cd ~/nightshadeWM/scripts-configs/scripts
  clear && ./shutdown.sh
}
#####################
# other misc system functions
#####################
function passwordCheck {
	dialog --title "Password Check" --backtitle "Security Input" --passwordbox 
}
#####################
# run the script, opening the dialog menu when the Session State button is pressed
#####################
sessionStateDialog
#####################
# the rest of the script (after SESSIONSTATE is opened) 
#####################
SESSIONSTATE=?	# take the input from the user 
#####################
# now, act on the user's choice with case
#####################
case $SESSIONSTATE in
	$SESSIONSTATE_NOTHING)		# homeScreenReturn function runs at this selection
		homeScreenReturn;;
	$SESSIONSTATE_LOCKSCREEN)	# lockScreen function runs at this selection
		lockScreen;;
	$SESSIONSTATE_LOGOUT)		# logOut function runs at this selection 
		logOut;;
	$SESSIONSTATE_SHUTDOWN)		# shutDown function runs at this selection
		shutDown;;
esac 
exit 