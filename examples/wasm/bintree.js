import * as fs from "fs";
// const fs = require('fs');
const bytes = fs.readFileSync('bintree.wasm');

let importObject = {
    env: {
        log_i32: (value) => { console.log ("logging i32: ", value) },
        log_invalid: (value) => { console.log ("got invalid node: (", value, ")") },
        log_i64: (value) => { console.log ("logging i64: ", value) },
        write_int: (value) => { process.stdout.write(value.toString()) },
        write_char: (value) => {
            var chr = String.fromCharCode(value);
            process.stdout.write(chr);
        },
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

    /*
    *       4
    *      / \
    *     2   6
    *    /\   /
    *   1  3 5
    *
     * */

    let leaf = obj.instance.exports.create_leaf();
    console.log(`===> result: ${leaf}`);

    let node1 = obj.instance.exports.create_node(leaf, 1, leaf);
    console.log(`===> result: ${node1}`);

    let node2 = obj.instance.exports.create_node(leaf, 3, leaf);
    console.log(`===> result: ${node2}`);

    let node5 = obj.instance.exports.create_node(node1, 2, node2);
    console.log(`===> result: ${node5}`);


    let node3 = obj.instance.exports.create_node(leaf, 5, leaf);
    console.log(`===> result: ${node3}`);

    let node6 = obj.instance.exports.create_node(node3, 6, leaf);
    console.log(`===> result: ${node6}`);

    let node7 = obj.instance.exports.create_node(node5, 4, node6);
    console.log(`===> result: ${node7}`);

    //    obj.instance.exports.in_order(node7);
    obj.instance.exports.pretty_print(node7); console.log(""); // newline

//    console.log(`===> isValid: ${obj.instance.exports.is_valid(node7) == 1}`)

    // no return
    // obj.instance.exports.test();

//    let leaf = obj.instance.exports.create_leaf();
 //   console.log(`===> result: ${leaf}`);

//    console.log(`===> isValid: ${obj.instance.exports.is_valid(leaf) == 1}`)

})();
