import * as fs from 'fs';
const bytes = fs.readFileSync('./foo.wasm');

const print_bool = (value, dataView) => {
  if (value & 1) {
    switch (value >> 1) {
      case 0: process.stdout.write('true');
      case 1: process.stdout.write('false');
    }
  }
};

const importObject = {
  env: {
    write_int(value) {
      process.stdout.write(value.toString());
    },
    write_char(value) {
      process.stdout.write(String.fromCharCode(value));
    },
  },
};

(async () => {
  const object = await WebAssembly.instantiate(
    new Uint8Array(bytes), importObject,
  );

  try {
    const start = Date.now();
    object.instance.exports.main_function();
    const stop = Date.now();

    const memory = object.instance.exports.memory;
    const dataView = new DataView(memory.buffer);
    const res_value = object.instance.exports.result.value;
    process.stdout.write('====> ');
    print_bool(res_value, dataView);

    const bytes = object.instance.exports.bytes_used.value;
    console.log(`\n====> used ${bytes} bytes of memory, took ${(stop - start)} (Node.js) ms.`);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
