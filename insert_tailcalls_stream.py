#!/usr/bin/env python3

# USAGE:  cat input.wat | tqdm --bytes | ./insert_tailcalls_stream.py > input-tailcalls.wat

import sys


def replace_calls():
    # pp_function_idx = None
    # for line in lines[::-1]:
    #     if "pretty_print_constructor" in line:
    #         pp_function_idx = int(line.split("(func")[1].replace(")", ""))
    #         break

    # if pp_function_idx is None:
    #     print("""Expected to find function exported as pretty_print_constructor.
    #          (Fn calls in it should not be replaced to tail calls.)""")
    #     exit(1)

    pp_function_idx = 2
    current_func_idx = None

    for line in sys.stdin:
        # remember idx of current function
        if "func (;" in line:
            current_func_idx = int(line.split("(func (;")[1].split(";)")[0])

        if current_func_idx != pp_function_idx and line.strip()[:4] == "call":
            line = line.replace("call", "return_call")

        sys.stdout.write(line)


if __name__ == '__main__':
    replace_calls()
