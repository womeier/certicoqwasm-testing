all:
	coqc test.v
#	cat foo.ir
#	echo "-----------------------------------------"
	wasm2wat foo.wasm > foo.wat
	nodejs foo.js

sha: sha256.vo
	ulimit -s unlimited && coqc test_sha.v
	wasm2wat sha.wasm > sha.wat
	python3 compare_output.py ./sha.js ./sha_output.txt

sha256.vo: sha256.v
	coqc $<

clean:
	rm -f *.vos *.glob *.vo *.vok *.s *.c *.h *.ir *.wat *.wasm

