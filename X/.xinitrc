#!/bin/sh
#
# ~/.xprofile -- execute commands before starting X
#

xrandr --setprovideroutputsource modesetting NVIDIA-0
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
          -option                          \
          -option compose:rctrl            \
          -option caps:swapescape          \
          -option lv3:ralt_switch          \
          -option rupeesign:4              \
          -option terminate:ctrl_alt_bkspc

# Environment {{{1
# ----------------

# Set the PATH.
export PATH="${HOME}/code/bin:${PATH}"

# Preferred web browser.
export BROWSER="/usr/bin/firefox"

# Note that fc(1) in vi-mode uses $VISUAL instead of $FCEDIT.
export EDITOR="/usr/bin/vim"
export FCEDIT="$EDITOR" VISUAL="$EDITOR"

# Set locale properly.  Ubuntu sets LANG to en_IN if IST is selected as the
# time zone.  But many programs (e.g., tmux) don't understand en_IN.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Default Mutt profile.
export MUTT_PROFILE="syr"

# 3 minutes to clear the clipboard after copying a password.
export PASSWORD_STORE_CLIP_TIME=180

# Location of password store git repo.
export PASSWORD_STORE_DIR="${HOME}/documents/.password-store"

# Local TEXMF directory.
export TEXMFHOME="${HOME}/.texmf"

# Preferred terminal emulator.
export TERMINAL="${HOME}/code/scripts/terminal"

# Default pager.
export PAGER="less"
export MANPAGER="less"

# File that's imported when the CPython interpreter is called interactively.
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

# Don't save sdcv history.
export SDCV_HISTSIZE=0

# Scale GTK3 UI elements by a factor of two.  But this scales the text, which
# has scaled once before.
export GDK_SCALE=2

# Thus, undo scaling of text.
export GDK_DPI_SCALE=0.5

# Set DPI for Qt applications.
export QT_FONT_DPI=168

xinput set-prop 12 357 0 1
xinput set-prop 12 354 1.0

xsetroot -solid "#303030"
dunst &
exec i3
