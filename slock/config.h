/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",    	 /* after initialization */
	[INPUT] =  "#0e1926",    /* during input */
	[FAILED] = "#ab0000",    /* wrong password */
	[CAPS] = "#da4901",      /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* time in seconds before the monitor shuts down*/
static const int monitortime = 30;

/* default message */
static const char * message = "Arch Linux";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "lucidasans-14";
