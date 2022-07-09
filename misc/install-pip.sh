#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-pip.sh -- install a bunch of modules using pip
#
# Usage: install-pip.sh
#
# This script installs a bunch of useful Python modules using pip.
#

PACKAGES=(
  howdoi            # code snippet lookup tool
  mutagen           # read and write audio tags for many formats
  readability-lxml  # fast html to text parser (article readability tool) with python 3 support
  s-tui             # Stress Terminal UI stress test and monitoring tool
)

pip install --upgrade "${PACKAGES[@]}"
