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
#   DeaDBeeF              https://deadbeef.sourceforge.io/download.html
#   fasd                  https://github.com/clvv/fasd/tarball/1.0.1
#   fzf                   https://github.com/junegunn/fzf-bin/releases
#                         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
#   Geekbench             https://www.geekbench.com/download/linux/
#   Google Chrome         https://www.google.com/chrome
#   JSMin                 https://raw.githubusercontent.com/douglascrockford/JSMin/master/jsmin.c
#   PDF Scale             https://github.com/tavinus/pdfScale/releases
#   rclone                https://rclone.org/downloads
#   restic                https://github.com/restic/restic/releases
#                         https://github.com/restic/rest-server/releases
#   Skype                 https://go.skype.com/skypeforlinux-64.deb
#   Xournal++             https://github.com/xournalpp/xournalpp/releases
#
# The following programs usually have outdated versions in the Debian
# repositories, therefore it makes sense to install them manually:
#
#   Calibre               http://calibre-ebook.com/download_linux
#   Latexmk               http://personal.psu.edu/jcc8/software/latexmk-jcc/versions.html
#   Pass                  https://git.zx2c4.com/password-store/
#   mktorrent             https://github.com/pobrn/mktorrent/archive/master.zip
#   youtube-dl            http://rg3.github.io/youtube-dl/download.html
#

set -eu
set -o pipefail

# Jump to the script directory.
pushd "$(dirname "$(readlink -f -- "$0")")"

# Always run as root.
[[ $(id -u) == 0 ]] || exec sudo -- "$0" "$@"

# Packages {{{1
# -------------

PACKAGES=(
  agrep
  android-tools-adb
  android-tools-fastboot
  apt-file
  apt-transport-https
  arandr
  aria2
  atril
  audacity
  axel
  bc
  biber
  bibtool
  brightnessctl
  build-essential
  bzr
  bzrtools
  ca-certificates
  cdbs
  cmake
  colordiff
  compton
  cowsay
  cryptsetup
  cuetools
  curl
  curl
  cvs
  darcs
  darktable
  dateutils
  debhelper
  dh-make
  diction
  diffutils
  djview4
  djview-plugin
  djvulibre-bin
  dmg2img
  duff
  elinks
  elinks-doc
  emacs
  engrampa
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
  gnome-icon-theme
  gnome-themes-extra
  gnupg
  gnupg-agent
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
  i965-va-driver-shaders
  iat
  id3v2
  indent
  indent-doc
  ink-generator
  inkscape
  input-utils
  intel-media-va-driver-non-free
  iotop
  ipe
  jmtpfs
  jq
  key-mon
  krb5-user
  krop
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
  pdftk
  pinentry-curses
  pinentry-gtk2
  playonlinux
  pngcrush
  poppler-utils
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
  software-properties-common
  sox
  spacefm-gtk3
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
  units
  unrar
  unzip
  urlview
  vlc
  w3m
  w3m-img
  whois
  wine
  wkhtmltopdf
  wmctrl
  zeal
  zip

  # Shells
  ksh
  posh
  zsh

  # Docker.
  containerd.io
  docker-ce
  docker-ce-cli

  # Vim
  vim
  vim-doc
  vim-gtk3

  # X
  xserver-xorg
  xserver-xorg-video-intel

  # X utilities
  hsetroot
  xautolock
  xbacklight
  xclip
  xdotool
  xinput
  xsel
)

REMOVE_PACKAGES=(
  unattended-upgrades
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
  unattended-upgrades.service

  # S.M.A.R.T test service.
  smartd.service

  # Docker.
  docker.service
  containerd.service
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
      tp-smapi-dkms       # ThinkPad hardware/firmware access modules source - dkms version
    )
esac

# Installation {{{1
# -----------------

# Docker.
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
echo >&2 "added docker repository"

apt update
apt upgrade --yes
apt install --yes "${PACKAGES[@]}"
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

popd
echo >&2 "finished post-install script"
