#!/bin/bash
# installer.sh -> for wiredWM
# This is the installer script for wiredWM. 
# Important info for config files: 
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
###############################
# Some notes on the packages we need to download on installation: 
# - we use *flameshot* for taking screenshots.
# - we use *nm-applet* for handling networks - i3 ships with this.
# - we use *nitrogen* for handling wallpaper selection and restoring.
# - we use *arandr* for graphical display management.
# - we use *volumeicon-alsa* for a GUI-friendly way of volume management.
# - we use *kitty* and *stterm* for lightweight terminals.
#	- note that stterm will be better for older machines.
#	- users can set their favorite terminal in the i3 config file.
# - we have custom scripts built on top of surf browser called "nightsurf"
# - we also have a custom conky, so we need the *conky* package.
# - we use *vim* for text editing.
# - *suckless-tools* is a collection of small software tools from the Suckless community.
###############################
i3_CONFIG_1_LOCATION="/etc/i3/config"
i3_CONFIG_2_LOCATION="~/.config/i3/config"
WIRED_i3_CONFIG="wiredWM/scripts-config/configs/i3-config"
i3STATUS_LOCATION="/etc/i3status.conf"
WIRED_i3STATUS_CONFIG="wiredWM/scripts-config/configs/i3status-config"
CONKY_CONFIG_LOCATION="etc/conky/conky.conf"
WIRED_CONKY_CONFIG="wiredWM/scripts-config/configs/conky.conf"
DUNSTRC_CONFIG_LOCATION_1="/etc/dunst/dunstrc"
DUNSTRC_CONFIG_LOCATION_2="~/.config/dunst/dunstrc"
WIRED_DUNSTRC="wiredWM/scripts-config/configs/dunstrc" 
VIM_CONFIG="~/.vimrc"
WIRED_VIM_CONFIG="~/wiredWM/scripts-config/configs/vimrc"
i3_INSTALL=$(sudo apt install i3 i3lock-fancy -y)
UPDATER=$(sudo apt update)
WIRED_PACKS=$(sudo apt install nitrogen arandr volumeicon-alsa flameshot kitty stterm surf conky suckless-tools vim -y) 
DEF_WP_LOCATION="~/wiredWM/wp/nExt.png"
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
# change dirs to /wiredWM/scripts-config/configs and begin applying configs to needed places.
cd ~/wiredWM/scripts-config/configs
# apply the i3-config file to /etc/i3/config and ~/.config/i3/config
echo "Copying wiredWM configuration files..."
sleepy
echo "Copying i3-config..."
sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_1_LOCATION
sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_2_LOCATION
echo "Done! If needed, you can edit your configuration files at ~/.config/i3/config anytime." 
sleepy
# apply the i3status-config file to /etc/i3status.conf
echo "Copying i3status-config..."
sudo cp -f $WIRED_i3STATUS_CONFIG $i3STATUS_LOCATION
sleepy
echo "i3status-config copied." && sleepy
echo "You can edit it anytime at /etc/i3status.conf" && sleepy
# apply the conky config to /etc/conky/conky.conf
echo "Copying conky.conf..."
sudo cp -f $WIRED_CONKY_CONFIG $CONKY_CONFIG_LOCATION
sleepy
echo "conky.conf copied." && sleepy
echo "You can edit conky at /etc/conky/conky.conf anytime." && sleepy 
# apply the dunstrc to /etc/dunst/dunstrc and ~/config.dunst/dunstrc
echo "Copying dunstrc..."
sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
sudo mkdir ~/.config/dunst && sudo touch ~/config/dunst/dunstrc
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_1
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_2
echo "dunstrc copied." && sleepy
# apply the vimrc to ~/.vimrc
echo "Copying vim configs..."
sudo cp -f $WIRED_VIM_CONFIG $VIM_CONFIG
echo "Vim configs copied. You can change it at ~/.vimrc."
# set the default background image.
# we are going to use wp/nExt.png.
echo "Setting default wallpaper..." && sleepy 
nitrogen --set-auto --save $DEF_WP_LOCATION
echo "Wallpaper saved. To change it, simply launch Nitrogen and choose whatever you would like." && sleepy 
# all done 
echo "wiredWM has been installed." && sleepy 
echo "In order to log into it, please log out of your current X Session and log into 'i3', which you can now find in your desktop environment list in your login manager." && sleepy 
notify-send "wiredWM installer" "wiredWM has been installed." 
sleepy && exit 
