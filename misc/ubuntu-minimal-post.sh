#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# ubuntu-minimal-post.sh -- Ubuntu post-installation script
#
# Usage: ubuntu-minimal-post.sh
#
# This is a post-installation script to install some packages and setup
# the system the way I want it after a fresh Ubuntu install from the
# mini ISO.  However, since all the packages I want aren't available on
# the Ubuntu repositories, some packages need to be manually installed:
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
# The following programs usually have outdated versions in the
# Debian/Ubuntu repositories, therefore it makes sense to install them
# manually:
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
  agrep                    # text search tool with support for approximate patterns
  android-tools-adb        # Android device bridge
  android-tools-fastboot   # Android fastboot
  apt-file                 # search for files within Debian packages (command-line interface)
  arandr                   # Simple visual front end for XRandR
  aria2                    # High speed download utility
  atril                    # MATE document viewer
  audacity                 # fast, cross-platform audio editor
  axel                     # light command line download accelerator
  bc                       # GNU bc arbitrary precision calculator language
  biber                    # Much-augmented BibTeX replacement for BibLaTeX users
  bibtool                  # tool to manipulate BibTeX files
  borgbackup               # deduplicating and compressing backup program
  borgbackup-doc           # deduplicating and compressing backup program (documentation)
  brightnessctl            # Control backlight brightness
  build-essential          # Informational list of build-essential packages
  bzr                      # easy to use distributed version control system
  bzrtools                 # Collection of tools for bzr
  cdbs                     # common build system for Debian packages
  checkinstall             # installation tracker
  cmake                    # cross-platform, open-source make system
  colordiff                # tool to colorize 'diff' output
  compton                  # compositor for X11, based on xcompmgr
  cowsay                   # configurable talking cow
  cryptsetup               # disk encryption support - startup scripts
  cuetools                 # tools for manipulating CUE/TOC files
  curl                     # command line tool for transferring data with URL syntax
  cvs                      # Concurrent Versions System
  darcs                    # distributed, interactive, smart revision control system
  darktable                # Virtual lighttable and darkroom for photographers
  dateutils                # nifty command line date and time utilities
  deadbeef                 # Audio player for GNU/Linux systems with X11
  debhelper                # helper programs for debian/rules
  dh-make                  # tool that converts source archives into Debian package source
  diction                  # Utilities to help with style and diction (English and German)
  diffutils                # File comparison utilities
  djview4                  # Viewer for the DjVu image format
  djview-plugin            # Browser plugin for the DjVu image format
  djvulibre-bin            # Utilities for the DjVu image format
  dmg2img                  # Tool for converting compressed dmg files to hfsplus images
  dmz-cursor-theme         # Style neutral, scalable cursor theme
  duff                     # Duplicate file finder
  elinks                   # advanced text-mode WWW browser
  elinks-doc               # advanced text-mode WWW browser - documentation
  emacs                    # GNU Emacs editor
  exfat-fuse               # read and write exFAT driver for FUSE
  exfat-utils              # utilities to create, check, label and dump exFAT filesystem
  exif                     # command-line utility to show EXIF information in JPEG files
  exiftran                 # digital camera JPEG image transformer
  extundelete              # utility to recover deleted files from ext3/ext4 partition
  exuberant-ctags          # build tag file indexes of source code definitions
  fakeroot                 # tool for simulating superuser privileges
  ffmpeg                   # Tools for transcoding, streaming and playing of multimedia files
  figlet                   # Make large character ASCII banners out of ordinary text
  filezilla                # Full-featured graphical FTP/FTPS/SFTP client
  firefox                  # Safe and easy web browser from Mozilla
  firejail                 # sandbox to restrict the application environment
  fonts-font-awesome       # iconic font designed for use with Twitter Bootstrap
  fonttools                # Converts OpenType and TrueType fonts to and from XML
  foremost                 # forensic program to recover lost files
  fortune-mod              # provides fortune cookies on demand
  fortunes                 # Data files containing fortune cookies
  fortunes-off             # Data files containing offensive fortune cookies
  fuseiso                  # FUSE module to mount ISO filesystem images
  fwupd                    # Firmware update daemon
  gawk                     # GNU awk, a pattern scanning and processing language
  geogebra                 # Dynamic mathematics software for education
  gimp-data-extras         # Extra brushes and patterns for GIMP
  gimp-gap                 # animation package for the GIMP
  gimp                     # GNU Image Manipulation Program
  gimp-help-en             # Documentation for the GIMP (English)
  gimp-lensfun             # Gimp plugin to correct lens distortion using the lensfun library
  gimp-plugin-registry     # repository of optional extensions for GIMP
  git-cvs                  # fast, scalable, distributed revision control system (cvs interoperability)
  git-email                # fast, scalable, distributed revision control system (email add-on)
  git                      # fast, scalable, distributed revision control system
  git-gui                  # fast, scalable, distributed revision control system (GUI)
  git-svn                  # fast, scalable, distributed revision control system (svn interoperability)
  gmic                     # GREYC's Magic for Image Computing
  gnome-themes-extra       # Adwaita GTK+ 2 theme — engine
  gnome-themes-ubuntu      # Ubuntu community themes
  gnupg                    # GNU privacy guard - a free PGP replacement
  gnuplot-doc              # Command-line driven interactive plotting program. Doc-package
  gnuplot-qt               # Command-line driven interactive plotting program. QT-package
  gpac                     # GPAC Project on Advanced Content - utilities
  gparted                  # GNOME partition editor
  gpgv2                    # GNU privacy guard - signature verification tool (dummy transitional package)
  groff                    # GNU troff text-formatting system
  gsmartcontrol            # graphical user interface for smartctl
  gvfs-backends            # userspace virtual filesystem - backends
  gv                       # PostScript and PDF viewer for X
  hardinfo                 # Displays system information
  hexchat                  # IRC client for X based on X-Chat 2
  htop                     # interactive processes viewer
  hugin                    # panorama photo stitcher - GUI tools
  i3                       # i3 window manager, screen locker, menu, statusbar
  iat                      # Converts many CD-ROM image formats to iso9660
  id3v2                    # command line id3v2 tag editor
  indent                   # C language source code formatting program
  indent-doc               # Documentation for GNU indent
  ink-generator            # Inkscape extension to automatically generate files from a template
  inkscape                 # vector-based drawing program
  input-utils              # utilities for the input layer of the Linux kernel
  iotop                    # simple top-like I/O monitor
  ipe                      # drawing editor for creating figures in PDF or PS formats
  jmtpfs                   # FUSE based filesystem for accessing MTP devices
  jq                       # lightweight and flexible command-line JSON processor
  key-mon                  # Utility to show live keyboard and mouse status
  krb5-user                # basic programs to authenticate using MIT Kerberos
  ksh                      # Real, AT&T version of the Korn shell
  lame                     # MP3 encoding library (frontend)
  libimage-exiftool-perl   # library and program to read and write meta information in multimedia files
  libnotify-bin            # sends desktop notifications to a notification daemon (Utilities)
  libreoffice-gtk3         # office productivity suite -- GTK+ 3 integration
  libreoffice              # office productivity suite
  libsox-fmt-mp3           # SoX MP2 and MP3 format library
  libtext-lorem-perl       # random faux Latin text generator
  libxml2-utils            # XML utilities
  liferea                  # feed/news/podcast client with plugin support
  light-themes             # Light Themes (Ambiance and Radiance)
  lintian                  # Debian package checker
  lm-sensors               # utilities to read temperature/voltage/fan sensors
  luminance-hdr            # HDR image creator
  lynx                     # classic non-graphical (text-mode) web browser
  lyx                      # document processor
  macchanger               # utility for manipulating the MAC address of network interfaces
  manpages-posix           # Manual pages about using POSIX system
  mawk                     # a pattern scanning and text processing language
  mediainfo                # command-line utility for reading information from audio/video files
  mercurial                # easy-to-use, scalable distributed version control system
  mesa-utils               # Miscellaneous Mesa GL utilities
  mosh                     # Mobile shell that supports roaming and intelligent local echo
  mpv                      # video player based on MPlayer/mplayer2
  msmtp                    # light SMTP client with support for server profiles
  mtr                      # Full screen ncurses and X11 traceroute tool
  mutt                     # text-based mailreader supporting MIME, GPG, PGP and threading
  nautilus                 # file manager and graphical shell for GNOME
  notmuch-mutt             # thread-based email index, search and tagging (Mutt interface)
  notmuch                  # thread-based email index, search and tagging
  offlineimap              # IMAP/Maildir synchronization and reader support
  openssh-client           # secure shell (SSH) client, for secure access to remote machines
  openssh-server           # secure shell (SSH) server, for secure access from remote machines
  p7zip-rar                # non-free rar module for p7zip
  pandoc-citeproc          # Pandoc support for Citation Style Language - tools
  pandoc                   # general markup converter
  parallel                 # build and execute command lines from standard input in parallel
  par                      # Paragraph reformatter
  patch                    # Apply a diff file to an original
  pavucontrol              # PulseAudio Volume Control
  pbuilder                 # personal package builder for Debian packages
  pdf2djvu                 # PDF to DjVu converter
  pdfcrack                 # PDF files password cracker
  pdfgrep                  # search in pdf files for strings matching a regular expression
  pdfshuffler              # merge, split and re-arrange pages from PDF documents
  pinentry-curses          # curses-based PIN or pass-phrase entry dialog for GnuPG
  pinentry-gtk2            # GTK+-2-based PIN or pass-phrase entry dialog for GnuPG
  playonlinux              # front-end for Wine
  pngcrush                 # optimizes PNG (Portable Network Graphics) files
  poppler-utils            # PDF utilities (based on Poppler)
  posh                     # Policy-compliant Ordinary SHell
  powertop                 # diagnose issues with power consumption and management
  pulseaudio               # PulseAudio sound server
  pv                       # Shell pipeline element to meter data passing through
  python3-dev              # header files and a static library for Python (default)
  python3-venv             # pyvenv-3 binary for python3 (default python3 version)
  python3-wheel            # built-package format for Python
  qpdfview                 # tabbed document viewer
  qrencode                 # QR Code encoder into PNG image
  quilt                    # Tool to work with series of patches
  rawtherapee              # RAW file processor
  rename                   # Perl extension for renaming multiple files
  rlwrap                   # readline feature command line wrapper
  rxvt-unicode-256color    # dummy transitional package for rxvt-unicode
  scalpel                  # fast filesystem-independent file recovery
  screen                   # terminal multiplexer with VT100/ANSI terminal emulation
  scrot                    # command line screen capture utility
  sdcv                     # StarDict Console Version
  shellcheck               # lint tool for shell scripts
  shntool                  # multi-purpose tool for manipulating and analyzing WAV files
  shotwell                 # digital photo organizer
  sloccount                # programs for counting physical source lines of code (SLOC)
  sox                      # Swiss army knife of sound processing
  spacefm                  # Multi-panel tabbed file manager - GTK2 version
  sshfs                    # filesystem client based on SSH File Transfer Protocol
  stellarium               # real-time photo-realistic sky generator
  stow                     # Organizer for /usr/local software packages
  stress                   # tool to impose load on and stress test a computer system
  subversion               # Advanced version control system
  subversion-tools         # Assorted tools related to Apache Subversion
  tcc                      # small ANSI C compiler
  tesseract-ocr-eng        # tesseract-ocr language files for English
  tesseract-ocr            # Tesseract command line OCR tool
  testdisk                 # Partition scanner and disk recovery tool, and PhotoRec file recovery tool
  texlive-full             # TeX Live:  pulling in all components of TeX Live
  thinkfan                 # simple and lightweight fan control program
  tlp-rdw                  # Radio device wizard
  tlp                      # Save bhottery power on laptops
  tmux                     # terminal multiplexer
  toilet                   # display large colourful characters in text mode
  tor                      # anonymizing overlay network for TCP
  torbrowser-launcher      # A program to help you securely download and run Tor Browser
  tree                     # displays an indented directory tree, in color
  ttf-xfree86-nonfree      # non-free TrueType fonts from XFree86
  tty-clock                # simple terminal clock
  ubuntu-drivers-common    # Detect and install additional Ubuntu driver packages
  ubuntu-restricted-extras # Commonly used media codecs and fonts for Ubuntu
  uchardet                 # universal charset detection library - cli utility
  udevil                   # Alternative storage media interface
  units                    # converts between different systems of units
  unzip                    # De-archiver for .zip files
  urlview                  # Extracts URLs from text
  vim-doc                  # Vi IMproved - HTML documentation
  vim-gnome                # Vi IMproved - enhanced vi editor (dummy package)
  vim                      # Vi IMproved - enhanced vi editor
  vlc                      # multimedia player and streamer
  w3m-img                  # inline image extension support utilities for w3m
  w3m                      # WWW browsable pager with excellent tables/frames support
  whois                    # intelligent WHOIS client
  wine-stable              # Windows API implementation - standard suite
  wkhtmltopdf              # Command line utilities to convert html to pdf or image using WebKit
  wmctrl                   # control an EWMH/NetWM compatible X Window Manager
  x11-apps                 # X11 applications, e.g., xcursorgen
  x11-xserver-utils        # X server utilities
  xautolock                # Program launcher for idle X sessions
  xbacklight               # simple utility to set the backlight level
  xclip                    # command line interface to X selections
  xdotool                  # simulate (generate) X11 keyboard/mouse input events
  xinput                   # Runtime configuration and test of XInput devices
  xsel                     # command-line tool to access X clipboard and selection buffers
  xserver-xorg-video-intel # X.Org X server -- Intel i8xx, i9xx display driver
  xserver-xorg             # X.Org X server
  zeal                     # Simple offline API documentation browser
  zip                      # Archiver for .zip files
  zsh                      # shell with lots of features
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
  motd-news.timer motd.service motd-news.service

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

# Get add-apt-repository first.
apt install --yes software-properties-common
for ppa in "${PPAS[@]}"
do
  add-apt-repository --yes --no-update "$ppa" && echo >&2 "added ${ppa}"
done
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

# Miscellaneous {{{1
# ------------------

# Disable message of the day spam.
chmod -x /etc/update-motd.d/*

popd
echo >&2 "finished post-install script"
