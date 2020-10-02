#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# install-conda.sh -- install a bunch of modules using conda
#
# Usage: install-conda.sh
#
# This script installs a bunch of common Python modules (mostly related
# to scientific computing) using Miniconda.  Get Miniconda from
#
#   https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#

PACKAGES=(
  # Better Python linting.
  flake8

  # Scientific Python.
  ipython
  jupyter
  matplotlib
  numba
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

  # Library for real and complex floating-point arithmetic with
  # arbitrary precision.
  mpmath
)

conda update --all
conda install "${PACKAGES[@]}"
