configs
=======

This is a repository for managing my configuration files (aka dotfiles), meticulously yak shaved over the years and contains about <!--FILES-->177 configuration files for about <!--PROGRAMS-->51
programs.  There are [many like it][others], but this one is
mine.

<a href="https://xkcd.com/1806/">
  <img align="right" src="https://imgs.xkcd.com/comics/borrow_your_laptop.png"/>
</a>

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

One can also use a symlink farm manager like [GNU Stow][stow] to install
the configuration files on a per-target basis.  For instance, to install
the configuration files for Vim and Mutt, from the cloned repository,
one could issue the command

    stow --target="$HOME" vim mutt

License
-------

Public domain.  See the file UNLICENSE for more details.

(Quite obviously this only applies to stuff I've written, i.e., things
without an explicit attribution.)

[others]: https://github.com/search?q=dotfiles+OR+configs
[stow]: https://www.gnu.org/software/stow/stow.html
