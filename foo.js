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
        obj.instance.exports.$main_function();
        let res = obj.instance.exports.result.value;
        process.stdout.write("\n====>");
        obj.instance.exports.$pretty_print_constructor(res);

        let bytes = obj.instance.exports.bytes_used.value;
        console.log(`\n====> used ${bytes} bytes of memory`);

    } catch (error) {
        console.log(error);
        process.exit(1);
    }
})();
