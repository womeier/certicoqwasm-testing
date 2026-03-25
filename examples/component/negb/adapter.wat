(module
  ;; Import from CertiCoq module (will be resolved by wasm-merge)
  (import "rocq" "memory" (memory 1))
  (import "rocq" "mem_ptr" (global $mem_ptr (mut i32)))
  (import "rocq" "result" (global $result (mut i32)))
  (import "rocq" "main_function" (func $main_function))
  (import "rocq" "__indirect_function_table" (table 2 funcref))

  ;; Function type for CertiCoq functions: (env, arg) -> void
  (type $rocq_func (func (param i32 i32)))

  ;; Export canonical ABI function
  ;; bool is represented as i32 (0=false, 1=true) in Component Model
  ;; CertiRocq represents bool as tagged immediates: false=1, true=3
  ;; Encoding: (tag << 1) | 1, so false(tag=0)=1, true(tag=1)=3
  (func (export "negb") (param $val i32) (result i32)
    (local $arg i32)
    (local $closure_ptr i32)
    (local $func_idx i32)
    (local $env_ptr i32)

    ;; Call main_function to get the closure pointer
    (call $main_function)
    (local.set $closure_ptr (global.get $result))

    ;; Extract function index and environment from closure
    ;; Closure layout: [tag (offset 0), func_idx (offset 4), env_ptr (offset 8)]
    (local.set $func_idx (i32.load (i32.add (local.get $closure_ptr) (i32.const 4))))
    (local.set $env_ptr (i32.load (i32.add (local.get $closure_ptr) (i32.const 8))))

    ;; Convert Component Model bool (0/1) to CertiRocq tagged immediate (1/3)
    ;; Formula: (val << 1) | 1
    (local.set $arg (i32.or (i32.shl (local.get $val) (i32.const 1)) (i32.const 1)))

    ;; Call CertiCoq function indirectly (env, arg)
    (call_indirect (type $rocq_func)
      (local.get $env_ptr)
      (local.get $arg)
      (local.get $func_idx))

    ;; Read result and convert CertiRocq tagged immediate (1/3) to bool (0/1)
    ;; Formula: val >> 1
    (i32.shr_u (global.get $result) (i32.const 1))
  )
)
