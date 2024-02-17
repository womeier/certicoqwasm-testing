all: foo_run

foo.wasm:
	ulimit -s unlimited && coqc test.v
#	wasm2wat --no-check foo.wasm > foo.wat
#	cat foo.wat | tqdm --bytes | ./insert_tailcalls_stream.py > foo-tail.wat
#	wat2wasm --enable-tail-call foo-tail.wat -o foo.wasm

foo_run: clean foo.wasm
	node --experimental-wasm-return_call foo.js

foo_run_wasmtime: clean
	ulimit -s unlimited && coqc test.v
	python3 foo.py

foo_check: clean foo.wasm
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha.wasm: sha256.vo
	rm -f sha.wat sha.wasm
	ulimit -s unlimited && coqc test_sha.v
#	wasm2wat --no-check sha.wasm > sha.wat
#	cat sha.wat | tqdm --bytes | ./insert_tailcalls_stream.py > sha-tail.wat
#	wat2wasm --enable-tail-call sha-tail.wat -o sha.wasm

sha_opt.wasm: sha.wasm
	wasm-opt -O2 --enable-tail-call --enable-mutable-globals sha.wasm --output sha_opt.wasm

sha: sha.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_explicit: sha.wasm
	node --experimental-wasm-return_call sha.js

sha_opt: sha_opt.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_opt_explicit: sha_opt.wasm
	node --experimental-wasm-return_call sha_opt.js

%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
