Configuration files
===================

This is a repository for my configuration files (aka dotfiles), yak
shaved over the years.

Installation
------------

To "install" the configuration files, clone the repository and run
the `install.sh' script.  Alternatively, one can use [GNU Stow][1] to
install the configuration files on a per-package basis.  For instance,
to install the configuration files for Vim and Mutt, one could do

    stow --target="$HOME" vim mutt

License
-------

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide.  This software is distributed without any
warranty.

(Quite obviously, this only applies to stuff I've written personally.
The copyright of other files belong to their respective authors.)

[1]: https://www.gnu.org/software/stow/stow.html
