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
    const start = Date.now();
    object.instance.exports.main_function();
    const stop = Date.now();

    if (object.instance.exports.out_of_mem == 1) {
      console.log("Ran out of memory.");
      process.exit(1);
    }

    const memory = object.instance.exports.memory;
    const dataView = new DataView(memory.buffer);
    const res_value = object.instance.exports.result.value;
    process.stdout.write('====> ');
    print_bool(res_value, dataView);

    const bytes = object.instance.exports.mem_ptr.value;
    console.log(`\n====> used ${bytes} bytes of memory, took ${(stop - start)} ms (Node.js).`);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
