# Openbox

A backup for my Openbox desktop configuration. Includes all needed themes and configs, a build of dmenu, the log-in manager config and some scripts. 
This is a modification of [dbuxy218's Prismatic Night Openbox theme](https://github.com/dbuxy218/Prismatic-Night) 
![A screenshot of my desktop](/screenshots/desktop.png?raw=true)

# Themes

+ [System / WM theme - Prismatic Night](https://github.com/dbuxy218/Prismatic-Night#openbox)
+ [GTK Theme - Adapta Nokto](https://cinnamon-spices.linuxmint.com/themes/view/Adapta-Nokto)
+ [Icon Theme - Breeze-Noir-White-Blue](https://store.kde.org/p/1361468)

# Stow - dotfiles

The dotfiles folder is set up to work with GNU Stow. All dotfiles can be automatically symlinked by launching 'stow -t ~ *'

# Packages 

I've added package lists with all the required packages I usually install.
Void Linux - xbps.txt
Arch - pacman.txt

# Top panel - tint2

I'm using [dbuxy218's tint2 config](https://github.com/dbuxy218/Prismatic-Night#tint2) with several modifications:

+ Changed the font to Roboto
+ Removed some buttons for programs I didn't need. 
+ Changed the clock format
+ More small optimizations 

# Default apps

The top panel has 5 icons for launching my default programs (such as a terminal or a text editor). If you are not using the same programs I use, you'll have to change these in the tint2rc.

+ Browser - firefox
+ Terminal emulator - xfce4-terminal
+ File Manager - pcmanfm
+ Gui text editor - gedit
+ Logout (power button) - lxsession-logout (lxsession package)

# Key bindings 

I'm using the default openbox keybindings with minor adds / changes 
+ Windows aero like snapping (Meta + left/right arrow will snap the window to the side)
+ 'Meta + up/down arrow' controls a maximized window
+ 'Meta + Shift + numbers' switches desktops (1 - 4)

And keybinds to launch some programs (still a work in progress)

+ 'Meta + e' - launches pcmanfm
+ 'Meta + p' launches dmenu
+ 'Meta + t' launches xfce terminal

# Log-in manager - lightdm

I'm using the lightdm log-in manager with a gtk3 greeter. Including a lightdm-gtk-greeter config (/etc/lightdm/lightdm-gtk-greeter.conf), and the contents of my /opt/lightdm folder -  A wallpaper I use (/opt/lightdm/background.jpg) and a xrandr script for virtual machines (the default resolution is 1024x768 unless you change it with a script like this). This has to be defined in the lightdm configuration file. 
![LightDM log-in manager](/screenshots/lightdm.png?raw=true)

# Dmenu

I use dmenu as an application launcher. I included a default build with two patches - caseinsensitive and lineheight. Also changed the colors to match the top panel.
The default keybind is Meta + P
The packages from base-devel are required to build this package as well as some libraries - libX11-devel, libXft-devel and libXinerama-devel (if not installed already)
![dmenu](/screenshots/dmenu.png?raw=true)
