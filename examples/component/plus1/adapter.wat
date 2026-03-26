(module
  ;; Import from CertiCoq module (will be resolved by wasm-merge)
  (import "rocq" "memory" (memory 1))
  (import "rocq" "mem_ptr" (global $mem_ptr (mut i32)))
  (import "rocq" "result" (global $result (mut i32)))
  (import "rocq" "out_of_mem" (global $out_of_mem (mut i32)))
  (import "rocq" "main_function" (func $main_function))
  (import "rocq" "__indirect_function_table" (table 2 funcref))

  ;; Function type for CertiCoq functions: (env, arg) -> void
  (type $rocq_func (func (param i32 i32)))

  ;; Export canonical ABI function
  ;; Returns option<u64> via memory pointer
  ;; Layout: discriminant (1 byte) at offset 0, payload (i64) at offset 8
  ;; discriminant=0 means none, discriminant=1 means some
  (func (export "plus1") (param $val i64) (result i32)
    (local $arg_ptr i32)
    (local $closure_ptr i32)
    (local $func_idx i32)
    (local $env_ptr i32)
    (local $ret_ptr i32)

    ;; Pre-allocate 32 bytes (for good measure) to return the result option
    (local.set $ret_ptr (global.get $mem_ptr))
    (global.set $mem_ptr (i32.add (global.get $mem_ptr) (i32.const 32)))

    ;; Call main_function to get the closure pointer
    (call $main_function)
    (local.set $closure_ptr (global.get $result))

    ;; Extract function index and environment from closure
    ;; Closure layout: [tag (offset 0), func_idx (offset 4), env_ptr (offset 8)]
    (local.set $func_idx (i32.load (i32.add (local.get $closure_ptr) (i32.const 4))))
    (local.set $env_ptr (i32.load (i32.add (local.get $closure_ptr) (i32.const 8))))

    ;; Store i64 argument at offset 16 from ret_ptr
    (local.set $arg_ptr (i32.add (local.get $ret_ptr) (i32.const 16)))
    (i64.store (local.get $arg_ptr) (local.get $val))

    ;; Call CertiCoq function indirectly (env, arg)
    (call_indirect (type $rocq_func)
      (local.get $env_ptr)
      (local.get $arg_ptr)
      (local.get $func_idx))

    ;; Check if out of memory
    ;; (this is required in general, but for this tiny example it could be skipped)
    (if (global.get $out_of_mem)
      (then
        ;; Return none: discriminant = 0
        (i32.store8 (local.get $ret_ptr) (i32.const 0))
      )
      (else
        ;; Return some: discriminant = 1, payload = result
        (i32.store8 (local.get $ret_ptr) (i32.const 1))
        (i64.store (i32.add (local.get $ret_ptr) (i32.const 8)) (i64.load (global.get $result)))
      )
    )

    ;; Return pointer to option struct
    (local.get $ret_ptr)
  )
)
