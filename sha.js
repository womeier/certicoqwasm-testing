const fs = require('node:fs');

const bytes = fs.readFileSync(__dirname + '/sha.wasm');

const print_positive_sexp = (value, dataView) => {
  if (value & 1) {
    process.stdout.write('xH');
  } else {
    const tag = dataView.getInt32(value, true);
    switch (tag) {
      case 0: {
      process.stdout.write('(xI ');
      break;
      }

      case 1: {
      process.stdout.write('(xO ');
      break;
      }
    }

    const argument = dataView.getInt32(value + 4, true);
    print_positive_sexp(argument, dataView);
    process.stdout.write(')');
  }
};

const print_Z_sexp = (value, dataView) => {
  if (value & 1) {
    process.stdout.write('Z0');
  } else {
    const tag = dataView.getInt32(value, true);
    switch (tag) {
      case 0: {
        process.stdout.write('(Zpos ');
        break;
      }

      case 1: {
        process.stdout.write('(Zneg ');
        break;
      }
    }

    const argument = dataView.getInt32(value + 4, true);
    print_positive_sexp(argument, dataView);
    process.stdout.write(')');
  }
};

const print_compcert_byte_sexp = (value, dataView) => {
  process.stdout.write('(mkint ');
  const argument = dataView.getInt32(value + 4, true);
  print_Z_sexp(argument, dataView);
  process.stdout.write(')');
};

const print_list_sexp = (value, dataView, print_element) => {
  if (value & 1) {
    switch (value >> 1) {
      case 0: {
        process.stdout.write('nil');
        break;
      }
    }
  } else {
    const tag = dataView.getInt32(value, true);
    switch (tag) {
      case 0: {
        process.stdout.write('(cons ');
        const head = dataView.getInt32(value + 4, true);
        print_element(head, dataView);
        process.stdout.write(' ');
        const tail = dataView.getInt32(value + 8, true);
        print_list_sexp(tail, dataView, print_element);
        process.stdout.write(')');
        break;
      }
    }
  }
};

const print_sha = (value, dataView) => print_list_sexp(value, dataView, print_compcert_byte_sexp);

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
    print_sha(res_value, dataView);

    const bytes = object.instance.exports.bytes_used.value;
    console.log(`\n====> used ${bytes} bytes of memory, took ${(stop - start)} (Node.js) ms.`);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
