(module
  (export "g1" (func 0))
  (func (;0;) (result i32)
    i32.const 42
    return_call $id
  )

  (export "g2" (func 1))
  (func (;1;) (result i32)
    i32.const 42
    call $id
  )

  (func $id (param i32) (result i32)
     local.get 0
  )
)
