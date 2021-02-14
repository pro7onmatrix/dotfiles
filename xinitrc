#!/usr/bin/sh

# Keyboard mapping and numlock
setxkbmap de &
numlockx &

# Lighting control
openrgb --profile cyan.orp &

# Wallpaper
nitrogen --restore &

# Compositor
picom --config $HOME/.config/picom/picom.conf --experimental-backends &

# Notifications
dunst &

# Status bar
exec slstatus &

# And last but not least, the window manager
exec dwm
