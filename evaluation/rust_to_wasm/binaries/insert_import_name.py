#!/usr/bin/env python3

# FUNCTIONALITY: replace import name
# USAGE:  cat input.wat | tqdm --bytes | ./replace_import_name.py > input-final.wat

import sys


def replace_import_name():

    for line in sys.stdin:
        if "__wbindgen_placeholder__" in line:
            segments = line.strip().split("\"")
            assert "writestring" in segments[3], segments
            segments[3] = "writestring"
            line = "\"".join(segments)
#            sys.stderr.write(str(lines))
#            sys.exit(1)

        sys.stdout.write(line)


if __name__ == "__main__":
    replace_import_name()
