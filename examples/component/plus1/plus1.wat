(module
  ;; Memory for returning option result
  (memory (export "memory") 1)

  ;; Returns option<u64> via memory pointer
  ;; Layout: discriminant (1 byte) at offset 0, payload (i64) at offset 8
  (func (export "plus1") (param $val i64) (result i32)
    ;; Store discriminant = 1 (some) at offset 0
    (i32.store8 (i32.const 0) (i32.const 1))
    ;; Store payload (val + 1) at offset 8
    (i64.store (i32.const 8) (i64.add (local.get $val) (i64.const 1)))
    ;; Return pointer to option struct
    (i32.const 0))
)
