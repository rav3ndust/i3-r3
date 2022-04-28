#!/bin/bash
# This is the installer script for wiredWM. 
# Important info for config files: 
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
###############################
i3_CONFIG_1_LOCATION="/etc/i3/config"
i3_CONFIG_2_LOCATION="~/.config/i3/config"
WIRED_i3_CONFIG="wiredWM/scripts-config/configs/i3-config"
i3STATUS_LOCATION="/etc/i3status.conf"
WIRED_i3STATUS_CONFIG="wiredWM/scripts-config/configs/i3status-config"
CONKY_CONFIG_LOCATION="etc/conky/conky.conf"
WIRED_CONKY_CONFIG="wiredWM/scripts-config/configs/conky.conf"
DUNSTRC_CONFIG=""
WIRED_DUNSTRC="wiredWM/scripts-config/configs/dunstrc" 
i3_INSTALL=$(sudo apt install i3 i3lock-fancy -y)
WIREDWM_CLONE=$(git clone https://github.com/rav3ndust/wiredWM)
UPDATER=$(sudo apt update)
WIRED_PACKS=$(sudo apt install nitrogen arandr volumeicon-alsa flameshot kitty stterm surf conky)
################################
function sleepy() {	# this function sleeps sys 1 sec
	sleep 1
}
# script begins here
# update system first and install needed wiredWM packages.
echo "Preparing your wiredWM install..."
sleepy
echo "Updating the repositories..."
$UPDATER
sleepy
echo "Downloading needed packages for wiredWM..."
$WIRED_PACKS
sleepy
# install vanilla i3 and its components.
echo "Downloading i3 and its components. Please be patient."
$i3_INSTALL
sleepy
# grab wiredWM from the repository. 
echo "Downloading wiredWM configurations..."
$WIREDWM_CLONE
