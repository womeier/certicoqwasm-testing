(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (struct (field i32 i32)))

  (export "add" (func 0))
  (func (;0;) (type 0)
    local.get 0
    call 2
    local.get 1
    ref.func 1
    call_ref 0)

  (; actual addition ;)
  (func (;1;) (type 0)
    local.get 0
    local.get 1
    i32.add)

  (; id ;)
  (func (;2;) (type 1)
    i32.const 123
    local.get 0
    struct.new 2
    struct.get 2 0)

  (table (;0;) 2 funcref)
  (elem (;0;) (i32.const 0) func 0)
  (elem (;1;) (i32.const 1) func 1)
)
