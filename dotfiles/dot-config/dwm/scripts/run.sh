#!/bin/sh

#xrdb -merge ~/.Xresources &
feh --bg-fill --randomize ~/.wallpaper  &
xset r rate 200 50 &
picom --backend xrender --config ~/.config/picom/picom.conf &

dash ~/.config/dwm/scripts/bar.sh &
while type chadwm > /dev/null; do chadwm && continue || break; done
#exec chadwm
