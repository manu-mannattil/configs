#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# python-post.sh -- install a bunch of Python modules and programs
#
# This script installs a bunch of useful Python modules using
# conda/mamba, pip, and pipx.  Python-based CLI programs are installed
# using pipx, with each program in an isolated virtual environment.
#
# It is assumed that you have conda/mamba installed.
#
#   https://conda-forge.org/miniforge
#
# Usage: python-post.sh
#

# pip ------------------------------------------------------------------

MODULES=(
  mutagen           # read and write audio tags for many formats
  readability-lxml  # fast html to text parser (article readability tool) with python 3 support
)

pip install --upgrade pip
pip install --upgrade "${MODULES[@]}"

# pipx -----------------------------------------------------------------

# pipx configuration.
export PIPX_BIN_DIR="$HOME/.local/pipx-bin"
mkdir -p "$PIPX_BIN_DIR"
export USE_EMOJI="false"

PROGRAMS=(
  # Code snippet lookup tool.
  howdoi

  # Stress Terminal UI stress test and monitoring tool
  s-tui

  # youtube-dl fork with regular updates.
  yt-dlp
)

pip install pipx
for p in "${PROGRAMS[@]}"
do
  pipx install "$p"
done

# conda/mamba ----------------------------------------------------------

if command -v mamba &>/dev/null
then
  installer="mamba"
else
  installer="conda"
fi

"$installer" update -n base "$installer"

CONDA_MODULES=(
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

"$installer" update --all
"$installer" install "${CONDA_MODULES[@]}"
