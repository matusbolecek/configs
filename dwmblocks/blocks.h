//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/		/*Command*/	 		/*Update Interval*/	/*Update Signal*/
  	{"", 		".local/bin/sb-scripts/music",	  		60,		        4},

  	{" ", 		".local/bin/sb-scripts/kernel",	  	0,		        5},

	{" ", 		".local/bin/sb-scripts/cputemp",	        2,		        6},

	{" ", 		".local/bin/sb-scripts/memory",	        2,		        7},

	{" 🔊 ", 	".local/bin/sb-scripts/volume",		2,		        10},

	{" ", 		".local/bin/sb-scripts/kbdlayout",		0,		        20},
	
	{" ", 		".local/bin/sb-scripts/clock",			5,		        30},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
