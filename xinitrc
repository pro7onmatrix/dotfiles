#!/usr/bin/sh

# Keyboard mapping and numlock
setxkbmap de &
numlockx &

# Wallpaper
nitrogen --restore &

# Compositor
picom --config $HOME/.config/picom/picom.conf --experimental-backends &

# Notifications
dunst &

# Status bar
dwmblocks &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Set resolution and refresh rate
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 144

# And last but not least, the window manager
exec dwm
