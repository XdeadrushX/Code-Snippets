#!/usr/bin/env python

"""
Very simple commandline python script which will regex-escape a string.

To use:
Move this file in /usr/bin/ without extension.
Ensure python is installed, then use the command which you named the file. for example:
escape Hello world!
will return Hello\ world\!

Exit codes:
  0 - all is fine
  1 - no arguments supplied
"""


import sys
import re


if len(sys.argv) < 2:
    sys.exit(1)

toEscape = " ".join(sys.argv[1:])
escaped = re.escape(toEscape)

print(escaped)
sys.exit(0)




