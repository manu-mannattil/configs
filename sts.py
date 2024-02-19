#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# sts.py is a simple shell-based templating system.  The basic usage is
#
#   sts.py [<options>] file [<args>]
#
# For more details about sts's options, run
#
#   sts --help
#
# sts scans the supplied files line by line and looks for lines
# beginning with the the pipe "|" symbol and executes the rest of the
# line as a shell command.  The other lines are echoed on the standard
# out as usual.  Before executing the "piped" lines, it substitutes the
# following variables [1]
#
#   variable    substitution
#   --------    ------------
#
#   {}          full path to the file
#   {.}         full path without extension
#   {..}        extension of the file
#   {/}         basename of the full path
#   {//}        dirname of the full path
#   {/.}        basename of the full path without extension
#   {@}         additional arguments supplied
#   {!}         MD5 digest of the full path
#
# [1]: The variable names have been inspired by GNU Parallel
#      conventions.
#

import argparse
import re
import subprocess
import sys
from hashlib import md5
from os import path
from shlex import quote

MATCH_RE = r"^\s*\|\s?" # regex to match shell lines
ESCAPE_RE = r"^\s*\\\|\s?" # regex to escape shell lines

def digest(string):
    """Return the MD5 digest of a string."""
    return md5(string.encode("utf-8")).hexdigest()

def pre_process(line, attributes):
    """Pre-process the given line."""
    line = re.sub(MATCH_RE, "", line)

    # Hack to support escaping of \{ and \}.
    line = line.replace("\\{", "\0ob\0")
    line = line.replace("\\}", "\0cb\0")

    line = line.replace("{}", attributes.get("name", ""))
    line = line.replace("{.}", attributes.get("stem", ""))
    line = line.replace("{..}", attributes.get("extension", ""))
    line = line.replace("{/}", attributes.get("basename", ""))
    line = line.replace("{//}", attributes.get("dirname", ""))
    line = line.replace("{/.}", attributes.get("stembase", ""))
    line = line.replace("{@}", attributes.get("args", ""))
    line = line.replace("{!}", attributes.get("digest", ""))

    # Replace escaped {}'s if any and cleanup.
    line = line.replace("\0ob\0", "{")
    line = line.replace("\0cb\0", "}")

    return line.strip()

def execute(commands, shell=None, dry_run=False, debug=False):
    if dry_run:
        print("\n".join(commands), file=sys.stderr)
        return
    elif debug:
        # All POSIX compliant shells support passing the -x option that
        # will print each command before execution.
        args = ["-x", "\n".join(commands)]
    else:
        args = ["\n".join(commands)]

    output = subprocess.check_output(args, shell=True, executable=shell)
    sys.stdout.buffer.write(output)
    sys.stdout.flush()

def process(fd, args=None, dry_run=False, shell=None, debug=False):
    """Process a file."""
    # Convert to absolute path and make an attributes dictionary.
    name = path.abspath(fd.name)
    attributes = {
        "name": quote(name),  # {}
        "stem": quote(path.splitext(name)[0]),  # {.}
        "extension": quote(path.splitext(name)[1]),  # {..}
        "basename": quote(path.basename(name)),  # {/}
        "dirname": quote(path.dirname(name)),  # {//}
        "stembase": quote(path.basename(path.splitext(name)[0])),  # {/.}
        "digest": digest(name),  # {!}
    }

    # If there are additional arguments, quote them safely
    # and make a string.
    if args:
        attributes.update({"args": " ".join(map(quote, args))})

    commands = []
    for line in fd:
        if re.match(MATCH_RE, line):
            commands.append(pre_process(line, attributes))
        else:
            if commands:
                execute(commands, shell, dry_run, debug)
                commands = []

            if re.match(ESCAPE_RE, line):
                line = line.replace(r"\|", "|")

            sys.stdout.write(line)
            sys.stdout.flush()

    if commands:
        execute(commands, shell, dry_run, debug)

def main():
    """Argument parsing."""
    arg_parser = argparse.ArgumentParser(prog="sts", description="simple templating system")
    arg_parser.add_argument(
        "-n",
        "--dry-run",
        action="store_true",
        help="print the commands that will be executed",
    )
    arg_parser.add_argument("-s", "--shell", default=None, help="set the shell to use")
    arg_parser.add_argument(
        "-x",
        "--x-trace",
        action="store_true",
        help="trace each step by passing '-x' to the shell",
    )
    arg_parser.add_argument("file", help="files", type=argparse.FileType("r"))
    arg_parser.add_argument("args", help="additional arguments", nargs="*")

    args = arg_parser.parse_args()
    process(args.file, args.args, args.dry_run, args.shell, args.x_trace)

if __name__ == "__main__":
    sys.exit(main())
