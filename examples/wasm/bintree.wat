(module
  ;; function imports
  (import "env" "log_i32" (func $log_i32 ( param i32 )))
  (import "env" "log_invalid" (func $log_invalid ( param i32 )))
  (import "env" "write_char" (func $write_char( param i32 ))) ;; ascii decimal
  (import "env" "write_int" (func $write_int( param i32 )))
  ;; memory and global variables
  (memory 10) ;; times 64KB
  (global $ptr (mut i32) (i32.const 0)) ;; no alignment requirements
  ;;
  (global $id_leaf i32 (i32.const 42))
  (global $id_node i32 (i32.const 43))
  (;

  representation in linear memory:

     Leaf: --> +----+
               | 42 |
               +----+

     Node: --> +----+---+---+---+
               | 43 | L | V | R |
               +----+---+---+---+
  ;)
  (func $store_int (param $val i32)
    global.get $ptr
    local.get $val
    i32.store

    global.get $ptr
    i32.const 4
    i32.add
    global.set $ptr
  )

  ;; beginning
  (func $create_leaf (export "create_leaf")
  (result i32)                    ;; pointer to leaf
    global.get $id_leaf
    call $store_int

    global.get $ptr               ;; return pointer
    i32.const 4
    i32.sub
    return
  )

  (func $create_node (export "create_node")
  (param $left i32) (param $value i32) (param $right i32)
  (result i32)
    global.get $id_node
    call $store_int

    local.get $left               ;; left subtree
    call $store_int

    local.get $value              ;; value
    call $store_int

    local.get $right              ;; right
    call $store_int

    global.get $ptr               ;; return pointer
    i32.const 16
    i32.sub
    return
  )

  (func $is_valid (export "is_valid")
  (param $addr i32)
  (result i32)                    ;; 1/0
    local.get $addr
    i32.load
    global.get $id_leaf
    i32.eq
    if
      i32.const 1
      return
    end

    local.get $addr
    i32.load
    global.get $id_node
    i32.eq
    if
      ;; left
      local.get $addr
      i32.const 4
      i32.add
      i32.load
      call $is_valid

      ;; right
      local.get $addr
      i32.const 12
      i32.add
      i32.load
      call $is_valid

      i32.and
      return
    end

    i32.const 0
    return
  )

  (func $in_order (export "in_order")
  (param $addr i32)
    local.get $addr
    call $is_valid

    i32.const 0
    i32.eq
    if                    ;; check if addr points to valid tree
      local.get $addr
      call $log_invalid
      return
    end

    local.get $addr
    i32.load
    global.get $id_leaf
    i32.eq
    if
      ;; leaf
      return
    end

    local.get $addr
    i32.const 4
    i32.add               ;; skip constructor id
    i32.load
    call $in_order

    local.get $addr
    i32.const 8
    i32.add               ;; skip constructor id, left
    i32.load
    call $log_i32

    local.get $addr
    i32.const 12
    i32.add               ;; skip constructor id, left, val
    i32.load
    call $in_order
  )

  (func $pretty_print (export "pretty_print")
  (param $addr i32)
    local.get $addr
    call $is_valid

    i32.const 0
    i32.eq
    if                    ;; check if addr points to valid tree
      local.get $addr
      call $log_invalid
      return
    end

    local.get $addr
    i32.load
    global.get $id_leaf
    i32.eq
    if
      ;; Leaf
      i32.const 76
      call $write_char
      i32.const 101
      call $write_char
      i32.const 97
      call $write_char
      i32.const 102
      call $write_char

      return
    end

    i32.const 40 ;; (
    call $write_char

    ;; Node
    i32.const 78
    call $write_char
    i32.const 111
    call $write_char
    i32.const 100
    call $write_char
    i32.const 101
    call $write_char

    i32.const 32 ;; space
    call $write_char

    local.get $addr
    i32.const 4
    i32.add               ;; skip constructor id
    i32.load
    call $pretty_print

    i32.const 32 ;; space
    call $write_char

    local.get $addr
    i32.const 8
    i32.add               ;; skip constructor id, left
    i32.load
    call $write_int

    i32.const 32 ;; space
    call $write_char

    local.get $addr
    i32.const 12
    i32.add               ;; skip constructor id, left, val
    i32.load
    call $pretty_print

    i32.const 41 ;; )
    call $write_char
  )
)
