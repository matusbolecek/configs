case $WM in
dwm)
	feh --bg-fill --randomize ~/repos/wallpapers/3/* &	
	urxvtd &
	dwm 
	;;
spectrwm)
	feh --bg-fill --randomize ~/repos/wallpapers/2/* &
	spectrwm ;;
esac
