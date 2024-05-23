all: run-add

%.wasm: %.wat
	wasm-tools parse -o $@  $<
	wasm-tools validate --features all $<

run-add: add.wasm
	@echo "Running add.{js, wasm} with node (needs node >= 22)..."
#	@node --experimental-wasm-typed_funcref --experimental-wasm-return-call --experimental-wasm-gc add.js
	@node add.js

clean:
	rm -r *.wasm
