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
  (func (export "plus1") (param $val i64) (result i64)
    (local $arg_ptr i32)
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

    ;; Allocate: store i64 at current mem_ptr
    (local.set $arg_ptr (global.get $mem_ptr))
    (i64.store (global.get $mem_ptr) (local.get $val))
    (global.set $mem_ptr (i32.add (global.get $mem_ptr) (i32.const 8)))

    ;; Call CertiCoq function indirectly (env, arg)
    (call_indirect (type $rocq_func)
      (local.get $env_ptr)
      (local.get $arg_ptr)
      (local.get $func_idx))

    ;; Read result from memory at address in $result global
    (i64.load (global.get $result))
  )
)
