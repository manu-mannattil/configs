# -*- coding: utf-8 -*-

# Default libraries {{{1
# ----------------------

import cmath
import math
import re

# Readline/history support {{{1
# -----------------------------

import readline
import atexit
import os

CACHEDIR = os.path.join(os.environ['HOME'], '.cache')
HISTFILE = os.path.join(CACHEDIR, 'python_history')

if os.path.exists(HISTFILE):
    readline.read_history_file(HISTFILE)
elif not os.path.exists(CACHEDIR):
    os.mkdir(CACHEDIR)

# Maximum number of lines in HISTFILE
readline.set_history_length(500)

# Write to HISTFILE on exit.
def save_history():
    readline.write_history_file(HISTFILE)
atexit.register(save_history)
