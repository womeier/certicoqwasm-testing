all: foo_run

foo.wasm:
	ulimit -s unlimited && coqc test.v
	wasm2wat --no-check foo.wasm > foo.wat
	@python3 ./insert_tailcalls.py --path_in foo.wat --path_out foo-tail.wat
	wat2wasm --enable-tail-call foo-tail.wat -o foo.wasm

foo_run: clean foo.wasm
	node --experimental-wasm-return_call foo.js

foo_run_wasmtime: clean
	ulimit -s unlimited && coqc test.v
	python3 foo.py

foo_check: clean foo.wasm
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha_cps.wasm: sha256.vo
	rm -f sha_cps.wat sha_cps.wasm
	ulimit -s unlimited && coqc test_sha.v
#	wasm2wat --no-check sha_cps.wasm > sha_cps.wat
#	@python3 ./insert_tailcalls.py --path_in sha_cps.wat --path_out sha_cps_tail.wat
#	wat2wasm --enable-tail-call sha_cps_tail.wat -o sha_cps.wasm

sha_cps: sha_cps.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_explicit: sha.wasm
	python3 sha.py

sha_explicit_node: sha.wasm
	node --experimental-wasm-return_call sha.js


%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
