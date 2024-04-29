OS=$(shell uname)

STACKSIZE=$(if $(filter Linux,$(OS)),unlimited,65532)

all: foo_run

foo.wasm:
	ulimit -s $(STACKSIZE) && coqc foo.v
#	wasm-tools parse foo.wasm --wat -o foo.wat
#	cat foo.wat | tqdm --bytes | ./insert_tailcalls.py > foo-tail.wat
#	wasm-tools parse foo-tail.wat -o foo.wasm

foo_run: clean foo.wasm
	wasm-tools parse foo.wasm --wat -o foo.wat
	wasm-tools validate --features all foo.wat
	node --experimental-wasm-return_call foo.js

foo_run_wasmtime: clean
	ulimit -s unlimited && coqc foo.v
	python3 foo.py

foo_check: clean foo.wasm
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha.wasm: sha256.vo
	rm -f sha.wat sha.wasm
	ulimit -s $(STACKSIZE) && coqc sha.v
#	wasm-tools parse sha.wasm --wat -o sha.wat
#	cat sha.wat | tqdm --bytes | ./insert_tailcalls.py > sha-tail.wat
#	wasm-tools parse sha-tail.wat -o sha.wasm

sha: sha.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_explicit: sha.wasm
	node --experimental-wasm-return_call sha.js

%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
