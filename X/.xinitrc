#!/bin/sh
#
# ~/.xinitrc -- execute commands before starting X
#

[ "$HOSTNAME" = "boron" ] && HIDPI=1

dgpu=$(cat /etc/prime-discrete)
[ "$dgpu" = "on" ] && xrandr --setprovideroutputsource modesetting NVIDIA-0

xrandr --auto
xrandr --dpi 168

[ -f "${HOME}/.Xresources" ] && xrdb -merge "${HOME}/.Xresources"

# Make GTK/QT apps use X input method (Xim).
# Without this, custom mappings in ~/.XCompose won't work.
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="xim"

# Synaptics driver settings.
# Two finger taps = middle click and disable touchpad while typing.
synclient TapButton2=2 PalmDetect=1

# X11 keyboard layout tweaks {{{1
# -------------------------------

# altgr-intl = international version of altgr (which has more symbols)
# caps:swapescape = swap caps lock and escape
# compose:rctrl = right ctrl is the compose key
# lv3:ralt_switch = right alt is altgr
# rupeesign:4 = altgr + 4 gives rupee sign
# terminate:ctrl_alt_bkspc = ctrl + alt + bkspc terminates X

setxkbmap -variant altgr-intl              \
          -option compose:rctrl            \
          -option caps:swapescape          \
          -option lv3:ralt_switch          \
          -option rupeesign:4              \
          -option terminate:ctrl_alt_bkspc

# Environment {{{1
# ----------------

# Preferred web browser.
export BROWSER="/usr/bin/firefox"

# Local TEXMF directory.
export TEXMFHOME="${HOME}/.texmf"

# Preferred terminal emulator.
export TERMINAL="${HOME}/code/scripts/terminal"

# Scale GTK3 UI elements by a factor of two.  But this scales the text, which
# has scaled once before.
export GDK_SCALE=2

# Thus, undo scaling of text.
export GDK_DPI_SCALE=0.5

# HiDPI Qt settings.
export QT_FONT_DPI=168
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Xubuntu sets this to gtk2.  But without setting this to gtk3, Qt
# applications don't seem to respect font settings.
export QT_QPA_PLATFORMTHEME=gtk3

xinput set-prop 12 304 0 1
xinput set-prop 12 295 1.0

# Background color.
xsetroot -solid "#303030"

# Use dunst for notifications.
dunst &

# Start screen locker with a waiting time of 10 minutes.
xautolock -time 10 -locker 'i3lock --color=303030' &

exec i3
