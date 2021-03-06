#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-conda.sh -- install a bunch of modules using conda
#
# Usage: install-conda.sh
#
# This script installs a bunch of common Python modules using Miniconda.
# https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#

PACKAGES=(
  # Python linter.
  flake8

  # Scientific Python stack.
  ipython
  jupyter
  matplotlib
  numba
  numpy
  scipy

  # Python 2 to 3 porting.
  future

  # Testing.
  coveralls
  nose
  pytest

  # Docutils (includes a bunch of reStructuredText manipulation
  # utilities)
  docutils

  # Library for real and complex floating-point arithmetic with
  # arbitrary precision.
  mpmath

  # Python code formatter.
  black

  # Python library designed for screen-scraping.
  beautifulsoup4

  # Cssselect parses CSS3 Selectors and translates them to XPath 1.0.
  cssselect

  # Powerful and Pythonic XML processing library combining
  # libxml2/libxslt with the ElementTree API.
  lxml
)

conda update --all
conda install "${PACKAGES[@]}"
