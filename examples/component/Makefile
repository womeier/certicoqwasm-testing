OS=$(shell uname)

STACKSIZE=$(if $(filter Linux,$(OS)),unlimited,65532)

all: foo_run

help:
	@echo "Available commands:"
	@echo "make foo_run      : compile and run foo.v (run with foo.js)"
	@echo "make clean        : clean"

foo.wasm:
	ulimit -s $(STACKSIZE) && rocq c foo.v


foo_run: clean foo.wasm foo.wat
#	wasm-tools parse foo.wasm --wat -o foo.wat
#	wasm-tools validate --features all foo.wat
	node foo.js

%.vo: %.v
	rocq c $<


%.wat: %.wasm
	wasm-tools parse $< -t -o $@
	wasm-tools validate --features all $@

# -------------------------------------------------------------

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
