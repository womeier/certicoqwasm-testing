all: run-concordium-test

run-node:
	cd node && node ./run.js

run-concordium-test:
#	wasm-tools parse ./wasm-testing/src/counter.wat -o ./wasm-testing/src/counter.wasm
#	wasm-tools validate ./wasm-testing/src/counter-certicoqwasm.wat
#	wat2wasm ./certicoqwasm/src/counter-certicoqwasm.wat -o /dev/null
#	wasm-tools parse ./certicoqwasm/src/counter-certicoqwasm.wat -o ./certicoqwasm/src/counter-certicoqwasm.wasm
	wasm-tools parse ./certicoqwasm/src/COUNTER_MODULE.wasm -t -o ./certicoqwasm/src/COUNTER_MODULE.wat
	python3 ./certicoqwasm/src/combine.py --certicoq-wasm-file ./certicoqwasm/src/COUNTER_MODULE.wat \
		--insert-file ./certicoqwasm/src/insert.wat --out-file ./certicoqwasm/src/counter_out.wat
	wat2wasm ./certicoqwasm/src/counter_out.wat -o ./certicoqwasm/src/counter_out.wasm
	wasm-opt --coalesce-locals ./certicoqwasm/src/counter_out.wasm -o ./certicoqwasm/src/counter_out_opt.wasm
	mv ./certicoqwasm/src/counter_out_opt.wasm ./certicoqwasm/src/counter_out.wasm
#	wasm2wat ./certicoqwasm/src/counter_out.wasm -o ./certicoqwasm/src/counter_out.wat
#	wasm-tools parse ./certicoqwasm/src/counter_out.wat -o ./certicoqwasm/src/counter_out.wasm
	cd certicoqwasm && cargo run
