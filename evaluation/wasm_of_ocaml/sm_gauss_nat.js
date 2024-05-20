import {join, dirname} from "path";
import {readFile} from "fs/promises";
import {spawnSync} from "child_process";
import * as process from "process";
import * as fs from "fs";

(function (a) {
    typeof globalThis !== "object" && (this ? b() : (a.defineProperty(a.prototype, "_T_", { configurable: true, get: b }), _T_));
    function b() {
        var b = this || self;
        b.globalThis = b;
        delete a.prototype._T_;
    }
})(Object);
((u) => async (a) => {
    "use strict";
    let { src: r, generated: C } = a;
    function F(a) {
	console.log(process.argv[1]);
        const c = join(dirname(process.argv[1]), a);
        return readFile(c);
    }
    function B(a) {
        const b = globalThis?.document?.currentScript?.src,
            c = b ? new URL(a, b) : a;
        return fetch(c);
    }
    const g = globalThis?.process?.versions?.node,
        o = g ? F(r) : B(r);
    let G = {
            cos: Math.cos,
            sin: Math.sin,
            tan: Math.tan,
            acos: Math.acos,
            asin: Math.asin,
            atan: Math.atan,
            cosh: Math.cosh,
            sinh: Math.sinh,
            tanh: Math.tanh,
            acosh: Math.acosh,
            asinh: Math.asinh,
            atanh: Math.atanh,
            cbrt: Math.cbrt,
            exp: Math.exp,
            expm1: Math.expm1,
            log: Math.log,
            log1p: Math.log1p,
            log2: Math.log2,
            log10: Math.log10,
            atan2: Math.atan2,
            hypot: Math.hypot,
            pow: Math.pow,
            fmod: (a, b) => a % b,
        },
        t = [Float32Array, Float64Array, Int8Array, Uint8Array, Int16Array, Uint16Array, Int32Array, Int32Array, Int32Array, Int32Array, Float32Array, Float64Array, Uint8Array, Uint8ClampedArray];
    const f = g && fs;
    let e = f?.constants,
        H = f ? [e.RDONLY, e.O_WRONLY, e.O_APPEND, e.O_CREAT, e.O_TRUNC, e.O_EXCL, e.O_NONBLOCK] : [];
    var b = { map: new WeakMap(), set: new Set(), finalization: new FinalizationRegistry((a) => b.set.delete(a)) };
    function J(a) {
        const c = new WeakRef(a);
        b.map.set(a, c);
        b.set.add(c);
        b.finalization.register(a, c, a);
    }
    function K(a) {
        const c = b.map.get(a);
        if (c) {
            b.map.delete(a);
            b.set.delete(c);
            b.finalization.unregister(a);
        }
    }
    function z() {
        return [...b.set].map((a) => a.deref()).filter((a) => a);
    }
    var s;
    function l(a, b, c) {
        try {
            return new WebAssembly.Function(a, b, c);
        } catch (f) {
            return b;
        }
    }
    const j = new TextDecoder("utf-8", { ignoreBOM: 1 }),
        A = new TextEncoder();
    function D(a, b) {
        b = Math.imul(b, 0xcc9e2d51 | 0);
        b = (b << 15) | (b >>> 17);
        b = Math.imul(b, 0x1b873593);
        a ^= b;
        a = (a << 13) | (a >>> 19);
        return (((a + (a << 2)) | 0) + (0xe6546b64 | 0)) | 0;
    }
    function E(a, b) {
        for (var c = 0; c < b.length; c++) a = D(a, b.charCodeAt(c));
        return a ^ b.length;
    }
    let v = {
            jstag: WebAssembly.JSTag || new WebAssembly.Tag({ parameters: ["externref"], results: [] }),
            identity: (a) => a,
            from_bool: (a) => !!a,
            get: (a, b) => a[b],
            set: (a, b, c) => (a[b] = c),
            delete: (a, b) => delete a[b],
            instanceof: (a, b) => a instanceof b,
            typeof: (a) => typeof a,
            equals: (a, b) => a == b,
            strict_equals: (a, b) => a === b,
            fun_call: (a, b, c) => a.apply(b, c),
            meth_call: (a, b, c) => a[b].apply(a, c),
            new_array: (a) => new Array(a),
            new_obj: () => ({}),
            new: (a, b) => new a(...b),
            global_this: globalThis,
            iter_props: (a, b) => {
                for (var c in a) if (a.hasOwnProperty(c)) b(c);
            },
            array_length: (a) => a.length,
            array_get: (a, b) => a[b],
            array_set: (a, b, c) => (a[b] = c),
            read_string: (a) => j.decode(new Uint8Array(h, 0, a)),
            read_string_stream: (a, b) => j.decode(new Uint8Array(h, 0, a), { stream: b }),
            append_string: (a, b) => a + b,
            write_string: (a) => {
                var c = 0,
                    b = a.length;
                while (1) {
                    let { read: d, written: e } = A.encodeInto(a.slice(c), I);
                    b -= d;
                    if (!b) return e;
                    x(e);
                    c += d;
                }
            },
            ta_create: (a, b) => new t[a](b),
            ta_normalize: (a) => (a instanceof Uint32Array ? new Int32Array(a.buffer, a.byteOffset, a.length) : a),
            ta_kind: (b) => t.findIndex((a) => b instanceof a),
            ta_length: (a) => a.length,
            ta_get_f64: (a, b) => a[b],
            ta_get_f32: (a, b) => a[b],
            ta_get_i32: (a, b) => a[b],
            ta_get_i16: (a, b) => a[b],
            ta_get_ui16: (a, b) => a[b],
            ta_get_i8: (a, b) => a[b],
            ta_get_ui8: (a, b) => a[b],
            ta_set_f64: (a, b, c) => (a[b] = c),
            ta_set_f32: (a, b, c) => (a[b] = c),
            ta_set_i32: (a, b, c) => (a[b] = c),
            ta_set_i16: (a, b, c) => (a[b] = c),
            ta_set_ui16: (a, b, c) => (a[b] = c),
            ta_set_i8: (a, b, c) => (a[b] = c),
            ta_set_ui8: (a, b, c) => (a[b] = c),
            ta_fill: (a, b) => a.fill(b),
            ta_blit: (a, b) => b.set(a),
            ta_subarray: (a, b, c) => a.subarray(b, c),
            ta_set: (a, b, c) => a.set(b, c),
            ta_new: (a) => new Uint8Array(a),
            ta_copy: (a, b, c, d) => a.copyWithin(b, c, d),
            ta_bytes: (a) => new Uint8Array(a.buffer, a.byteOffset, a.length * a.BYTES_PER_ELEMENT),
            wrap_callback: (a) =>
                function () {
                    var e = arguments.length;
                    if (e > 0) {
                        var b = new Array(e);
                        for (var d = 0; d < e; d++) b[d] = arguments[d];
                    } else b = [undefined];
                    return c(a, b.length, b, 1);
                },
            wrap_callback_args: (a) =>
                function () {
                    var e = arguments.length,
                        d = new Array(e);
                    for (var b = 0; b < e; b++) d[b] = arguments[b];
                    return c(a, 1, [d], 0);
                },
            wrap_callback_strict: (a, b) =>
                function () {
                    var g = arguments.length,
                        e = new Array(a),
                        f = Math.min(arguments.length, a);
                    for (var d = 0; d < f; d++) e[d] = arguments[d];
                    return c(b, a, e, 0);
                },
            wrap_callback_unsafe: (a) =>
                function () {
                    var e = arguments.length,
                        d = new Array(e);
                    for (var b = 0; b < e; b++) d[b] = arguments[b];
                    return c(a, d.length, d, 2);
                },
            wrap_meth_callback: (a) =>
                function () {
                    var e = arguments.length,
                        b = new Array(e + 1);
                    b[0] = this;
                    for (var d = 0; d < e; d++) b[d + 1] = arguments[d];
                    return c(a, b.length, b, 1);
                },
            wrap_meth_callback_args: (a) =>
                function () {
                    var e = arguments.length,
                        d = new Array(e);
                    for (var b = 0; b < e; b++) d[b] = arguments[b];
                    return c(a, 2, [this, d], 0);
                },
            wrap_meth_callback_strict: (a, b) =>
                function () {
                    var d = new Array(a + 1),
                        f = Math.min(arguments.length, a);
                    d[0] = this;
                    for (var e = 0; e < f; e++) d[e + 1] = arguments[e];
                    return c(b, d.length, d, 0);
                },
            wrap_meth_callback_unsafe: (a) =>
                function () {
                    var e = arguments.length,
                        b = new Array(e + 1);
                    b[0] = this;
                    for (var d = 0; d < e; d++) b[d + 1] = arguments[d];
                    return c(a, b.length, b, 2);
                },
            wrap_fun_arguments: (a) =>
                function () {
                    return a(arguments);
                },
            format_float: (a, b, c, d) => {
                function j(a, b) {
                    if (Math.abs(a) < 1.0) return a.toFixed(b);
                    else {
                        var c = parseInt(a.toString().split("+")[1]);
                        if (c > 20) {
                            c -= 20;
                            a /= Math.pow(10, c);
                            a += new Array(c + 1).join("0");
                            if (b > 0) a = a + "." + new Array(b + 1).join("0");
                            return a;
                        } else return a.toFixed(b);
                    }
                }
                switch (b) {
                    case 0:
                        var e = d.toExponential(a),
                            f = e.length;
                        if (e.charAt(f - 3) == "e") e = e.slice(0, f - 1) + "0" + e.slice(f - 1);
                        break;
                    case 1:
                        e = j(d, a);
                        break;
                    case 2:
                        a = a ? a : 1;
                        e = d.toExponential(a - 1);
                        var i = e.indexOf("e"),
                            h = +e.slice(i + 1);
                        if (h < -4 || d >= 1e21 || d.toFixed(0).length > a) {
                            var f = i - 1;
                            while (e.charAt(f) == "0") f--;
                            if (e.charAt(f) == ".") f--;
                            e = e.slice(0, f + 1) + e.slice(i);
                            f = e.length;
                            if (e.charAt(f - 3) == "e") e = e.slice(0, f - 1) + "0" + e.slice(f - 1);
                            break;
                        } else {
                            var g = a;
                            if (h < 0) {
                                g -= h + 1;
                                e = d.toFixed(g);
                            } else while (((e = d.toFixed(g)), e.length > a + 1)) g--;
                            if (g) {
                                var f = e.length - 1;
                                while (e.charAt(f) == "0") f--;
                                if (e.charAt(f) == ".") f--;
                                e = e.slice(0, f + 1);
                            }
                        }
                        break;
                }
                return c ? " " + e : e;
            },
            gettimeofday: () => new Date().getTime() / 1000,
            gmtime: (a) => {
                var b = new Date(a * 1000),
                    c = b.getTime(),
                    e = new Date(Date.UTC(b.getUTCFullYear(), 0, 1)).getTime(),
                    d = Math.floor((c - e) / 86400000);
                return m(b.getUTCSeconds(), b.getUTCMinutes(), b.getUTCHours(), b.getUTCDate(), b.getUTCMonth(), b.getUTCFullYear() - 1900, b.getUTCDay(), d, false);
            },
            localtime: (a) => {
                var b = new Date(a * 1000),
                    c = b.getTime(),
                    f = new Date(b.getFullYear(), 0, 1).getTime(),
                    d = Math.floor((c - f) / 86400000),
                    e = new Date(b.getFullYear(), 0, 1),
                    g = new Date(b.getFullYear(), 6, 1),
                    h = Math.max(e.getTimezoneOffset(), g.getTimezoneOffset());
                return m(b.getSeconds(), b.getMinutes(), b.getHours(), b.getDate(), b.getMonth(), b.getFullYear() - 1900, b.getDay(), d, b.getTimezoneOffset() < h);
            },
            mktime: (a, b, c, d, e, f) => new Date(a, b, c, d, e, f).getTime(),
            random_seed: () => crypto.getRandomValues(new Int32Array(12)),
            open: (a, d, c) =>
                f.openSync(
                    a,
                    H.reduce((a, b, c) => (d & (1 << c) ? a | b : a), 0),
                    c
                ),
            close: (a) => f.closeSync(a),
            write: (a, b, c, d, e) => (f ? f.writeSync(a, b, c, d, e == null ? e : Number(e)) : (console[a == 2 ? "error" : "log"](typeof b == "string" ? b : j.decode(b.slice(c, c + d))), d)),
            read: (a, b, c, d, e) => f.readSync(a, b, c, d, e),
            file_size: (a) => f.fstatSync(a, { bigint: true }).size,
            register_channel: J,
            unregister_channel: K,
            channel_list: z,
            exit: (a) => g && d.exit(a),
            argv: () => (g ? d.argv.slice(1) : ["a.out"]),
            getenv: (a) => (g ? d.env[a] : null),
            system: (a) => {
                var b = spawnSync(a, { shell: true, stdio: "inherit" });
                if (b.error) throw b.error;
                return b.signal ? 255 : b.status;
            },
            time: () => performance.now(),
            getcwd: () => (g ? d.cwd() : "/static"),
            chdir: (a) => d.chdir(a),
            mkdir: (a, b) => f.mkdirSync(a, b),
            unlink: (a) => f.unlinkSync(a),
            readdir: (a) => f.readdirSync(a),
            file_exists: (a) => +f.existsSync(a),
            rename: (a, b) => f.renameSync(a, b),
            throw: (a) => {
                throw a;
            },
            start_fiber: (a) => s(a),
            suspend_fiber: l({ parameters: ["externref", "funcref", "eqref"], results: ["eqref"] }, (c, b) => new Promise((a) => c(a, b)), { suspending: "first" }),
            resume_fiber: (a, b) => a(b),
            weak_new: (a) => new WeakRef(a),
            weak_deref: (a) => {
                var b = a.deref();
                return b == undefined ? null : b;
            },
            weak_map_new: () => new WeakMap(),
            map_new: () => new Map(),
            map_get: (a, b) => {
                var c = a.get(b);
                return c == undefined ? null : c;
            },
            map_set: (a, b, c) => a.set(b, c),
            map_delete: (a, b) => a.delete(b),
            log: (a) => console.log("ZZZZZ", a),
        },
        k = { test: (a) => +(typeof a === "string"), compare: (a, b) => (a < b ? -1 : +(a > b)), hash: E, decodeStringFromUTF8Array: () => "", encodeStringToUTF8Array: () => 0 };
    const p = Object.assign({ Math: G, bindings: v, js: u, "wasm:js-string": k, "wasm:text-decoder": k, "wasm:text-encoder": k, env: {} }, C),
        q = { builtins: ["js-string", "text-decoder", "text-encoder"] },
        L = g ? await WebAssembly.instantiate(await o, p, q) : await WebAssembly.instantiateStreaming(o, p, q);
    var { caml_callback: c, caml_alloc_tm: m, caml_start_fiber: y, caml_handle_uncaught_exception: n, caml_buffer: w, caml_extract_string: x, _initialize: i } = L.instance.exports,
        h = w?.buffer,
        I = h && new Uint8Array(h, 0, h.length);
    s = l({ parameters: ["eqref"], results: ["externref"] }, y, { promising: "first" });
    var i = l({ parameters: [], results: ["externref"] }, i, { promising: "first" }),
        d = globalThis.process;
    if (d && d.on) d.on("uncaughtException", (a, b) => n(a));
    else if (globalThis.addEventListener) globalThis.addEventListener("error", (a) => a.error && n(a.error));
    const start_time = Date.now();
    await i();
    const end_time = Date.now();
    const exec_time = end_time - start_time
    console.log(`sm_gauss_nat execution time (including pretty printing): ${exec_time} ms`);
})(
    (function (a) {
        "use strict";
        return {};
    })(globalThis)
)({
    generated: ((a) => {
        var b = a,
            c = a?.module?.export || a;
        return { strings: ["Undefined_recursive_module", "Assert_failure", "Sys_blocked_io", "Stack_overflow", "Match_failure", "Not_found", "Division_by_zero", "End_of_file", "Invalid_argument", "Failure", "Sys_error", "Out_of_memory"] };
    })(globalThis),
    src: "sm_gauss_nat.wasm",
});
