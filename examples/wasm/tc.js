import * as fs from "fs";
const bytes = fs.readFileSync('./tc.wasm');

(async () => {
    const obj = await WebAssembly.instantiate(new Uint8Array (bytes), {env: {}});
    let res = obj.instance.exports.g1();
    console.log(`g1===> ${res}`);

    res = obj.instance.exports.g2();
    console.log(`g2===> ${res}`);
})();
