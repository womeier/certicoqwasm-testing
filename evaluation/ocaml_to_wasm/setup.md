# Notes on wasm_of_ocaml binaries

- Requires `node` v22.1.0
- Run individual benchmarks with `node run-node.js binaries <benchmark>.js`
- The result is pretty printed
- The startup and main execution time of the wasm module is printed (note that the main execution time includes pretty printing, and that the `pp` output is set to 0)
- The ocaml code extracted from the `color` benchmark does not typecheck, and so is not included here
- The extraction of the `sm_gauss_PrimInt` benchmark requires specifying an ocaml implementation for the Uint63 operations, and so is not included here

To run all benchmarks and print time, run `python benchmark.py --folder binaries`.

## Using the `wasm_of_ocaml` compiler

Install the compiler by following the instructions at <https://github.com/ocaml-wasm/wasm_of_ocaml>

1. Extract the definition with the Coq `Extraction` command to obtain `.ml` and `.mli` files.
2. (Optional) Add a pretty printing function and a 'main' definition to call the pretty printing function on the result (see below for an example).
3. Compile the `.ml` and `.mli` files to byte code:
 ```
 ocamlfind ocamlc -package js_of_ocaml,js_of_ocaml-ppx,js_of_ocaml-lwt -linkpkg -o <filename>.byte <filename>.mli <filename>.ml
 ```
4. Compile the byte code to a Wasm binary.
 ```
 wasm_of_ocaml <filename>.byte
 ```
5. The above command also creates a javascript scaffolding file `<filename>.js` that enables running the binary, run with `node <filename.js>`

### Example: Adding pretty printing

Extracting a Coq definition with the `nat` inductive type, e.g. `Definition foo := 5.`, will generate an ocaml file containing the ocaml type definition below:
``` ocaml
type nat =
| O
| S of nat
```

Add a pretty printing function like the one below to the generated ocaml file:
``` ocaml
let rec print_nat n =
  match n with
  | O -> Printf.printf "O"
  | S n' ->
    Printf.printf "(S ";
    print_nat n';
    Printf.printf ")"
```

Add a main definition at the bottom of the file to print the result of the extracted definition:
``` ocaml
let main =
  print_nat foo;
  Printf.printf "\n"
```

Remember to also add these to the `.mli` files:
``` ocaml
val print_nat : nat -> unit

val main : unit
```
