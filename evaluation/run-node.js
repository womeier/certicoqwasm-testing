var args = process.argv.slice(2);
if (args.length != 2) {
    console.log("Expected two args: 0: path to folder containing wasm file to run, 1: program.");
    process.exit(1);
}
path = args[0];
program = args[1];

const fs = require('fs');
const bytes = fs.readFileSync(path + `./CertiCoq.Benchmarks.tests.${program}.wasm`);

function write_int (value) {
    process.stdout.write(value.toString())
}

function write_char (value) {
    var chr = String.fromCharCode(value);
    process.stdout.write(chr);
}

let importObject = {
    env: {
        $write_char: write_char,
        $write_int: write_int,
    }
/*    env: {
        import_i32: 5_000_000_000, // _ is ignored in numbers in JS and WAT
        import_f32: 123.0123456789,
        import_f64: 123.0123456789,
    } */
};

(async () => {
    const start_inst = Date.now();
    const obj = await WebAssembly.instantiate(
        new Uint8Array (bytes), importObject
    );
    const stop_inst = Date.now();
    const time_inst = stop_inst - start_inst;

    try {
        const start_main = Date.now();
        obj.instance.exports.$main_function();
        const stop_main = Date.now();
        const time_main = stop_main - start_main;

        let bytes = obj.instance.exports.bytes_used.value;
        let time_pp = undefined;

        if (obj.instance.exports.result_out_of_mem.value == 1) {
            console.log("Ran out of memory.");
            process.exit(1);
        } else {
            const res_value = obj.instance.exports.result.value;
            process.stdout.write("\n====>");

            const start_pp = Date.now();
            obj.instance.exports.$pretty_print_constructor(res_value); console.log(""); // newline
            const stop_pp = Date.now();
            time_pp = stop_pp - start_pp;
        }

        console.log(`Benchmark ${path}: {{"time_instantiate": "${time_inst}", "time_main": "${time_main}", "time_pp": "${time_pp}", "program": "${program}"}} ms.`);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
})();
