#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-pip.sh -- install a bunch of modules using pip
#
# Usage: install-pip.sh
#
# This script installs a bunch of common Python modules using pip.
#

PACKAGES=(
  beautifulsoup4 # screen-scraping library
  cssselect      # cssselect parses CSS3 Selectors and translates them to XPath 1.0
  lxml           # powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API
  mutagen        # read and write audio tags for many formats
  titlecase      # module to convert a sentence to title case
  vegas          # Tools for adaptive multidimensional Monte Carlo integration
  s-tui          # Stress Terminal UI stress test and monitoring tool
)

pip install "${PACKAGES[@]}"
