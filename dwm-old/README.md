# dwm

A backup of my desktop setup using the dwm window manager. Including the wm itself, dmenu, slock and some config files. 
![A screenshot of my desktop](/screenshots/1.jpg?raw=true)

# dynamic window manager & patches

A heavily patched build of the suckless window manager. Patches used are:
+ Attachaside (new windows appear in the stack)
+ Autostart (~/.dwm/autostart.sh is executed after launching dwm)
+ Bar-height (user can change the top bar height in config.h)
+ Center (floating windows spawn in the center of the screen)
+ Centered Master layout
+ Gridmode (adds a grid layout)
+ Rotatestack (allows rotating windows around with MOD + Shift + J/K)
+ Selectivefakefullscreen (windows can be set to only display in a set space while they're fullscreen)
+ Statuspadding (Status bar padding)
+ Systray (adds a system tray)
+ Swallow (Opening a program in a terminal will take up the Terminal's window space)
+ Uselessgap (Adds gaps between windows)

# dmenu

I'm using the [distrotube](https://gitlab.com/dwt1) build of dmenu with changed colors. Refer to the [original project](https://gitlab.com/dwt1/dmenu-distrotube) for more documentation. 
I also added the caseinsensitive patch - dmenu is now case insensitive by default.

# dwmblocks

Modular status bar for dwm. The default location of scripts is in /opt/dwmblocks/scripts (unless changed in blocks.h). Some scripts do not update regularly, but only change when they receive a signal. Refer to [Luke Smith's dwmblocks repo](https://github.com/LukeSmithxyz/dwmblocks) for advice on how to set this up. 
Thanks to [dwt1](https://gitlab.com/dwt1) for some of the scripts. 

# slock

Also including my patched build of slock - the suckless screen locker. I used the capscolor, dpms and message patches. 

# Packages / dependencies 

Including my official & AUR package lists. These can be installed with 'pacman -S - < pacman.txt'. The same syntax works with yay / paru.

# Themes

+ GTK Theme - [Arithm-Dark](https://pling.com/p/1291666)
+ Icon theme - Breeze 

# Key bindings 

I am using the default key bindings with some small changes. If I didn't list something here, it's probably unchanged. 
+ Modkey = Super / Windows key
+ MOD + Return - Opens the default Terminal (Alacritty)
+ MOD + Shift + Return - Opens the dmenu launcher
+ Alt + Tab - Switches back to the last tag opened (Used to be MOD + Tab in the default bindings)
+ MOD + Tab - Shows all open windows at once. 
+ MOD + A / S - Shiftview function, scrolls through tags.
+ MOD + Space - changes the keyboard layout from us to sk. The layout name can be changed in the config if needed.
+ MOD + Backspace - Quit dwm.

Also adding keybinds to launch specific programs. 

+ MOD + Alt + F - Launches the [Librewolf](https://librewolf-community.gitlab.io) browser. 
+ MOD + Alt + V - Launches the [vimb](https://fanglingsu.github.io/vimb/) browser with tabbed. 
+ MOD + Alt + E - Launches the PCManFM gui file manager.
+ MOD + Alt + L - Locks the screen with slock.
+ MOD + Alt + Q - Launches the lxsession logout prompt.
+ MOD + Alt + P - Enable / disable the picom compositor.
+ MOD + Alt + F5 - Restart the dwmblocks statusbar.

I am using flameshot to take screenshots of my desktop. See dots/flameshot/flameshot.conf for the configuration. 
+ Ctrl + Print - Opens the area capture gui.
+ Print - Captures a full screen screenshot.

