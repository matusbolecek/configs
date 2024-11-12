/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 6;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int swallowfloating = 0;  /* 1 means swallow floating windows by default */
static const unsigned int systraypinning = 1;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 22;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int horizpadbar        = 2;        /* horizontal padding for statusbar */
static const int vertpadbar         = 0;        /* vertical padding for statusbar */

static const char *fonts[]     = {"Mononoki Nerd Font:size=9:antialias=true:autohint=true",
                                  "Hack:size=8:antialias=true:autohint=true",
                                  "JoyPixels:size=10:antialias=true:autohint=true"
                                  };

                                  
static const char col_1[]  = "#0e1926"; /* background color of bar */
static const char col_2[]  = "#0e1926"; /* border color unfocused windows */
static const char col_3[]  = "#d7d7d7";
static const char col_4[]  = "#1960bc"; /* border color focused windows and tags */
/* bar opacity 
 * 0xff is no transparency.
 * 0xee adds wee bit of transparency.
 * Play with the value to get desired transparency.
 */
static const unsigned int baralpha    = 0xee; 
static const unsigned int borderalpha = 0xff;
static const char *colors[][3]        = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_3, col_1, col_2 },
	[SchemeSel]  = { col_3, col_4,  col_4 },
};
static const unsigned int alphas[][3] = {
	/*               fg      bg        border     */
	[SchemeNorm] = { 0xff, baralpha, borderalpha },
	[SchemeSel]  = { 0xff, baralpha, borderalpha },
};


/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
/* static const char *tags[] = { "", "", "", "", "", "", "", "", "" }; */

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     iscentered   isfloating 	isterminal 	noswallow	isfakefullscreen monitor */
	{ "Librewolf",     NULL,       NULL,  0,            0,           0,           	0,		-1,		0,		-1 },
/*	{ "Gimp",     NULL,       NULL,       0,            0,           1,           	0,		0,		0,		-1 }, 	 */
	{ "discord",  NULL,       NULL,       1 << 8,       0,           0,           	0,		0,		0,		-1 },
	{ "Brave",    NULL,       NULL,       0, 	    0,           0,           	0,		-1,		1,		-1 },
	{ "Alacritty", NULL,     NULL,        0,            0,           0,             1,		0,		0,	        -1 },
	{ NULL,      NULL,     "Event Tester", 0,           0,           0,             0,	      	1,		0,		-1 }, /* xev */

};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-h", "22", "-p", "Run: ", NULL };
static const char *termcmdzsh[]  = { "alacritty", "-e", "zsh",  NULL };
static const char *termcmdbash[]  = { "alacritty", "-e", "bash",  NULL };
// static const char *tabvimbcmd[]  = { "tabbed", "vimb", "-e", NULL };

#include "shiftview.c"
#include "X11/XF86keysym.h"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,     	XK_Return, spawn,          {.v = dmenucmd } },
	{ MODKEY,               	XK_Return, spawn,          {.v = termcmdzsh } },
	{ MODKEY|Mod1Mask,             	XK_Return, spawn,          {.v = termcmdbash} },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ Mod1Mask,                     XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY|ShiftMask,		XK_f,      togglefloating, {0} },
	{ MODKEY,                       XK_Tab,    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_s,  shiftview,       {.i = +1 } },
	{ MODKEY,                       XK_a,  shiftview,       {.i = -1 } },
	
	// Launching Programs
	{ MODKEY|Mod1Mask,             	XK_f,      spawn,          SHCMD("librewolf") },
	{ MODKEY|Mod1Mask,             	XK_v,      spawn,          SHCMD("brave --new-window --start-fullscreen") },
	{ MODKEY|Mod1Mask,             	XK_b,      spawn,          SHCMD("brave --new-window") },
	{ MODKEY|Mod1Mask,             	XK_e,      spawn,          SHCMD("pcmanfm") },
	{ MODKEY|Mod1Mask,             	XK_l,      spawn,          SHCMD("slock") },
	{ MODKEY|Mod1Mask,             	XK_h,      spawn,          SHCMD("virt-manager") },
	{ MODKEY|Mod1Mask,             	XK_q,      spawn,          SHCMD("lxsession-logout") },
	{ MODKEY|Mod1Mask,             	XK_m,      spawn,          SHCMD("alacritty -e mocp") },
	{ MODKEY|Mod1Mask,             	XK_p,      spawn,          SHCMD("killall picom || picom &") },

	// Dmenu Scripts
	{ MODKEY,	             	XK_BackSpace,      spawn,          SHCMD("dmconf") },
	{ MODKEY|ShiftMask,            	XK_BackSpace,      spawn,          SHCMD("dman") },
	{ MODKEY,            		XK_p,    	   spawn,          SHCMD("dmtuxi") },
	{ MODKEY|ShiftMask,            	XK_p,    	   spawn,          SHCMD("dmsearch") },

	// Restart the dwmblocks statusbar
	{ MODKEY|Mod1Mask,             	XK_F5,     spawn,          SHCMD("killall dwmblocks && dwmblocks") },

	
	// Taking screenshots with flameshot, see dotfiles/flameshot.conf
	{ ControlMask,             	XK_Print,      spawn,          SHCMD("flameshot gui") },
	{ 0,             		XK_Print,      spawn,          SHCMD("flameshot full -c") },

	// Keyboard layout switching + dwmblocks signal to change the displayed layout
	{ MODKEY,             		XK_space,  spawn,          SHCMD("if [ $(setxkbmap -query | grep -o -e us -e sk)  = 'us' ]; then setxkbmap sk; else setxkbmap us; fi ; pkill -RTMIN+20 dwmblocks") }, 

	// Media controls / function keys
	{ 0,      XF86XK_AudioMute,      	spawn,          SHCMD("pamixer -t ; pkill -RTMIN+10 dwmblocks") },
	{ 0,      XF86XK_AudioRaiseVolume,      spawn,          SHCMD("pamixer -i 4 ; pkill -RTMIN+10 dwmblocks") },
	{ 0,      XF86XK_AudioLowerVolume,      spawn,          SHCMD("pamixer -d 4 ; pkill -RTMIN+10 dwmblocks") },

	{ 0,      XF86XK_AudioPrev,      	spawn,          SHCMD("mocp --previous") },
	{ 0,      XF86XK_AudioNext,      	spawn,          SHCMD("mocp --next") },

	// Tagging
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmdzsh } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
