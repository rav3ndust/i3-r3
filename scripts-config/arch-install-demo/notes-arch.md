# NightshadeOS install notes

Things we need to build on top of Arch: 

- arandr (display management); 
- i3-wm, i3status, i3lock, i3blocks (window management); ~ 
- nitrogen (GUI wallpaper management); 
- feh (TUI wallpaper management);
- sddm (login manager);
- flameshot (screenshot util); 
- volumeicon (systray audio management); 
- dmenu (menu management); 
- conky (displaying certain system info on desktop); ~
- dunst (for displaying notifications); ~
- kitty (terminal emulator); 
- vim (TUI text editing); ~
- code (GUI text editing);
- micro (TUI text editing); 
- fish (terminal with autocomplete); 
- rofi (potential dmenu replacement); 

> Items denoted with "~" means that I have custom configs for most of these items. 
>
> We need to make sure that the configs are correctly applied in installation script.

## Other notes: 

We also need to change the installation scripts to be Arch-centric. 

Right now, they are more Debian/Ubuntu-centric.

## Update the installer!

Since we decided to build a minimal system on top of Arch for nightshadeOS, we need to make sure to update the installer. The goal would be to have archinstall grab the configs and apply them after the base Arch installation is ran. On bootup, we have a fresh instance of "nightshadeOS" with the wiredWM. 

## The commands: 

From base Arch install after installation is complete: 

```sh
mkdir -p nightshadeOS-components/wired
git clone https://github.com/rav3ndust/wiredWM
echo "Copying
