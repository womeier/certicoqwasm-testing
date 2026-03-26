main: run-comp

# 3 kinds of components

# manually from hand-written .wat
run-comp-manual: plus1.comp.wasm
	wasmtime run --invoke 'plus1(5)' plus1.comp.wasm

plus1.comp.wasm:
	wasm-tools component embed world.wit plus1.wat -o plus1.wasm
	wasm-tools component new plus1.wasm -o plus1.comp.wasm
	wasm-tools parse plus1.comp.wasm -t  -o plus1.comp.wat

# with Rust wit_bindgen
run-rust:
	cd ./plus1 && cargo component build --release
	# wasm-tools parse ./plus1/target/wasm32-wasip1/release/plus1.wasm -t -o plus1-rust.comp.wat
	wasm-tools component wit ./plus1/target/wasm32-wasip1/release/plus1.wasm
	wasmtime run --invoke 'plus1(5)' ./plus1/target/wasm32-wasip1/release/plus1.wasm

# Rocq extraction
%.vo: %.v
	rocq c $<

# component based on CertiRocq (adapter + wasm-merge)
run-comp: rocq-plus1.comp.wasm
	wasmtime run --invoke 'plus1(8)' rocq-plus1.comp.wasm
	wasm-tools component wit rocq-plus1.comp.wasm

rocq-plus1.wasm: plus1.vo
	# also text format
	wasm-tools parse rocq-plus1.wasm -t -o rocq-plus1.wat

rocq-plus1.comp.wasm: adapter.wat world.wit rocq-plus1.wasm
	wasm-tools parse adapter.wat -o adapter.wasm
	sed '/(export "memory" (memory 0))/a\  (export "__indirect_function_table" (table 0))' rocq-plus1.wat > rocq-plus1-patched.wat
	wasm-tools parse rocq-plus1-patched.wat -o rocq-plus1-patched.wasm
	wasm-merge rocq-plus1-patched.wasm rocq adapter.wasm adapter --enable-multimemory --enable-reference-types -o merged.wasm
	wasm-tools component embed world.wit merged.wasm -o embedded.wasm
	wasm-tools component new embedded.wasm -o $@

clean:
	rm -f *.wasm *.comp.wat rocq-plus1.wat *.ir *.vo *.vok *.glob *.vos rocq-plus1-patched.wat
