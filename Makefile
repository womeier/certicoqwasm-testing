all: foo_run

foo.wasm:
	ulimit -s unlimited && coqc test.v
	wasm2wat foo.wasm > foo.wat # --no-check may be useful for debugging
	@python3 ./insert_tailcalls.py --path_in foo.wat --path_out foo-tail.wat
	wat2wasm --enable-tail-call foo-tail.wat -o foo.wasm

foo_run: clean foo.wasm foo.wat
	node --experimental-wasm-return_call foo.js

foo_check: clean foo.wasm
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha.wasm: sha256.vo
	rm -f sha.wat sha.wasm
	ulimit -s unlimited && coqc test_sha.v
	wasm2wat --no-check sha.wasm > sha.wat
	@python3 ./insert_tailcalls.py --path_in sha.wat --path_out sha-tail.wat
	wat2wasm --enable-tail-call sha-tail.wat -o sha.wasm

sha: sha.wasm
	python3 compare_output.py ./sha.js ./sha_output.txt

sha_explicit: sha.wasm
	node --experimental-wasm-return_call sha.js

%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
