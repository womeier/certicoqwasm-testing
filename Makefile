all: foo_run

foo.wasm:
	coqc test.v

foo.wat: foo.wasm
	wasm2wat foo.wasm > foo.wat

foo_run: clean foo.wasm foo.wat
	nodejs foo.js

foo_check: clean foo.wasm
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

# -------------------------------------------------------------

sha: sha256.vo
	ulimit -s unlimited && coqc test_sha.v
	wasm2wat sha.wasm > sha.wat
	python3 compare_output.py ./sha.js ./sha_output.txt

%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
