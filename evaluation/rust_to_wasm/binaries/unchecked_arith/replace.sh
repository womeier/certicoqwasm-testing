#!/usr/bin/bash

rust_examples="demo1 demo2 list_sum vs_easy vs_hard binom sha_fast color even_10000 ack_3_9 sm_gauss_N sm_gauss_nat bernstein_yang"

echo "Fixing import names"
for f in ${rust_examples}
do
    if [[ ! -e ${f}.wasm ]]; then echo "${f}.wasm not found, skipping"; continue; fi
    echo "Fixing " ${f}
    src_name=${f}.wasm
    src_name_wat=${f}.wat
    src_name_wat_replaced=${f}-replaced.wat
	wasm2wat ${src_name} -o ${src_name_wat}
	cat ${src_name_wat} | ./insert_import_name.py > ${src_name_wat_replaced}
	wat2wasm ${src_name_wat_replaced} -o ${src_name}
	rm -f ${src_name_wat_replaced} ${src_name_wat}
done
