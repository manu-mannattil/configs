#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-apt.sh -- install a bunch of packages using apt
#
# Usage: install-apt.sh
#
# This script is for installing a bunch of packages after a fresh
# Xubuntu install.  However, since all packages aren't available on
# the Ubuntu repositories, some packages need to be manually installed:
#
#   DeaDBeeF FB plugin    https://gitlab.com/zykure/deadbeef-fb/tree/release/binary
#   Dropbox               https://www.dropbox.com/install?os=lnx
#   epub2txt              https://github.com/kevinboone/epub2txt/releases
#   fzf                   https://github.com/junegunn/fzf-bin/releases
#   Geekbench             https://www.geekbench.com/download/linux/
#   Google Chrome         https://www.google.com/chrome
#   JSMin                 https://raw.githubusercontent.com/douglascrockford/JSMin/master/jsmin.c
#   krop                  http://arminstraub.com/software/krop
#   PDF Scale             https://github.com/tavinus/pdfScale/releases
#   pdfsizeopt            https://github.com/pts/pdfsizeopt
#   Platform tools        https://dl.google.com/android/repository/platform-tools-latest-linux.zip
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
  # Debian/Ubuntu stuff {{{2
  # ------------------------

  apt-file                            # search for files within Debian packages (command-line interface)
  aptitude                            # terminal-based package manager
  cdbs                                # common build system for Debian packages
  checkinstall                        # installation tracker
  debhelper                           # helper programs for debian/rules
  devscripts                          # scripts to make the life of a Debian Package maintainer easier
  dh-make                             # tool that converts source archives into Debian package source
  dpatch                              # patch maintenance system for Debian source packages
  dput                                # Debian package upload tool
  fakeroot                            # tool for simulating superuser privileges
  groff                               # The full groff distribution including man pages
  lintian                             # Debian package checker
  pbuilder                            # personal package builder for Debian packages
  snapcraft                           # easily craft snaps
  synaptic                            # Graphical package manager
  ubuntu-restricted-extras            # Commonly used media codecs and fonts for Ubuntu

  # Developer utilities {{{2
  # ------------------------

  build-essential                     # Informational list of build-essential packages
  cmake                               # cross-platform, open-source make system
  colordiff                           # tool to colorize 'diff' output
  diffutils                           # File comparison utilities
  patch                               # Apply a diff file to an original
  quilt                               # Tool to work with series of patches
  zeal                                # Simple offline API documentation browser

  # Desktop {{{2
  # ------------

  compton                             # compositor for X11, based on xcompmgr

  # Development {{{2
  # ----------------

  exuberant-ctags                     # build tag file indexes of source code definitions
  flex                                # fast lexical analyzer generator
  indent                              # C language source code formatting program
  indent-doc                          # Documentation for GNU indent
  manpages-posix                      # Manual pages about using POSIX system
  qttools5-dev-tools                  # Qt 5 development tools.
  shellcheck                          # lint tool for shell scripts
  sloccount                           # programs for counting physical source lines of code (SLOC)

  # Email {{{2
  # ----------

  msmtp                               # light SMTP client with support for server profiles
  mutt                                # text-based mailreader supporting MIME, GPG, PGP and threading
  notmuch                             # thread-based email index, search and tagging
  offlineimap                         # IMAP/Maildir synchronization and reader support
  postfix                             # High-performance mail transport agent
  urlview                             # Extracts URLs from text

  # Fonts {{{2
  # ----------

  ttf-xfree86-nonfree                 # non-free TrueType fonts from XFree86
  fonts-font-awesome                  # iconic font with > 200 glyphs

  # Games {{{2
  # ----------

  cowsay                              # configurable talking cow
  fortune-mod                         # provides fortune cookies on demand
  fortunes                            # Data files containing fortune cookies
  fortunes-off                        # Data files containing offensive fortune cookies
  golly                               # Game of Life simulator using hashlife algorithm

  # Graphics {{{2
  # -------------

  darktable                           # RAW developer and image organizer
  djview-plugin                       # Browser plugin for the DjVu image format
  djview4                             # Viewer for the DjVu image format
  djvulibre-bin                       # Utilities for the DjVu image format
  engauge-digitizer                   # interactively extracts numbers from bitmap graphs or maps
  engauge-digitizer-doc               # engauge-digitizer user manual and tutorial
  exif                                # command-line utility to show EXIF information in JPEG files
  exiftran                            # digital camera JPEG image transformer
  figlet                              # Make large character ASCII banners out of ordinary text
  fonttools                           # Converts OpenType and TrueType fonts to and from XML
  gimp                                # The GNU Image Manipulation Program
  gimp-data-extras                    # Extra brushes and patterns for GIMP
  gimp-gap                            # animation package for the GIMP
  gimp-help-en                        # Documentation for the GIMP (English)
  gimp-lensfun                        # Gimp plugin to correct lens distortion using the lensfun library
  gimp-plugin-registry                # repository of optional extensions for GIMP
  gmic                                # GREYC's Magic for Image Computing
  gthumb                              # GNOME image viewer and organizer
  gv                                  # PostScript and PDF viewer for X
  hugin                               # panorama photo stitcher - GUI tools
  ink-generator                       # Inkscape extension to automatically generate files from a template
  inkscape                            # vector-based drawing program
  ipe                                 # a vector graphics editor for technical drawing
  libimage-exiftool-perl              # library and program to read and write meta information in multimedia files
  luminance-hdr                       # graphical user interface providing a workflow for HDR imaging
  pdf2djvu                            # PDF to DjVu converter
  pdfshuffler                         # merge, split and re-arrange pages from PDF documents
  pinta                               # Simple drawing/painting program
  pngcrush                            # optimizes PNG (Portable Network Graphics) files
  qpdfview                            # tabbed document viewer
  qrencode                            # QR Code encoder into PNG image
  rawtherapee                         # RAW file processor
  shotwell                            # digital photo organizer
  tesseract-ocr                       # Tesseract command line OCR tool
  tesseract-ocr-eng                   # tesseract-ocr language files for English
  toilet                              # display large colourful characters in text mode
  wkhtmltopdf                         # Command line utilities to convert html to pdf or image using WebKit

  # Miscellaneous languages/runtime environments {{{2
  # -------------------------------------------------

  gawk                                # GNU awk, a pattern scanning and processing language
  mawk                                # a pattern scanning and text processing language
  ruby-dev                            # Header files for compiling extension modules for Ruby (default version)
  tcc                                 # small ANSI C compiler

  # Multimedia {{{2
  # ---------------

  audacity                            # fast, cross-platform audio editor
  cdparanoia                          # audio extraction tool for sampling CDs
  cuetools                            # tools for manipulating CUE/TOC files
  deadbeef                            # audio player
  ffmpeg                              # Tools for transcoding, streaming and playing of multimedia files
  gpac                                # GPAC Project on Advanced Content - utilities
  id3v2                               # A command line id3v2 tag editor
  lame                                # MP3 encoding library (frontend)
  libsox-fmt-mp3                      # SoX MP2 and MP3 format library
  mediainfo                           # command-line utility for reading information from audio/video files
  mpv                                 # video player based on MPlayer/mplayer2
  shntool                             # multi-purpose tool for manipulating and analyzing WAV files
  sox                                 # Swiss army knife of sound processing
  vlc                                 # multimedia player and streamer

  # Network/Applications {{{2
  # -------------------------

  elinks                              # advanced text-mode WWW browser
  elinks-doc                          # advanced text-mode WWW browser - documentation
  filezilla                           # transfer files using FTP
  hexchat                             # IRC client for X based on X-Chat 2
  krb5-user                           # basic programs to authenticate using MIT Kerberos
  lynx                                # classic non-graphical (text-mode) web browser
  mosh                                # Mobile shell that supports roaming and intelligent local echo
  openssh-client                      # secure shell (SSH) client, for secure access to remote machines
  openssh-server                      # secure shell (SSH) server, for secure access from remote machines
  tor                                 # anonymizing overlay network for TCP
  torbrowser-launcher                 # helps download and run the Tor Browser Bundle
  w3m                                 # WWW browsable pager with excellent tables/frames support
  w3m-img                             # inline image extension support utilities for w3m

  # Network/Tools {{{2
  # ------------------

  aria2                               # High speed download utility
  axel                                # light command line download accelerator
  curl                                # command line tool for transferring data with URL syntax
  mtr                                 # Full screen ncurses and X11 traceroute tool
  modem-manager-gui                   # GUI front-end for ModemManager / Wader / oFono

  # Office {{{2
  # -----------

  biber                               # Much-augmented BibTeX replacement for BibLaTeX users
  bibtool                             # tool to manipulate BibTeX files
  diction                             # Utilities to help with style and diction (English and German)
  libreoffice                         # office productivity suite (metapackage)
  libreoffice-gtk                     # office productivity suite -- GTK+ integration
  lyx                                 # document processor
  pandoc                              # general markup converter
  pandoc-citeproc                     # Pandoc support for Citation Style Language - tools
  pdfcrack                            # PDFCrack is a simple tool for recovering passwords from pdf documents
  poppler-utils                       # PDF utilities (based on Poppler)
  sdcv                                # StarDict Console Version
  texlive-full                        # metapackage pulling in all components of TeX Live
  texstudio                           # LaTeX Editor

  # Scientific {{{2
  # ---------------

  geogebra                            # Dynamic mathematics software for education
  gnuplot-doc                         # Command-line driven interactive plotting program.  Doc-package
  gnuplot-qt                          # Command-line driven interactive plotting program.  QT-package
  stellarium                          # real-time photo-realistic sky generator

  # Shells {{{2
  # -----------

  ksh                                 # Real, AT&T version of the Korn shell
  posh                                # Policy-compliant Ordinary SHell
  zsh                                 # shell with lots of features

  # System tools {{{2
  # -----------------

  borgbackup                          # deduplicating and compressing backup program
  borgbackup-doc                      # documentation for borg
  cryptsetup                          # disk encryption support - startup scripts
  exfat-fuse                          # read and write exFAT driver for FUSE
  exfat-utils                         # utilities to create, check, label and dump exFAT filesystem
  extundelete                         # utility to recover deleted files from ext3/ext4 partition
  firejail                            # sandbox to restrict the application environment
  foremost                            # forensic program to recover lost files
  gdebi                               # simple tool to view and install deb files - GNOME GUI
  gnome-system-monitor                # Process viewer and system resource monitor for GNOME
  gparted                             # GNOME partition editor
  gsmartcontrol                       # graphical user interface for smartctl
  hardinfo                            # Displays system information
  htop                                # interactive processes viewer
  iat                                 # Converts many CD-ROM image formats to iso9660
  input-utils                         # utilities for the input layer of the Linux kernel
  iotop                               # simple top-like I/O monitor
  keymon                              # Transitional package for key-mon
  lm-sensors                          # utilities to read temperature/voltage/fan sensors
  macchanger                          # utility for manipulating the MAC address of network interfaces
  playonlinux                         # front-end for Wine
  powertop                            # diagnose issues with power consumption and management
  scalpel                             # fast filesystem-independent file recovery
  testdisk                            # Partition scanner and disk recovery tool, and PhotoRec file recovery tool
  tlp-rdw                             # Add-on to TLP for managing Bluetooth, Wi-Fi, WWAN, etc.
  tlp                                 # Save battery power on laptops
  whois                               # intelligent WHOIS client
  wine-stable                         # Microsoft Windows Compatibility Layer (meta-package)
  xbacklight                          # simple utility to set the backlight level

  # Text editors/Terminal emulators   {{{2
  # --------------------------------  ----

  emacs                               # GNU Emacs metapackage
  gnome-terminal                      # GNOME terminal emulator application
  rxvt-unicode-256color               # multi-lingual terminal emulator with Unicode support for X11
  screen                              # terminal multiplexer with VT100/ANSI terminal emulation
  tmux                                # terminal multiplexer
  vim-doc                             # Vi IMproved - HTML documentation
  vim-gnome                           # Vi IMproved - enhanced vi editor - with GTK3 GUI
  vim                                 # Vi IMproved - enhanced vi editor

  # Utilities {{{2
  # --------------

  agrep                               # text search tool with support for approximate patterns
  dateutils                           # nifty command line date and time utilities
  dmg2img                             # Tool for converting compress dmg files to hfsplus images
  dtrx                                # intelligently extract multiple archive types
  duff                                # Duplicate file finder
  gnupg                               # GNU privacy guard - a free PGP replacement
  gpgv2                               # GNU privacy guard - signature verification tool (new v2.x)
  jq                                  # lightweight and flexible command-line JSON processor
  libtext-lorem-perl                  # random faux Latin text generator
  libxml2-utils                       # XML utilities for formatting, linting, etc.
  p7zip-rar                           # non-free rar module for p7zip
  par                                 # Paragraph reformatter
  parallel                            # build and execute command lines from standard input in parallel
  pdfgrep                             # search in pdf files for strings matching a regular expression
  pinentry-curses                     # curses-based PIN or pass-phrase entry dialog for GnuPG
  pinentry-gtk2                       # GTK+-2-based PIN or pass-phrase entry dialog for GnuPG
  pv                                  # Shell pipeline element to meter data passing through
  rename                              # Perl extension for renaming multiple files
  rlwrap                              # readline feature command line wrapper
  scrot                               # command line screen capture utility
  stow                                # Organizer for /usr/local software packages
  stress                              # tool to impose load on and stress test a computer system
  tree                                # displays an indented directory tree, in color
  tty-clock                           # simple terminal clock
  uchardet                            # universal charset detection library - cli utility
  units                               # converts between different systems of units
  wmctrl                              # control an EWMH/NetWM compatible X Window Manager
  xclip                               # command line interface to X selections
  xdotool                             # simulate (generate) X11 keyboard/mouse input events
  xsel                                # command-line tool to access X clipboard and selection buffers

  # Version control {{{2
  # --------------------

  bzr                                 # easy to use distributed version control system
  bzrtools                            # Collection of tools for bzr
  cvs                                 # Concurrent Versions System
  darcs                               # distributed, interactive, smart revision control system
  git                                 # fast, scalable, distributed revision control system
  git-cvs                             # fast, scalable, distributed revision control system (cvs interoperability)
  git-email                           # fast, scalable, distributed revision control system (email add-on)
  git-gui                             # fast, scalable, distributed revision control system (GUI)
  git-svn                             # fast, scalable, distributed revision control system (svn interoperability)
  mercurial                           # easy-to-use, scalable distributed version control system
  subversion                          # Advanced version control system
  subversion-tools                    # Assorted tools related to Apache Subversion
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
  motd-news.timer

  # Ubuntu's snap package manager.
  snapd.service snapd.seeded.service snapd.socket

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
)

RM_PACKAGES=(
  # D-Bus daemon to generate thumbnails.
  tumbler

  # Ubuntu error reporting tools.
  whoopsie apport apport-gtk
)

# Computer specific packages {{{1
# -------------------------------

case "$HOSTNAME" in
  # Dell Inspiron 3442.
  carbon)
    DISABLE_UNITS+=(
      # I don't print on this laptop.  Thus, disable CUPS.
      cups.path cups-browsed.service cups.service cups.socket
    )
    PACKAGES+=(
      # Broadcom Wi-Fi drivers
      bcmwl-kernel-source
    ) ;;
esac

# Installation {{{1
# -----------------

for ppa in "${PPAS[@]}"
do
  add-apt-repository --yes --no-update "$ppa" && echo >&2 "added ${ppa}"
done
apt update
apt upgrade --yes
apt install --yes "${PACKAGES[@]}"

# Remove packages that we don't want.
apt purge --yes "${RM_PACKAGES[@]}"

# Now, disable the systemd units that we don't use. However, use
# `disable' instead of `mask' since the services ought to be started if
# they are required.
for unit in "${DISABLE_UNITS[@]}"
do
  systemctl stop "$unit"
  systemctl disable "$unit"
done
