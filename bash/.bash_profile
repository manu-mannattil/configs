# vim: ft=sh fdm=marker et sts=4 sw=4

# If interactive, pick up stuff from ~/.bashrc
if [[ -n "$PS1" && -f "${HOME}/.bashrc" ]]
then
    source "${HOME}/.bashrc"
fi

export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /home/manu/.nix-profile/etc/profile.d/nix.sh ]; then . /home/manu/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
