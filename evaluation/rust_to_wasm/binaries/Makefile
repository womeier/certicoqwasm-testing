all: demo1 demo2 binom color list_sum

demo1:
	wasm2wat demo1.wasm -o demo1.wat
	cat demo1.wat | ./insert_import_name.py > demo1-name.wat
	wat2wasm demo1-name.wat -o demo1.wasm
	rm *.wat

demo2:
	wasm2wat demo2.wasm -o demo2.wat
	cat demo2.wat | ./insert_import_name.py > demo2-name.wat
	wat2wasm demo2-name.wat -o demo2.wasm
	rm *.wat

binom:
	wasm2wat binom.wasm -o binom.wat
	cat binom.wat | ./insert_import_name.py > binom-name.wat
	wat2wasm binom-name.wat -o binom.wasm
	rm *.wat

color:
	wasm2wat color.wasm -o color.wat
	cat color.wat | ./insert_import_name.py > color-name.wat
	wat2wasm color-name.wat -o color.wasm
	rm *.wat

list_sum:
	wasm2wat list_sum.wasm -o list_sum.wat
	cat list_sum.wat | ./insert_import_name.py > list_sum-name.wat
	wat2wasm list_sum-name.wat -o list_sum.wasm
	rm *.wat

# TODO sha, vs_easy, vs_hard
