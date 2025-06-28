#!/bin/sh

#xrdb -merge ~/.Xresources &
feh --bg-fill ~/wallpaper/jazzandrain.jpeg &
xset r rate 200 50 &
picom --backend xrender --config /home/Talos/.config/picom/picom.conf --log-level "TRACE" --log-file /home/Talos/.config/logs/picom-log &

dash ~/.config/chadmanwm/scripts/bar.sh &
#while type chadwm > /dev/null; do chadwm && continue || break; done
exec chadwm
