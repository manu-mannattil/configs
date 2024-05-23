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

sts() {
    [[ "$1" == "--" ]] && shift
    "$REPO/sts.py" --shell "/bin/bash" "$1" >"$2"
    echo >&2 "sts: processed '$1' -> '$2'"
}

# Function to copy/symlink a file from the repository tree into $HOME.
# Parent directories will be created if they don't exist.
install() {
    if [[ "$1" =~ ^(-c|--copy)$ ]]
    then
        local cmd=(cp -vr)
        shift
    elif [[ "$1" =~ ^(-t|--template)$ ]]
    then
        local cmd=(sts)
        shift
    else
        local cmd=(ln -vs)
    fi

    for file
    do
        local origin="$REPO/$file"
        local target="$HOME/${file#*/}"
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
    touch "$HOME/.hushlogin"

    # NOTE (2018-05-26): For reasons I don't fully understand, readline
    # screws up the history-search-forward/backward functions (set in
    # ~/.inputrc) when the first line of $HISTFILE is _not_ a blank
    # line.  Basically, a two word command like `echo a' gets completed
    # twice if the first line of $HISTFILE isn't a blank line.
    : ${HISTFILE:=$HOME/.cache/bash_history}
    mkdir -p ~/.cache
    echo "" >$HISTFILE
}

# :target: bibtool - bibtool configuration
__install_bibtool() {
    install "bibtool/.bibtoolrsc"
}

# :target: bin - custom launch scripts
__install_bin() {
    install "bin/.local/bin"
}

# :target: clang - clang configuration files
__install_clang() {
    install "clang/.clang-format"
}

# :target: conda - Conda configuration
__install_conda() {
    install "conda/.condarc"
}

# :target: curl - cURL cli configuration
__install_curl() {
    install "curl/.curlrc"
}

# :target: cvs - cvs configuration
__install_cvs() {
    # Strip comments and empty lines when copying.
    grep -v '\(^$\|^#\)' "$REPO/cvs/.cvsignore" | sort | uniq >"$HOME/.cvsignore"
}

# :target: ctags - exuberant ctags configuration
__install_ctags() {
    install "ctags/.ctags"
}

# :target: deadbeef - DeaDBeeF music player configuration
__install_deadbeef() {
    # Preserve tabs and playlists.
    if [[ -f "$HOME/.config/deadbeef/config" ]] &&
        grep -q "^playlist.tab" "$HOME/.config/deadbeef/config"
    then
        grep "^playlist.tab" "$HOME/.config/deadbeef/config" >"$HOME/.config/deadbeef/tabs"
        install --copy "deadbeef/.config/deadbeef/config"
        cat "$HOME/.config/deadbeef/tabs" >>"$HOME/.config/deadbeef/config"
    else
        install --copy "deadbeef/.config/deadbeef"
    fi
}

# :target: dircolors - dircolors configuration
__install_dircolors() {
    install "dircolors/.dir_colors"
}

# :target: dunst - dunst configuration
__install_dunst() {
    install "dunst/.config/dunst"
}

# :target: emacs - minimal Emacs configuration
__install_emacs() {
    install "emacs/.emacs"
}

# :target: firefox - Firefox configuration
__install_firefox() {
    [[ -f /usr/bin/firefox ]] || {
        info "firefox binary not found; fetching..."
        pushd "$REPO/firefox"
        sudo make install
        popd
    }

    # Symlink/copy some files in all Firefox profiles.
    if [[ -f "$HOME/.mozilla/firefox/profiles.ini" ]]
    then
        while IFS= read -r profile
        do
            ln -v -sf "$REPO/firefox/.mozilla/firefox/profile/user.js" \
                "$HOME/.mozilla/firefox/$profile"
        done < <(sed -n 's/^Path=//p' "$HOME/.mozilla/firefox/profiles.ini")
    fi

    # Symlink `chrome' directory to default profile.
    default=$(echo "$HOME/.mozilla/firefox/"*.default)
    if [[ -d "$default" ]]
    then
        rm -rf "$default/chrome"
        ln -v -sf "$REPO/firefox/.mozilla/firefox/profile/chrome" "$default"
    fi
}

# :target: fontconfig - fontconfig configuration
__install_fontconfig() {
    install "fontconfig/.config/fontconfig"
}

# :target: gnupg - GnuPG configuration
__install_gnupg() {
    install --copy "gnupg/.gnupg/gpg.conf" "gnupg/.gnupg/gpg-agent.conf"

    # Set the right permissions.
    chmod -v 700 "$HOME/.gnupg"
    chmod -v 600 "$HOME/.gnupg/gpg.conf" "$HOME/.gnupg/gpg-agent.conf"
}

# :target: git - git configuration and helpers
__install_git() {
    install "git/.gitconfig" "git/.gitattributes" "git/.git-pass"
}

# :target: gtk - GTK 2/3 configuration
__install_gtk() {
    install "gtk/.gtkrc-2.0" "gtk/.gtkrc-hidpi-2.0" "gtk/.config/gtk-3.0/settings.ini"
}

# :target: htop - htop configuration
__install_htop() {
    install --copy "htop/.config/htop"
}

# :target: i3 - i3 wm configuration
__install_i3() {
    install "i3/.config/i3/config"
    install --template "i3/.config/i3/i3status.conf"
}

# :target: inkscape - inkscape configuration
__install_inkscape() {
    install "inkscape/.config/inkscape/templates" "inkscape/.config/inkscape/palettes"
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
    install "latexmk/.config/latexmk"
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
    install "mathematica/.Mathematica/Kernel/init.m"                        \
            "mathematica/.Mathematica/FrontEnd/frontend.css"                \
            "mathematica/.Mathematica/Applications"                         \
            "mathematica/.Mathematica/SystemFiles/FrontEnd/TextResources/X" \
            "mathematica/.Mathematica/SystemFiles/FrontEnd/StyleSheets"
}

# :target: matplotlib - matplotlib configuration
__install_matplotlib() {
    install "matplotlib/.config/matplotlib"
}

# :target: mbsync - mbsync configuration
__install_mbsync() {
    install "mbsync/.mbsyncrc"
}

# :target: mpv - mpv media player configuration
__install_mpv() {
    install "mpv/.config/mpv/mpv.conf" "mpv/.config/mpv/input.conf"
}

# :target: msmtp - msmtp configuration
__install_msmtp() {
    # msmtp requires ~/.msmtprc to be rw only by the user.
    install --copy "msmtp/.msmtprc"
    chmod 600 "$HOME/.msmtprc"
}

# :target: mutt - Mutt configuration and profiles
__install_mutt() {
    install "mutt/.mutt" "mutt/.mailcap" "mutt/.urlview"

    # Create cache directories.
    mkdir -vp "$HOME/.cache/mutt/attach"
    mkdir -vp "$HOME/.cache/mutt/notmuch"
    mkdir -vp "$HOME/.cache/mutt/headers"
}

# :target: notmuch - notmuch mail indexer configuration
__install_notmuch() {
    install "notmuch/.notmuch-config"
}

# :target: openbox - openbox stacking window manager
__install_openbox() {
    install "openbox/.config/openbox"
}

# :target: parallel - GNU parallel configuration
__install_parallel() {
    install "parallel/.parallel/config"
}

# :target: proxychains -- proxychains configuration
__install_proxychains() {
    install "proxychains/.proxychains"
}

# :target: qpdfview - qpdfview configuration
__install_qpdfview() {
    install --copy "qpdfview/.config/qpdfview/qpdfview.conf"
    install "qpdfview/.config/qpdfview/shortcuts.conf"
}

# :target: readline - GNU Readline library configuration
__install_readline() {
    install "readline/.inputrc"

    # Cache directory for rlwrap command history.
    mkdir -vp "$HOME/.cache/rlwrap"
}

# :target: rofi - rofi configuration
__install_rofi() {
    install "rofi/.config/rofi"
}

# :target: ssh - SSH config
__install_ssh() {
    install --copy "ssh/.ssh/config"
    mkdir -p "$HOME/.ssh/controlmasters"
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh/"id_*
    chmod 644 "$HOME/.ssh/"id_*.pub
}

# :target: terminfo - terminfo files for less-known terminals
__install_terminfo() {
    install "terminfo/.terminfo"
}

# :target: tint2 - tint2 panel configuration
__install_tint2() {
    install "tint2/.config/tint2"
}

# :target: tmux - tmux configuration
__install_tmux() {
    install "tmux/.tmux" "tmux/.tmux.conf"
}

# :target: vim - Vim configuration and plugins
__install_vim() {
    install "vim/.vimrc" "vim/.vim" "vim/.gvimrc"

    mkdir -vp "$HOME/.cache/vim/swap"
    mkdir -vp "$HOME/.cache/vim/backup"
    mkdir -vp "$HOME/.cache/vim/undo"

    # Create nonstandard spell files if they don't already exist.  If
    # this is not done, Vim will warn each time spellcheck is turned on.
    mkdir -p "$HOME/.vim/spell"
    [[ -f "$HOME/.vim/spell/in" ]] || touch "$HOME/.vim/spell/in"

    # Now, run :mkspell on spell files.
    info "compiling vim spell files"
    find "$HOME/.vim/spell" -type f ! -name '*.spl' \
        -exec vim -e -s -u NONE -c ':mkspell! %' -c ':qall!' {} \;

    # Install plugins.
    "$HOME/.vim/install-plugins"

    # Create a symlink of the snippets directory to ~ for easier access.
    rm -f "$HOME/.snippets"
    ln -v -sf "$HOME/.vim/snippets" "$HOME/.snippets"
}

# :target: wget - wget configuration
__install_wget() {
    install "wget/.wgetrc"
}

# :target: x - X11 configuration
__install_x() {
    install "X/.XCompose" "X/.xinitrc" "X/.Xresources"
    [[ "$DISPLAY" ]] && xrdb -merge "$HOME/.Xresources"
}

# :target: xdg - common configuration used by all X desktop environments
__install_xdg() {
    install "xdg/.config/user-dirs.dirs" \
            "xdg/.local/share/applications"/* \
            "xdg/.local/share/mime/packages"/*

    update-mime-database -V "$HOME/.local/share/mime"
}

# :target: xnview - XnView configuration
__install_xnview() {
    install --copy "xnview/.config/xnviewmp/xnview.ini"
}

# :target: xournalpp - Xournal++ configuration
__install_xournalpp() {
    install --copy "xournalpp/.xournalpp/settings.xml" "xournalpp/.xournalpp/toolbar.ini"
}

# :target: yapf - yapf Python formatter
__install_yapf() {
    install "yapf/.config/yapf"
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
                gnupg
                htop
                ipython
                less
                parallel
                readline
                ssh
                terminfo
                tmux
                vim
                wget
            ) ;;
        default)
            # :group: default - install all targets
            targets+=( $(__fetch_possible_targets) ) ;;
        mail)
            # :group: mail - mutt, mbsync, msmtp, notmuch
            targets+=( mutt mbsync msmtp notmuch ) ;;
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
            __parse_target "${1%/}" ;;
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
git rev-parse --is-inside-work-tree &>/dev/null && git config --local core.hooksPath .githooks

# End of script.
popd &>/dev/null
info "finished setting up configuration files"

# vim: ft=sh fdm=marker et sts=4 sw=4
