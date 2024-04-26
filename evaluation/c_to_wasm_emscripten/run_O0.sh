#!/bin/sh

FILES=`cat TESTS`

ulimit -s unlimited

for f in $FILES
do
    if [ -f "binaries/O0/${f}-opt_O0.wasm" ]; then
        echo "Running -O0 ${f}:"	
        node --stack-size=100000 binaries/O0/${f}-opt_O0.js
    fi
done

true
