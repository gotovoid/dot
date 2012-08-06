#!/usr/bin/env python3

import os
import platform

try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

def cls():
    os.system('cls' if platform.system()=='Windows' else 'clear')

cls()
