# wired window manager
=====

### Welcome to the Wired

**wiredWM** is rav3ndust's personal fork of i3, which is a tiling window manager for X11. There is also work ongoing to bring the configs over to Sway, for Wayland.

![image](https://github.com/rav3ndust/wiredWM/assets/35274771/606fd9ee-4924-4d64-96f0-1de99bf3de87)

###### let's all love lain

=====

## minimal and lightweight 

![image](https://github.com/rav3ndust/wiredWM/assets/35274771/a1229952-062f-4f6e-8eb9-02e08712c081)


###### minimal desktop and keyboard-driven for quick efficiency. clickable icons are located at the right side of the status bar for common tasks - for those unfortunate occasions where you have to reach for the mouse

Easy to use and easily extensible. Takes up very little of precious system resources, and gives you a minimal but efficient keyboard-driven environment, so you can focus less on messing around with bells and whistles found on prominent desktop environments and focus more on the task at hand. It *is* a tiling window manager, and these sorts of WMs are well-loved for how efficient and extensible they can be. 

**Clickable launchers for:**

- Screenshot utility (handles via `flameshot`.)
- Network/Wi-Fi manager (handles via `nm-applet`.)
- Volume Control (handles via `volumeicon`) 
- Weather (handles via `meteo-qt`)
- Bluetooth Manager (handles via `blueman`)
  
=====

## more resources for your stuff

![image](https://github.com/rav3ndust/wiredWM/assets/35274771/1100995d-363f-45e6-8b45-a4f084d983d7)

###### browse the web and run all of your favorite applications in a minimal environment 

Just open up the **nightshade launcher** by pressing *crtl+d* - that launches a custom **dmenu** script, and you can search for and launch your applications with ease. Think of it as your miniature Start panel.

For a general list of applications, you can also press *ctrl+Shift+a* and scroll through to select one. Anything that has a desktop entry will appear here. 

=====

## organize your windows with ease

![image](https://github.com/rav3ndust/wiredWM/assets/35274771/40b3d828-78a1-4af7-be99-089c440a3b57)

###### automate the organization of the windows on your screen

A bunch of floating windows can become difficult to manage in the middle of a workflow - which is another reason a tiling window manager can really come in handy. Being built on top of the much-loved **i3**, **wiredWM** allows you to easily tile or float your windows with a quick keyboard shortcut. 

=====

### custom stuff

**wiredWM** also contains: 

- custom **dmenu** and **rofi** configurations for running commands and launching applications.
- status bar giving you your connectivity stats, battery life, time and date, and handy applets for common utilities
- my own custom scripts built on top of [suckless's](https://suckless.org) **surf** browser.
- a custom **conky** config.
- custom keyboard shortcuts for some of the scripts we've built in.
- display compositing via **picom**.
- ...various other assorted things!

### handy quickstart!

Here are some of the common **keyboard shortcuts** to keep in mind when starting out: 

> Please note, the *Meta* key is also known as the *Windows* key!

- **Meta+Enter**: Open a terminal.
- **Meta+d**: Open `dmenu` to run a command.
- **Meta+Shift+A**: Open Application List to launch an app. Reads from `.desktop` files.
- **Meta+Shift+D**: Open `rofi` run launcher to filter open windows and run commands.
- **Meta+Shift+Q**: Close the focused window.
- **Meta+W**: Switch to **tabbed** windowing.
- **Meta+S**: Switch to **stacked** windowing.
- **Meta+E**: Switch to **tiled** windowing.
- **Meta+Shift+R**: Restart the window manager in-place.
- **Meta+Shift+Z**: Lock your screen. We use `i3lock-fancy` for this.
- **Meta+Shift+N**: Pops out your recent notifications.
- **Meta+Shift+E**: Log out of the session. 

### more 

For more information about i3, please see [the project's website](https://i3wm.org/) and [online documentation](https://i3wm.org/docs/). We'll be updating docs for wiredWM soon. 

You're of course more than free to contribute to my fork, but if you want to check out more information about contributing to the OG i3, please see [CONTRIBUTING.md](.github/CONTRIBUTING.md). 

If you like **wiredWM** and feel some burning desire to help fund it, please direct your contributions towards the parent project, **i3**. WIthout it, this project would not be able to exist! 

*close the world, enter the nExt* ;)

### credits 

**wiredWM** is a fork of [i3](https://github.com/i3/i3), the most glorious window manager ever made.

Some of our other major components are: 

- [rofi](https://github.com/davatorium/rofi)
- [flameshot](https://github.com/flameshot-org/flameshot)
- [nm-applet](https://github.com/pavlix/nm-applet)
- various components from [suckless](https://suckless.org).
