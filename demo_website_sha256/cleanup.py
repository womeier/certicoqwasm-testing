#!/usr/bin/env python3

import os
import shutil

keep = [
    "Makefile",
    "cleanup.py",
    "coq",
    "files",
    "certicoqwasm-demo.html",
    ".gitignore",
]


for f in os.listdir():
    if f not in keep:
        if os.path.isfile(f):
            os.remove(f)
        else:
            shutil.rmtree(f)
