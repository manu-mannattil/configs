# configs

This is a repository for managing my configuration files (aka dotfiles), meticulously yak shaved over the years and contains about <!--FILES-->209 configuration files for about <!--PROGRAMS-->55
programs.  There are [many like it][others], but this one is mine.

<a href="https://xkcd.com/1806/">
  <img align="right" src="https://raw.githubusercontent.com/manu-mannattil/assets/master/configs/xkcd.png"/>
</a>

## Setup

To setup the configuration files, clone the repository and run the
`setup.sh` script.  `setup.sh` can take one or more targets as
arguments.  In that case, configuration files for only those targets
will be installed.  Targets can be grouped into groups.  As an example,
to install the targets from the `cli` group along with the targets
`firefox` and `mutt`, run

    setup.sh --group cli firefox mutt

By default all targets will be installed.  To list the available targets
and groups, run

    setup.sh --list
    setup.sh --list-groups

One can also use a symlink farm manager like [GNU Stow][stow] to install
the configuration files on a per-target basis.  For instance, to install
the configuration files for Vim and Mutt, from the cloned repository,
one could issue the command

    stow --target="$HOME" vim mutt

## Templating

In some cases, one needs different versions of the same configuration
file to use on different hosts.  In such situations, we use a simple
shell-based templating system.

Configuration files that are actually templates are processed by the
[sts.py](sts.py) Python script.  Each line that begins with a pipe | is
treated as a shell command.  Contiguous blocks of such "piped" lines are
sent to a shell and the resulting output is put on the stdout.  Other
"unpiped" lines are sent to the stdout as usual.  For example, consider
a file `program.conf` with the contents

    This line is printed as usual.
    | if [ $(uname -n) = "apple" ]
    | then
    |     echo 'We are on host apple.'
    | elif [ $(uname -n) = "orange" ]
    | then
    |     echo 'We are on host orange.'
    | else
    |     echo 'We are on an unknown host.'
    | fi
    This line is also printed as usual.

On a host with hostname "orange", upon processing this file, one would
get the following:

    This line is printed as usual.
    We are on host orange.
    This line is also printed as usual.

This way host-specific configuration files can be created.

## License

Public domain.  See the file UNLICENSE for more details.

(Quite obviously this only applies to stuff I've written, i.e., things
without an explicit attribution.)

[others]: https://github.com/search?q=dotfiles+OR+configs
[stow]: https://www.gnu.org/software/stow/stow.html
