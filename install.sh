#!/usr/bin/env bash
#
# NAME
#
#   install.sh - configuration files installation script
#
# SYNOPSIS
#
#   install.sh [--group <group>] [<target>...]
#   install.sh --list
#   install.sh --list-groups
#
# OPTIONS
#
#     --group <group>       install from target group
#     --list                list all possible targets
#     --list-groups         list all possible groups
#
# DESCRIPTION
#
#   install.sh is a simple shell script to copy/symlink my configuration
#   files to $HOME.  It makes sense to symlink only those configuration
#   files that would not get overwritten or edited by programs.  Others
#   should be copied instead.
#
#   install.sh can take one or more targets as arguments.  In that case,
#   the configuration files for only those targets will be installed.
#   By default all targets will be installed.
#
#   WARNING: This script will do everything to get the new files in the
#   right places -- including deleting and overwriting files.  Backups
#   of existing files will NOT be kept.  You have been warned!
#
# DEPENDENCIES
#
#   GNU coreutils, dirname(1), git(1), readlink(1), etc.
#

set -e
set -o pipefail

REPO=$(dirname "$(readlink -f -- "$0")")
pushd "$REPO" &>/dev/null

# Print an informational message.
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

# The basic idea of targets is this -- each target gets
# a function associated with it.  It must have a name of the
# form __install_<target>().  The target function is called
# to install the configuration files for that target.
# Targets can be grouped into groups for convenience.
#
# Each target function must have an associated comment line
# beginning with ":target:" so that it can be grepped for
# displaying the list of possible targets.

# Targets {{{1
# ------------

# :target: aria2 - aria2 download accelerator configuration
__install_aria2() {
    install "aria2/.aria2"
}

# :target: bash - GNU Bash shell configuration
__install_bash() {
    install "bash/.bashrc" "bash/.bash_profile"

    # No motd (message of the day) login banner.
    touch "${HOME}/.hushlogin"
}

# :target: bibtool - bibtool configuration
__install_bibtool() {
    install "bibtool/.bibtoolrsc"
}

# :target: curl - cURL cli configuration
__install_curl() {
    install "curl/.curlrc"
}

# :target: cvs - cvs configuration
__install_cvs() {
    # Strip comments and empty lines when copying.
    grep -v '\(^$\|^#\)' "${REPO}/cvs/.cvs_ignore" | sort | uniq >"${HOME}/.cvsignore"
}

# :target: ctags - exuberant ctags configuration
__install_ctags() {
    install "ctags/.ctags"
}

# :target: darktable - darktable configuration
__install_darktable() {
    install "darktable/.config/darktable/darktable.css"
    install --copy "darktable/.config/darktable/darktablerc"
}

# :target: deadbeef - DeaDBeeF music player configuration
__install_deadbeef() {
    # Preserve tabs and playlists.
    if [[ -f "${HOME}/.config/deadbeef/config" ]]
    then
        grep "^playlist.tab" "${HOME}/.config/deadbeef/config" >"${HOME}/.config/deadbeef/tabs"
        install --copy "deadbeef/.config/deadbeef/config"
        cat "${HOME}/.config/deadbeef/tabs" >>"${HOME}/.config/deadbeef/config"
    else
        install --copy "deadbeef/.config/deadbeef"
    fi
}

# :target: dircolors - dircolors configuration
__install_dircolors() {
    install "dircolors/.dir_colors"
}

# :target: emacs - minimal Emacs configuration
__install_emacs() {
    install "emacs/.emacs"
}

# :target: firefox - Firefox configuration
__install_firefox() {
    # Symlink user.js in all Firefox profiles.
    if [[ -f "${HOME}/.mozilla/firefox/profiles.ini" ]]
    then
        while IFS= read -r profile
        do
            ln -v -sf "${REPO}/firefox/.mozilla/firefox/profile/user.js" \
                "${HOME}/.mozilla/firefox/${profile}"
        done < <(sed -n 's/^Path=//p' "${HOME}/.mozilla/firefox/profiles.ini")
    fi

    # Disable Flash cache.
    rm -v -rf "${HOME}/.macromedia" "${HOME}/.adobe"
    ln -v -s /dev/null "${HOME}/.macromedia"
    ln -v -s /dev/null "${HOME}/.adobe"
}

# :target: fontconfig - fontconfig configuration
__install_fontconfig() {
    install "fontconfig/.config/fontconfig"
}

# :target: gpg - GnuPG configuration
__install_gpg() {
    install "gnupg/.gnupg/gpg.conf" "gnupg/.gnupg/gpg-agent.conf"

    # Set the right permissions.
    chmod -v 700 "${HOME}/.gnupg"
    chmod -v 600 "${HOME}/.gnupg/gpg.conf" "${HOME}/.gnupg/gpg-agent.conf"
}

# :target: git - git configuration and helpers
__install_git() {
    install "git/.gitconfig" "git/.gitattributes" "git/.git-pass"
}

# :target: gtk - GTK 2/3 configuration
__install_gtk() {
    install "gtk/.gtkrc-2.0" "gtk/.config/gtk-3.0/settings.ini"
}

# :target: htop - htop configuration
__install_htop() {
    install --copy "htop/.config/htop"
}

# :target: i3 - i3 wm configuration
__install_i3() {
    install "i3/.config/i3/config"
}

# :target: ipython - iPython configuration
__install_ipython() {
    install "ipython/.ipython/profile_default/ipython_config.py"
}

# :target: latexindent - latexindent configuration
__install_latexindent() {
    install "latexindent/.latexindent.yaml"
}

# :target: latexmk - latexmk configuration
__install_latexmk() {
    install "latexmk/.latexmkrc"
}

# :target: lensfun - Lensfun misc lens files
__install_lensfun() {
    install "lensfun/.local/share/lensfun"
}

# :target: less - lessfilter for less
__install_less() {
    install "less/.lessfilter"
}

# :target: liferea - Liferea configuration
__install_liferea() {
    install "liferea/.config/liferea/liferea.css"
}

# :target: mathematica - Wolfram Mathematica configuration
__install_mathematica() {
    install --copy "mathematica/.Mathematica/FrontEnd/init.m"
    install "mathematica/.Mathematica/Kernel/init.m"
}

# :target: matplotlib - matplotlib configuration
__install_matplotlib() {
    install "matplotlib/.config/matplotlib"
}

# :target: mpv - mpv media player configuration
__install_mpv() {
    install "mpv/.config/mpv/mpv.conf" "mpv/.config/mpv/input.conf"
}

# :target: msmtp - msmtp configuration
__install_msmtp() {
    # msmtp requires ~/.msmtprc to be rw only by the user.
    chmod -v 600 "${REPO}/msmtp/.msmtprc"
    install "msmtp/.msmtprc"
}

# :target: mutt - Mutt configuration and profiles
__install_mutt() {
    install "mutt/.mutt" "mutt/.mailcap" "mutt/.urlview"

    # Create cache directories.
    mkdir -vp "${HOME}/.cache/mutt/attach"
    mkdir -vp "${HOME}/.cache/mutt/notmuch"
    mkdir -vp "${HOME}/.cache/mutt/headers"
}

# :target: notmuch - notmuch mail indexer configuration
__install_notmuch() {
    install "notmuch/.notmuch-config"
}

# :target: offlineimap - OfflineIMAP configuration
__install_offlineimap() {
    install "offlineimap/.offlineimaprc" "offlineimap/.offlineimap.py"
}

# :target: parallel - GNU parallel configuration
__install_parallel() {
    install "parallel/.parallel/config"
}

# :target: python - CPython REPL configuration
__install_python() {
    install "python/.pythonrc.py"
}

# :target: qpdfview - qpdfview configuration
__install_qpdfview() {
    install --copy "qpdfview/.config/qpdfview/qpdfview.conf"
}

# :target: readline - GNU Readline library configuration
__install_readline() {
    install "readline/.inputrc"

    # Cache directory for rlwrap command history.
    mkdir -vp "${HOME}/.cache/rlwrap"
}

# :target: terminfo - terminfo files for less-known terminals
__install_terminfo() {
    install "terminfo/.terminfo"
}

# :target: tex - LaTeX configuration (local texmf directory)
__install_tex() {
    install "tex/.texmf"
}

# :target: tmux - tmux configuration
__install_tmux() {
    install "tmux/.tmux" "tmux/.tmux.conf"
}

# :target: vim - Vim configuration and plugins
__install_vim() {
    install "vim/.vimrc" "vim/.vim" "vim/.gvimrc"

    mkdir -vp "${HOME}/.cache/vim/swap"
    mkdir -vp "${HOME}/.cache/vim/backup"
    mkdir -vp "${HOME}/.cache/vim/undo"

    # Create nonstandard spell files if they don't already exist.  If
    # this is not done, Vim will warn each time spellcheck is turned on.
    mkdir -p "${HOME}/.vim/spell"
    [[ -f "${HOME}/.vim/spell/in" ]] || touch "${HOME}/.vim/spell/in"

    # Now, run :mkspell on spell files.
    info "compiling vim spell files"
    find "${HOME}/.vim/spell" -type f ! -name '*.spl' \
        -exec vim -e -s -u NONE -c ':mkspell! %' -c ':qall!' {} \;

    # Install plugins.
    "${HOME}/.vim/install-plugins"

    # Create a symlink of the snippets directory to ~ for easier access.
    rm -f "${HOME}/.snippets"
    ln -v -sf "${HOME}/.vim/snippets" "${HOME}/.snippets"
}

# :target: wget - wget configuration
__install_wget() {
    install "wget/.wgetrc"
}

# :target: x - X11 configuration
__install_x() {
    install "X/.XCompose" "X/.xinitrc" "X/.Xresources"
    [[ "$DISPLAY" ]] && xrdb -merge "${HOME}/.Xresources"
}

# :target: xdg - common configuration used by all X desktop environments
__install_xdg() {
    install "xdg/.config/user-dirs.dirs" \
            "xdg/.local/share/applications"/* \
            "xdg/.local/share/mime/packages"/*

    update-mime-database -V "${HOME}/.local/share/mime"
}

# :target: xfce - configuration files for the XFCE desktop environment
__install_xfce() {
    install --copy \
        "xfce/.local/share/xfce4/helpers/terminal.desktop" \
        "xfce/.config/xfce4/helpers.rc"

    # Execute shell scripts in Thunar by clicking.
    # https://bbs.archlinux.org/viewtopic.php?id=194464
    command -v xfconf-query &>/dev/null && xfconf-query \
        --channel thunar \
        --create \
        --property /misc-exec-shell-scripts-by-default \
        --type bool \
        --set true
}

# :target: xnview - XnView configuration
__install_xnview() {
    install --copy "xnview/.config/xnviewmp/xnview.ini"
}

# :target: youtube-dl - youtube-dl configuration
__install_youtube-dl() {
    install "youtube-dl/.config/youtube-dl.conf"
}

# }}}

__fetch_possible_targets() {
    grep -o '^__install_[^()]*()' -- "$0" \
        | sed 's/^__install_//;s/()//' \
        | sort
}

targets=()

__parse_group() {
    case "$1" in
        # The first line of every group case must begin with
        # ":group:" so that it can be grepped to list the
        # available groups.
        cli)
            # :group: cli - set of basic CLI programs
            # Useful especially when installing
            # on a headless server.
            targets+=(
                bash
                curl
                dircolors
                emacs
                git
                gpg
                htop
                ipython
                less
                parallel
                python
                readline
                terminfo
                tmux
                vim
                wget
            ) ;;
        default)
            # :group: default - install all targets
            targets+=( $(__fetch_possible_targets) ) ;;
        "")  info "group name required"; exit 1 ;;
        *)   info "unknown group $1"; exit 1 ;;
    esac
}

__parse_target() {
    if type -t "__install_${1,,}" &>/dev/null
    then
        targets+=( "$1" )
    else
        info "unknown target $1"; exit 1
    fi
}

[[ "$*" ]] || set -- "--group" "default"

while [[ "$1" ]]
do
    case "$1" in
        -l|--list)
            grep -o '^\s*#\+\s*:target:\s*.*$' -- "$0" \
                | sed 's/^\s*#\+\s*:target:\s*//' \
                | sort
            exit 0 ;;
        --list-groups)
            grep -o '^\s*#\+\s*:group:\s*.*$' -- "$0" \
                | sed 's/^\s*#\+\s*:group:\s*//' \
                | sort
            exit 0 ;;
        -g|--group)
            __parse_group "$2"; shift ;;
        -*)
            info "unknown option $1"
            exit 1 ;;
        *)
            __parse_target "$1" ;;
    esac
    shift
done

# Sort array elements uniquely.
targets=( $(IFS=$'\n'; sort <<<"${targets[*]}" | uniq) )
info "${#targets[@]} target(s)"

# Install targets.
for t in "${targets[@]}"
do
    "__install_${t,,}"
done

# Set up Git hooks.
git config --local core.hooksPath .githooks

# End of script.
popd &>/dev/null
info "finished setting up configuration files"

# vim: ft=sh fdm=marker et sts=4 sw=4
