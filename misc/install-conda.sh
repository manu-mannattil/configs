#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-conda.sh -- install a bunch of modules using conda
#
# Usage: install-conda.sh
#
# This script installs a bunch of common Python modules (mostly related
# to scientific computing) using Miniconda.
#

PACKAGES=(
  # Better Python linting.
  flake8

  # Scientific Python.
  ipython
  jupyter
  matplotlib
  numpy
  scipy

  # Python 2 to 3 porting.
  future

  # Testing.
  nose
  coveralls

  # Docutils (includes a bunch of reStructuredText manipulation
  # utilities)
  docutils
)

conda update --all
conda install "${PACKAGES[@]}"
