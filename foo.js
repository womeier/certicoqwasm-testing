const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/foo.wasm');

let importObject = {
    env: {
        $write_int:  function(value) { process.stdout.write(value.toString()) },
        $write_char: function(value) { process.stdout.write(String.fromCharCode(value)) },
    }
};

(async () => {
    const obj = await WebAssembly.instantiate(
        new Uint8Array (bytes), importObject
    );

    try {
        const start = Date.now();
        obj.instance.exports.$main_function();
        const stop = Date.now();

        let res = obj.instance.exports.result.value;
        process.stdout.write("\n====>");
        obj.instance.exports.$pretty_print_constructor(res);

        let bytes = obj.instance.exports.bytes_used.value;
        console.log(`\n====> used ${bytes} bytes of memory, took ${(stop -start)} (Node.js) ms.`);

    } catch (error) {
        console.log(error);
        process.exit(1);
    }
})();
