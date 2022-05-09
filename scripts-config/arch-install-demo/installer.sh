#!/bin/bash
# installer.sh -> for wiredWM
# This is the installer script for wiredWM.
# Assumes an Arch Linux environment.
# Important info for config files:
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
# - polybar config lives at ~/.config/polybar/config.ini
###############################
# Some notes on the packages we need to download on installation:
# - we use *sddm* for login manager.
# - we have *fish* as a secondary shell with highlighting and autocomplete.
# - we use *flameshot* for taking screenshots.
# - we use *nm-applet* for handling networks - i3 ships with this.
# - we use *nitrogen* for handling wallpaper selection and restoring with GUI.
# - we use *feh* for handling wallpapers through CLI.
# - we use *arandr* for graphical display management.
# - we use *polybar* for handling status bar.
# - we use *kitty* and *alacritty* for lightweight terminals.
#	- users can set their favorite terminal in the i3 config file.
# - we have custom scripts built on top of surf browser called "nightsurf"
# - we also have a custom conky, so we need the *conky* package.
# - we use *vim* and *micro* for text editing in the terminal.
# - we use *code* for GUI text editing.
# - we use *rofi* for a simple run launcher.
# - we use *picom* for handling display compositing.
# - we use *nnn* as a terminal file browser.
# - we use *nemo* as a graphical file browser.
# - we also include *chromium* and *nightsurf* for web browsing.
# - we include *amfora* for browsing the Gemini network.
# - we have *xautolock* that runs *i3lock* after 10 mins of system inactivity.
# - we have *polkit-dumb-agent* for handling granting elevated user privs.
###############################
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
POLYBAR_WIRED_CONFIG="$HOME/wiredWM/scripts-config/polybar-config/config.ini"
POLYBAR_CONFIG_LOCATION="$HOME/.config/polybar/config.ini"
DEF_WP_LOCATION="$HOME/wiredWM/wp/lain2.jpg"
CONFIGS="$HOME/wiredWM/scripts-config/configs"
################################
function makeFolders() {
	sudo mkdir /etc/i3 && sudo touch /etc/i3/config
	sudo mkdir $HOME/.config/i3 && sudo touch $HOME/.config/i3/config
	sudo touch /etc/i3status.conf
	sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
	sudo mkdir $HOME/.config/dunst && sudo touch $HOME/.config/dunst/dunstrc
	sudo mkdir /etc/conky && sudo touch /etc/conky/conky.conf
	sudo mkdir $HOME/.config/polybar && sudo touch $HOME/.config/polybar/config.ini
}
function sleepy() {		# this function sleeps sys 1 sec
	sleep 1
}
function updater() {		# this function updates repositories
	sudo pacman -Syu
}
function i3_install() {		# this function installs vanilla i3
	sudo pacman -S i3-wm
}
function wired_packs() {	# this function intalls the needed deps for wiredWM
	sudo pacman -S git nitrogen arandr fish xautolock flameshot alacritty micro dunst amfora kitty feh code network-manager-applet conky vim sddm nnn picom chromium nemo
}
function enable_AUR() {		# builds yay for using the AUR
	echo "Enabling the Arch User Repository (AUR)..."
	echo "Cloning the 'yay' repository from https://aur.archlinux.org/yay.git..."
	git clone https://aur.archlinux.org/yay.git
	echo "Yay downloaded. Building..."
	cd yay && makepkg -si
	echo "Yay AUR helper built."
}
function polybar_rofi_inst() {	# builds polybar and rofi
	cd
	echo "Downloading and building polybar..."
	yay -S polybar
	echo "polybar finished."
	sleepy
	echo "Downloading and building rofi..."
	yay -S rofi
	echo "rofi finished."
}
function polkit-dumb-install() { # builds polkit-dumb-agent
	echo "Installing polkit agent for superuser priveleges..."
	yay -S polkit-dumb-agent
	echo "Polkit agent installed."
}
function nightsurf_apply() {	# builds nightsurf
	echo "Building nightsurf browser..."
	mkdir -p $HOME/nightsurf && touch $HOME/nightsurf/nightsurf.sh
	echo "#!/bin/bash" >> $HOME/nightsurf/nightsurf.sh
	# clone our build of surf
	cd ~/nightsurf && git clone https://github.com/rav3ndust/nightsurf
	cd nightsurf && sudo make install
	echo "tabbed -u red -U purple -t black -T red surf -e" >> $HOME/nightsurf/nightsurf.sh
	yay -S tabbed	# add tab support
	chmod +x $HOME/nightsurf/nightsurf.sh	# make the file executable.
	sudo cp $HOME/nightsurf/nightsurf.sh /usr/bin/nightsurf
	echo "Nightsurf built. Invoke at any time by calling 'nightsurf'."
}
# script begins here
# update system first and install needed wiredWM packages.
echo "Preparing your wiredWM install..."
sleepy
echo "Updating the repositories..."
updater
sleepy
# download Yay AUR Helper and build it.
enable_AUR
sleepy
# install wiredWM repo and needed packages.
# we also want to grab i3lock-fancy-git from AUR (for WM lockscreen)
echo "Downloading needed packages for wiredWM..."
wired_packs
sleepy
echo "WiredWM packages installed."
echo "Downloading i3lock-fancy from AUR..."
yay -S i3lock-fancy-git
echo "Lockscreen downloaded. Moving on..."
# install vanilla i3 and its components.
echo "Downloading i3 and its components. Please be patient."
i3_install
sleepy
# download and install polybar and rofi from AUR.
polybar_rofi_inst
sleepy
# build the nightsurf browser.
nightsurf_apply
sleepy
# download polkit-dumb-agent from AUR for elevated privs when needed.
polkit-dumb-install
sleepy
# make needed directories and files
echo "Creating folders for config files..."
makeFolders
sleepy
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
sudo mkdir ~/.config/dunst && sudo touch ~/.config/dunst/dunstrc
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_1
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_2
echo "dunstrc copied." && sleepy
# apply the vimrc to ~/.vimrc
echo "Copying vim configs..."
sudo cp -f $WIRED_VIM_CONFIG $VIM_CONFIG
echo "Vim configs copied. You can change it at ~/.vimrc."
# apply the polybar config to ~/.config/polybar/config.ini
echo "Copying polybar configs..."
sudo cp -f $POLYBAR_WIRED_CONFIG $POLYBAR_CONFIG_LOCATION
echo "Polybar config copied. Edit it anytime at ~/.config/polybar/config.ini."
# set the default background image.
# we are going to use wp/nExt.png.
echo "Setting default wallpaper..." && sleepy
feh --bg-scale $DEF_WP_LOCATION
echo "Wallpaper saved. To change it, simply launch Nitrogen and choose whatever you would like." && sleepy
# all done
echo "wiredWM has been installed." && sleepy
echo "In order to log into it, please log out of your current X Session and log into 'i3', which you can now find in your desktop environment list in your login manager." && sleepy
notify-send "wiredWM installer" "wiredWM has been installed."
sleepy && exit
