# vim: ft=sh fdm=marker et sts=4 sw=4

# Bail out if not interactive.
[[ -n "$PS1" ]] || return

# Shell options {{{1
# ------------------

# Prevent output redirection using '>', '>&', and '<>' from overwriting
# existing files.
set -o noclobber

# Use Vi keybindings. (This is actually not required as I'm setting it in
# ~/.inputrc as well. But some programs don't seem to work if this isn't set.)
set -o vi

# Execute a command name that is the name of a directory as if it were the
# argument to the cd command.
shopt -s autocd

# Correct minor errors in the spelling of a directory component in a cd
# command.
shopt -s cdspell

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Attempt to save all lines of a multiple-line command in the same
# history entry
shopt -s cmdhist

# Attempt spelling correction on directory names during word completion if the
# directory name initially supplied does not exist.
shopt -s dirspell

# Enable extended pattern matching features.
shopt -s extglob

# Make range expressions used in pattern matching bracket expressions behave as
# if in the traditional C locale when performing comparisons.  E.g., [A-Z] will
# now only match uppercase characters.
shopt -s globasciiranges

# Match all files and zero or more directories and subdirectories when the
# pattern ** is uses in a pathname expansion context.
shopt -s globstar

# Append the history list to the file named by the value of the HISTFILE
# variable when the shell exits instead than overwriting the file.
shopt -s histappend

# Give the user an opportunity to reedit a failed history substitution.
shopt -s histreedit

# Disable annoying XON/XOFF flow control.
stty -ixon

# Bash history {{{2
# -----------------

# Preserve history across multiple terminals:
#   Append the new history lines to the history file.
PROMPT_COMMAND="history -a"
#   Append the history lines not already read from the history file to the
#   current history list in memory.
PROMPT_COMMAND="${PROMPT_COMMAND}; history -n"

# The file in which command history is saved.
# NOTE (2018-05-26): For reasons I don't fully understand, readline screws up
# the history-search-forward/backward functions (set in ~/.inputrc) when the
# first line of $HISTFILE is _not_ a blank line.  Basically, a two word command
# like `echo a' gets completed twice if the first line of $HISTFILE isn't
# a blank line.
export HISTFILE="${HOME}/.cache/bash_history"

# Don't restrict history file's size at all.
export HISTFILESIZE=""
export HISTSIZE=""

# Only keep unique lines in the history file.
export HISTCONTROL=ignoreboth:erasedups

# Appends time stamps (as seconds since the Unix epoch) to the commands
# in the history file.  The HISTTIMEFORMAT variable is used to format
# this into a human readable date when the history command is invoked.
export HISTTIMEFORMAT="%Y-%m-%d %H:%M %Z "

# Ignore commands matched by the following colon-separated patterns.
# Patterns are extended patterns if extglob is set.
export HISTIGNORE="bg:clear:fg:history:ls:rm *:aria2c *:find *-delete*:"

# Store history files for commands wrapped with rl-wrap in separate directory.
export RLWRAP_HOME="${HOME}/.cache/rlwrap"

# Colors {{{2
# -----------

# Dark colors [0 - 7].
export          COLOR_BLACK=$'\E[38;5;0m'
export            COLOR_RED=$'\E[38;5;1m'
export          COLOR_GREEN=$'\E[38;5;2m'
export         COLOR_YELLOW=$'\E[38;5;3m'
export           COLOR_BLUE=$'\E[38;5;4m'
export        COLOR_MAGENTA=$'\E[38;5;5m'
export           COLOR_CYAN=$'\E[38;5;6m'
export          COLOR_WHITE=$'\E[38;5;7m'

# Bright colors [8 - 15].
export   COLOR_BRIGHT_BLACK=$'\E[38;5;8m'
export     COLOR_BRIGHT_RED=$'\E[38;5;9m'
export   COLOR_BRIGHT_GREEN=$'\E[38;5;10m'
export  COLOR_BRIGHT_YELLOW=$'\E[38;5;11m'
export    COLOR_BRIGHT_BLUE=$'\E[38;5;12m'
export COLOR_BRIGHT_MAGENTA=$'\E[38;5;13m'
export    COLOR_BRIGHT_CYAN=$'\E[38;5;14m'
export   COLOR_BRIGHT_WHITE=$'\E[38;5;15m'

export          COLOR_RESET=$'\E[0m'

# Aliases {{{1
# ------------

# Clear all aliases before starting
unalias -a &>/dev/null

# Make things more verbose and meaningful, pretty print stuff, ask
# before overwriting files, vi keybindings, etc.
alias chmod='chmod --preserve-root'
alias cp='cp -iv'
alias du='du -csh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rgrep='rgrep --color=auto'
alias rm='rm -dvI --one-file-system'
alias rsync='rsync --human-readable --info=progress2 --itemize-changes --partial --progress --protect-args --verbose --stats'
alias tree='tree -C'
alias vidir='vidir -v'

# Silly aliases for faster directory navigation.
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."

# Axel with sensible defaults.
alias axel='axel -n 4 -a -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36"'

# Show calendar 2 months before and 3 months after current month.
alias cal='ncal -A 3 -B 2'

# Don't restrict box-width in cowsay.
alias cowsay='cowsay -n'

# Write to the physical medium before exiting.  Important when making bootable
# Linux USB sticks.
alias dd='dd conv=fdatasync'

# dos2unix and unix2dos using sed.
alias dos2unix='sed -r "s/\r*$//"'
alias unix2dos='sed -r "s/\r*$/\r/"'

# CLI Emacs.
alias emacs='emacs -nw'

# Remove useless info (e.g., compilation flags) when using ffmpeg.
alias ffmpeg='ffmpeg -hide_banner'

# Rewrap to 72 columns.
alias fmt='fmt -w 72'

# fzf hacks.
alias fzopen='open $(fzf)'

# Use the colordiff wrapper instead of calling diff directly.
alias diff='colordiff'

# Ask duff to recurse into directories.
alias duff='duff -r'

# Always run docker as root.
alias docker='sudo docker'

# HTML to PDF using wkhtmltopdf
alias html2pdf='wkhtmltopdf'

# Enable readline support for the following programs.
alias dash='rlwrap -a -c dash'
alias gnuplot='rlwrap -pgreen -a -c gnuplot'
alias posh='rlwrap -a -c posh'

# Don't compress raster images embedded in PDFs.
alias pdfsizeopt='pdfsizeopt --do-optimize-images=no'

# Toggle redshift.
alias redtoggle='pkill -USR1 redshift'

# Use compression when using scp.
alias scp='scp -C'

# Don't run vi.
alias vi='vim'

# Markdown using Pandoc.
alias markdown='pandoc -S -f markdown+superscript+subscript -t html'

# Threaded pdf2djvu.
alias pdf2djvu='pdf2djvu -j0'

# Embed fonts while converting PS to PDF.
alias ps2pdf='ps2pdf -dEmbedAllFonts=true'

# PDF to EPS using pdftops.
alias pdf2eps='pdftops -f 1 -l 1 -eps'

# PDF to TXT that preserves layout
alias pdf2txt='pdftotext -layout'

# Overwrite 5 times, fill up with zeroes, and then delete.
alias shred='shred -vzfun 5'

# Hack to 'sudo' aliases; also preserve environment.
alias sudo='sudo -E '

# HTML -> Text using elinks.
alias html2txt='elinks -force-html -dump'

# Always tell w3m that we're opening HTML files.
alias w3m='w3m -T text/html'

# Colored wdiff.
alias wdiff='wdiff --start-delete="$COLOR_BRIGHT_RED" --end-delete="$COLOR_RESET" --start-insert="$COLOR_BRIGHT_GREEN" --end-insert="$COLOR_RESET"'

# Online tools.
alias myip='curl -qsL http://icanhazip.com'
alias weather='curl -q http://wttr.in/?m'

# less configuration {{{1
# -----------------------

# Options for less.  See less(1) for more.
export LESS="-cfiJMR -j .5"
export LESSHISTFILE="${HOME}/.cache/lesshst"
export LESSHISTSIZE="5000"

# Enhance less using lesspipe.
if command -v lesspipe &>/dev/null
then
    eval $(lesspipe)
fi

# Colored man pages!
export LESS_TERMCAP_mb=$'\E[5m'                 # begin blinking
export LESS_TERMCAP_md=$'\E[1;38;5;12m'         # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end bold
export LESS_TERMCAP_se=$'\E[0m'                 # end highlight
export LESS_TERMCAP_so=$'\E[38;5;0m\E[48;5;11m' # begin highlight
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[4;38;5;13m'         # begin underline

# fasd {{{1
# ---------

if command -v fasd &>/dev/null
then
    eval "$(fasd --init auto)"

    # Get rid of default fasd aliases.
    unalias a d f s sd sf z zz

    alias d='fasd_cd -d'
    alias di='fasd_cd -d -i'
    alias o='fasd -e open'
    alias v='fasd -f -e vim'
    alias vv='fasd -f -e e'
fi

# Functions {{{1
# --------------

# cd {{{2
# -------

# cd with automatic sourcing of .env files.
# A leaner NIH version of autoenv: https://github.com/hyperupcall/autoenv
cd() {
    if builtin cd "$@"
    then
        if [[ -f ".env" ]] && [[ "$PWD" != "$AUTOENV_ROOT" ]]
        then
            source ".env"
            export AUTOENV_ROOT="$PWD"

            if [[ -f ".env.leave" ]]
            then
                export AUTOENV_LEAVE="$PWD/.env.leave"
            else
                unset -v AUTOENV_LEAVE
            fi
        fi

        # If there's an .env.leave file, and we're not in a child
        # directory of the directory containing the .env file, then
        # source the .env.leave file.
        if [[ "$AUTOENV_LEAVE" ]] && [[ "$PWD"/ != "$AUTOENV_ROOT"/* ]]
        then
            source "$AUTOENV_LEAVE"
            unset -v AUTOENV_ROOT AUTOENV_LEAVE
        fi

        return 0
    else
        return $?
    fi
}

# plmgr {{{2
# ----------

: ${PLMGR_PLAYLIST_DIR:="${HOME}/music/playlists"}
: ${PLMGR_PLAYLIST_DEFAULT:="miscellaneous.m3u"}

_plmgr() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local opts='-a -r'

    COMPREPLY=()

    if [[ "$cur" == -* ]]
    then
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    else
        # Make sure that `-a' isn't present in the arguments.
        for arg in "${COMP_WORDS[@]}"
        do
            [[ "$arg" == '-a' ]] && return 0
        done

        COMPREPLY=( $(CDPATH= cd "$PLMGR_PLAYLIST_DIR"
                      compgen -A file -X '!*.m3u' -- "$cur") )
    fi

    return 0
}
complete -F _plmgr plmgr

# ls {{{2
# -------

ls() {
    # If the single-column output of ls fits the terminal window,
    # prefer that, otherwise use the usual output.
    if (( $(wc -l < <(command ls -1 "$@" 2>/dev/null)) < "$LINES" ))
    then
        command ls -1 --color=auto --group-directories-first -hF "$@"
    else
        command ls --color=auto --group-directories-first -hF "$@"
    fi
}

# lyrics {{{2
# -----------

# usage: lyrics [<args>] [<keyword>...]
#
# A wrapper function around my lyrics script.

lyrics() {
    while [[ "$1" ]]
    do
        case "$1" in
            -*) local args+=("$1")     ;;
            *)  local keywords+=("$1") ;;
        esac
        shift
    done

    if [[ "${keywords[@]}" ]]
    then
        command lyrics "${args[@]}" "${keywords[@]}"
    else
        # If no keyword is supplied, see if there's a song
        # playing in DeaDBeeF.
        command lyrics "${args[@]}" $(deadbeef --nowplaying '%a %t' 2>/dev/null)
    fi
}

# mbsync {{{2
# -----------

# usage: mbsync [<arg>...]
#
# An mbsync wrapper that adds some trimmings like running notmuch right
# after synchronization and printing the number of new messages.

mbsync() {
    [[ "$*" ]] || set -- "$MUTT_PROFILE"
    command mbsync "$@" && notmuch new && {
        # Print number of new messages in each folder.  Unlike OfflineIMAP,
        # mbsync's output is somewhat cryptic and it's not always clear
        # which folders have new messages.
        cd ~/mail
        find -type f -path '*/new/*' -not -path '*/spam/*' \
                     -not -path '*/trash/*' | awk -F / '
            /^\./ {
                count[$2 "/" $3] += 1
            }

            END {
                for (folder in count)
                    printf("%s: %s\n", folder, count[folder])
            }
        '
        cd "$OLDPWD"
    }
}

# mergepath {{{2
# --------------

# usage: mergepath [-v <var>] [-s <sep>] <arg>...
#
# mergepath simply adds <arg> to the contents of the variable <var>
# (by default PATH) after separating it with separator <sep> (by default :),
# but also makes sure that it's only added once.  Some examples:
#
#   mergepath ~/.local/bin
#   mergepath -v MANPATH ~/conda/share/man/

mergepath() {
    local var="PATH" sep=":"
    declare OPTARG OPTIND
    while getopts ":v:s:" opt
    do
        case "$opt" in
            v)  var="$OPTARG" ;;
            s)  sep="$OPTARG" ;;
        esac
    done
    shift $(( OPTIND - 1 ))

    for arg
    do
        [[ "${sep}${!var}${sep}" == *"${sep}${arg%/}${sep}"* ]] || {
            export $var="${arg%/}${sep}${!var}"
        }
    done
}

# mutt {{{2
# ---------

# usage: mutt [<arg>...]
#
# If the first argument is an option recognized by Mutt or
# contains the `@' character, the entire list of arguments
# is passed over to Mutt.  Otherwise, it is assumed to be
# the name of the profile one would like to use.
#
# NOTE: It's advisable to set the default MUTT_PROFILE variable in
# /etc/environment so as to make it the default profile when mutt is
# called outside this function.

: ${MUTT_PROFILE_DIR:="${HOME}/.mutt/profiles"}

mutt() {
    if [[ "$1" =~ (^-[aAbcdDefFhHimnpQRsvxyzZ-]|^mailto:|.*@.*|^$) ]]
    then
        command mutt "$@"
    elif [[ -f "${MUTT_PROFILE_DIR}/${1}" ]]
    then
        MUTT_PROFILE="$1" command mutt "${@:2}"
    else
        echo >&2 "mutt: invalid option or profile -- '${1}'"
        return 1
    fi
}

_mutt() {
    # Only complete if we're on the first argument.
    [[ "$COMP_CWORD" = 1 ]] || return 0
    COMPREPLY=( $(CDPATH= cd "$MUTT_PROFILE_DIR"
                  compgen -A file -- "${COMP_WORDS[COMP_CWORD]}") )
}
complete -F _mutt mutt

# mux {{{2
# --------

# usage: mux [<session-script>]
#
# A dumb tmux sessions `manager'.

: ${TMUX_SESSIONS_DIR:="${HOME}/.tmux"}
: ${TMUX_DEFAULT_SESSION:="default"}

mux() {
    if [[ "$*" ]]
    then
        if [[ -f "$1" ]]
        then
            bash "$1"
        elif [[ -f "${TMUX_SESSIONS_DIR}/${1}.tmux" ]]
        then
            bash "${TMUX_SESSIONS_DIR}/${1}.tmux"
        else
            echo >&2 "mux: '${1}': no such session script"
            return 1
        fi
    else
        mux "$TMUX_DEFAULT_SESSION"
    fi
}

_mux() {
    # Only complete if we're on the first argument.
    [[ "$COMP_CWORD" = 1 ]] || return 0

    # All .tmux files in the TMUX_SESSIONS_DIR without the
    # .tmux extension.
    COMPREPLY=( $(CDPATH= cd "$TMUX_SESSIONS_DIR"
                  compgen -A file -X '!*.tmux' -- "${COMP_WORDS[COMP_CWORD]}") )
    COMPREPLY=( "${COMPREPLY[@]/%.tmux/}" )

    return 0
}
complete -F _mux mux

# Exports {{{1
# ------------

# Recognize emulators that support 256 colors, but don't set $TERM properly.
if [[ "$TERM" = "xterm" ]]
then
    if [[ "$COLORTERM" = "gnome-terminal" ||
          "$COLORTERM" = "xfce4-terminal" ||
          "$VTE_VERSION" ]]
    then
        export TERM="xterm-256color"
    fi
fi

export SDCV_PAGER="sdcv-prettify --color | less"

# Length of line in man(1).
export MANWIDTH=80

# Set up $LS_COLORS.
if [[ -f "${HOME}/.dir_colors" ]]
then
    eval $(dircolors "${HOME}/.dir_colors")
else
    eval $(dircolors)
fi

# Set the PATH.
mergepath "${HOME}/code/bin" "${HOME}/.local/bin"

# Note that fc(1) in vi-mode uses $VISUAL instead of $FCEDIT.
export EDITOR="/usr/bin/vim"
export FCEDIT="$EDITOR" VISUAL="$EDITOR"

# Preferred web browser.
export BROWSER="firefox"

# Java applications: (i) pick up font settings from system, (ii) antialias text.
export JDK_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Set locale properly.  Ubuntu sets LANG to en_IN if IST is selected as the
# time zone.  But many programs (e.g., tmux) don't understand en_IN.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Default Mutt profile.
export MUTT_PROFILE="posteo"

# 3 minutes to clear the clipboard after copying a password.
export PASSWORD_STORE_CLIP_TIME=180

# Location of password store git repo.
export PASSWORD_STORE_DIR="${HOME}/documents/.password-store"

# Default pager.
export PAGER="less"
export MANPAGER="less"

# File that's imported when the CPython interpreter is called interactively.
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

# Don't save sdcv history.
export SDCV_HISTSIZE=0

# Local TEXMF directory.
export TEXMFHOME="${HOME}/.texmf"

# Preferred terminal emulator.
export TERMINAL="${HOME}/code/scripts/terminal"

# Will reduce the time it takes for xdg-open to figure out that the DE
# is a generic one.
export XDG_CURRENT_DESKTOP="X-Generic"

# Sourced files {{{1
# ------------------

# Setup Bash completion.
if [[ -f /usr/share/bash-completion/bash_completion ]]
then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]
then
    source /etc/bash_completion
fi

# Prevent Bash completion from using /etc/hosts entries as SSH
# hostnames.  See /usr/share/bash-completion/bash_completion
export COMP_KNOWN_HOSTS_WITH_HOSTFILE=
export BASH_COMPLETION_KNOWN_HOSTS_WITH_HOSTFILE=

# Source local .bashrc if any.
[[ -f "${HOME}/.bashrc_local" ]] && source "${HOME}/.bashrc_local"

# Source .env file if any.  This is a security risk!
[[ -f ".env" ]] && source ".env"

# Bash prompt {{{1
# ----------------

# Print a one-time message if system reboot is required.
[[ -f "/var/run/reboot-required" ]] && cat "/var/run/reboot-required"

# Wrap colors in in \[ and \] for use in prompt.
# See: http://mywiki.wooledge.org/BashFAQ/053
# Dark colors [0 - 7].
export          PS1_BLACK="\[$COLOR_BLACK\]"
export            PS1_RED="\[$COLOR_RED\]"
export          PS1_GREEN="\[$COLOR_GREEN\]"
export         PS1_YELLOW="\[$COLOR_YELLOW\]"
export           PS1_BLUE="\[$COLOR_BLUE\]"
export        PS1_MAGENTA="\[$COLOR_MAGENTA\]"
export           PS1_CYAN="\[$COLOR_CYAN\]"
export          PS1_WHITE="\[$COLOR_WHITE\]"

# Bright colors [8 - 15].
export   PS1_BRIGHT_BLACK="\[$COLOR_BRIGHT_BLACK\]"
export     PS1_BRIGHT_RED="\[$COLOR_BRIGHT_RED\]"
export   PS1_BRIGHT_GREEN="\[$COLOR_BRIGHT_GREEN\]"
export  PS1_BRIGHT_YELLOW="\[$COLOR_BRIGHT_YELLOW\]"
export    PS1_BRIGHT_BLUE="\[$COLOR_BRIGHT_BLUE\]"
export PS1_BRIGHT_MAGENTA="\[$COLOR_BRIGHT_MAGENTA\]"
export    PS1_BRIGHT_CYAN="\[$COLOR_BRIGHT_CYAN\]"
export   PS1_BRIGHT_WHITE="\[$COLOR_BRIGHT_WHITE\]"

export          PS1_RESET="\[$COLOR_RESET\]"

# Keep at most 5 directories in PS1 paths.
export PROMPT_DIRTRIM=5

# Show more git info in PS1.
# See /usr/lib/git-core/git-sh-prompt for documentation.
export GIT_PS1_DESCRIBE_STYLE=default
export GIT_PS1_SHOWCOLORHINTS=yes
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_SHOWSTASHSTATE=yes
export GIT_PS1_SHOWUNTRACKEDFILES=yes
export GIT_PS1_SHOWUNTRACKEDFILES=yes
export GIT_PS1_SHOWUPSTREAM=auto

__bash_prompt() {
    local ps1_git=$(git rev-parse --is-inside-work-tree &>/dev/null &&
                    echo " ${PS1_BRIGHT_CYAN}git${PS1_BRIGHT_WHITE}:$(__git_ps1 '%s')")
    local ps1_conda=$([[ "$CONDA_DEFAULT_ENV" ]] &&
                      echo " ${PS1_BRIGHT_MAGENTA}conda${PS1_BRIGHT_WHITE}:${CONDA_DEFAULT_ENV##*/}")

    PS1="\n${PS1_BRIGHT_RED}\u${PS1_WHITE}@${PS1_BRIGHT_YELLOW}\h${PS1_WHITE}:${PS1_BRIGHT_GREEN}\w${ps1_conda}${ps1_venv}${ps1_git}\
         \n${PS1_BRIGHT_WHITE}\$${PS1_RESET} "
}
PROMPT_COMMAND="${PROMPT_COMMAND}; __bash_prompt"
