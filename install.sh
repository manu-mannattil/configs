#!/usr/bin/env bash
#
# NAME
#
#   install.sh - configuration files installation script
#
# SYNOPSIS
#
#   install.sh
#
# DESCRIPTION
#
#   install.sh is a simple shell script to copy/symlink my configuration
#   files to $HOME.  It makes sense to symlink only those configuration
#   files that would not get overwritten or edited by programs.  Others
#   should be copied instead.
#
#   WARNING: This script will do everything to get the new files in the
#   right places -- including deleting and overwriting files.  Backups
#   of existing files will NOT be kept.  You have been warned!
#
# DEPENDENCIES
#
#   dirname(1), git(1), readlink(1), etc.
#

set -eu
set -o pipefail

REPO=$(dirname "$(readlink -f -- "$0")")
cd "$REPO"

# Function for printing information messages.
info() {
    echo >&2 "${0##*/}: $@"
}

# Function to copy/symlink a file from the repository tree into $HOME.
# Parent directories will be created if they don't exist.
install() {
    if [[ "$1" =~ ^(-c|--copy)$ ]]
    then
        local cmd=(cp -vr)
        shift
    else
        local cmd=(ln -vs)
    fi

    for file
    do
        local origin="${REPO}/${file}"
        local target="${HOME}/${file#*/}"
        local tardir=$(dirname "$target")

        # Catch potential rm -rf $HOME: if the file/directory name ends
        # in a `/', $target reduces to $HOME.
        if [[ "$(echo "$target" | sed 's|/*$||')" == "$HOME" ]]
        then
            info "error installing '$file'"
            info "target cannot be \$HOME!"
            exit 1
        else
            rm -vrf -- "$target"
        fi

        # If $tardir is a file, mkdir -p will fail.
        [[ -f "$tardir" ]] && rm -vr -- "$tardir"
        mkdir -vp -- "$tardir"

        "${cmd[@]}" -- "$origin" "$target"
    done
}

# Files to symlink {{{1
# ---------------------

install                                                           \
    "X/.XCompose" "X/.xprofile" "X/.Xresources"                   \
    "aria2/.aria2"                                                \
    "bash/.bashrc" "bash/.bash_profile"                           \
    "bibtool/.bibtoolrsc"                                         \
    "curl/.curlrc"                                                \
    "detox/.detoxrc" "detox/.config/detox"                        \
    "dircolors/.dir_colors"                                       \
    "emacs/.emacs"                                                \
    "fontconfig/.config/fontconfig"                               \
    "git/.gitconfig" "git/.gitattributes" "git/.git-pass"         \
    "ipe/.ipe/ipelets" "ipe/.ipe/styles"                          \
    "ipython/.ipython/profile_default/ipython_config.py"          \
    "latexindent/.latexindent.yaml"                               \
    "latexmk/.latexmkrc"                                          \
    "lensfun/.local/share/lensfun"                                \
    "less/.lessfilter"                                            \
    "liferea/.config/liferea/liferea.css"                         \
    "matplotlib/.config/matplotlib"                               \
    "mpv/.config/mpv/mpv.conf" "mpv/.config/mpv/input.conf"       \
    "notmuch/.notmuch-config"                                     \
    "offlineimap/.offlineimaprc" "offlineimap/.offlineimap.py"    \
    "parallel/.parallel/config"                                   \
    "python/.pythonrc.py"                                         \
    "tex/.texmf"                                                  \
    "tmux/.tmux" "tmux/.tmux.conf"                                \
    "urxvt/.urxvt/ext" "urxvt/.urxvt/colors"                      \
    "wget/.wgetrc"                                                \
    "xdg/.config/user-dirs.dirs"                                  \
    "youtube-dl/.config/youtube-dl.conf"

# Files to copy over {{{1
# -----------------------

install --copy                                                    \
    "htop/.config/htop"                                           \
    "mathematica/.Mathematica/FrontEnd/init.m"                    \
    "qpdfview/.config/qpdfview/qpdfview.conf"                     \
    "xfce/.local/share/xfce4/helpers/terminal.desktop"            \
    "xfce/.config/xfce4/helpers.rc"                               \
    "xnview/.config/xnviewmp/xnview.ini"

# cvsignore {{{1
# --------------

# Strip comments and empty lines when copying.
grep -v '\(^$\|^#\)' "${REPO}/cvs/.cvs_ignore" | sort | uniq >"${HOME}/.cvsignore"

# darktable {{{1
# --------------

install "darktable/.config/darktable/darktable.css"
install --copy "darktable/.config/darktable/darktablerc"

# DeaDBeeF {{{1
# -------------

# Preserve tabs and playlists.
if [[ -f "${HOME}/.config/deadbeef/config" ]]
then
    grep "^playlist.tab" "${HOME}/.config/deadbeef/config" >"${HOME}/.config/deadbeef/tabs"
    install --copy "deadbeef/.config/deadbeef/config"
    cat "${HOME}/.config/deadbeef/tabs" >>"${HOME}/.config/deadbeef/config"
else
    install --copy "deadbeef/.config/deadbeef"
fi

# Firefox {{{1
# ------------

# Symlink user.js in all Firefox profiles.
if [[ -f "${HOME}/.mozilla/firefox/profiles.ini" ]]
then
    while IFS= read -r profile
    do
        ln -sf "${REPO}/firefox/.mozilla/firefox/profile/user.js" \
               "${HOME}/.mozilla/firefox/${profile}"
    done < <(sed -n 's/^Path=//p' "${HOME}/.mozilla/firefox/profiles.ini")
fi

# Disable Flash cache.
rm -v -rf "${HOME}/.macromedia" "${HOME}/.adobe"
ln -v -s /dev/null "${HOME}/.macromedia"
ln -v -s /dev/null "${HOME}/.adobe"

# GnuPG {{{1
# ----------

install "gnupg/.gnupg/gpg.conf" "gnupg/.gnupg/gpg-agent.conf"

# Set the right permissions.
chmod -v 700 "${HOME}/.gnupg"
chmod -v 600 "${HOME}/.gnupg/gpg.conf" "${HOME}/.gnupg/gpg-agent.conf"

# Msmtp {{{1
# -----------

# msmtp requires ~/.msmtprc to be rw only by the user.
chmod -v 600 "${REPO}/msmtp/.msmtprc"
install "msmtp/.msmtprc"

# Mutt {{{1
# ---------

install "mutt/.mutt" "mutt/.mailcap" "mutt/.urlview"

mkdir -vp "${HOME}/.cache/mutt/attach"
mkdir -vp "${HOME}/.cache/mutt/notmuch"
mkdir -vp "${HOME}/.cache/mutt/headers"

# Thunar {{{1
# -----------

# Execute shell scripts by clicking.
# https://bbs.archlinux.org/viewtopic.php?id=194464
command -v xfconf-query &>/dev/null && xfconf-query               \
    --channel thunar                                              \
    --create                                                      \
    --property /misc-exec-shell-scripts-by-default                \
    --type bool                                                   \
    --set true

# Vim {{{1
# --------

install "vim/.vimrc" "vim/.vim" "vim/.gvimrc"

mkdir -vp "${HOME}/.cache/vim/swap"
mkdir -vp "${HOME}/.cache/vim/backup"
mkdir -vp "${HOME}/.cache/vim/undo"

# Run :mkspell on spell files.
info "compiling vim spell files"
find "${HOME}/.vim/spell" -type f ! -name '*.spl'                 \
     -exec vim -e -s -u NONE -c ':mkspell! %' -c ':qall!' {}      \;

# Install plugins.
"${HOME}/.vim/install-plugins"

# Readline {{{1
# --------------

install "readline/.inputrc"

# Cache directory for rlwrap command history.
mkdir -vp "${HOME}/.cache/rlwrap"

# rtorrent {{{1
# -------------

install "rtorrent/.rtorrent.rc"
mkdir -vp "${HOME}/downloads/.rtorrent"
mkdir -vp "${HOME}/downloads/.torrents"

# XDG MIME and other miscellanea {{{1
# -----------------------------------

install "xdg/.local/share/applications"/*                         \
        "xdg/.local/share/mime/packages"/*

update-mime-database -V "${HOME}/.local/share/mime"

# No motd (message of the day) login banner.
touch "${HOME}/.hushlogin"

# End of script.
cd "$OLDPWD"

info "finished setting up configuration files"

# vim: ft=sh fdm=marker et sts=4 sw=4
