;; =================================================================================================================================
;; begin manual insertion
;; =================================================================================================================================

;; =================================================================================================================================
;; assign the expected names to the imported functions

(func $get_parameter_size (param $index i32) (result i32)
  (call 0 (local.get 0)))
(func $get_parameter_section (param $index i32) (param $write_location i32) (param $length i32) (param $offset i32) (result i32)
  (call 1 (local.get 0) (local.get 1) (local.get 2) (local.get 3)))
(func $invoke (param $tag i32) (param $start i32) (param $length i32) (result i64)
  (call 2 (local.get 0) (local.get 1) (local.get 2)))
(func $write_output (param $start i32) (param $length i32) (param $offset i32) (result i32)
  (call 3 (local.get 0) (local.get 1) (local.get 2)))
(func $state_lookup_entry (param $key_start i32) (param $key_length i32) (result i64)
  (call 4 (local.get 0) (local.get 1)))
(func $state_create_entry (param $key_start i32) (param $key_length i32) (result i64)
  (call 5 (local.get 0) (local.get 1)))
(func $state_entry_read (param $entry i64) (param $write_location i32) (param $length i32) (param $offset i32) (result i32)
  (call 6 (local.get 0) (local.get 1) (local.get 2) (local.get 3)))
(func $state_entry_write (param $entry i64) (param $read_location i32) (param $length i32) (param $offset i32) (result i32)
  (call 7 (local.get 0) (local.get 1) (local.get 2) (local.get 3)))

;; =================================================================================================================================
;; Helper Functions Concordium

(func $assert_eq (param $actual i32) (param $expected i32)
  (if (i32.eq (local.get $actual) (local.get $expected))
    (then nop)
    (else unreachable)))

(func $assert_eq_64 (param $actual i64) (param $expected i64)
  (if (i64.eq (local.get $actual) (local.get $expected))
    (then nop)
    (else unreachable)))

(func $assert_ne (param $actual i32) (param $expected i32)
  (if (i32.ne (local.get $actual) (local.get $expected))
    (then nop)
    (else unreachable)))

;; get 1st parameter
(func $get_parameter (result i64)
  (i64.store (i32.const 0) (i64.const 0))
  (call $get_parameter_section (i32.const 0) (i32.const 0) (i32.const 8) (i32.const 0))
  (drop)
  (return (i64.load (i32.const 0)))
)

;; Write a u64 to the [] entry in the state and assert that it succeeded. (adapted from fib.wat)
(func $set_state (param $val i64)
  (local $entry i64)
  ;; Get the id for the entry at [].
  (i64.store (i32.const 0) (i64.const 0))
  (local.set $entry (call $state_lookup_entry (i32.const 0) (i32.const 8)))
  ;; Store the input value at memory location 0.
  (i64.store (i32.const 0) (local.get $val))
  ;; Then write the u64 to the state from the position 0 in memory. Also check that writing succeeded.
  (call $assert_eq
    (call $state_entry_write (local.get $entry) (i32.const 0) (i32.const 8) (i32.const 0))
    (i32.const 8)) ;; Eight bytes should have been written.
)

;; Read the u64 state to wasm memory location 0 and assert that 8 bytes were read. (adapted from fib.wat)
(func $get_state (result i64)
  (local $entry i64)
  ;; Get the id for the entry at [].
  (i64.store (i32.const 0) (i64.const 0))
  (local.set $entry (call $state_lookup_entry (i32.const 0) (i32.const 8)))
  ;; Read to memory position 0.
  (call $assert_eq
    (call $state_entry_read (local.get $entry) (i32.const 0) (i32.const 8) (i32.const 0))
    (i32.const 8)
  )
  ;; Return the state value.
  (i64.load (i32.const 0))
)

;; Set the provided u64 as the return value, by using the `write_output` host function. Asserts that it succeeded. (taken from fib.wat)
(func $set_return_value (param $val i64)
  ;; Store the value at memory location 16.
  (i64.store (i32.const 0) (local.get $val))
  ;; Then write the u64 to the output from the position 0 in memory. Also check that writing succeeded.
  (call $assert_eq
    (call $write_output (i32.const 0) (i32.const 8) (i32.const 0))
    (i32.const 8)) ;; Eight bytes should have been written.
)

;; =================================================================================================================================
;; Helper Functions CertiCoq-Wasm

(func $assert_not_out_of_mem
  (call $assert_ne (global.get 3) (i32.const 1))
)

;; get certicoqwasm result
(func $get_result (result i32)
  (call $assert_not_out_of_mem)
  (return (global.get 2)) ;; result_var
)

(func $get_result_monad_ok (param $result i32) (result i32)
  (call $assert_eq (i32.load (local.get $result)) (i32.const 0)) ;; ordinal of Ok is 0
  (return (i32.load (i32.add (local.get $result) (i32.const 4)))) ;; return value wrapped by Ok
)

(func $make_Some (param $arg i32) (result i32) (local $res i32)
  ;; allocate (Some arg)
  (local.set $res (global.get 0))
  (i32.store (global.get 0) (i32.const 0))  ;; ordinal(Some) = 0
  (i32.store (i32.add (global.get 0) (i32.const 4)) (local.get $arg))
  (global.set 0 (i32.add (global.get 0) (i32.const 8)))
  (return (local.get $res))
)

;; lANF i63 primitive is i32 pointer to i64 in linear memory
(func $i64_to_i63 (param $val i64) (result i32) (local $res i32)
  ;; 0 is global mem_ptr
  (local.set $res (global.get 0))
  (i64.store (global.get 0) (local.get $val))
  (global.set 0 (i32.add (global.get 0) (i32.const 8))) ;; increase global mem_ptr so i64 is not overwritten later
  (return (local.get $res))
)
(func $i63_to_i64 (param $ptr i32) (result i64)
  (call $assert_not_out_of_mem)
  (return (i64.load (local.get $ptr)))
)

;; the parameter clos is an i32 pointing to a con_15(fidx, env) lANF closure
(func $call_closure (param $clos i32) (param $arg i32) (result i32)
  (local $fidx i32) (local $env i32)
  ;; ordinal of con_15 is 0
  (call $assert_eq (i32.load (local.get $clos)) (i32.const 0))

  (local.set $fidx (i32.load (i32.add (local.get $clos) (i32.const 4)))) ;; skip ordinal
  (local.set $env (i32.load (i32.add (local.get $clos) (i32.const 8)))) ;; skip ordinal, fidx
  (call_indirect (type 2) (local.get $env) (local.get $arg) (local.get $fidx))
  (return (call $get_result))
)
;; convenient uncurried function application with n args
(func $uncurry2 (param $clos i32) (param $arg1 i32) (param $arg2 i32) (result i32)
  (return (call $call_closure (call $call_closure (local.get $clos) (local.get $arg1)) (local.get $arg2)))
)
(func $uncurry3 (param $clos i32) (param $arg1 i32) (param $arg2 i32) (param $arg3 i32) (result i32)
  (return (call $uncurry2 (call $call_closure (local.get $clos) (local.get $arg1)) (local.get $arg2) (local.get $arg3)))
)
(func $uncurry4 (param $clos i32) (param $arg1 i32) (param $arg2 i32) (param $arg3 i32) (param $arg4 i32)(result i32)
  (return (call $uncurry3 (call $call_closure (local.get $clos) (local.get $arg1)) (local.get $arg2) (local.get $arg3) (local.get $arg4)))
)

;; =================================================================================================================================
;; The counter contract, see the record (COUNTER_MODULE : ConcordiumWasmMod _ _) in CounterConcordiumWasm.v in the ConCert repo.

(; running the main function returns the record COUNTER_MODULE
(representation: pointer to lin mem with tag followed by the following)

   concwmd_init : chain -> ctx -> Z (init value) -> result state
   concwmd_receive : chain -> ctx -> state -> option state -> result (state * actions)
   concwmd_encode_state : state -> i63
   concwmd_decode_state : i63 -> state
   concwmd_make_msg : i63 -> option Msg
;)

(func $counter_init_wrapper (export "init_counter") (param i64) (result i32)
  (local $init_value i64)

  ;; create and state entry
  (call $state_create_entry (i32.const 0) (i32.const 8))

  ;; get counter initial value
  (local.set $init_value (call $get_parameter))
  ;; ==> call certicoq-wasm contract (Counter.counter_init)
  (local.set $init_value (call $counter_init (local.get $init_value)))

  ;; set state entry
  (call $set_state (local.get $init_value))

  (return (i32.const 0)) ;; Successful init
)

(func $counter_init (param $init_value i64) (result i64)
  (local $main_res i32)
  (local $init_clos i32)
  (local $state_to_i63_clos i32)
  (local $i63_to_Z_clos i32)

  ;; args for the init function
  (local $chain i32)
  (local $ctx i32)
  (local $init_value_Z i32)

  (local $res i32) ;; final result

  ;; reserve the first 100 bytes in the linmem for concordium IO
  ;; I think only the first 8 are used (more for good measure)
  (global.set 0 (i32.add (i32.const 100) (global.get 0))) ;; global_mem_ptr

  ;; this shouldn't be necessary wtf?
  (i64.store (i32.const 0) (i64.const 0))

  (call 9) ;; call main
  (local.set $main_res (call $get_result))
  ;; concwmd_init
  (local.set $init_clos (i32.load (i32.add (local.get $main_res) (i32.const 4))))
  ;; concwmd_encode_state
  (local.set $state_to_i63_clos (i32.load (i32.add (local.get $main_res) (i32.const 12))))
  ;; concwmd_i63_to_Z
  (local.set $i63_to_Z_clos (i32.load (i32.add (local.get $main_res) (i32.const 24))))

  (local.set $chain (i32.const -1)) ;; unused
  (local.set $ctx (i32.const 0)) ;; 0 ok here, init function loads i32 from addr 0+4, encode_state discards it

  (local.set $init_value_Z
    (call $call_closure (local.get $i63_to_Z_clos) (call $i64_to_i63 (local.get $init_value)))
  )

  ;; call the function CertiCoq-Wasm generated for the counter_init function
  (local.set $res (call $uncurry3 (local.get $init_clos) (local.get $chain) (local.get $ctx) (local.get $init_value_Z)))
  (local.set $res (call $get_result_monad_ok (local.get $res))) ;; state
  (local.set $res (call $call_closure (local.get $state_to_i63_clos) (local.get $res))) ;; ptr -> i64

  (return (local.get $init_value))
;;  (return (call $i63_to_i64 (local.get $res))) ;; counter value
)

;; This function wraps the interface with the concordium blockchain
(func $counter_receive_wrapper(export "counter.inc") (param i64) (result i32)
  (local $state i64) ;; value of counter
  (local $increase_by i64)
  (local $state_new i64)

  ;; read the integer from the contract state
  (local.set $state (call $get_state))
  ;; read param passed from rust
  (local.set $increase_by (call $get_parameter))

  ;; ==> call certicoq-wasm contract (Counter.counter_receive)
  (local.set $state_new (call $counter_receive (local.get $state) (local.get $increase_by)))

  ;; update the contract state
  (call $set_state (local.get $state_new))
  ;; and then write the return value
  (call $set_return_value (local.get $state_new))
  ;; and return success
  (i32.const 0)
)

;; This function calls the counter_receive function generated by CertiCoq-Wasm
(func $counter_receive (param $count_old i64) (param $increase_by i64) (result i64)
  (local $main_res i32)

  (local $receive_clos i32)
  (local $state_to_i63_clos i32)
  (local $i63_to_state_clos i32)
  (local $make_msg_clos i32)

  ;; args for the counter_receive function
  (local $chain i32)
  (local $ctx i32)
  (local $state i32)
  (local $msg i32)

  (local $res i32) ;; final result

  ;; reserve the first 100 bytes in the linmem for concordium IO
  ;; I think only the first 8 are used (more for good measure)
  (global.set 0 (i32.add (i32.const 100) (global.get 0))) ;; global_mem_ptr
  (call 9) ;; call main
  (local.set $main_res (call $get_result))

  ;; concwmd_receive
  (local.set $receive_clos      (i32.load (i32.add (local.get $main_res) (i32.const 8))))
  ;; concwmd_encode_state
  (local.set $state_to_i63_clos (i32.load (i32.add (local.get $main_res) (i32.const 12))))
  ;; concwmd_decode_state
  (local.set $i63_to_state_clos (i32.load (i32.add (local.get $main_res) (i32.const 16))))
  ;; concwmd_make_msg
  (local.set $make_msg_clos     (i32.load (i32.add (local.get $main_res) (i32.const 20))))

  ;; -1: chain, ctx (not used in counter)
  (local.set $chain (i32.const -1))
  (local.set $ctx   (i32.const -1))
  (local.set $state (call $call_closure (local.get $i63_to_state_clos) (call $i64_to_i63 (local.get $count_old))))
  (local.set $msg   (call $call_closure (local.get $make_msg_clos)     (call $i64_to_i63 (local.get $increase_by))))

  ;; call the function CertiCoq-Wasm generated for the counter_receive function
  (local.set $res (call $uncurry4 (local.get $receive_clos) (local.get $chain) (local.get $ctx) (local.get $state) (local.get $msg)))

  ;; Ok (state * list actionBody)
  ;; (return (i64.extend_i32_s (i32.load (local.get $res))))
  (local.set $res (call $get_result_monad_ok (local.get $res))) ;; state * list actionBody
  (local.set $res (i32.load (i32.add (local.get $res) (i32.const 4)))) ;; state
  (local.set $res (call $call_closure (local.get $state_to_i63_clos) (local.get $res))) ;; ptr -> i64

  (return (call $i63_to_i64 (local.get $res))) ;; current counter value
;;   (i64.extend_i32_s (local.get $res))
)
;; =================================================================================================================================
;; end manual insertion
;; =================================================================================================================================
