import { print_i63, print_compare, print_bool, print_nat_sexp, print_nat_notation, print_list_sexp, print_list_notation, print_option, print_prod, print_positive_sexp, print_N_sexp, print_Z_sexp, print_compcert_byte_sexp } from '../../evaluation/pp.js';

import * as fs from 'fs';

const bytes = fs.readFileSync('./sha.wasm');
// Specify pp function.
const print_sha = (value, dataView) => print_list_sexp(value, dataView, print_compcert_byte_sexp);

const importObject = { env: {} };

(async () => {
  const object = await WebAssembly.instantiate(
    new Uint8Array(bytes), importObject,
  );

  try {
    const start = Date.now();
    object.instance.exports.main_function();
    const stop = Date.now();

    const dataView = new DataView(object.instance.exports.memory.buffer);
    const res_value = object.instance.exports.result.value;
    process.stdout.write('====> ');
    print_sha(res_value, dataView);

    const bytes = object.instance.exports.bytes_used.value;
    console.log(`\n====> used ${bytes} bytes of memory, took ${(stop - start)} ms (Node.js).`);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
