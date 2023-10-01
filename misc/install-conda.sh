#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-conda.sh -- install a bunch of modules using conda
#
# Usage: install-conda.sh
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

  # Python code formatters.
  black
  yapf

  # Python library designed for screen-scraping.
  beautifulsoup4

  # Cssselect parses CSS3 Selectors and translates them to XPath 1.0.
  cssselect

  # Powerful and Pythonic XML processing library combining
  # libxml2/libxslt with the ElementTree API.
  lxml

  # Semi-analytical tricks.
  theano

  # Module to convert a sentence to title case.
  titlecase
)

if command -v mamba &>/dev/null
then
  installer="mamba"
else
  installer="conda"
fi

"$installer" update --all
"$installer" install "${PACKAGES[@]}"
