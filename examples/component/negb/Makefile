main: run-comp


# Rocq extraction
%.vo: %.v
	rocq c $<

# component based on CertiRocq (adapter + wasm-merge)
run-comp: rocq-negb.comp.wasm
	wasmtime run --invoke 'negb(true)' rocq-negb.comp.wasm
	wasmtime run --invoke 'negb(false)' rocq-negb.comp.wasm

rocq-negb.wasm: negb.vo
	# also text format
	wasm-tools parse rocq-negb.wasm -t -o rocq-negb.wat

rocq-negb.comp.wasm: adapter.wat world.wit rocq-negb.wasm
	wasm-tools parse adapter.wat -o adapter.wasm
	sed '/(export "memory" (memory 0))/a\  (export "__indirect_function_table" (table 0))' rocq-negb.wat > rocq-negb-patched.wat
	wasm-tools parse rocq-negb-patched.wat -o rocq-negb-patched.wasm
	wasm-merge rocq-negb-patched.wasm rocq adapter.wasm adapter --enable-multimemory --enable-reference-types --enable-tail-call -o merged.wasm
	wasm-tools component embed world.wit merged.wasm -o embedded.wasm
	wasm-tools component new embedded.wasm -o $@

clean:
	rm -f *.wasm *.comp.wat rocq-negb.wat *.ir *.vo *.vok *.glob *.vos rocq-negb-patched.wat
