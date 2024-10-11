OS=$(shell uname)

STACKSIZE=$(if $(filter Linux,$(OS)),unlimited,65532)

all: foo_run

help:
	@echo "Available commands:"
	@echo "make foo_run      : compile and run foo.v (run with foo.js)"
	@echo "make sha          : compile and run sha.v, checks the result (run with sha.js)"
	@echo "make sha_explicit : compile and run sha.v, print result (run with sha.js)"
	@echo "make clean        : clean"

foo.wasm:
	ulimit -s $(STACKSIZE) && coqc foo.v

foo_run: clean foo.wasm
#	wasm-tools parse foo.wasm --wat -o foo.wat
#	wasm-tools validate --features all foo.wat
	node foo.js

# This doesn't currently work.
foo_check: clean foo.wasm
	@python3 ../wasmcert/wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha.wasm: sha256.vo
	rm -f sha.wat sha.wasm
	ulimit -s $(STACKSIZE) && coqc sha.v

sha: sha.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_explicit: sha.wasm
	node sha.js

%.vo: %.v
	coqc $<

# -------------------------------------------------------------

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
