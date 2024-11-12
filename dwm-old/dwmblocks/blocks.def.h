//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/		/*Command*/	 		/*Update Interval*/	/*Update Signal*/
  	{"", 		"/opt/dwmblocks/scripts/music",	  		60,		        4},

  	{" ", 		"/opt/dwmblocks/scripts/kernel",	  	0,		        5},

	{" ", 		"/opt/dwmblocks/scripts/cputemp",	        2,		        6},

	{" ", 		"/opt/dwmblocks/scripts/memory",	        2,		        7},

	{" 🔊 ", 	"/opt/dwmblocks/scripts/volume",		2,		        10},

	{" ", 		"/opt/dwmblocks/scripts/kbdlayout",		0,		        20},
	
	{" ", 		"/opt/dwmblocks/scripts/clock",			5,		        30},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
