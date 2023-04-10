all: foo

foo:
	coqc test.v
#	cat foo.ir
#	echo "-----------------------------------------"
	wasm2wat foo.wasm > foo.wat
	nodejs foo.js

foo_check:
	@python3 wasm_to_coq.py foo.wasm
	coqc foo_wasm.v

sha: sha256.vo
	ulimit -s unlimited && coqc test_sha.v
	wasm2wat sha.wasm > sha.wat
	python3 compare_output.py ./sha.js ./sha_output.txt

%.vo: %.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm rm *.wasm.v
