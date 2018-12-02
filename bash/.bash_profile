# vim: ft=sh fdm=marker et sts=4 sw=4

# If interactive, pick up stuff from ~/.bashrc
if [[ -n "$PS1" && -f "${HOME}/.bashrc" ]]
then
    source "${HOME}/.bashrc"
fi
