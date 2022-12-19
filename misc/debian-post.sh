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
#   fzf                   https://github.com/junegunn/fzf-bin/releases
#                         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
#   Geekbench             https://www.geekbench.com/download/linux/
#   git-latexdiff         https://gitlab.com/git-latexdiff/git-latexdiff
#   Google Chrome         https://www.google.com/chrome
#   pdfsizeopt            https://github.com/pts/pdfsizeopt
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
  # Android
  adb # Android Debug Bridge
  fastboot # Android fastboot tool

  # Archive utilities.
  p7zip-rar # non-free rar module for p7zip
  unrar # Unarchiver for .rar files (non-free version)
  unzip # De-archiver for .zip files
  zip # Archiver for .zip files
  engrampa # archive manager for MATE

  # Audio
  audacity # fast, cross-platform audio editor
  cuetools # tools for manipulating CUE/TOC files
  libsox-fmt-mp3 # SoX MP2 and MP3 format library
  pavucontrol # PulseAudio Volume Control
  shntool # multi-purpose tool for manipulating and analyzing WAV files
  sox # Swiss army knife of sound processing
  lame # MP3 encoding library (frontend)
  id3v2 # command line id3v2 tag editor
  pulseaudio # PulseAudio sound server

  # Crypto and security
  gnupg # GNU privacy guard - a free PGP replacement
  gnupg-agent # GNU privacy guard - cryptographic agent (dummy transitional package)
  cryptsetup # disk encryption support - startup scripts
  gpgv2 # GNU privacy guard - signature verification tool (dummy transitional package)
  pinentry-gnome3 # GNOME 3 PIN or pass-phrase entry dialog for GnuPG

  # Debian
  apt-file # search for files within Debian packages (command-line interface)

  # Desktop and window managers
  adwaita-qt # Adwaita light/dark theme for Qt
  gnome-icon-theme # GNOME Desktop icon theme
  gnome-themes-extra # Adwaita GTK+ 2 theme — engine
  i3 # metapackage (i3 window manager, screen locker, menu, statusbar)
  libnotify-bin # sends desktop notifications to a notification daemon
  openbox # standards-compliant, fast, light-weight and extensible window manager
  rofi # window switcher, run dialog and dmenu replacement
  spacefm-gtk3 # Multi-panel tabbed file manager - GTK3 version
  suckless-tools # simple commands for minimalistic window managers
  wmctrl # control an EWMH/NetWM compatible X Window Manager

  # Development
  build-essential # Informational list of build-essential packages
  cmake # cross-platform, open-source make system
  colordiff # tool to colorize 'diff' output
  diffutils # File comparison utilities
  exuberant-ctags # build tag file indexes of source code definitions
  gcc-doc # documentation for gcc, g++, gobjc, etc.
  indent # C language source code formatting program
  indent-doc # Documentation for GNU indent
  input-utils # utilities for the input layer of the Linux kernel
  manpages-posix # Manual pages about using POSIX system
  patch # Apply a diff file to an original
  sloccount # programs for counting physical source lines of code (SLOC)

  # Display and X11
  arandr # Simple visual front end for XRandR
  brightnessctl # Control backlight brightness
  compton # compositor for X11, based on xcompmgr
  hsetroot # tool for composing root-pixmaps for X11
  mesa-utils # Miscellaneous Mesa GL utilities
  redshift # Adjusts the color temperature of your screen
  xautolock # Program launcher for idle X sessions
  xbacklight # simple utility to set the backlight level
  xclip # command line interface to X selections
  xdotool # simulate (generate) X11 keyboard/mouse input events
  xinput # Runtime configuration and test of XInput devices
  xsel # command-line tool to access X clipboard and selection buffers
  xserver-xorg-video-intel # X.Org X server -- Intel i8xx, i9xx display driver
  xwrits # remind you to take regular breaks from the computer

  # Download managers
  aria2 # High speed download utility
  axel # light command line download accelerator
  filezilla # Full-featured graphical FTP/FTPS/SFTP client

  # Email
  isync # IMAP and MailDir mailbox synchronizer
  mutt # text-based mailreader supporting MIME, GPG, PGP and threading
  notmuch # thread-based email index, search and tagging
  notmuch-mutt # thread-based email index, search and tagging (Mutt interface)
  msmtp # light SMTP client with support for server profiles
  urlview # Extracts URLs from text

  # File system
  duff # Duplicate file finder
  exfat-fuse # read and write exFAT driver for FUSE
  exfat-utils # utilities to create, check, label and dump exFAT filesystem
  extundelete # utility to recover deleted files from ext3/ext4 partition
  foremost # forensic program to recover lost files
  fuseiso # FUSE module to mount ISO filesystem images
  gparted # GNOME partition editor
  gsmartcontrol # graphical user interface for smartctl
  gvfs # userspace virtual filesystem - GIO module
  gvfs-backends # userspace virtual filesystem - backends
  inotify-tools # provides a simple interface to inotify (inotifywait & inotifywatch)
  jmtpfs # FUSE based filesystem for accessing MTP devices
  scalpel # fast filesystem-independent file recovery
  testdisk # Partition scanner and disk recovery tool, and PhotoRec file recovery tool

  # Fonts and font utilities
  fonts-font-awesome # iconic font designed for use with Twitter Bootstrap
  fonttools # Converts OpenType and TrueType fonts to and from XML (Executables)
  gsfonts # Fonts for the Ghostscript interpreter(s)
  ttf-xfree86-nonfree # non-free TrueType fonts from XFree86

  # Fun and games
  cowsay # configurable talking cow
  figlet # Make large character ASCII banners out of ordinary text
  fortune-mod # provides fortune cookies on demand
  fortunes # Data files containing fortune cookies
  fortunes-off # Data files containing offensive fortune cookies
  toilet # display large colourful characters in text mode

  # Hardware
  fwupd # Firmware update daemon
  hardinfo # Displays system information
  i965-va-driver-shaders # VAAPI driver for Intel G45 & HD Graphics family
  intel-gpu-tools # tools for debugging the Intel graphics driver
  intel-media-va-driver-non-free # VAAPI driver for the Intel GEN8+ Graphics family
  lm-sensors # utilities to read temperature/voltage/fan sensors
  tlp # Save battery power on laptops
  tlp-rdw # Radio device wizard
  vainfo # Video Acceleration (VA) API for Linux -- info program

  # Image manipulation
  darktable # virtual lighttable and darkroom for photographers
  exif # command-line utility to show EXIF information in JPEG files
  exiftran # digital camera JPEG image transformer
  gifsicle # GIF compressor
  gimp-data-extras # Extra brushes and patterns for GIMP
  gimp-gap # animation package for the GIMP
  gimp # GNU Image Manipulation Program
  gimp-help-en # Documentation for the GIMP (English)
  gimp-lensfun # Gimp plugin to correct lens distortion using the lensfun library
  gimp-plugin-registry # repository of optional extensions for GIMP
  gmic # GREYC's Magic for Image Computing
  hugin # panorama photo stitcher - GUI tools
  ink-generator # Inkscape extension to automatically generate files from a template
  inkscape # vector-based drawing program
  libimage-exiftool-perl # library and program to read and write meta information in multimedia files
  optipng # advanced PNG (Portable Network Graphics) optimizer
  pngcrush # optimizes PNG (Portable Network Graphics) files
  rawtherapee # raw image converter and digital photo processor

  # Internet
  elinks # advanced text-mode WWW browser
  elinks-doc # advanced text-mode WWW browser - documentation
  lynx # classic non-graphical (text-mode) web browser
  w3m # WWW browsable pager with excellent tables/frames support
  w3m-img # inline image extension support utilities for w3m
  liferea # feed/news/podcast client with plugin support

  # Languages
  python2 # Python 2 is required by some legacy software (e.g., pdfsizeopt)
  default-jre # Default Java runtime

  # PDF, PS, and DjVu tools
  atril # MATE document viewer
  djvulibre-bin # Utilities for the DjVu image format
  gv # PostScript and PDF viewer for X
  krop # tool to crop PDF files
  pdf2djvu # PDF to DjVu converter
  pdfcrack # PDF files password cracker
  pdfgrep # search in pdf files for strings matching a regular expression
  pdfshuffler # merge, split and re-arrange PDF documents - transitional package
  pdftk # transitional package for pdftk, a tool for manipulating PDF documents
  poppler-utils # PDF utilities (based on Poppler)
  qpdfview # tabbed document viewer
  wkhtmltopdf # Command line utilities to convert html to pdf or image using WebKit
  zathura # document viewer with a minimalistic interface

  # Multimedia
  ffmpeg # Tools for transcoding, streaming and playing of multimedia files
  mpv # video player based on MPlayer/mplayer2
  v4l-utils # Collection of command line video4linux utilities
  vlc # multimedia player and streamer
  mediainfo # command-line utility for reading information from audio/video files

  # Network
  curl # command line tool for transferring data with URL syntax
  hexchat # IRC client for X based on X-Chat 2
  mtr # Full screen ncurses and X11 traceroute tool
  openssh-client # secure shell (SSH) client, for secure access to remote machines
  openssh-server # secure shell (SSH) server, for secure access from remote machines
  sshfs # filesystem client based on SSH File Transfer Protocol
  macchanger # utility for manipulating the MAC address of network interfaces
  whois # intelligent WHOIS client
  tor # anonymizing overlay network for TCP

  # Scientific
  bc # GNU bc arbitrary precision calculator language
  gnuplot-doc # Command-line driven interactive plotting program. Doc-package
  gnuplot-qt # Command-line driven interactive plotting program. QT-package

  # Shells and terminal emulators
  ksh # Real, AT&T version of the Korn shell
  posh # Policy-compliant Ordinary SHell
  rxvt-unicode # RXVT-like terminal emulator with Unicode and 256-color support
  shellcheck # lint tool for shell scripts
  zsh # shell with lots of features

  # System tools
  psmisc # utilities that use the proc file system (e.g., killall, pstree, etc.)
  iotop # simple top-like I/O monitor
  htop # interactive processes viewer
  fakeroot # tool for simulating superuser privileges
  firejail # sandbox to restrict the application environment
  sysvinit-utils # System-V-like utilities

  # TeX and writing
  bibtool # tool to manipulate BibTeX files
  diction # Utilities to help with style and diction (English and German)
  libreoffice-gtk3 # office productivity suite
  lyx # document processor
  sdcv # StarDict Console Version
  texlive-full # TeX Live: metapackage pulling in all components of TeX Live
  wdiff # compare two files word by word

  # Text processing
  gawk # GNU awk, a pattern scanning and processing language
  mawk # Pattern scanning and text processing language
  jq # lightweight and flexible command-line JSON processor

  # Version control
  git # fast, scalable, distributed revision control system
  git-cvs # fast, scalable, distributed revision control system (cvs interoperability)
  git-email # fast, scalable, distributed revision control system (email add-on)
  git-gui # fast, scalable, distributed revision control system (GUI)
  mercurial # easy-to-use, scalable distributed version control system

  # Vim and Emacs
  vim # Vi IMproved - enhanced vi editor
  vim-doc # Vi IMproved - HTML documentation
  vim-gtk3 # Vi IMproved - enhanced vi editor - with GTK3 GUI
  emacs # GNU Emacs editor (metapackage)

  # Utilities (assorted)
  dateutils # nifty command line date and time utilities
  fasd # jump to directories and files quickly
  libtext-lorem-perl # random faux Latin text generator
  ncal # CLI calender program
  parallel # build and execute command lines from standard input in parallel
  pv # Shell pipeline element to meter data passing through
  rename # Perl extension for renaming multiple files
  rlwrap # readline feature command line wrapper
  screen # terminal multiplexer with VT100/ANSI terminal emulation
  scrot # command line screen capture utility
  stow # Organizer for /usr/local software packages
  stress # tool to impose load on and stress test a computer system
  tmux # terminal multiplexer
  tree # displays an indented directory tree, in color
  tty-clock # simple terminal clock
  uchardet # universal charset detection library - cli utility
  units # converts between different systems of units

  # Miscellaneous
  wine # Windows API implementation - standard suite
  libwine:i386 # Windows API implementation - library (32-bit version)

  # Docker
  containerd.io # An open and reliable container runtime
  docker-ce # Docker: the open-source application container engine
  docker-ce-cli # Docker CLI: the open-source application container engine
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
      acpi-call-dkms  # ThinkPad hardware/firmware access modules source - dkms version
    )
esac

# Installation {{{1
# -----------------

# Docker.
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

dpkg --add-architecture i386
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
