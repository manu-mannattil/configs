# IPython configuration.

# Lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = """\
    import numpy as np
    import matplotlib.pyplot as plt
""".split('\n')

# Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'

# Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.TerminalInteractiveShell.editing_mode = 'vi'
