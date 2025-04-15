#!/usr/bin/env python3
import click
import os


@click.command()
@click.option("--certicoq-wasm-file", type=str, help=".wat file", required=True)
@click.option("--insert-file", type=str, help=".wat file", required=True)
@click.option("--out-file", type=str, help=".wat file", required=True)
def insert(certicoq_wasm_file, insert_file, out_file):
    assert ".wat" in certicoq_wasm_file
    assert ".wat" in insert_file
    assert ".wat" in out_file
    with open(insert_file) as f_insert:
        with open(certicoq_wasm_file) as f_wasm:
            wat_certicoqwasm = f_wasm.read()
            i = f_insert.read()

            if os.path.exists(out_file):
                os.remove(out_file)
            with open(out_file, "w") as f_out:
                f_out.write("")

            with open(out_file, "a") as f_out:
                # drop last ")" and newline
                for line in wat_certicoqwasm.split("\n")[:-2]:
                    if '(export "_' in line:
                        # concordium limits the number of exported functions, comment out
                        f_out.write(";; " + line + "\n")
                    else:
                        f_out.write(line + "\n")

                # insert at the end
                f_out.write(i + "\n" + ")")


if __name__ == "__main__":
    insert()
