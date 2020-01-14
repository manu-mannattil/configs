configs
=======

This is a repository for managing my configuration files (aka dotfiles),
yak shaved over the years and contains about <!--FILES-->166 configuration
files for about <!--PROGRAMS-->45 programs.

Installation
------------

To "install" the configuration files, clone the repository and run
the `install.sh` script.  `install.sh` can take one or more targets as
arguments.  In that case, configuration files for only those targets
will be installed.  Targets can be grouped into groups.  As an example,
to install the targets from the `cli` group along with the targets
`firefox` and `mutt`, run

    install.sh --group cli firefox mutt

By default all targets will be installed.  To list the available targets
and groups, run

    install.sh --list
    install.sh --list-groups

One can also use a symlink farm manager like [GNU Stow][1] to install
the configuration files on a per-target basis.  For instance, to install
the configuration files for Vim and Mutt, from the cloned repository,
one could issue the command

    stow --target="$HOME" vim mutt

License
-------

Public domain.  See the file UNLICENSE for more details.

(Quite obviously this only applies to stuff I've written, i.e., things
without an explicit attribution.)

[1]: https://www.gnu.org/software/stow/stow.html
