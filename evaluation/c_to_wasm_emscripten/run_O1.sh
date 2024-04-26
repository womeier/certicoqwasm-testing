#!/bin/sh

FILES=`cat TESTS`

ulimit -s unlimited

for f in $FILES
do
    if [ -f "binaries/O1/${f}-opt_O1.wasm" ]; then
        echo "Running -O1 ${f}:"	
        node --stack-size=100000 binaries/O1/${f}-opt_O1.js
    fi
done

true
