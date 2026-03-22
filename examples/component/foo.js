import * as fs from 'fs';
const bytes = fs.readFileSync('./foo.wasm');

 // the constructors of bools are swapped, see https://github.com/CertiCoq/certicoq/pull/100
const print_bool = (value, dataView) => {
  if (value & 1) {
    switch (value >> 1) {
      case 0: process.stdout.write('false'); break;
      case 1: process.stdout.write('true'); break;
    }
  }
};

const importObject = { env: {} };

(async () => {
  const object = await WebAssembly.instantiate(
    new Uint8Array(bytes), importObject,
  );

  try {
    object.instance.exports.main_function();

    if (object.instance.exports.out_of_mem == 1) {
      console.log("Ran out of memory.");
      process.exit(1);
    }

    let res = object.instance.exports.result.value;
    let mem = new Uint32Array(object.instance.exports.memory.buffer);
    // console.log("TAG: " + mem[res/4] + ", FIDX: " + mem[res/4 + 1]);
    let fidx = mem[res/4 + 1];
    let envAddr = mem[res/4 + 2];
    let notFunc = object.instance.exports[Object.keys(object.instance.exports)[fidx]];
    // console.log(notFunc);

    // Wasm encoding: true=3, false=1
    notFunc(envAddr, 3);
    let RES = object.instance.exports.result.value;
    console.log(RES);
    print_bool(RES, null);

    /*
    const memory = object.instance.exports.memory;
    const dataView = new DataView(memory.buffer);
    const res_value = object.instance.exports.result.value;
    console.log(res_value);
    */

//    print_bool(res, dataView);

    const bytes = object.instance.exports.mem_ptr.value;
    console.log(`\n====> used ${bytes} bytes of memory`);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
