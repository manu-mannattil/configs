#!/usr/bin/env bash
# vim: ft=sh fdm=marker et sts=2 sw=2
#
# python-setup.sh -- install a bunch of Python modules and programs
#
# This script installs a bunch of useful Python modules using
# conda/mamba, pip, and pipx.  Python-based CLI programs are installed
# using pipx, with each program in an isolated virtual environment.
#
# It is assumed that you have conda/mamba installed.
#
#   NOTE: mambaforge is discouraged since September 2023.
#   https://conda-forge.org/miniforge
#
# Usage: python-setup.sh
#

set -euo pipefail

# pipx configuration.
export PIPX_HOME="$HOME/.local/share/pipx"
export PIPX_BIN_DIR="$HOME/.local/pipx-bin"
export USE_EMOJI="false"

export MINIFORGE_HOME="$HOME/.local/miniforge"
export VENVS_DIRECTORY="$HOME/.local/venvs"

# Miniforge ------------------------------------------------------------

install_miniforge() {
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir" >/dev/null 2>&1' EXIT
  trap 'exit 2' HUP INT QUIT TERM

  pushd "$tmpdir"

  wget --continue --no-config --progress=bar -O miniforge3.sh \
    "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"

  chmod +x miniforge3.sh
  # ~/.local/miniforge must not exit
  ./miniforge3.sh -b -p "$MINIFORGE_HOME"

  popd
}

# pip ------------------------------------------------------------------

MODULES=(
  readability-lxml  # fast html to text parser (article readability tool) with Python 3 support
)

install_pip_modules() {
  pip install --upgrade pip
  pip install --upgrade "${MODULES[@]}"
}

# If we update all modules, this is bound to create conflicts with mamba
# installed stuff.
update_pip_modules() {
  install_pip_modules
}

# pipx -----------------------------------------------------------------

PROGRAMS=(
  black               # Python code formatter
  flake8              # Python linter
  gallery-dl          # youtube-dl for galleries
  howdoi              # code snippet lookup tool
  markdown-anki-decks # make Anki decks with markdown
  s-tui               # stress Terminal UI stress test and monitoring tool
  speedtest-cli       # speedtest.net on the CLI
  tidal-dl            # download tidal.com media
  vsci                # video contact sheet (i.e., thumbnails) maker
  yapf                # Python code formatter
  yt-dlp              # youtube-dl fork with regular updates
)

install_pipx_programs() {
  pip install pipx
  for p in "${PROGRAMS[@]}"
  do
    pipx install "$p"
  done
}

update_pipx_programs() {
  pipx upgrade-all --include-injected
}

# conda/mamba ----------------------------------------------------------

CONDA_MODULES=(
  # Scientific Python stack.
  ipython
  jupyter
  matplotlib
  numba
  numpy
  scipy
  scikit-learn
  opencv

  # Testing.
  pytest

  # Docutils (includes a bunch of reStructuredText manipulation
  # utilities)
  docutils

  # Library for real and complex floating-point arithmetic with
  # arbitrary precision.
  mpmath

  # Python library designed for screen-scraping.
  beautifulsoup4

  # Powerful and Pythonic XML processing library combining
  # libxml2/libxslt with the ElementTree API.
  lxml

  # Module to convert a sentence to title case.
  titlecase
)

install_conda_modules() {
  mamba update -n base "mamba"
  mamba install "${CONDA_MODULES[@]}"
}

update_conda_modules() {
  mamba update -n base "mamba"
  mamba update --all
}

# Modules in separate virtualenvs --------------------------------------

# These are python packages that do not provide an executable and
# require to be used as python -m <package>.

_pip_venv_install() {
  for package
  do
    python -m venv "$VENVS_DIRECTORY/$package"
    source "$VENVS_DIRECTORY/$package/bin/activate"
    pip install --upgrade "$package"
  done
}

install_pip_venv_programs() {
  _pip_venv_install "yalafi"
}

# Option selection -----------------------------------------------------

[[ "$*" ]] || {
    echo >&2 "${0##*/}: option must be specified"
    echo >&2 "usage: ${0##*/} install|update|clean"
    exit 1
}

case "$1" in
  -u|--update|update)
    echo >&2 "${0##*/}: updating conda modules"
    update_conda_modules

    echo >&2 "${0##*/}: updating pip modules"
    update_pip_modules

    echo >&2 "${0##*/}: updating pipx programs"
    update_pipx_programs

    mamba clean --all
    rm -vrf ~/.cache/pipx
    ;;
  -i|--install|install)
    mkdir -p "$PIPX_BIN_DIR"
    mkdir -p "$VENVS_DIRECTORY"

    echo >&2 "${0##*/}: installing miniforge"
    install_miniforge

    echo >&2 "${0##*/}: installing conda modules"
    install_conda_modules

    echo >&2 "${0##*/}: installing pip modules"
    install_pip_modules

    echo >&2 "${0##*/}: installing pipx programs"
    install_pipx_programs

    echo >&2 "${0##*/}: installing venv programs"
    install_pip_venv_programs

    mamba clean --all
    rm -vrf ~/.cache/pipx
    ;;
  -p|--purge|purge)
    read -rp "To purge existing installation and packages type YES in all caps: " response
    [[ "$response" = "YES" ]] || {
      echo >&2 "${0##*/}: aborted"
      exit 0
    }
    rm -vrf "$MINIFORGE_HOME"
    rm -vrf "$PIPX_HOME"
    rm -vrf "$PIPX_BIN_DIR"
    rm -vrf "$VENVS_DIRECTORY"
    rm -vrf ~/.cache/pipx
    ;;
  *)
    echo >&2 "usage: ${0##*/} install|update|purge"
    exit 1
    ;;
esac
