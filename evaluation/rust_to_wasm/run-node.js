const fs = require("fs");
var args = process.argv.slice(2);
if (args.length != 2) {
    console.log("Expected two args: 0: path to folder containing wasm file to run, 1: program.");
    console.log("e.g.: $ node --experimental-wasm-return_call run-node.js ./binaries/naive vs_easy");
    process.exit(1);
}
let path = args[0];
if (path.charAt(path.length - 1) != "/") { path = path + "/" }

let program = args[1];

let imports = {};
imports['__wbindgen_placeholder__'] = module.exports;
let wasm;
const { TextDecoder } = require(`util`);

let cachedTextDecoder = new TextDecoder('utf-8', { ignoreBOM: true, fatal: true });

cachedTextDecoder.decode();

let cachedUint8Memory0 = null;

function getUint8Memory0() {
    if (cachedUint8Memory0 === null || cachedUint8Memory0.byteLength === 0) {
        cachedUint8Memory0 = new Uint8Array(wasm.memory.buffer);
    }
    return cachedUint8Memory0;
}

function getStringFromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return cachedTextDecoder.decode(getUint8Memory0().subarray(ptr, ptr + len));
}

let start_pp;
let stop_pp;
let time_pp;
// import_name writestring is inserted in wasm binary by script
module.exports.writestring = function(arg0, arg1) {
    start_pp = Date.now();
    console.log(getStringFromWasm0(arg0, arg1));
    stop_pp = Date.now();
    time_pp = stop_pp - start_pp;
};

(async () => {
    const start_startup = Date.now();

    const bytes = fs.readFileSync(`${path}/${program}.wasm`);
    // const wasmModule = new WebAssembly.Module(bytes);
    // const wasmInstance = new WebAssembly.Instance(wasmModule, imports);
    const obj = await WebAssembly.instantiate(
       new Uint8Array (bytes), imports
    );
    wasm = obj.instance.exports;

    const stop_startup = Date.now();
    const time_startup = stop_startup - start_startup;

    const start_main = Date.now();
    wasm.main();
    const stop_main = Date.now();
    const time_main = stop_main - start_main;

    //console.log(WebAssembly.Module.imports(wasmModule));
    console.log(`Benchmark rust-wasm (${path}): {{"time_startup": "${time_startup}", "time_main": "${time_main}", "time_pp": "${time_pp}", "program": "${program}"}} ms.`);

})();
