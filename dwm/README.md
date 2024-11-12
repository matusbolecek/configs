# dwm

My heavily patched build of the suckless window manager - dwm. 
![A screenshot of my desktop](/.github/screenshots/1.png?raw=true)

# Patches

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

# Key bindings 

I am using the default key bindings with some changes. If I didn't list something here, it's probably the same as the default. 
MODkey = Super / Windows key

| Keybinding | Action |
| :--- | :--- |
| `MOD + Return` | Opens a terminal (Alacritty) |
| `MOD + Shift + Return` | Opens the dmenu run launcher |
| `Alt + Tab` | Switches back to the last tag  |
| `MOD + Tab` | Shows all open windows |
| `MOD + A / S` | Shiftview function, scrolls through tags |
| `MOD + Space` | Changes the keyboard layout |
| `MOD + BackSpace` | Quits dwm |

Also adding keybinds to launch specific programs. 

| Keybinding | Program |
| :--- | :--- |
| `MOD + Alt + E` | PCManFM gui file manager |
| `MOD + Alt + F` | [Librewolf](https://librewolf-community.gitlab.io) browser |
| `MOD + Alt + B` | Brave browser |
| `MOD + Alt + V` | [vimb](https://fanglingsu.github.io/vimb/) browser with tabbed |
| `MOD + Alt + H` | virt-manager |
| `MOD + Alt + L` | Locks screen with slock |
| `MOD + Alt + M` | Music on console (mocp) |
| `MOD + Alt + P` | Enable / disable the picom compositor |
| `MOD + Alt + Q` | lxsession logout prompt |
| `MOD + Alt + F5` | Restart dwmblocks |
| `Crtl + PrtSc` | Area screenshot (flameshot) |
| `PrtSc` | Fullscreen screenshot (flameshot) |

# More screenshots 

![Screenshot 2](/.github/screenshots/2.png?raw=true)
![Screenshot 3](/.github/screenshots/3.png?raw=true)
