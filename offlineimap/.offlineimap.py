# -*- coding: utf-8 -*-

from subprocess import check_output

def get_pass(account):
    """Retrieve password from password store using pass(1)."""
    return check_output(["pass", account]).splitlines()[0]
