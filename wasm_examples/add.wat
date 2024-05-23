(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param (ref any)) (result i32)))
  (type (;2;) (struct (field i32 i32)))
  (type (;3;) (func (param i32) (result (ref any))))

  (export "add" (func 0))
  (func (;0;) (type 0)
    local.get 0
    local.get 1
    ref.func 1
    call_ref 0)

  (; actual addition ;)
  (func (;1;) (type 0)
    local.get 0
    ref.i31
    call 2 (; identity ;)

    i32.const 1
    local.get 1
    struct.new 2
    call 2 (; identity ;)

(;    i32.const 43  indicates func ref
    ref.func 1
    call 2 ;)

    i32.add)

  (func (;2;) (type 1)
    local.get 0
    ref.test (ref i31)
    if
      (; is i31 ;)
      local.get 0
      ref.cast (ref i31)
      i31.get_u
      return
    else
      (; is struct ;)
      local.get 0
      ref.cast (ref 2)
      struct.get 2 1
      return
    end

    unreachable
    )

  (export "wrap_i31" (func 3))
  (func (;3;) (type 3)
    local.get 0
    ref.i31
    return)

  (export "wrap_struct" (func 4))
  (func (;4;) (type 3)
    local.get 0
    i32.const 0
    struct.new 2
    return)

  (; also possible instead
      (table 2 funcref)
      (elem (i32.const 0) func 0)
      (elem (i32.const 1) func 1)
  ;)
  (elem func 1)
)
