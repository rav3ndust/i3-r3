#!/bin/bash
#set -euo pipefail
########################################################
# installer.sh -> for wiredWM
#	- by @rav3ndust (https://github.com/rav3ndust.xyz)
#	( NOTE: This version of the script is for Debian-based installations.)
# This is the installer script for wiredWM. 
# Important info for config files: 
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
########################################################
# Some notes on the packages we need to download on installation: 
# - we use *flameshot* for taking screenshots.
# - we use *nm-applet* for handling networks - i3 ships with this.
# - we use *blueman* for handling bluetooth connections. 
#	- *blueman-applet* is the applet for interfacing with connections.
# - we use *nitrogen* for handling wallpaper selection and restoring with GUI.
# - we use *feh* for handling wallpapers through CLI.
# - we use *arandr* for graphical display management.
# - we use *volumeicon* for a GUI-friendly way of volume management.
# - we use *kitty* and *stterm* for lightweight terminals.
#	- note that stterm will be better for older machines.
#	- users can set their favorite terminal in the i3 config file.
# - we have custom scripts built on top of surf browser called "nightsurf"
# - we also have a custom conky, so we need the *conky* package.
# - we use *vim* for text editing.
# - *suckless-tools* is a collection of small software tools from the Suckless community.
# - we use *lxpolkit* for user authentication when elevated system privs are needed.
# - we use *lxappearance* for handling things like cursor selection and other graphical tweaks.
# - we use *nnn* for terminal file management. 
# - we use *cmus* for playing audio in the terminal. 
# - we use *mpv* for handling multimedia files.
# - we use *xscreensaver* for handling screensaver functionality and auto-locking.
# - we use *xss-lock* for an additional screen locking utility to run i3lock-fancy.
# - we use *meteo-qt* for displaying weather info in the i3bar.
# - we also add *calcurse* for tracking appointments and `TODO`s in the terminal.
# - - - - - - - - - - - - - - - 
# wayland-specific stuff
# - we are using, of course, sway to base all of our wired configs on
# - *swaybg* handles what nitrogen normally would, backgrounds/wallpapers
# - *waybar*, heavily configured, handles our status bar needs
# - *grimshot* and *flameshot* are both here
# - *xdg-desktop-portal-wlr* handles wlroots desktop portals
# - we have our wrapper around *swaylock* called *nslock* which is a custom lockscreen
# - we include *wf-recorder* for recording the screen
########################################################
i3_CONFIG_1_LOCATION="/etc/i3/config"
i3_CONFIG_2_LOCATION="$HOME/.config/i3/config"
WIRED_i3_CONFIG="$HOME/wiredWM/scripts-config/configs/i3-config"
i3STATUS_LOCATION="/etc/i3status.conf"
WIRED_i3STATUS_CONFIG="$HOME/wiredWM/scripts-config/configs/i3status-config"
CONKY_CONFIG_LOCATION="/etc/conky/conky.conf"
WIRED_CONKY_CONFIG="$HOME/wiredWM/scripts-config/configs/conky.conf"
DUNSTRC_CONFIG_LOCATION_1="/etc/dunst/dunstrc"
DUNSTRC_CONFIG_LOCATION_2="$HOME/.config/dunst/dunstrc"
WIRED_DUNSTRC="$HOME/wiredWM/scripts-config/configs/dunstrc" 
VIM_CONFIG="$HOME/.vimrc"
WIRED_VIM_CONFIG="$HOME/wiredWM/scripts-config/configs/vimrc" 
DEF_WP_LOCATION="$HOME/wiredWM/wp/lain3wp.jpg"
########################################################
# - - - Functions - - - 
########################################################
makeFolders () {
	# this function handles wm config
	echo "Creating folders for config files..."
	sleep 1
	sudo mkdir /etc/i3 && sudo touch /etc/i3/config
	sudo mkdir $HOME/.config/i3 && sudo touch $HOME/.config/i3/config
	sudo touch /etc/i3status.conf
	sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
	sudo mkdir $HOME/.config/dunst && sudo touch $HOME/.config/dunst/dunstrc
	sudo mkdir /etc/conky && sudo touch /etc/conky/conky.conf
}
install_wired_pkgs () {	
	# this function updates and intalls the needed deps for wiredWM
	sudo apt-get update
	sudo apt-get install -y i3 i3lock-fancy nitrogen pulseaudio-utils xterm calcurse arandr rofi xss-lock feh volumeicon-alsa polybar blueman dunst flameshot meteo-qt pasystray ffmpeg kitty stterm surf conky suckless-tools lxpolkit lxappearance vim nnn cmus xscreensaver amfora sway swaylock swaybg grimshot xdg-desktop-portal-wlr qt5-ct waybar wf-recorder
} 
apply_configs () {
	# this function applies the configs for: 
	#	- i3
	#	- i3status
	#	- conky
	#	- dunst
	#	- vim
	# apply the i3-config file to /etc/i3/config and ~/.config/i3/config
	echo "Copying wiredWM configuration files..."
	sleep 1
	echo "Copying i3-config..."
	sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_1_LOCATION
	sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_2_LOCATION
	echo "Done! If needed, you can edit your configuration files at ~/.config/i3/config anytime." 
	sleep 1
	# apply the i3status-config file to /etc/i3status.conf
	echo "Copying i3status-config..."
	sudo cp -f $WIRED_i3STATUS_CONFIG $i3STATUS_LOCATION
	sleep 1
	echo "i3status-config copied." && sleep 1
	echo "You can edit it anytime at /etc/i3status.conf" && sleep 1
	# apply the conky config to /etc/conky/conky.conf
	echo "Copying conky.conf..."
	sudo cp -f $WIRED_CONKY_CONFIG $CONKY_CONFIG_LOCATION
	sleep 1
	echo "conky.conf copied." && sleep 1
	echo "You can edit conky at /etc/conky/conky.conf anytime." && sleep 1
	# apply the dunstrc to /etc/dunst/dunstrc and ~/.config/dunst/dunstrc
	echo "Copying dunstrc..."
	sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
	sudo mkdir ~/.config/dunst && sudo touch ~/.config/dunst/dunstrc
	sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_1
	sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_2
	echo "dunstrc copied." && sleep 1
	# apply the vimrc to ~/.vimrc
	echo "Copying vim configs..."
	sudo cp -f $WIRED_VIM_CONFIG $VIM_CONFIG
	echo "Vim configs copied. You can change it at ~/.vimrc."
	sleep 1 
 	apply_nslock() {
  		# applies the nslock script to /usr/bin. is only used on wayland.
		local nslock_script="$HOME/wiredWM/scripts-config/locker-scripts/nslock.sh"
  		local nslock_exec_location="/usr/bin/nslock"
    		echo "Applying nslock to $nslock_exec_location..."; sleep 1 
  		chmod +x $nslock_script; sudo cp $nslock_script $nslock_exec_location
    		echo "Done."; sleep 1
  	}
   	apply_nslock
}
wp_set () {
	# this function uses nitrogen to set the default wallpaper.
	# we are going to use wp/lainwp3.png.
	echo "Setting default wallpaper..." && sleep 1
	nitrogen --set-scaled $DEF_WP_LOCATION
	echo "Wallpaper saved. To change it, simply launch Nitrogen and choose whatever you would like." 
	sleep 1 
}
override_fp () {
	# when running flatpak applications, some apps don't respect user appearance settings. 
 	# we noticed an issue with cursors being consistent on certain apps, such as firefox. 
  	# this function runs flatpak override commands to make the appearance more consistent.
   	local location_1="/home/$USER/.icons/"
    	local location_2="/usr/share/icons/"
     	echo "Overriding Flatpak appearance settings..." && sleep 1
     	flatpak --user override --filesystem=$location_1:ro
      	flatpak --user override --filesystem=$location_2:ro
        echo "Flatpak overrides finished." && sleep 1
}
main () {
	# 'main' function
	# update system and install needed wiredWM packages.
	echo "Updating repositories and preparing for installation..."
	sleep 1
	install_wired_pkgs		
	makeFolders				
	apply_configs	
 	override_fp
	wp_set					
	# x x x x x x x x x x x x x x x x x x 
	# - - - finish up
	echo "wiredWM has been installed." && sleep 1
	echo "In order to log into it, please log out of your current X Session and log into 'i3', which you can now find in your desktop environment list in your login manager." && sleep 1
	notify-send "wiredWM installer" "wiredWM has been installed." 
	sleep 3 && exit 
}
########################################################
# Script Entry Point
########################################################
main
# TODO more testing on a few new installations.
