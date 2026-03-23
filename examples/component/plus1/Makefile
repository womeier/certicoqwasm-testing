# manual .wat
run: plus1.comp.wasm
	wasmtime run --invoke 'plus1(5)' plus1.comp.wasm

plus1.comp.wasm:
	wasm-tools component embed world.wit plus1.wat -o plus1.wasm
	wasm-tools component new plus1.wasm -o plus1.comp.wasm
	wasm-tools parse plus1.comp.wasm -t  -o plus1.comp.wat

clean:
	rm -f *.wasm *.comp.wat

# with Rust wit_bindgen
rust:
	cd ./plus1 && cargo component build --release
	# wasm-tools parse ./plus1/target/wasm32-wasip1/release/plus1.wasm -t -o plus1-rust.comp.wat
	wasm-tools component wit ./plus1/target/wasm32-wasip1/release/plus1.wasm
	wasmtime run --invoke 'plus1(5)' plus1.comp.wasm
