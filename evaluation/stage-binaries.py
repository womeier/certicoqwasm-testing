#!/usr/bin/env python3
"""Stage the benchmarks of the CertiRocq pinned in ../flake.nix into ./binaries/<NAME>.

Copies the .wasm files and writes one INFO.txt: NAME and a short description
that benchmark.py reads. This is steps 2) and 3) of "Adding new
CertiCoq-Wasm binaries for evaluation" in ../README.md.

    ./stage-binaries.py rm-cap-oct-22-26 -d "constructors with store offsets"
    ./stage-binaries.py foo -d "..." --result ../result   # don't build, reuse a result
"""

import os
import shutil
import subprocess
import sys
from datetime import date
from pathlib import Path

import click

CWD = Path(__file__).resolve().parent
os.chdir(CWD)

FLAKE = CWD.parent
BINARIES = CWD / "binaries"
PATTERN = "CertiRocq.Tests.wasm.tests.*.wasm"


def build():
    """nix build .#wasm-benchmarks, return its store path."""
    print(f"Building .#wasm-benchmarks in {FLAKE} (this takes a while on a cold cache).")
    r = subprocess.run(
        ["nix", "build", "--no-link", "--print-out-paths", ".#wasm-benchmarks"],
        cwd=FLAKE,
        capture_output=True,
        check=False,
    )
    sys.stderr.write(r.stderr.decode())
    if r.returncode != 0:
        sys.exit("nix build failed.")
    return Path(r.stdout.decode().strip().splitlines()[-1])


@click.command()
@click.argument("name")
@click.option("--description", "-d", required=True, help="Short description, shown by benchmark.py.")
@click.option(
    "--result",
    type=click.Path(exists=True, file_okay=False, path_type=Path),
    help="Use this already built result/store path instead of running nix build.",
)
@click.option("--force", is_flag=True, help="Overwrite ./binaries/<NAME> if it exists.")
def main(name, description, result, force):
    """Stage the pinned CertiRocq's benchmarks as ./binaries/NAME."""
    if "/" in name or name.startswith("."):
        raise click.UsageError(f"NAME must be a plain folder name, got {name!r}.")

    dest = BINARIES / name
    if dest.exists() and not force:
        raise click.UsageError(f"{dest} already exists, pass --force to overwrite it.")

    src = result.resolve() if result else build()

    wasm = sorted(src.glob(PATTERN))
    if not wasm:
        sys.exit(f"No {PATTERN} in {src}.")

    dest.mkdir(parents=True, exist_ok=True)
    for f in wasm:
        target = dest / f.name
        shutil.copyfile(f, target)
        target.chmod(0o644)  # the store originals are read-only

    (dest / "INFO.txt").write_text(
        f"name:        {name}\n"
        f"description: {description}\n"
        f"staged:      {date.today().isoformat()} from {src}\n"
    )

    print(f"Staged {len(wasm)} binaries in binaries/{name}:")
    print((dest / "INFO.txt").read_text())
    print("Next: add the expected output to ./results/ and run ./sanity-checks.py")
    print(f"      ./benchmark.py --engine=node --folder ./binaries/{name}")


if __name__ == "__main__":
    main()
