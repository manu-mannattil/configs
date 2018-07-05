Configuration files
===================

This is a repository for managing my configuration files (aka dotfiles),
yak shaved over the years.

Installation
------------

To "install" the configuration files, clone the repository and run
the `install.sh` script.  Alternatively, one can use a symlink farm
manager like [GNU Stow][1] to install the configuration files on
a per-package basis.  For instance, to install the configuration files
for Vim and Mutt, from the cloned repository, one could issue the
command

    stow --target="$HOME" vim mutt

License
-------

Public domain.  (Quite obviously this only applies to stuff I've
written, i.e., things without an explicit attribution.)

[1]: https://www.gnu.org/software/stow/stow.html
