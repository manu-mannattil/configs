#!/usr/bin/env bash
#
# ~/.xinitrc -- execute commands before starting X
#

# On my P43s, run X on NVIDIA if required.  Requires gpu-select.
# https://github.com/manu-mannattil/gpu-select
[[ -f /etc/gpu-select/state ]] && {
    gpu=$(</etc/gpu-select/state)
    [[ "$gpu" == "nvidia" ]] && xrandr --setprovideroutputsource modesetting NVIDIA-0
}

xrandr --auto

case "$HOSTNAME" in
    # ThinkPad P43s.
    boron)
        : ${DE:=i3} ${HIDPI:=1}
        ;;
    # ThinkPad X230t.
    lithium)
        : ${DE:=openbox}
        v4l2-ctl --device /dev/video0     \
                 --set-ctrl=gamma=250     \
                 --set-ctrl=contrast=13   \
                 --set-ctrl=saturation=70 \
                 --set-ctrl=sharpness=5
        ;;
    # Tel Aviv U. desktop.
    magrathea)
        : ${DE:=i3}
        ;;
esac

# Notes on my HiDPI display configuration
# ---------------------------------------

# My laptop has a 2560x1440 HiDPI display that I sometimes connect to
# a 1920x1080 monitor.  In such a situation, I generally use the external
# monitor as the __only__ display and keep my laptop lid closed.  The HiDPI
# settings are set by .xinitrc depending on the value of the environment
# variable $HIDPI.  By default, if $HIDPI is not set, .xinitrc initializes it
# by looking at the hostname.  If $HIDPI has already been initialized, .xinitrc
# does nothing.  Now, after I connect the monitor, I run startx as
#
#   $ HIDPI=0 startx
#
# This way I tell .xinitrc that I don't want a HiDPI session.  All of this
# might seem to be convoluted yak shaving, but it really is very simple!

if [[ "$HIDPI" == 1 ]]
then
    xrdb -DHIDPI=1 -merge "${HOME}/.Xresources"

    # HiDPI GTK settings
    # ------------------

    # Scale GTK3 UI elements by a factor of two.  But this
    # scales the text, which has been scaled once before.
    export GDK_SCALE=2

    # Thus, undo scaling of text.
    export GDK_DPI_SCALE=0.5

    # We need this since GTK 2.0 needs to have a different configuration for
    # low-DPI screens.
    export GTK2_RC_FILES="${HOME}/.gtkrc-hidpi-2.0"

    # HiDPI Qt settings
    # -----------------

    # We're supposed to set QT_AUTO_SCREEN_SCALE_FACTOR to 0 since we're
    # setting the DPI exactly.  But for some reason, icons in certain
    # applications (e.g., XnView) don't scale properly without setting
    # it to 1.
    export QT_FONT_DPI=168
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_ENABLE_HIGHDPI_SCALING=1

    # This variable describes the possible HiDPI scale factor
    # rounding policy (either "round" or "passthrough"), which decides
    # how non-integer scale factors (such as Windows 150%) are handled.
    # "Round" is the Qt5 default and "PassThrough" is the Qt6 default.
    export QT_SCALE_FACTOR_ROUNDING_POLICY="PassThrough"
else
    # When on the NVIDIA dGPU Qt has to be told that we need 96 DPI when not
    # using HiDPI; I don't know why.
    export QT_FONT_DPI=96

    # The display names keep changing depending on the order they were
    # recognized.  Thus, we have to grep the monitor names to find the eDP,
    # i.e., the embedded display port (aka laptop screen) and the first one
    # that isn't an eDP.
    edp=$(xrandr --listmonitors | cut -d ' ' -f 6 | grep eDP)
    ext=$(xrandr --listmonitors | cut -d ' ' -f 6 | grep -v eDP | sort -r | head -n 1)

    if [[ "$ext" ]]
    then
        # My USB-C to HDMI travel dock has trouble waking up the monitor when
        # the system goes to standby or the screen blanks.  Thus, don't allow
        # screen blanking and disable DPMS.
        xset s off -dpms
        if [[ ${EDP:=1} == 1 ]]
        then
            # Set the eDP and the external monitor to 1920x1080, but make the
            # external monitor the primary display.
            xrandr --output $ext --primary --mode 1920x1080 --pos 0x0 --output $edp --mode 1920x1080 --pos 0x0
        else
            # Turn of the eDP if EDP is set to something other than 1.
            xrandr --output $ext --primary --mode 1920x1080 --output $edp --off
        fi
    else
        # Start screen locker with a waiting time of 30 minutes.
        xautolock -time 30 -locker 'i3lock --ignore-empty-password --show-failed-attempts --color=333333' &
    fi

    xrdb -merge "${HOME}/.Xresources"
fi

# Qt theming.
export QT_QPA_PLATFORMTHEME=gtk3
export QT_STYLE_OVERRIDE="adwaita-dark"

# Turn off the system bell.
xset b off

# Make GTK/QT apps use X input method (Xim).
# Without this, custom mappings in ~/.XCompose won't work.
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="xim"

# Use a plain text file for all gsettings configurations.
# The file itself is at ~/.config/dconf/user.txt.
# Without this, some GTK applications (Firefox, for example) does not
# respect colorscheme preference (dark vs. light).
# https://anarc.at/blog/2020-03-02-moving-dconf-entries-to-git
export DCONF_PROFILE="$HOME/.config/dconf/profile"

# X11 keyboard layout tweaks
# --------------------------

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

# Start redshift to adjust screen temperature.
# The actual latitude:longitude is set in ~/.location
# for cleaner version control.
[[ -f "$HOME/.location" ]] && {
    loc=$(sed '/^\s*#/d
               /^\s*$/d
               s/\s*#.*$//
               s/^\s*//' "$HOME/.location" | head -n 1)
    redshift -l "$loc" &
}

# Set the background color.
bgcolor="#333333"
if command -v hsetroot &>/dev/null
then
    # Compton doesn't work with xsetroot.
    # https://github.com/chjj/compton/issues/162
    hsetroot -solid "$bgcolor"
else
    xsetroot -solid "$bgcolor"
fi

# Use dunst for notifications.
dunst &

# Control computer usage.
xwrits top clock breakclock mouse=5 &

# I really don't want the overhead of a compositor, but Zoom's screen
# sharing requires a compositor -- otherwise black squares will replace
# Zoom's window.  The issue seems to be
# https://support.zoom.us/hc/en-us/articles/202082128-Black-screen-during-screen-sharing
xcompmgr -c -l0 -t0 -r0 -o.00 &

# Since updating to Debian 10.10, launching the WM using dbus-launch
# seems to be required to have a nonempty $DBUS_SESSION_BUS_ADDRESS.
# Without this, several applications (evince, inkscape, etc.) wait 25
# seconds (some hard-coded time related to D-Bus) before showing their
# GUI.
case "$DE" in
    i3)
        exec dbus-launch --exit-with-session --sh-syntax i3
        ;;
    openbox)
        # Use tint2 for the taskbar, systray, etc.
        tint2 &
        exec dbus-launch --exit-with-session --sh-syntax openbox
        ;;
    *)
        echo >&2 "${0##*/}: DE must be either 'i3' or 'openbox'"
        exit 1
        ;;
esac
