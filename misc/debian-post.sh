#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# debian-post.sh -- Debian post-installation script
#
# Usage: debian-post.sh
#
# This is a post-installation script to install some packages and setup
# the system the way I want it after a fresh Debian install from the
# netinst ISO.  However, since all the packages I want aren't available
# in the Debian repositories, some packages need to be manually
# installed:
#
#   DeaDBeeF FB plugin    https://gitlab.com/zykure/deadbeef-fb/tree/release/binary
#   fzf                   https://github.com/junegunn/fzf-bin/releases
#                         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
#   Geekbench             https://www.geekbench.com/download/linux/
#   Google Chrome         https://www.google.com/chrome
#   JSMin                 https://raw.githubusercontent.com/douglascrockford/JSMin/master/jsmin.c
#   krop                  http://arminstraub.com/software/krop
#   PDF Scale             https://github.com/tavinus/pdfScale/releases
#   pdfsizeopt            https://github.com/pts/pdfsizeopt
#   rclone                https://rclone.org/downloads
#   restic                https://github.com/restic/restic/releases
#                         https://github.com/restic/rest-server/releases
#   Skype                 https://go.skype.com/skypeforlinux-64.deb
#
# The following programs usually have outdated versions in the Debian
# repositories, therefore it makes sense to install them manually:
#
#   Calibre               http://calibre-ebook.com/download_linux
#   Latexmk               http://personal.psu.edu/jcc8/software/latexmk-jcc/versions.html
#   Pass                  https://git.zx2c4.com/password-store/
#   youtube-dl            http://rg3.github.io/youtube-dl/download.html
#

set -eu
set -o pipefail

# Jump to the script directory.
pushd "$(dirname "$(readlink -f -- "$0")")"

# Always run as root.
[[ $(id -u) == 0 ]] || exec sudo -- "$0" "$@"

# PPAs {{{1
# ---------

PPAS=(
  ppa:costamagnagianfranco/borgbackup # Borg backup
  ppa:pmjdebruijn/darktable-release   # Darktable
  ppa:starws-box/deadbeef-player      # DeaDBeeF
  ppa:micahflee/ppa                   # Onionshare, Tor browser launcher, etc.
  ppa:dhor/myway                      # RawTherapee
  ppa:linrunner/tlp                   # TLP (Advanced Power Management for Linux)
)

# Packages {{{1
# -------------

PACKAGES=(
  agrep
  android-tools-adb
  android-tools-fastboot
  apt-file
  arandr
  aria2
  atril
  audacity
  axel
  bc
  biber
  bibtool
  borgbackup
  borgbackup-doc
  brightnessctl
  build-essential
  bzr
  bzrtools
  cdbs
  cmake
  colordiff
  compton
  cowsay
  cryptsetup
  cuetools
  curl
  cvs
  darcs
  darktable
  dateutils
  debhelper
  dh-make
  diction
  diffutils
  djview-plugin
  djview4
  djvulibre-bin
  dmg2img
  dmz-cursor-theme
  duff
  elinks
  elinks-doc
  emacs
  evince
  exfat-fuse
  exfat-utils
  exif
  exiftran
  extundelete
  exuberant-ctags
  fakeroot
  ffmpeg
  figlet
  filezilla
  firefox-esr
  firejail
  fonts-font-awesome
  fonttools
  foremost
  fortune-mod
  fortunes
  fortunes-off
  fuseiso
  fwupd
  gawk
  geogebra
  gimp
  gimp-data-extras
  gimp-gap
  gimp-help-en
  gimp-lensfun
  gimp-plugin-registry
  git
  git-cvs
  git-email
  git-gui
  git-svn
  gmic
  gnome-themes-extra
  gnupg
  gnuplot-doc
  gnuplot-qt
  gpac
  gparted
  gpgv2
  groff
  gsfonts
  gsmartcontrol
  gv
  gvfs
  gvfs-backends
  hardinfo
  hexchat
  htop
  hugin
  i3
  iat
  id3v2
  indent
  indent-doc
  ink-generator
  inkscape
  input-utils
  iotop
  ipe
  jmtpfs
  jq
  key-mon
  krb5-user
  ksh
  lame
  libimage-exiftool-perl
  libnotify-bin
  libreoffice
  libreoffice-gtk3
  libsox-fmt-mp3
  libtext-lorem-perl
  libxml2-utils
  liferea
  lintian
  lm-sensors
  luminance-hdr
  lynx
  lyx
  macchanger
  manpages-posix
  mawk
  mediainfo
  mercurial
  mesa-utils
  mosh
  mpv
  msmtp
  mtr
  mutt
  nautilus
  notmuch
  notmuch-mutt
  offlineimap
  openssh-client
  openssh-server
  p7zip-rar
  pandoc
  pandoc-citeproc
  par
  parallel
  patch
  pavucontrol
  pbuilder
  pdf2djvu
  pdfcrack
  pdfgrep
  pdfshuffler
  pinentry-curses
  pinentry-gtk2
  playonlinux
  pngcrush
  poppler-utils
  posh
  powertop
  psmisc
  pulseaudio
  pv
  python3-dev
  python3-venv
  python3-wheel
  qpdfview
  qrencode
  quilt
  rawtherapee
  rename
  rlwrap
  rxvt-unicode-256color
  scalpel
  screen
  scrot
  sdcv
  shellcheck
  shntool
  shotwell
  sloccount
  sox
  spacefm
  sshfs
  stellarium
  stow
  stress
  subversion
  subversion-tools
  sysvinit-utils
  tcc
  tesseract-ocr
  tesseract-ocr-eng
  testdisk
  texlive-full
  thinkfan
  tlp
  tlp-rdw
  tmux
  toilet
  tor
  tree
  ttf-xfree86-nonfree
  tty-clock
  uchardet
  udevil
  units
  unzip
  urlview
  vim
  vim-doc
  vim-gtk3
  vlc
  w3m
  w3m-img
  whois
  wine
  wkhtmltopdf
  wmctrl
  x11-apps
  x11-xserver-utils
  xautolock
  xbacklight
  xclip
  xdotool
  xinput
  xsel
  xserver-xorg
  xserver-xorg-video-intel
  zeal
  zip
  zsh
# checkinstall
# containerd.io
# docker-ce
# docker-ce-cli
# gnome-themes-ubuntu
# torbrowser-launcher
# ubuntu-drivers-common
# ubuntu-restricted-extras
)

# Optimization {{{1
# -----------------

# Disable the following systemd units since I don't really make any
# practical use of them.  Analyze each unit by looking at the output of
#
#   systemd-analyze blame
#   systemctl list-units --all
#
DISABLE_UNITS=(
  # APT related automatic cleanup, download, etc.
  apt-daily.service apt-daily-upgrade.service
  apt-daily.timer apt-daily-upgrade.timer

  # Message of the day spam.
  # motd-news.timer motd.service motd-news.service

  # Tor daemon.  It's better to start it when needed.
  tor.service tor@default.servick

  # DBus activated daemon for mobile broadband interface.
  ModemManager.service

  # Zeroconf and mDNS/DNS-SD service discovery.
  avahi-daemon.service avahi-daemon.socket

  # Bluetooth support.
  bluetooth.service

  # Dialup Internet related stuff.
  pppd-dns.service

  # Disable automatic updates (even security related).
  # unattended-upgrades.service

  # S.M.A.R.T test service.
  smartd.service
)

# Host-specific packages {{{1
# ---------------------------

case "$HOSTNAME" in
  # Dell Inspiron 3442.
  carbon)
    PACKAGES+=(
      bcmwl-kernel-source # Broadcom Wi-Fi drivers.
    )
    ;;
  # ThinkPad P43s.
  boron)
    PACKAGES+=(
      acpi-call-dkms    # Kernel module that enables you to call ACPI methods
      nvidia-driver-430 # Transitional package for nvidia-driver-435
      tp-smapi-dkms     # ThinkPad hardware/firmware access modules source - dkms version
    )
esac

# Installation {{{1
# -----------------

# Docker.
# curl -qfsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# add-apt-repository --yes --no-update \
#   "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
#   echo >&2 "added docker repository"

#apt update
#apt upgrade --yes
#apt install --yes "${PACKAGES[@]}"
apt autoremove --yes
apt clean --yes


# Disable systemd units {{{1
# --------------------------

# Now, disable the systemd units that we don't use.  However, use
# `disable' instead of `mask' since the services ought to be started if
# they are required.
for unit in "${DISABLE_UNITS[@]}"
do
  systemctl disable --now "$unit"
done

# # Miscellaneous {{{1
# # ------------------

# # Disable message of the day spam.
# chmod -x /etc/update-motd.d/*

# popd
# echo >&2 "finished post-install script"
