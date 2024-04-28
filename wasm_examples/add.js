const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/add.wasm');
const val_1 = 41;
const val_2 = 1;


let importObject = {
    env: {
        log_i32: (value) => { console.log ("logging i32: ", value) },
        log_i64: (value) => { console.log ("logging i64: ", value) },
    },
/*    env: {
        import_i32: 5_000_000_000, // _ is ignored in numbers in JS and WAT
        import_f32: 123.0123456789,
        import_f64: 123.0123456789,
    } */
};

(async () => {
    const obj = await WebAssembly.instantiate(
        new Uint8Array (bytes), importObject
    );

    let res = obj.instance.exports.add(val_1, val_2);
    console.log(`===> ${res}`);

    // THIS WORKS
    // res = obj.instance.exports.wrap_i31(123);
    // console.log(`===> ${res}`);

    // PP NOT SUPPORTED, may be extended https://github.com/WebAssembly/gc/blob/main/proposals/gc/MVP-JS.md
    // res = obj.instance.exports.wrap_struct(123);
    // console.log(res.Get);
})();
