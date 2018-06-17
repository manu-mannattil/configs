# vim: ft=sh fdm=marker et sts=4 sw=4

# Bail out if not interactive.
if [[ -z "$PS1" ]]
then
    return
fi

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
    eval $(dircolors "${HOME}/.dir_colors") &>/dev/null
fi

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
export HISTIGNORE="bg:clear:fg:history:ls"

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
alias detox='detox -v'
alias du='du -csh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rgrep='rgrep --color=auto'
alias rm='rm -dvI --one-file-system'
alias rsync='rsync --compress --human-readable --info=progress2 --itemize-changes --progress --protect-args --verbose --stats'
alias tree='tree -C'
alias vidir='vidir -v'

# Silly aliases for faster directory navigation.
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."

# Ag | Less.
alias ag-less='ag --pager "less -cR"'

# Axel with sensible defaults.
alias axel='axel -n 4 -a -U "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36"'

# Don't restrict box-width in cowsay.
alias cowsay='cowsay -n'

# dos2unix and unix2dos using sed.
alias dos2unix='sed -r "s/\r*$//"'
alias unix2dos='sed -r "s/\r*$/\r/"'

# Dateutils: the executables in the official Debian package have `dateutils'
# prefixed in their names, which makes them cumbersome to type.
alias dadd='dateutils.dadd'
alias dconv='dateutils.dconv'
alias ddiff='dateutils.ddiff'
alias dgrep='dateutils.dgrep'
alias dround='dateutils.dround'
alias dseq='dateutils.dseq'
alias dsort='dateutils.dsort'
alias dtest='dateutils.dtest'
alias dzone='dateutils.dzone'
alias strptime='dateutils.strptime'

# Rewrap to 72 columns.
alias fmt='fmt -w 72'

# fzf hacks.
alias fzopen='open $(fzf)'

# Use the colordiff wrapper instead of calling diff directly.
alias diff='colordiff'

# Recursive, non-interative, verbose dtrx.
alias dtrx='dtrx -v -n --one here'

# Ask duff to recurse into directories.
alias duff='duff -r'

# HTML to PDF using wkhtmltopdf
alias html2pdf='wkhtmltopdf'

# Enable readline support for the following programs.
alias dash='rlwrap -a -c dash'
alias gnuplot='rlwrap -pgreen -a -c gnuplot'
alias posh='rlwrap -a -c posh'

# Markdown using Pandoc.
alias markdown='pandoc -S -f markdown+superscript+subscript -t html'

# Clean Markdown and polish punctuation.
alias clean-markdown='pandoc -f markdown -t markdown -S'

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

# Hack to 'sudo' aliases.
alias sudo='sudo '

# TeXPretty with sensible defaults.  Use two spaces for indentation, use
# $ ... $ for inline math, and \begin{equation} ... \end{equation} for
# displaymath.  Also suppresses all errors and warnings.
alias texpretty='texpretty --indent 2 --math-conversions 33 --no-comment-banner --logfile /dev/null'

# HTML -> Text using elinks.
alias html2txt='elinks -force-html -dump'

# Always tell w3m that we're opening HTML files.
alias w3m='w3m -T text/html'

# Colored wdiff
alias wdiff='wdiff --start-delete="$COLOR_BRIGHT_RED" --end-delete="$COLOR_RESET" --start-insert="$COLOR_BRIGHT_GREEN" --end-insert="$COLOR_RESET"'

# What is my external IP?
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

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

# Functions {{{1
# --------------

# cd-gvfs-dir {{{2
# ----------------

# Change directory to the "top-level directory" under which all GVfs
# mountpoints are found.  Devices connected through the Media Transfer
# Protocol (MTP) are usually found in this directory.

cd-gvfs-dir() {
    cd "/run/user/${UID}/gvfs"
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

# mergepath {{{2
# --------------

# usage: mergepath <dir>...
#
# mergeparth simply adds <dir> to $PATH, but also makes sure
# that it's only added once, e.g., mergepath ~/.local/bin

mergepath() {
    for dir
    do
        [[ ":${PATH}:" == *":${dir%/}:"* ]] || export PATH="${dir%/}:$PATH"
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

: ${MUTT_PROFILE:=gmail}
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

# open {{{2
# ---------

# usage: open <file>...
#
# Open a file using exo-open and background it properly.

open() {
    nohup exo-open "$@" </dev/null &>/dev/null
}

# permid {{{2
# -----------

# usage: permid
#
# Create a permanent ID for a document: https://cr.yp.to/bib/documentid.html

permid() {
    head /dev/urandom | md5sum | cut -d ' ' -f 1 | tee /dev/stderr | pbcopy
}

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

# Source local .bashrc if any.
if [[ -f "${HOME}/.bashrc_local" ]]
then
    source "${HOME}/.bashrc_local"
fi

# Bash prompt {{{1
# ----------------

# Print a one-time message if system reboot is required.
if [[ -f "/var/run/reboot-required" ]]
then
    cat "/var/run/reboot-required"
fi

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

# Prevent virtualenv from modifying the prompt by default.
# export VIRTUAL_ENV_DISABLE_PROMPT=1

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
    # local ps1_venv=$([[ "$VIRTUAL_ENV" ]] &&
    #                  echo " ${PS1_BRIGHT_MAGENTA}venv${PS1_BRIGHT_WHITE}:${VIRTUAL_ENV##*/}")

    local ps1_conda=$([[ "$CONDA_DEFAULT_ENV" ]] &&
                      echo " ${PS1_BRIGHT_MAGENTA}conda${PS1_BRIGHT_WHITE}:${CONDA_DEFAULT_ENV##*/}")

    PS1="\n${PS1_BRIGHT_RED}\u${PS1_WHITE}@${PS1_BRIGHT_YELLOW}\h${PS1_WHITE}:${PS1_BRIGHT_GREEN}\w${ps1_conda}${ps1_venv}${ps1_git}\
         \n${PS1_BRIGHT_WHITE}\$${PS1_RESET} "

}
PROMPT_COMMAND="${PROMPT_COMMAND}; __bash_prompt"
