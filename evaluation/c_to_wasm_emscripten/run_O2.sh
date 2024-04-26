#!/bin/sh

FILES=`cat TESTS`

ulimit -s unlimited

for f in $FILES
do
    if [ -f "binaries/O2/${f}-opt_O2.wasm" ]; then
        echo "Running -O2 ${f}:"	
        node --stack-size=100000 binaries/O2/${f}-opt_O2.js
    fi
done

true
