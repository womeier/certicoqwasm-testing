(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (type (;3;) (func (result i32)))
  (type (;4;) (func (param i32 i64) (result i32)))
  (type (;5;) (func (result i64)))
  (type (;6;) (func (param i32)))
  (type (;7;) (func (param i32) (result i32)))
  (type (;8;) (func (param i64) (result i32)))
  (type (;9;) (func))
  (type (;10;) (func (param i32 i32 i32 i32)))
  (type (;11;) (func (param i32 i32 i32)))
  (type (;12;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;14;) (func (param i32 i32 i32 i32 i32 i32)))
  (type (;15;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;16;) (func (param i64 i32 i32) (result i32)))
  (import "concordium" "accept" (func $_ZN14concordium_std5prims6accept17hf93576e394a80c25E (type 3)))
  (import "concordium" "simple_transfer" (func $_ZN14concordium_std5prims15simple_transfer17hd5ce3c90f71e48c5E (type 4)))
  (import "concordium" "combine_and" (func $_ZN14concordium_std5prims11combine_and17h662153db78184c59E (type 0)))
  (import "concordium" "get_slot_time" (func $_ZN14concordium_std5prims13get_slot_time17h28cff685067e82a8E (type 5)))
  (import "concordium" "get_init_origin" (func $_ZN14concordium_std5prims15get_init_origin17he2e25a3b7939f5e0E (type 6)))
  (import "concordium" "get_receive_sender" (func $_ZN14concordium_std5prims18get_receive_sender17h51fcbe17bbd09fafE (type 6)))
  (import "concordium" "get_receive_self_address" (func $_ZN14concordium_std5prims24get_receive_self_address17h9cab23bc56e094a5E (type 6)))
  (import "concordium" "get_receive_self_balance" (func $_ZN14concordium_std5prims24get_receive_self_balance17h511dec6c6f0e077fE (type 5)))
  (import "concordium" "get_receive_invoker" (func $_ZN14concordium_std5prims19get_receive_invoker17hdb8ac4c5feeebbc6E (type 6)))
  (import "concordium" "state_size" (func $_ZN14concordium_std5prims10state_size17h00763b029122c0f2E (type 3)))
  (import "concordium" "load_state" (func $_ZN14concordium_std5prims10load_state17hecf53a1e2ababc57E (type 2)))
  (import "concordium" "write_state" (func $_ZN14concordium_std5prims11write_state17hff5e20a7d67244c0E (type 2)))
  (import "concordium" "resize_state" (func $_ZN14concordium_std5prims12resize_state17hd8a626f2a1133055E (type 7)))
  (import "concordium" "get_parameter_section" (func $_ZN14concordium_std5prims21get_parameter_section17h04d7053659128aabE (type 2)))
  (func $_ZN27concordium_contracts_common5impls127_$LT$impl$u20$concordium_contracts_common..traits..Deserial$u20$for$u20$concordium_contracts_common..types..ContractAddress$GT$8deserial17h8243c7b389139bf6E (type 1) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.load offset=8
    local.set 3
    local.get 1
    i32.load offset=4
    local.set 4
    local.get 1
    i32.load
    local.set 5
    i32.const 0
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                loop  ;; label = @7
                  local.get 4
                  local.get 3
                  i32.sub
                  local.tee 7
                  i32.const 8
                  local.get 6
                  i32.sub
                  local.tee 8
                  local.get 7
                  local.get 8
                  i32.lt_u
                  select
                  local.tee 7
                  i32.eqz
                  br_if 1 (;@6;)
                  local.get 7
                  local.get 3
                  i32.add
                  local.tee 8
                  local.get 7
                  i32.lt_u
                  br_if 3 (;@4;)
                  local.get 8
                  local.get 4
                  i32.gt_u
                  br_if 4 (;@3;)
                  local.get 2
                  i32.const 8
                  i32.add
                  local.get 6
                  i32.add
                  local.get 5
                  local.get 3
                  i32.add
                  local.get 7
                  call $memcpy
                  drop
                  local.get 1
                  local.get 8
                  i32.store offset=8
                  local.get 8
                  local.set 3
                  local.get 7
                  local.get 6
                  i32.add
                  local.tee 6
                  i32.const 8
                  i32.lt_u
                  br_if 0 (;@7;)
                end
                local.get 6
                i32.const 8
                i32.ne
                br_if 0 (;@6;)
                local.get 2
                i64.load offset=8
                local.set 9
                i32.const 0
                local.set 6
                loop  ;; label = @7
                  local.get 4
                  local.get 8
                  i32.sub
                  local.tee 7
                  i32.const 8
                  local.get 6
                  i32.sub
                  local.tee 3
                  local.get 7
                  local.get 3
                  i32.lt_u
                  select
                  local.tee 7
                  i32.eqz
                  br_if 1 (;@6;)
                  local.get 7
                  local.get 8
                  i32.add
                  local.tee 3
                  local.get 7
                  i32.lt_u
                  br_if 5 (;@2;)
                  local.get 3
                  local.get 4
                  i32.gt_u
                  br_if 6 (;@1;)
                  local.get 2
                  i32.const 8
                  i32.add
                  local.get 6
                  i32.add
                  local.get 5
                  local.get 8
                  i32.add
                  local.get 7
                  call $memcpy
                  drop
                  local.get 1
                  local.get 3
                  i32.store offset=8
                  local.get 3
                  local.set 8
                  local.get 7
                  local.get 6
                  i32.add
                  local.tee 6
                  i32.const 8
                  i32.lt_u
                  br_if 0 (;@7;)
                end
                local.get 6
                i32.const 8
                i32.ne
                br_if 0 (;@6;)
                local.get 0
                i32.const 16
                i32.add
                local.get 2
                i64.load offset=8
                i64.store
                local.get 0
                local.get 9
                i64.store offset=8
                i64.const 0
                local.set 9
                br 1 (;@5;)
              end
              i64.const 1
              local.set 9
            end
            local.get 0
            local.get 9
            i64.store
            local.get 2
            i32.const 16
            i32.add
            global.set $__stack_pointer
            return
          end
          local.get 3
          local.get 8
          i32.const 1048664
          call $_ZN4core5slice5index22slice_index_order_fail17hfe0b37c521ea69d8E
          unreachable
        end
        local.get 8
        local.get 4
        i32.const 1048664
        call $_ZN4core5slice5index24slice_end_index_len_fail17ha8b9a9b3afaec0e8E
        unreachable
      end
      local.get 8
      local.get 3
      i32.const 1048664
      call $_ZN4core5slice5index22slice_index_order_fail17hfe0b37c521ea69d8E
      unreachable
    end
    local.get 3
    local.get 4
    i32.const 1048664
    call $_ZN4core5slice5index24slice_end_index_len_fail17ha8b9a9b3afaec0e8E
    unreachable)
  (func $_ZN7counter15convert_actions17he329687970b0c6f3E (type 1) (param i32 i32)
    (local i32 i64 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        br_if 0 (;@2;)
        call $_ZN14concordium_std5prims6accept17hf93576e394a80c25E
        local.set 1
        local.get 0
        i64.const 5
        i64.store
        local.get 0
        local.get 1
        i32.store offset=8
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.load offset=8
          br_if 0 (;@3;)
          local.get 1
          i32.const 24
          i32.add
          i32.load8_u
          i32.const 1
          i32.and
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 0
        i64.const 3
        i64.store
        br 1 (;@1;)
      end
      local.get 1
      i32.const 16
      i32.add
      i64.load
      local.set 3
      local.get 1
      i32.load offset=4
      local.set 4
      local.get 2
      i32.const 24
      i32.add
      local.get 1
      i32.const 49
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 16
      i32.add
      local.get 1
      i32.const 41
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 8
      i32.add
      local.get 1
      i32.const 33
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      local.get 1
      i64.load offset=25 align=1
      i64.store
      block  ;; label = @2
        local.get 3
        i64.const 0
        i64.lt_s
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        call $_ZN14concordium_std5prims15simple_transfer17hd5ce3c90f71e48c5E
        local.set 1
        local.get 2
        local.get 4
        call $_ZN7counter15convert_actions17he329687970b0c6f3E
        block  ;; label = @3
          local.get 2
          i64.load
          local.tee 3
          i64.const 5
          i64.ne
          br_if 0 (;@3;)
          local.get 1
          local.get 2
          i32.load offset=8
          call $_ZN14concordium_std5prims11combine_and17h662153db78184c59E
          local.set 1
          local.get 0
          i64.const 5
          i64.store
          local.get 0
          local.get 1
          i32.store offset=8
          br 2 (;@1;)
        end
        local.get 0
        local.get 2
        i64.load offset=8
        i64.store offset=8
        local.get 0
        local.get 3
        i64.store
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i64.store offset=8
      local.get 0
      i64.const 3
      i64.store
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN61_$LT$counter..State$u20$as$u20$concert_std..ConCertSerial$GT$14concert_serial17h6502a6c193a6eee5E (type 0) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i64.load offset=40
    i64.store offset=56
    i32.const 0
    local.set 3
    block  ;; label = @1
      loop  ;; label = @2
        local.get 2
        i32.const 48
        i32.add
        local.get 1
        local.get 2
        i32.const 56
        i32.add
        local.get 3
        i32.add
        i32.const 8
        local.get 3
        i32.sub
        call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
        local.get 2
        i32.load offset=48
        i32.const 0
        i32.ne
        local.get 2
        i32.load offset=52
        local.tee 4
        i32.eqz
        i32.or
        local.tee 5
        br_if 1 (;@1;)
        local.get 4
        local.get 3
        i32.add
        local.tee 3
        i32.const 8
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    i32.const 1
    local.set 6
    block  ;; label = @1
      local.get 5
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store8 offset=56
            i32.const 1
            local.set 6
            local.get 2
            i32.const 16
            i32.add
            local.get 1
            local.get 2
            i32.const 56
            i32.add
            i32.const 1
            call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
            local.get 2
            i32.load offset=16
            br_if 3 (;@1;)
            local.get 2
            i32.load offset=20
            i32.eqz
            br_if 3 (;@1;)
            i32.const 1
            local.set 6
            local.get 0
            i32.const 1
            i32.add
            local.set 5
            i32.const 0
            local.set 3
            br 1 (;@3;)
          end
          i32.const 1
          local.set 6
          local.get 2
          i32.const 1
          i32.store8 offset=56
          local.get 2
          i32.const 40
          i32.add
          local.get 1
          local.get 2
          i32.const 56
          i32.add
          i32.const 1
          call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
          local.get 2
          i32.load offset=40
          br_if 2 (;@1;)
          local.get 2
          i32.load offset=44
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          i32.const 16
          i32.add
          i64.load
          local.set 7
          local.get 2
          local.get 0
          i64.load offset=8
          i64.store offset=56
          i32.const 0
          local.set 3
          block  ;; label = @4
            loop  ;; label = @5
              local.get 2
              i32.const 32
              i32.add
              local.get 1
              local.get 2
              i32.const 56
              i32.add
              local.get 3
              i32.add
              i32.const 8
              local.get 3
              i32.sub
              call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
              local.get 2
              i32.load offset=32
              i32.const 0
              i32.ne
              local.get 2
              i32.load offset=36
              local.tee 4
              i32.eqz
              i32.or
              local.tee 5
              br_if 1 (;@4;)
              local.get 4
              local.get 3
              i32.add
              local.tee 3
              i32.const 8
              i32.lt_u
              br_if 0 (;@5;)
            end
          end
          local.get 5
          br_if 2 (;@1;)
          local.get 2
          local.get 7
          i64.store offset=56
          i32.const 0
          local.set 3
          block  ;; label = @4
            loop  ;; label = @5
              local.get 2
              i32.const 24
              i32.add
              local.get 1
              local.get 2
              i32.const 56
              i32.add
              local.get 3
              i32.add
              i32.const 8
              local.get 3
              i32.sub
              call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
              local.get 2
              i32.load offset=24
              i32.const 0
              i32.ne
              local.get 2
              i32.load offset=28
              local.tee 4
              i32.eqz
              i32.or
              local.tee 5
              i32.const 1
              i32.and
              br_if 1 (;@4;)
              local.get 4
              local.get 3
              i32.add
              local.tee 3
              i32.const 8
              i32.lt_u
              br_if 0 (;@5;)
            end
          end
          i32.const 1
          local.set 6
          local.get 5
          i32.const 1
          i32.and
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        loop  ;; label = @3
          local.get 2
          i32.const 8
          i32.add
          local.get 1
          local.get 5
          local.get 3
          i32.add
          i32.const 32
          local.get 3
          i32.sub
          call $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E
          local.get 2
          i32.load offset=8
          br_if 2 (;@1;)
          local.get 2
          i32.load offset=12
          local.tee 4
          i32.eqz
          br_if 2 (;@1;)
          local.get 4
          local.get 3
          i32.add
          local.tee 3
          i32.const 31
          i32.le_u
          br_if 0 (;@3;)
        end
      end
      i32.const 0
      local.set 6
    end
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $init_counter (type 8) (param i64) (result i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const 0
    local.set 2
    local.get 1
    i32.const 0
    i32.store offset=12
    local.get 1
    i32.const 16
    i32.add
    call $_ZN56_$LT$bumpalo..Bump$u20$as$u20$core..default..Default$GT$7default17h17f51c298eee1805E
    local.get 1
    i32.const 0
    i32.store offset=28
    block  ;; label = @1
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          local.get 1
          i32.const 28
          i32.add
          local.get 1
          i32.const 32
          i32.add
          local.get 2
          i32.add
          i32.const 8
          local.get 2
          i32.sub
          call $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E
          local.get 1
          i32.load
          br_if 1 (;@2;)
          local.get 1
          i32.load offset=4
          local.tee 3
          i32.eqz
          br_if 1 (;@2;)
          local.get 3
          local.get 2
          i32.add
          local.tee 2
          i32.const 7
          i32.le_u
          br_if 0 (;@3;)
        end
        local.get 2
        i32.const 8
        i32.ne
        br_if 0 (;@2;)
        local.get 1
        i64.load offset=32
        local.set 4
        call $_ZN14concordium_std5prims13get_slot_time17h28cff685067e82a8E
        drop
        local.get 1
        i32.const 32
        i32.add
        call $_ZN14concordium_std5prims15get_init_origin17he2e25a3b7939f5e0E
        local.get 1
        i32.const 32
        i32.add
        call $_ZN14concordium_std5prims15get_init_origin17he2e25a3b7939f5e0E
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.load offset=24
            local.tee 3
            i32.load offset=16
            local.tee 2
            i32.const 48
            i32.lt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const -48
            i32.add
            i32.const -8
            i32.and
            local.tee 2
            local.get 3
            i32.load
            i32.lt_u
            br_if 0 (;@4;)
            local.get 3
            local.get 2
            i32.store offset=16
            br 1 (;@3;)
          end
          local.get 1
          i32.const 16
          i32.add
          i32.const 8
          i32.const 48
          call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
          local.tee 2
          br_if 0 (;@3;)
          call $_ZN7bumpalo3oom17hb45e5b394b07a879E
          unreachable
        end
        local.get 2
        i32.const 0
        i32.store8
        local.get 2
        local.get 4
        i64.store offset=40
        local.get 2
        local.get 1
        i64.load offset=32 align=1
        i64.store offset=1 align=1
        local.get 2
        i32.const 9
        i32.add
        local.get 1
        i32.const 40
        i32.add
        i64.load align=1
        i64.store align=1
        local.get 2
        i32.const 17
        i32.add
        local.get 1
        i32.const 48
        i32.add
        i64.load align=1
        i64.store align=1
        local.get 2
        i32.const 25
        i32.add
        local.get 1
        i32.const 56
        i32.add
        i64.load align=1
        i64.store align=1
        i32.const -42000002
        i32.const 0
        local.get 2
        local.get 1
        i32.const 12
        i32.add
        call $_ZN61_$LT$counter..State$u20$as$u20$concert_std..ConCertSerial$GT$14concert_serial17h6502a6c193a6eee5E
        select
        local.set 2
        local.get 1
        i32.const 16
        i32.add
        call $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E
        br 1 (;@1;)
      end
      local.get 1
      i32.const 16
      i32.add
      call $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E
      i32.const -42000001
      local.set 2
    end
    local.get 1
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $counter.counter_receive (type 8) (param i64) (result i32)
    (local i32 i32 i32 i32 i64 i64 i32 i64)
    global.get $__stack_pointer
    i32.const 256
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    i32.const 0
    i32.store offset=96
    local.get 1
    i32.const 100
    i32.add
    call $_ZN56_$LT$bumpalo..Bump$u20$as$u20$core..default..Default$GT$7default17h17f51c298eee1805E
    local.get 1
    i32.const 0
    i32.store offset=112
    local.get 1
    i32.const 88
    i32.add
    local.get 1
    i32.const 112
    i32.add
    local.get 1
    i32.const 152
    i32.add
    i32.const 1
    call $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.load offset=88
              br_if 0 (;@5;)
              local.get 1
              i32.load offset=92
              i32.const 1
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              local.set 2
              i32.const 0
              local.set 3
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 1
                      i32.load8_u offset=152
                      br_table 1 (;@8;) 0 (;@9;) 4 (;@5;)
                    end
                    local.get 1
                    i32.const 80
                    i32.add
                    local.get 1
                    i32.const 112
                    i32.add
                    local.get 1
                    i32.const 152
                    i32.add
                    i32.const 1
                    call $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E
                    local.get 1
                    i32.load offset=80
                    br_if 3 (;@5;)
                    local.get 1
                    i32.load offset=84
                    i32.const 1
                    i32.ne
                    br_if 3 (;@5;)
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          i32.load8_u offset=152
                          br_table 0 (;@11;) 1 (;@10;) 6 (;@5;)
                        end
                        i32.const 0
                        local.set 4
                        loop  ;; label = @11
                          local.get 1
                          i32.const 64
                          i32.add
                          local.get 1
                          i32.const 112
                          i32.add
                          local.get 1
                          i32.const 152
                          i32.add
                          local.get 4
                          i32.add
                          i32.const 8
                          local.get 4
                          i32.sub
                          call $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E
                          local.get 1
                          i32.load offset=64
                          br_if 6 (;@5;)
                          local.get 1
                          i32.load offset=68
                          local.tee 3
                          i32.eqz
                          br_if 6 (;@5;)
                          local.get 3
                          local.get 4
                          i32.add
                          local.tee 4
                          i32.const 7
                          i32.le_u
                          br_if 0 (;@11;)
                        end
                        local.get 4
                        i32.const 8
                        i32.ne
                        br_if 5 (;@5;)
                        local.get 1
                        i64.load offset=152
                        local.set 5
                        i64.const 0
                        local.set 6
                        br 1 (;@9;)
                      end
                      i32.const 0
                      local.set 4
                      loop  ;; label = @10
                        local.get 1
                        i32.const 72
                        i32.add
                        local.get 1
                        i32.const 112
                        i32.add
                        local.get 1
                        i32.const 152
                        i32.add
                        local.get 4
                        i32.add
                        i32.const 8
                        local.get 4
                        i32.sub
                        call $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E
                        local.get 1
                        i32.load offset=72
                        br_if 5 (;@5;)
                        local.get 1
                        i32.load offset=76
                        local.tee 3
                        i32.eqz
                        br_if 5 (;@5;)
                        local.get 3
                        local.get 4
                        i32.add
                        local.tee 4
                        i32.const 7
                        i32.le_u
                        br_if 0 (;@10;)
                      end
                      local.get 4
                      i32.const 8
                      i32.ne
                      br_if 4 (;@5;)
                      local.get 1
                      i64.load offset=152
                      local.set 5
                      i64.const 1
                      local.set 6
                    end
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 1
                        i32.load offset=108
                        local.tee 4
                        i32.load offset=16
                        local.tee 3
                        i32.const 16
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 3
                        i32.const -16
                        i32.add
                        i32.const -8
                        i32.and
                        local.tee 3
                        local.get 4
                        i32.load
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 4
                        local.get 3
                        i32.store offset=16
                        br 1 (;@9;)
                      end
                      local.get 1
                      i32.const 100
                      i32.add
                      i32.const 8
                      i32.const 16
                      call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
                      local.tee 3
                      i32.eqz
                      br_if 2 (;@7;)
                    end
                    local.get 3
                    local.get 5
                    i64.store offset=8
                    local.get 3
                    local.get 6
                    i64.store
                  end
                  loop  ;; label = @8
                    local.get 1
                    i32.const 56
                    i32.add
                    local.get 1
                    i32.const 96
                    i32.add
                    local.get 1
                    i32.const 152
                    i32.add
                    local.get 2
                    i32.add
                    i32.const 8
                    local.get 2
                    i32.sub
                    call $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$4read17hf4787e124f102dc4E
                    local.get 1
                    i32.load offset=56
                    br_if 2 (;@6;)
                    local.get 1
                    i32.load offset=60
                    local.tee 4
                    i32.eqz
                    br_if 2 (;@6;)
                    local.get 4
                    local.get 2
                    i32.add
                    local.tee 2
                    i32.const 7
                    i32.le_u
                    br_if 0 (;@8;)
                  end
                  local.get 2
                  i32.const 8
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 1
                  i64.load offset=152
                  local.set 5
                  local.get 1
                  i32.const 48
                  i32.add
                  local.get 1
                  i32.const 96
                  i32.add
                  call $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$7read_u817h65c6077a42f90c89E
                  local.get 1
                  i32.load8_u offset=48
                  br_if 1 (;@6;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          i32.load8_u offset=49
                          local.tee 7
                          i32.const 255
                          i32.and
                          br_table 0 (;@11;) 1 (;@10;) 5 (;@6;)
                        end
                        i32.const 0
                        local.set 2
                        loop  ;; label = @11
                          local.get 1
                          i32.const 8
                          i32.add
                          local.get 1
                          i32.const 96
                          i32.add
                          local.get 1
                          i32.const 152
                          i32.add
                          local.get 2
                          i32.add
                          i32.const 32
                          local.get 2
                          i32.sub
                          call $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$4read17hf4787e124f102dc4E
                          local.get 1
                          i32.load offset=8
                          br_if 5 (;@6;)
                          local.get 1
                          i32.load offset=12
                          local.tee 4
                          i32.eqz
                          br_if 5 (;@6;)
                          local.get 4
                          local.get 2
                          i32.add
                          local.tee 2
                          i32.const 31
                          i32.gt_u
                          br_if 2 (;@9;)
                          br 0 (;@11;)
                        end
                      end
                      local.get 1
                      i32.const 32
                      i32.add
                      local.get 1
                      i32.const 96
                      i32.add
                      call $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$8read_u6417h99b5f1058f6c6c58E
                      local.get 1
                      i32.load offset=32
                      br_if 3 (;@6;)
                      local.get 1
                      i64.load offset=40
                      local.set 6
                      local.get 1
                      i32.const 16
                      i32.add
                      local.get 1
                      i32.const 96
                      i32.add
                      call $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$8read_u6417h99b5f1058f6c6c58E
                      local.get 1
                      i64.load offset=16
                      i32.wrap_i64
                      br_if 3 (;@6;)
                      local.get 1
                      i64.load offset=24
                      local.set 8
                      br 1 (;@8;)
                    end
                    local.get 2
                    i32.const 32
                    i32.ne
                    br_if 2 (;@6;)
                    local.get 1
                    i32.const 120
                    i32.add
                    local.get 1
                    i32.const 183
                    i32.add
                    i32.load8_u
                    i32.store8
                    local.get 1
                    local.get 1
                    i32.load offset=152 align=1
                    i32.store offset=208
                    local.get 1
                    local.get 1
                    i64.load offset=175 align=1
                    i64.store offset=112
                    local.get 1
                    local.get 1
                    i32.const 155
                    i32.add
                    i32.load align=1
                    i32.store offset=211 align=1
                    local.get 1
                    i64.load offset=159 align=1
                    local.set 6
                    local.get 1
                    i64.load offset=167 align=1
                    local.set 8
                  end
                  local.get 1
                  local.get 1
                  i32.load offset=211 align=1
                  i32.store offset=227 align=1
                  local.get 1
                  local.get 1
                  i32.load offset=208
                  i32.store offset=224
                  local.get 1
                  i32.const 152
                  i32.add
                  i32.const 8
                  i32.add
                  local.get 1
                  i32.const 112
                  i32.add
                  i32.const 8
                  i32.add
                  i64.load
                  i64.store
                  local.get 1
                  local.get 1
                  i64.load offset=112
                  i64.store offset=152
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 1
                      i32.load offset=108
                      local.tee 4
                      i32.load offset=16
                      local.tee 2
                      i32.const 48
                      i32.lt_u
                      br_if 0 (;@9;)
                      local.get 2
                      i32.const -48
                      i32.add
                      i32.const -8
                      i32.and
                      local.tee 2
                      local.get 4
                      i32.load
                      i32.lt_u
                      br_if 0 (;@9;)
                      local.get 4
                      local.get 2
                      i32.store offset=16
                      br 1 (;@8;)
                    end
                    local.get 1
                    i32.const 100
                    i32.add
                    i32.const 8
                    i32.const 48
                    call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
                    local.tee 2
                    i32.eqz
                    br_if 1 (;@7;)
                  end
                  local.get 2
                  local.get 7
                  i32.store8
                  local.get 2
                  local.get 1
                  i32.load offset=224
                  i32.store offset=1 align=1
                  local.get 2
                  local.get 8
                  i64.store offset=16
                  local.get 2
                  local.get 6
                  i64.store offset=8
                  local.get 2
                  local.get 1
                  i64.load offset=152
                  i64.store offset=24
                  local.get 2
                  local.get 5
                  i64.store offset=40
                  local.get 2
                  i32.const 4
                  i32.add
                  local.get 1
                  i32.load offset=227 align=1
                  i32.store align=1
                  local.get 2
                  i32.const 32
                  i32.add
                  local.get 1
                  i32.const 160
                  i32.add
                  i64.load
                  i64.store
                  call $_ZN14concordium_std5prims13get_slot_time17h28cff685067e82a8E
                  drop
                  local.get 1
                  i32.const 152
                  i32.add
                  call $_ZN14concordium_std5prims18get_receive_sender17h51fcbe17bbd09fafE
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 1
                        i32.load8_u offset=152
                        br_table 1 (;@9;) 0 (;@10;) 8 (;@2;)
                      end
                      local.get 1
                      local.get 1
                      i32.const 152
                      i32.add
                      i32.const 1
                      i32.add
                      i32.store offset=112
                      local.get 1
                      i64.const 16
                      i64.store offset=116 align=4
                      local.get 1
                      i32.const 224
                      i32.add
                      local.get 1
                      i32.const 112
                      i32.add
                      call $_ZN27concordium_contracts_common5impls127_$LT$impl$u20$concordium_contracts_common..traits..Deserial$u20$for$u20$concordium_contracts_common..types..ContractAddress$GT$8deserial17h8243c7b389139bf6E
                      local.get 1
                      i64.load offset=224
                      i64.eqz
                      i32.eqz
                      br_if 7 (;@2;)
                      local.get 1
                      i32.const 112
                      i32.add
                      i32.const 16
                      i32.add
                      local.get 1
                      i32.const 224
                      i32.add
                      i32.const 16
                      i32.add
                      i64.load
                      i64.store
                      local.get 1
                      local.get 1
                      i64.load offset=232
                      i64.store offset=120
                      local.get 1
                      i32.const 1
                      i32.store8 offset=112
                      br 1 (;@8;)
                    end
                    local.get 1
                    i32.const 112
                    i32.add
                    i32.const 25
                    i32.add
                    local.get 1
                    i32.const 152
                    i32.add
                    i32.const 25
                    i32.add
                    i64.load align=1
                    i64.store align=1
                    local.get 1
                    i32.const 112
                    i32.add
                    i32.const 17
                    i32.add
                    local.get 1
                    i32.const 152
                    i32.add
                    i32.const 17
                    i32.add
                    i64.load align=1
                    i64.store align=1
                    local.get 1
                    i32.const 112
                    i32.add
                    i32.const 9
                    i32.add
                    local.get 1
                    i32.const 152
                    i32.add
                    i32.const 9
                    i32.add
                    i64.load align=1
                    i64.store align=1
                    local.get 1
                    local.get 1
                    i64.load offset=153 align=1
                    i64.store offset=113 align=1
                    local.get 1
                    i32.const 0
                    i32.store8 offset=112
                  end
                  local.get 1
                  i32.const 192
                  i32.add
                  call $_ZN14concordium_std5prims24get_receive_self_address17h9cab23bc56e094a5E
                  local.get 1
                  local.get 1
                  i64.load offset=200
                  i64.store offset=216
                  local.get 1
                  local.get 1
                  i64.load offset=192
                  i64.store offset=208
                  local.get 1
                  i64.const 16
                  i64.store offset=156 align=4
                  local.get 1
                  local.get 1
                  i32.const 208
                  i32.add
                  i32.store offset=152
                  local.get 1
                  i32.const 224
                  i32.add
                  local.get 1
                  i32.const 152
                  i32.add
                  call $_ZN27concordium_contracts_common5impls127_$LT$impl$u20$concordium_contracts_common..traits..Deserial$u20$for$u20$concordium_contracts_common..types..ContractAddress$GT$8deserial17h8243c7b389139bf6E
                  local.get 1
                  i64.load offset=224
                  i64.eqz
                  i32.eqz
                  br_if 5 (;@2;)
                  local.get 1
                  i32.const 152
                  i32.add
                  i32.const 16
                  i32.add
                  local.get 1
                  i32.const 224
                  i32.add
                  i32.const 16
                  i32.add
                  i64.load
                  i64.store
                  local.get 1
                  local.get 1
                  i64.load offset=232
                  i64.store offset=160
                  local.get 1
                  i32.const 1
                  i32.store8 offset=152
                  local.get 1
                  i32.const 112
                  i32.add
                  local.get 1
                  i32.const 152
                  i32.add
                  call $_ZN84_$LT$concordium_contracts_common..types..Address$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0765f6e3319438fcE
                  drop
                  call $_ZN14concordium_std5prims24get_receive_self_balance17h511dec6c6f0e077fE
                  drop
                  local.get 1
                  i32.const 152
                  i32.add
                  call $_ZN14concordium_std5prims19get_receive_invoker17hdb8ac4c5feeebbc6E
                  local.get 1
                  i32.const 152
                  i32.add
                  call $_ZN14concordium_std5prims18get_receive_sender17h51fcbe17bbd09fafE
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 1
                      i32.load8_u offset=152
                      br_table 1 (;@8;) 0 (;@9;) 7 (;@2;)
                    end
                    local.get 1
                    local.get 1
                    i32.const 152
                    i32.add
                    i32.const 1
                    i32.add
                    i32.store offset=224
                    local.get 1
                    i64.const 16
                    i64.store offset=228 align=4
                    local.get 1
                    i32.const 112
                    i32.add
                    local.get 1
                    i32.const 224
                    i32.add
                    call $_ZN27concordium_contracts_common5impls127_$LT$impl$u20$concordium_contracts_common..traits..Deserial$u20$for$u20$concordium_contracts_common..types..ContractAddress$GT$8deserial17h8243c7b389139bf6E
                    local.get 1
                    i64.load offset=112
                    i64.const 0
                    i64.ne
                    br_if 6 (;@2;)
                  end
                  local.get 1
                  i32.const 224
                  i32.add
                  call $_ZN14concordium_std5prims24get_receive_self_address17h9cab23bc56e094a5E
                  local.get 1
                  local.get 1
                  i64.load offset=232
                  i64.store offset=120
                  local.get 1
                  local.get 1
                  i64.load offset=224
                  i64.store offset=112
                  local.get 1
                  i64.const 16
                  i64.store offset=212 align=4
                  local.get 1
                  local.get 1
                  i32.const 112
                  i32.add
                  i32.store offset=208
                  local.get 1
                  i32.const 152
                  i32.add
                  local.get 1
                  i32.const 208
                  i32.add
                  call $_ZN27concordium_contracts_common5impls127_$LT$impl$u20$concordium_contracts_common..traits..Deserial$u20$for$u20$concordium_contracts_common..types..ContractAddress$GT$8deserial17h8243c7b389139bf6E
                  local.get 1
                  i64.load offset=152
                  i64.eqz
                  i32.eqz
                  br_if 5 (;@2;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 3
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 3
                              i32.const 8
                              i32.add
                              i64.load
                              local.set 5
                              block  ;; label = @14
                                local.get 3
                                i64.load
                                i64.const 0
                                i64.ne
                                br_if 0 (;@14;)
                                local.get 5
                                i64.const 0
                                i64.le_s
                                br_if 1 (;@13;)
                                local.get 5
                                i64.const 0
                                i64.lt_s
                                local.get 2
                                i64.load offset=40
                                local.tee 6
                                local.get 5
                                i64.add
                                local.tee 5
                                local.get 6
                                i64.lt_s
                                i32.ne
                                br_if 2 (;@12;)
                                block  ;; label = @15
                                  local.get 1
                                  i32.load offset=108
                                  local.tee 3
                                  i32.load offset=16
                                  local.tee 4
                                  i32.const 48
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 4
                                  i32.const -48
                                  i32.add
                                  i32.const -8
                                  i32.and
                                  local.tee 4
                                  local.get 3
                                  i32.load
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 3
                                  local.get 4
                                  i32.store offset=16
                                  br 5 (;@10;)
                                end
                                local.get 1
                                i32.const 100
                                i32.add
                                i32.const 8
                                i32.const 48
                                call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
                                local.tee 4
                                br_if 4 (;@10;)
                                br 7 (;@7;)
                              end
                              local.get 5
                              i64.const 0
                              i64.gt_s
                              br_if 2 (;@11;)
                            end
                            local.get 1
                            i64.const 1
                            i64.store offset=160
                            i64.const 4
                            local.set 5
                            br 3 (;@9;)
                          end
                          i32.const 1048692
                          call $_ZN4core6option13unwrap_failed17h0e0b231623e0d004E
                          unreachable
                        end
                        local.get 5
                        i64.const 0
                        i64.gt_s
                        local.get 2
                        i64.load offset=40
                        local.tee 6
                        local.get 5
                        i64.sub
                        local.tee 5
                        local.get 6
                        i64.lt_s
                        i32.ne
                        br_if 2 (;@8;)
                        block  ;; label = @11
                          local.get 1
                          i32.load offset=108
                          local.tee 3
                          i32.load offset=16
                          local.tee 4
                          i32.const 48
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 4
                          i32.const -48
                          i32.add
                          i32.const -8
                          i32.and
                          local.tee 4
                          local.get 3
                          i32.load
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 3
                          local.get 4
                          i32.store offset=16
                          br 1 (;@10;)
                        end
                        local.get 1
                        i32.const 100
                        i32.add
                        i32.const 8
                        i32.const 48
                        call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
                        local.tee 4
                        i32.eqz
                        br_if 3 (;@7;)
                      end
                      local.get 4
                      local.get 2
                      i64.load
                      i64.store
                      local.get 4
                      i32.const 32
                      i32.add
                      local.get 2
                      i32.const 32
                      i32.add
                      i64.load
                      i64.store
                      local.get 4
                      i32.const 24
                      i32.add
                      local.get 2
                      i32.const 24
                      i32.add
                      i64.load
                      i64.store
                      local.get 4
                      i32.const 16
                      i32.add
                      local.get 2
                      i32.const 16
                      i32.add
                      i64.load
                      i64.store
                      local.get 4
                      i32.const 8
                      i32.add
                      local.get 2
                      i32.const 8
                      i32.add
                      i64.load
                      i64.store
                      local.get 4
                      local.get 5
                      i64.store offset=40
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          i32.load offset=108
                          local.tee 3
                          i32.load offset=16
                          local.tee 2
                          i32.const 64
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 2
                          i32.const -64
                          i32.add
                          i32.const -8
                          i32.and
                          local.tee 2
                          local.get 3
                          i32.load
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 3
                          local.get 2
                          i32.store offset=16
                          br 1 (;@10;)
                        end
                        local.get 1
                        i32.const 100
                        i32.add
                        i32.const 8
                        i32.const 64
                        call $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E
                        local.tee 2
                        i32.eqz
                        br_if 3 (;@7;)
                      end
                      local.get 2
                      i32.const 0
                      i32.store
                      local.get 1
                      i32.const 96
                      i32.add
                      i32.const 0
                      call $_ZN14concordium_std5impls107_$LT$impl$u20$concordium_std..traits..HasContractState$u20$for$u20$concordium_std..types..ContractState$GT$8truncate17h9750936bf87e13a9E
                      i64.const 2
                      local.set 5
                      local.get 4
                      local.get 1
                      i32.const 96
                      i32.add
                      call $_ZN61_$LT$counter..State$u20$as$u20$concert_std..ConCertSerial$GT$14concert_serial17h6502a6c193a6eee5E
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const 152
                      i32.add
                      local.get 2
                      call $_ZN7counter15convert_actions17he329687970b0c6f3E
                      local.get 1
                      i64.load offset=152
                      local.set 5
                      local.get 1
                      i32.const 100
                      i32.add
                      call $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E
                      local.get 5
                      i64.const 5
                      i64.ne
                      br_if 6 (;@3;)
                      local.get 1
                      i32.load offset=160
                      local.set 2
                      br 8 (;@1;)
                    end
                    local.get 1
                    i32.const 100
                    i32.add
                    call $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E
                    br 5 (;@3;)
                  end
                  i32.const 1048708
                  call $_ZN4core6option13unwrap_failed17h0e0b231623e0d004E
                  unreachable
                end
                call $_ZN7bumpalo3oom17hb45e5b394b07a879E
                unreachable
              end
              i64.const 1
              local.set 5
              br 1 (;@4;)
            end
            i64.const 0
            local.set 5
          end
          local.get 1
          i32.const 100
          i32.add
          call $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E
        end
        i32.const -42000001
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 5
                i32.wrap_i64
                br_table 5 (;@1;) 0 (;@6;) 1 (;@5;) 2 (;@4;) 3 (;@3;) 5 (;@1;)
              end
              i32.const -42000002
              local.set 2
              br 4 (;@1;)
            end
            i32.const -42000003
            local.set 2
            br 3 (;@1;)
          end
          i32.const -42000004
          local.set 2
          br 2 (;@1;)
        end
        i32.const -2147483648
        local.set 2
        local.get 1
        i64.load offset=160
        local.tee 5
        i64.const 2147483647
        i64.gt_u
        br_if 1 (;@1;)
        local.get 5
        i64.const 4294967295
        i64.and
        i64.const 0
        i64.eq
        br_if 1 (;@1;)
      end
      call $_ZN3std7process5abort17hbc03b63e6e7f1c48E
      unreachable
    end
    local.get 1
    i32.const 256
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $__rust_alloc_error_handler (type 1) (param i32 i32)
    local.get 0
    local.get 1
    call $__rg_oom
    return)
  (func $_ZN4core3ops8function6FnOnce9call_once17h982520ca6acd3ab6E (type 9)
    call $_ZN7bumpalo24allocation_size_overflow17hb00d813073c427daE
    unreachable)
  (func $_ZN7bumpalo24allocation_size_overflow17hb00d813073c427daE (type 9)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=4
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1048760
    i32.store offset=8
    local.get 0
    i32.const 1048724
    i32.store offset=16
    local.get 0
    i32.const 8
    i32.add
    i32.const 1048864
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN56_$LT$bumpalo..Bump$u20$as$u20$core..default..Default$GT$7default17h17f51c298eee1805E (type 6) (param i32)
    local.get 0
    i32.const 1049620
    i32.store offset=8
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN55_$LT$bumpalo..Bump$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc01ff855618ab0f5E (type 6) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.const 1049620
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 0
        i32.load offset=12
        local.set 1
        local.get 0
        i32.load
        local.get 0
        i32.const 8
        i32.add
        i32.load
        local.get 0
        i32.load offset=4
        call $__rust_dealloc
        local.get 1
        local.set 0
        local.get 1
        i32.const 1049620
        i32.ne
        br_if 0 (;@2;)
      end
    end)
  (func $_ZN7bumpalo3oom17hb45e5b394b07a879E (type 9)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=4
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1048896
    i32.store offset=8
    local.get 0
    i32.const 1048724
    i32.store offset=16
    local.get 0
    i32.const 8
    i32.add
    i32.const 1048904
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN7bumpalo4Bump17alloc_layout_slow17h78d0928f982f5ec4E (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 3
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=8
        local.set 4
        i32.const 0
        local.set 5
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.tee 6
      local.get 0
      i32.const 8
      i32.add
      i32.load
      local.tee 4
      i32.load offset=20
      local.tee 7
      i32.ge_u
      local.set 5
      local.get 6
      local.get 7
      i32.sub
      local.set 8
    end
    i32.const 0
    local.set 9
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 8
          i32.add
          i32.load
          i32.const -24
          i32.add
          local.tee 6
          i32.const 0
          i32.lt_s
          br_if 0 (;@3;)
          local.get 1
          i32.const 16
          local.get 1
          i32.const 16
          i32.gt_u
          select
          local.tee 10
          local.get 2
          i32.add
          i32.const -1
          i32.add
          local.tee 7
          local.get 2
          i32.lt_u
          br_if 2 (;@1;)
          local.get 6
          i32.const 1
          i32.shl
          local.tee 6
          local.get 2
          i32.const 464
          local.get 2
          i32.const 464
          i32.gt_u
          select
          local.tee 11
          local.get 6
          local.get 11
          i32.gt_u
          select
          local.set 6
          local.get 7
          i32.const 0
          local.get 10
          i32.sub
          i32.and
          local.set 7
          block  ;; label = @4
            local.get 10
            i32.popcnt
            i32.const 1
            i32.eq
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              i32.load offset=4
              local.tee 3
              local.get 2
              i32.le_u
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.const 464
                i32.ge_u
                br_if 0 (;@6;)
                loop  ;; label = @7
                  i32.const 0
                  local.set 9
                  i32.const 0
                  local.set 3
                  block  ;; label = @8
                    local.get 6
                    local.get 2
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 4
                    i32.load offset=20
                    i32.eqz
                    local.set 3
                  end
                  block  ;; label = @8
                    local.get 6
                    local.get 11
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 3
                    i32.eqz
                    br_if 5 (;@3;)
                  end
                  local.get 6
                  local.get 7
                  local.get 6
                  local.get 7
                  i32.gt_u
                  select
                  local.set 3
                  local.get 6
                  i32.const 1
                  i32.shr_u
                  local.set 6
                  local.get 3
                  i32.const 4143
                  i32.add
                  i32.const 4095
                  i32.ge_u
                  br_if 0 (;@7;)
                  br 4 (;@3;)
                end
              end
              loop  ;; label = @6
                i32.const 0
                local.set 9
                local.get 6
                local.get 11
                i32.lt_u
                br_if 3 (;@3;)
                local.get 6
                local.get 7
                local.get 6
                local.get 7
                i32.gt_u
                select
                local.set 3
                local.get 6
                i32.const 1
                i32.shr_u
                local.set 6
                local.get 3
                i32.const 4143
                i32.add
                i32.const 4095
                i32.ge_u
                br_if 0 (;@6;)
                br 3 (;@3;)
              end
            end
            loop  ;; label = @5
              local.get 6
              i32.const 1
              i32.shr_u
              local.set 3
              block  ;; label = @6
                local.get 6
                local.get 7
                local.get 6
                local.get 7
                i32.gt_u
                select
                local.tee 6
                i32.const 4096
                i32.lt_u
                br_if 0 (;@6;)
                i32.const 0
                local.set 9
                local.get 6
                i32.const 4143
                i32.add
                i32.const 4095
                i32.lt_u
                br_if 3 (;@3;)
                local.get 3
                local.set 6
                local.get 3
                local.get 11
                i32.ge_u
                br_if 1 (;@5;)
                br 3 (;@3;)
              end
              local.get 3
              local.set 6
              local.get 3
              local.get 11
              i32.ge_u
              br_if 0 (;@5;)
            end
            i32.const 0
            return
          end
          i32.const -2147483648
          local.get 10
          i32.sub
          local.set 12
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 5
                i32.eqz
                br_if 0 (;@6;)
                br 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 3
                i32.const 0
                i32.ne
                local.get 0
                i32.load offset=4
                local.tee 8
                local.get 2
                i32.gt_u
                i32.and
                local.set 5
                loop  ;; label = @7
                  i32.const 0
                  local.set 9
                  i32.const 0
                  local.set 3
                  block  ;; label = @8
                    local.get 5
                    local.get 6
                    local.get 2
                    i32.ge_u
                    local.get 8
                    i32.const 464
                    i32.lt_u
                    i32.and
                    i32.and
                    i32.const 1
                    i32.ne
                    br_if 0 (;@8;)
                    local.get 0
                    i32.load offset=8
                    i32.load offset=20
                    i32.eqz
                    local.set 3
                  end
                  block  ;; label = @8
                    local.get 6
                    local.get 11
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 3
                    i32.eqz
                    br_if 5 (;@3;)
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 6
                      local.get 7
                      local.get 6
                      local.get 7
                      i32.gt_u
                      select
                      local.tee 3
                      i32.const 4096
                      i32.lt_u
                      br_if 0 (;@9;)
                      local.get 3
                      i32.const 4143
                      i32.add
                      local.tee 13
                      local.get 3
                      i32.const 48
                      i32.add
                      i32.lt_u
                      br_if 6 (;@3;)
                      local.get 13
                      i32.const -4096
                      i32.and
                      i32.const -48
                      i32.add
                      local.set 3
                      br 1 (;@8;)
                    end
                    i32.const -1
                    local.get 3
                    i32.const 47
                    i32.add
                    i32.clz
                    i32.shr_u
                    i32.const -47
                    i32.add
                    local.set 3
                  end
                  local.get 3
                  i32.const 24
                  i32.add
                  local.tee 9
                  local.get 3
                  i32.lt_u
                  br_if 5 (;@2;)
                  local.get 6
                  i32.const 1
                  i32.shr_u
                  local.set 6
                  local.get 12
                  local.get 9
                  i32.lt_u
                  br_if 0 (;@7;)
                end
                i32.const 0
                i32.load8_u offset=1049645
                drop
                local.get 9
                local.get 10
                call $__rust_alloc
                local.tee 5
                br_if 2 (;@4;)
                local.get 0
                i32.load
                local.set 3
                br 0 (;@6;)
              end
            end
            loop  ;; label = @5
              local.get 3
              i32.const 0
              i32.ne
              local.get 0
              i32.load offset=4
              local.tee 5
              local.get 2
              i32.gt_u
              i32.and
              local.set 13
              loop  ;; label = @6
                i32.const 0
                local.set 9
                i32.const 0
                local.set 3
                block  ;; label = @7
                  local.get 13
                  local.get 6
                  local.get 2
                  i32.ge_u
                  local.get 5
                  i32.const 464
                  i32.lt_u
                  i32.and
                  i32.and
                  i32.const 1
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 0
                  i32.load offset=8
                  i32.load offset=20
                  i32.eqz
                  local.set 3
                end
                block  ;; label = @7
                  local.get 6
                  local.get 11
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 3
                  i32.eqz
                  br_if 4 (;@3;)
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 6
                    local.get 7
                    local.get 6
                    local.get 7
                    i32.gt_u
                    select
                    local.tee 3
                    i32.const 4096
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 3
                    i32.const 4143
                    i32.add
                    local.tee 14
                    local.get 3
                    i32.const 48
                    i32.add
                    i32.lt_u
                    br_if 5 (;@3;)
                    local.get 14
                    i32.const -4096
                    i32.and
                    i32.const -48
                    i32.add
                    local.set 3
                    br 1 (;@7;)
                  end
                  i32.const -1
                  local.get 3
                  i32.const 47
                  i32.add
                  i32.clz
                  i32.shr_u
                  i32.const -47
                  i32.add
                  local.set 3
                end
                local.get 3
                i32.const 24
                i32.add
                local.tee 9
                local.get 3
                i32.lt_u
                br_if 4 (;@2;)
                local.get 6
                i32.const 1
                i32.shr_u
                local.set 6
                local.get 8
                local.get 3
                i32.lt_u
                br_if 0 (;@6;)
                local.get 12
                local.get 9
                i32.lt_u
                br_if 0 (;@6;)
              end
              i32.const 0
              i32.load8_u offset=1049645
              drop
              local.get 9
              local.get 10
              call $__rust_alloc
              local.tee 5
              br_if 1 (;@4;)
              local.get 0
              i32.load
              local.set 3
              br 0 (;@5;)
            end
          end
          local.get 4
          i32.load offset=20
          local.set 7
          local.get 5
          local.get 3
          i32.add
          local.tee 6
          local.get 4
          i32.store offset=12
          local.get 6
          local.get 9
          i32.store offset=8
          local.get 6
          local.get 10
          i32.store offset=4
          local.get 6
          local.get 5
          i32.store
          local.get 0
          local.get 6
          i32.store offset=8
          local.get 6
          local.get 7
          local.get 3
          i32.add
          i32.store offset=20
          local.get 6
          local.get 6
          local.get 2
          i32.sub
          i32.const 0
          local.get 1
          i32.sub
          i32.and
          local.tee 9
          i32.store offset=16
        end
        local.get 9
        return
      end
      call $_ZN7bumpalo24allocation_size_overflow17hb00d813073c427daE
      unreachable
    end
    call $_ZN4core3ops8function6FnOnce9call_once17h982520ca6acd3ab6E
    unreachable)
  (func $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$4read17hf4787e124f102dc4E (type 10) (param i32 i32 i32 i32)
    (local i32)
    local.get 1
    i32.load
    local.set 4
    local.get 1
    local.get 4
    local.get 2
    local.get 3
    local.get 4
    call $_ZN14concordium_std5prims10load_state17hecf53a1e2ababc57E
    local.tee 3
    i32.add
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$8read_u6417h99b5f1058f6c6c58E (type 1) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.load
    local.set 3
    local.get 1
    local.get 3
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    local.get 3
    call $_ZN14concordium_std5prims10load_state17hecf53a1e2ababc57E
    local.tee 4
    i32.add
    i32.store
    local.get 0
    local.get 2
    i64.load offset=8
    i64.store offset=8
    local.get 0
    local.get 4
    i32.const 8
    i32.ne
    i64.extend_i32_u
    i64.store
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN14concordium_std5impls108_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..ContractState$GT$7read_u817h65c6077a42f90c89E (type 1) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.load
    local.set 3
    local.get 1
    local.get 3
    local.get 2
    i32.const 15
    i32.add
    i32.const 1
    local.get 3
    call $_ZN14concordium_std5prims10load_state17hecf53a1e2ababc57E
    local.tee 4
    i32.add
    i32.store
    local.get 0
    local.get 2
    i32.load8_u offset=15
    i32.store8 offset=1
    local.get 0
    local.get 4
    i32.const 1
    i32.ne
    i32.store8
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN14concordium_std5impls109_$LT$impl$u20$concordium_contracts_common..traits..Write$u20$for$u20$concordium_std..types..ContractState$GT$5write17h80e137beed9596d0E (type 10) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        local.tee 4
        local.get 3
        i32.add
        local.get 4
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 4
        br 1 (;@1;)
      end
      local.get 1
      local.get 2
      local.get 3
      local.get 4
      call $_ZN14concordium_std5prims11write_state17hff5e20a7d67244c0E
      local.tee 3
      local.get 4
      i32.add
      i32.store
      i32.const 0
      local.set 4
    end
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    local.get 4
    i32.store)
  (func $_ZN14concordium_std5impls107_$LT$impl$u20$concordium_std..traits..HasContractState$u20$for$u20$concordium_std..types..ContractState$GT$8truncate17h9750936bf87e13a9E (type 1) (param i32 i32)
    block  ;; label = @1
      call $_ZN14concordium_std5prims10state_size17h00763b029122c0f2E
      local.get 1
      i32.le_u
      br_if 0 (;@1;)
      local.get 1
      call $_ZN14concordium_std5prims12resize_state17hd8a626f2a1133055E
      drop
    end
    block  ;; label = @1
      local.get 0
      i32.load
      local.get 1
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store
    end)
  (func $_ZN14concordium_std5impls104_$LT$impl$u20$concordium_contracts_common..traits..Read$u20$for$u20$concordium_std..types..Parameter$GT$4read17hd68f35d702cd6750E (type 10) (param i32 i32 i32 i32)
    (local i32)
    local.get 1
    i32.load
    local.set 4
    local.get 1
    local.get 4
    local.get 2
    local.get 3
    local.get 4
    call $_ZN14concordium_std5prims21get_parameter_section17h04d7053659128aabE
    local.tee 3
    i32.add
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func $__rust_alloc (type 0) (param i32 i32) (result i32)
    i32.const 1049648
    local.get 1
    local.get 0
    call $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17h8be0324704efe0dbE)
  (func $__rust_dealloc (type 11) (param i32 i32 i32)
    i32.const 1049648
    local.get 0
    local.get 2
    local.get 1
    call $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17hc72c09abeddd2ab1E)
  (func $__rust_realloc (type 12) (param i32 i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 1049648
      local.get 2
      local.get 3
      call $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17h8be0324704efe0dbE
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      local.get 0
      local.get 1
      local.get 3
      local.get 1
      local.get 3
      i32.lt_u
      select
      call $memcpy
      drop
      i32.const 1049648
      local.get 0
      local.get 2
      local.get 1
      call $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17hc72c09abeddd2ab1E
    end
    local.get 4)
  (func $_ZN84_$LT$concordium_contracts_common..types..Address$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0765f6e3319438fcE (type 0) (param i32 i32) (result i32)
    (local i32 i32)
    local.get 1
    i32.load8_u
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 3
          local.get 2
          i32.const 255
          i32.and
          br_if 1 (;@2;)
          local.get 0
          i32.const 1
          i32.add
          local.get 1
          i32.const 1
          i32.add
          i32.const 32
          call $memcmp
          i32.eqz
          return
        end
        local.get 2
        i32.const 255
        i32.and
        br_if 1 (;@1;)
        i32.const 0
        local.set 3
      end
      local.get 3
      return
    end
    local.get 0
    i64.load offset=8
    local.get 1
    i64.load offset=8
    i64.eq
    local.get 0
    i32.const 16
    i32.add
    i64.load
    local.get 1
    i32.const 16
    i32.add
    i64.load
    i64.eq
    i32.and)
  (func $_ZN88_$LT$wee_alloc..size_classes..SizeClassAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$22new_cell_for_free_list17hfa99c8db0da3defcE (type 10) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    local.get 1
    i32.load
    local.tee 5
    i32.load
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 2
          i32.add
          local.tee 1
          local.get 1
          i32.mul
          local.tee 1
          i32.const 2048
          local.get 1
          i32.const 2048
          i32.gt_u
          select
          local.tee 2
          i32.const 4
          local.get 4
          i32.const 12
          i32.add
          i32.const 1048920
          i32.const 1
          call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 4
          i32.load offset=12
          i32.store
          local.get 2
          i32.const 2
          i32.shl
          local.set 6
          br 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 2
            i32.shl
            local.tee 6
            i32.const 16416
            local.get 6
            i32.const 16416
            i32.gt_u
            select
            i32.const 65543
            i32.add
            local.tee 7
            i32.const 16
            i32.shr_u
            memory.grow
            local.tee 1
            i32.const -1
            i32.ne
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            i32.load offset=12
            i32.store
            br 1 (;@3;)
          end
          local.get 1
          i32.const 16
          i32.shl
          local.tee 1
          i32.const 0
          i32.store offset=4
          local.get 1
          local.get 4
          i32.load offset=12
          i32.store offset=8
          local.get 1
          local.get 1
          local.get 7
          i32.const -65536
          i32.and
          i32.add
          i32.const 2
          i32.or
          i32.store
          local.get 4
          local.get 1
          i32.store offset=12
          local.get 2
          i32.const 4
          local.get 4
          i32.const 12
          i32.add
          i32.const 1048920
          i32.const 1
          call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
          local.set 1
          local.get 5
          local.get 4
          i32.load offset=12
          i32.store
          local.get 1
          br_if 1 (;@2;)
        end
        i32.const 1
        local.set 2
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 1
      i64.const 0
      i64.store offset=4 align=4
      local.get 1
      local.get 1
      local.get 6
      i32.add
      i32.const 2
      i32.or
      i32.store
      i32.const 0
      local.set 2
    end
    local.get 0
    local.get 1
    i32.store offset=4
    local.get 0
    local.get 2
    i32.store
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN70_$LT$wee_alloc..LargeAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$13min_cell_size17hc92800961319134bE (type 0) (param i32 i32) (result i32)
    i32.const 512)
  (func $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E (type 13) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 2
      i32.load
      local.tee 5
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    local.get 1
    i32.const -1
    i32.add
    local.set 6
    i32.const 0
    local.get 1
    i32.sub
    local.set 7
    local.get 0
    i32.const 2
    i32.shl
    local.set 8
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 5
                  i32.load offset=8
                  local.tee 1
                  i32.const 1
                  i32.and
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const 8
                  i32.add
                  local.set 9
                  br 1 (;@6;)
                end
                loop  ;; label = @7
                  local.get 5
                  local.get 1
                  i32.const -2
                  i32.and
                  i32.store offset=8
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 5
                      i32.load offset=4
                      local.tee 9
                      i32.const -4
                      i32.and
                      local.tee 1
                      br_if 0 (;@9;)
                      i32.const 0
                      local.set 10
                      br 1 (;@8;)
                    end
                    i32.const 0
                    local.get 1
                    local.get 1
                    i32.load8_u
                    i32.const 1
                    i32.and
                    select
                    local.set 10
                  end
                  block  ;; label = @8
                    local.get 5
                    i32.load
                    local.tee 11
                    i32.const -4
                    i32.and
                    local.tee 12
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 11
                    i32.const 2
                    i32.and
                    br_if 0 (;@8;)
                    local.get 12
                    local.get 12
                    i32.load offset=4
                    i32.const 3
                    i32.and
                    local.get 1
                    i32.or
                    i32.store offset=4
                    local.get 5
                    i32.load offset=4
                    local.tee 9
                    i32.const -4
                    i32.and
                    local.set 1
                    local.get 5
                    i32.load
                    local.set 11
                  end
                  block  ;; label = @8
                    local.get 1
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 1
                    local.get 1
                    i32.load
                    i32.const 3
                    i32.and
                    local.get 11
                    i32.const -4
                    i32.and
                    i32.or
                    i32.store
                    local.get 5
                    i32.load offset=4
                    local.set 9
                    local.get 5
                    i32.load
                    local.set 11
                  end
                  local.get 5
                  local.get 9
                  i32.const 3
                  i32.and
                  i32.store offset=4
                  local.get 5
                  local.get 11
                  i32.const 3
                  i32.and
                  i32.store
                  block  ;; label = @8
                    local.get 11
                    i32.const 2
                    i32.and
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 10
                    local.get 10
                    i32.load
                    i32.const 2
                    i32.or
                    i32.store
                  end
                  local.get 2
                  local.get 10
                  i32.store
                  local.get 10
                  local.set 5
                  local.get 10
                  i32.load offset=8
                  local.tee 1
                  i32.const 1
                  i32.and
                  br_if 0 (;@7;)
                end
                local.get 10
                i32.const 8
                i32.add
                local.set 9
                local.get 10
                local.set 5
              end
              block  ;; label = @6
                local.get 5
                i32.load
                i32.const -4
                i32.and
                local.tee 10
                local.get 5
                i32.const 8
                i32.add
                local.tee 11
                i32.sub
                local.get 8
                i32.lt_u
                br_if 0 (;@6;)
                local.get 11
                local.get 3
                local.get 0
                local.get 4
                call_indirect (type 0)
                i32.const 2
                i32.shl
                i32.add
                i32.const 8
                i32.add
                local.get 10
                local.get 8
                i32.sub
                local.get 7
                i32.and
                local.tee 1
                i32.le_u
                br_if 2 (;@4;)
                local.get 6
                local.get 11
                i32.and
                i32.eqz
                br_if 3 (;@3;)
                local.get 9
                i32.load
                local.set 1
              end
              local.get 2
              local.get 1
              i32.store
              local.get 1
              local.set 5
              local.get 1
              br_if 0 (;@5;)
            end
            i32.const 0
            return
          end
          i32.const 0
          local.set 11
          local.get 1
          i32.const 0
          i32.store
          local.get 1
          i32.const -8
          i32.add
          local.tee 1
          i64.const 0
          i64.store align=4
          local.get 1
          local.get 5
          i32.load
          i32.const -4
          i32.and
          i32.store
          block  ;; label = @4
            local.get 5
            i32.load
            local.tee 9
            i32.const -4
            i32.and
            local.tee 10
            i32.eqz
            br_if 0 (;@4;)
            local.get 9
            i32.const 2
            i32.and
            br_if 0 (;@4;)
            local.get 10
            local.get 10
            i32.load offset=4
            i32.const 3
            i32.and
            local.get 1
            i32.or
            i32.store offset=4
            local.get 1
            i32.load offset=4
            i32.const 3
            i32.and
            local.set 11
          end
          local.get 1
          local.get 11
          local.get 5
          i32.or
          i32.store offset=4
          local.get 5
          local.get 5
          i32.load offset=8
          i32.const -2
          i32.and
          i32.store offset=8
          local.get 5
          local.get 5
          i32.load
          local.tee 11
          i32.const 3
          i32.and
          local.get 1
          i32.or
          local.tee 10
          i32.store
          local.get 11
          i32.const 2
          i32.and
          br_if 1 (;@2;)
          local.get 1
          i32.load
          local.set 11
          br 2 (;@1;)
        end
        local.get 2
        local.get 5
        i32.load offset=8
        i32.const -4
        i32.and
        i32.store
        local.get 5
        i32.load
        local.set 11
        local.get 5
        local.set 1
        br 1 (;@1;)
      end
      local.get 5
      local.get 10
      i32.const -3
      i32.and
      i32.store
      local.get 1
      i32.load
      i32.const 2
      i32.or
      local.set 11
    end
    local.get 1
    local.get 11
    i32.const 1
    i32.or
    i32.store
    local.get 1
    i32.const 8
    i32.add)
  (func $_ZN88_$LT$wee_alloc..size_classes..SizeClassAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$13min_cell_size17h93ccb12e4c19367eE (type 0) (param i32 i32) (result i32)
    local.get 1)
  (func $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17h8be0324704efe0dbE (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        br_if 0 (;@2;)
        local.get 1
        local.set 2
        br 1 (;@1;)
      end
      local.get 2
      i32.const 3
      i32.add
      local.tee 4
      i32.const 2
      i32.shr_u
      local.set 5
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const -1
            local.get 1
            i32.const 4
            i32.ne
            local.get 1
            i32.const 4
            i32.lt_u
            select
            local.tee 2
            i32.const -1
            i32.eq
            br_if 0 (;@4;)
            local.get 2
            i32.const 255
            i32.and
            br_if 1 (;@3;)
          end
          local.get 5
          i32.const -1
          i32.add
          local.tee 2
          i32.const 256
          i32.lt_u
          br_if 1 (;@2;)
        end
        local.get 3
        local.get 0
        i32.load offset=1024
        i32.store offset=12
        block  ;; label = @3
          local.get 5
          local.get 1
          local.get 3
          i32.const 12
          i32.add
          i32.const 1048920
          i32.const 1
          call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
          local.tee 2
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 4
            i32.const -4
            i32.and
            local.tee 2
            local.get 1
            i32.const 3
            i32.shl
            i32.const 16384
            i32.add
            local.tee 4
            local.get 2
            local.get 4
            i32.gt_u
            select
            i32.const 65543
            i32.add
            local.tee 4
            i32.const 16
            i32.shr_u
            memory.grow
            local.tee 2
            i32.const -1
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            local.set 2
            br 1 (;@3;)
          end
          local.get 2
          i32.const 16
          i32.shl
          local.tee 2
          i32.const 0
          i32.store offset=4
          local.get 2
          local.get 3
          i32.load offset=12
          i32.store offset=8
          local.get 2
          local.get 2
          local.get 4
          i32.const -65536
          i32.and
          i32.add
          i32.const 2
          i32.or
          i32.store
          local.get 3
          local.get 2
          i32.store offset=12
          local.get 5
          local.get 1
          local.get 3
          i32.const 12
          i32.add
          i32.const 1048920
          i32.const 1
          call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
          local.set 2
        end
        local.get 0
        local.get 3
        i32.load offset=12
        i32.store offset=1024
        br 1 (;@1;)
      end
      local.get 3
      local.get 0
      i32.const 1024
      i32.add
      i32.store offset=8
      local.get 3
      local.get 0
      local.get 2
      i32.const 2
      i32.shl
      i32.add
      local.tee 0
      i32.load
      i32.store offset=12
      block  ;; label = @2
        local.get 5
        local.get 1
        local.get 3
        i32.const 12
        i32.add
        local.get 3
        i32.const 8
        i32.add
        i32.const 2
        call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
        local.tee 2
        br_if 0 (;@2;)
        local.get 3
        local.get 3
        i32.const 8
        i32.add
        local.get 5
        local.get 3
        call $_ZN88_$LT$wee_alloc..size_classes..SizeClassAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$22new_cell_for_free_list17hfa99c8db0da3defcE
        i32.const 0
        local.set 2
        local.get 3
        i32.load
        br_if 0 (;@2;)
        local.get 3
        i32.load offset=4
        local.tee 2
        local.get 3
        i32.load offset=12
        i32.store offset=8
        local.get 3
        local.get 2
        i32.store offset=12
        local.get 5
        local.get 1
        local.get 3
        i32.const 12
        i32.add
        local.get 3
        i32.const 8
        i32.add
        i32.const 2
        call $_ZN9wee_alloc15alloc_first_fit17h629dff7669726181E
        local.set 2
      end
      local.get 0
      local.get 3
      i32.load offset=12
      i32.store
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $_ZN72_$LT$wee_alloc..WeeAlloc$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17hc72c09abeddd2ab1E (type 10) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const -1
              local.get 2
              i32.const 4
              i32.ne
              local.get 2
              i32.const 4
              i32.lt_u
              select
              local.tee 2
              i32.const -1
              i32.eq
              br_if 0 (;@5;)
              local.get 2
              i32.const 255
              i32.and
              br_if 1 (;@4;)
            end
            local.get 3
            i32.const 3
            i32.add
            i32.const 2
            i32.shr_u
            i32.const -1
            i32.add
            local.tee 3
            i32.const 255
            i32.le_u
            br_if 1 (;@3;)
          end
          local.get 0
          i32.load offset=1024
          local.set 4
          local.get 1
          i32.const 0
          i32.store
          local.get 1
          i32.const -8
          i32.add
          local.tee 3
          local.get 3
          i32.load
          local.tee 2
          i32.const -2
          i32.and
          local.tee 5
          i32.store
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.const 4
              i32.add
              local.tee 6
              i32.load
              i32.const -4
              i32.and
              local.tee 7
              i32.eqz
              br_if 0 (;@5;)
              local.get 7
              i32.load
              local.tee 8
              i32.const 1
              i32.and
              br_if 0 (;@5;)
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.const -4
                    i32.and
                    local.tee 9
                    br_if 0 (;@8;)
                    local.get 7
                    local.set 1
                    br 1 (;@7;)
                  end
                  local.get 7
                  local.set 1
                  local.get 2
                  i32.const 2
                  i32.and
                  br_if 0 (;@7;)
                  local.get 9
                  local.get 9
                  i32.load offset=4
                  i32.const 3
                  i32.and
                  local.get 7
                  i32.or
                  i32.store offset=4
                  local.get 3
                  i32.load
                  local.set 5
                  local.get 6
                  i32.load
                  local.tee 2
                  i32.const -4
                  i32.and
                  local.tee 1
                  i32.eqz
                  br_if 1 (;@6;)
                  local.get 1
                  i32.load
                  local.set 8
                end
                local.get 1
                local.get 5
                i32.const -4
                i32.and
                local.get 8
                i32.const 3
                i32.and
                i32.or
                i32.store
                local.get 6
                i32.load
                local.set 2
                local.get 3
                i32.load
                local.set 5
              end
              local.get 6
              local.get 2
              i32.const 3
              i32.and
              i32.store
              local.get 3
              local.get 5
              i32.const 3
              i32.and
              i32.store
              local.get 5
              i32.const 2
              i32.and
              i32.eqz
              br_if 1 (;@4;)
              local.get 7
              local.get 7
              i32.load
              i32.const 2
              i32.or
              i32.store
              br 1 (;@4;)
            end
            local.get 2
            i32.const -4
            i32.and
            local.tee 7
            i32.eqz
            br_if 3 (;@1;)
            local.get 2
            i32.const 2
            i32.and
            br_if 3 (;@1;)
            local.get 7
            i32.load8_u
            i32.const 1
            i32.and
            br_if 3 (;@1;)
            local.get 1
            local.get 7
            i32.load offset=8
            i32.const -4
            i32.and
            i32.store
            local.get 7
            local.get 3
            i32.const 1
            i32.or
            i32.store offset=8
          end
          local.get 0
          local.get 4
          i32.store offset=1024
          return
        end
        local.get 1
        local.get 0
        local.get 3
        i32.const 2
        i32.shl
        i32.add
        local.tee 3
        i32.load
        i32.store
        local.get 1
        i32.const -8
        i32.add
        local.tee 1
        local.get 1
        i32.load
        i32.const -2
        i32.and
        i32.store
        local.get 3
        local.get 1
        i32.store
      end
      return
    end
    local.get 1
    local.get 4
    i32.store
    local.get 0
    local.get 3
    i32.store offset=1024)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h194562d370a7e54fE (type 1) (param i32 i32)
    local.get 0
    i64.const -163230743173927068
    i64.store offset=8
    local.get 0
    i64.const -4493808902380553279
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h2803b11d586da195E (type 1) (param i32 i32)
    local.get 0
    i64.const -7436231257884308288
    i64.store offset=8
    local.get 0
    i64.const 3805095882030868409
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hfb753a3e5605543cE (type 1) (param i32 i32)
    local.get 0
    i64.const -2328142212601399361
    i64.store offset=8
    local.get 0
    i64.const -3363810345684501719
    i64.store)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h62e4dab0b011f520E (type 11) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        i32.add
        local.tee 2
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 2
        local.get 4
        local.get 2
        i32.gt_u
        select
        local.tee 2
        i32.const 8
        local.get 2
        i32.const 8
        i32.gt_u
        select
        local.tee 2
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            local.get 3
            i32.const 0
            i32.store offset=24
            br 1 (;@3;)
          end
          local.get 3
          local.get 1
          i32.store offset=28
          local.get 3
          i32.const 1
          i32.store offset=24
          local.get 3
          local.get 0
          i32.load offset=4
          i32.store offset=20
        end
        local.get 3
        i32.const 8
        i32.add
        local.get 4
        local.get 2
        local.get 3
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h4894625d2bd523b7E
        local.get 3
        i32.load offset=12
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load offset=8
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.store
          local.get 0
          local.get 1
          i32.store offset=4
          br 2 (;@1;)
        end
        local.get 1
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.const 16
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17h722157b3132392fcE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h4e5e906b1729d011E
      unreachable
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3fmt5Write9write_fmt17h784e68f74eb2f743E (type 0) (param i32 i32) (result i32)
    local.get 0
    i32.const 1048920
    local.get 1
    call $_ZN4core3fmt5write17h4206e0695f244d58E)
  (func $_ZN4core3ptr122drop_in_place$LT$$RF$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$17h6ecccaa8db774c73E (type 6) (param i32))
  (func $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h93070f1f038dbd8eE (type 6) (param i32))
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17heec836c805d21e7dE (type 6) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h205a557bbada610aE (type 6) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.const -2147483648
      i32.or
      i32.const -2147483648
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h8828f10ecba41348E (type 0) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=12
            local.get 1
            i32.const 2048
            i32.lt_u
            br_if 1 (;@3;)
            block  ;; label = @5
              local.get 1
              i32.const 65536
              i32.ge_u
              br_if 0 (;@5;)
              local.get 2
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=14
              local.get 2
              local.get 1
              i32.const 12
              i32.shr_u
              i32.const 224
              i32.or
              i32.store8 offset=12
              local.get 2
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=13
              i32.const 3
              local.set 1
              br 3 (;@2;)
            end
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=15
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=14
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            local.get 2
            local.get 1
            i32.const 18
            i32.shr_u
            i32.const 7
            i32.and
            i32.const 240
            i32.or
            i32.store8 offset=12
            i32.const 4
            local.set 1
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.tee 3
            local.get 0
            i32.load
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hb8fa64f42ae21badE
            local.get 0
            i32.load offset=8
            local.set 3
          end
          local.get 0
          local.get 3
          i32.const 1
          i32.add
          i32.store offset=8
          local.get 0
          i32.load offset=4
          local.get 3
          i32.add
          local.get 1
          i32.store8
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 192
        i32.or
        i32.store8 offset=12
        i32.const 2
        local.set 1
      end
      block  ;; label = @2
        local.get 0
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        local.get 1
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 1
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h62e4dab0b011f520E
        local.get 0
        i32.load offset=8
        local.set 3
      end
      local.get 0
      i32.load offset=4
      local.get 3
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 1
      call $memcpy
      drop
      local.get 0
      local.get 3
      local.get 1
      i32.add
      i32.store offset=8
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    i32.const 0)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hb8fa64f42ae21badE (type 1) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.tee 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.load
        local.tee 3
        i32.const 1
        i32.shl
        local.tee 4
        local.get 1
        local.get 4
        local.get 1
        i32.gt_u
        select
        local.tee 1
        i32.const 8
        local.get 1
        i32.const 8
        i32.gt_u
        select
        local.tee 1
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=24
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.store offset=28
          local.get 2
          i32.const 1
          i32.store offset=24
          local.get 2
          local.get 0
          i32.load offset=4
          i32.store offset=20
        end
        local.get 2
        i32.const 8
        i32.add
        local.get 4
        local.get 1
        local.get 2
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h4894625d2bd523b7E
        local.get 2
        i32.load offset=12
        local.set 3
        block  ;; label = @3
          local.get 2
          i32.load offset=8
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          local.get 3
          i32.store offset=4
          br 2 (;@1;)
        end
        local.get 3
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 2
        i32.const 16
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17h722157b3132392fcE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h4e5e906b1729d011E
      unreachable
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h15bc49a521d9983aE (type 2) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h62e4dab0b011f520E
      local.get 0
      i32.load offset=8
      local.set 3
    end
    local.get 0
    i32.load offset=4
    local.get 3
    i32.add
    local.get 1
    local.get 2
    call $memcpy
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec11finish_grow17h4894625d2bd523b7E (type 10) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          i32.const -1
          i32.le_s
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.load offset=4
                i32.eqz
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 3
                  i32.const 8
                  i32.add
                  i32.load
                  local.tee 4
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 2
                    br_if 0 (;@8;)
                    local.get 1
                    local.set 3
                    br 4 (;@4;)
                  end
                  i32.const 0
                  i32.load8_u offset=1049645
                  drop
                  br 2 (;@5;)
                end
                local.get 3
                i32.load
                local.get 4
                local.get 1
                local.get 2
                call $__rust_realloc
                local.set 3
                br 2 (;@4;)
              end
              block  ;; label = @6
                local.get 2
                br_if 0 (;@6;)
                local.get 1
                local.set 3
                br 2 (;@4;)
              end
              i32.const 0
              i32.load8_u offset=1049645
              drop
            end
            local.get 2
            local.get 1
            call $__rust_alloc
            local.set 3
          end
          block  ;; label = @4
            local.get 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            i32.store offset=4
            local.get 0
            i32.const 8
            i32.add
            local.get 2
            i32.store
            local.get 0
            i32.const 0
            i32.store
            return
          end
          local.get 0
          local.get 1
          i32.store offset=4
          local.get 0
          i32.const 8
          i32.add
          local.get 2
          i32.store
          br 2 (;@1;)
        end
        local.get 0
        i32.const 0
        i32.store offset=4
        local.get 0
        i32.const 8
        i32.add
        local.get 2
        i32.store
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      i32.store offset=4
    end
    local.get 0
    i32.const 1
    i32.store)
  (func $_ZN3std7process5abort17hbc03b63e6e7f1c48E (type 9)
    unreachable
    unreachable)
  (func $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17ha76513a70bb070b0E (type 6) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h96d2bc381fa6ee1eE
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h96d2bc381fa6ee1eE (type 6) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.tee 2
    i32.const 12
    i32.add
    i32.load
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            br_table 0 (;@4;) 1 (;@3;) 3 (;@1;)
          end
          local.get 3
          br_if 2 (;@1;)
          i32.const 1048920
          local.set 2
          i32.const 0
          local.set 3
          br 1 (;@2;)
        end
        local.get 3
        br_if 1 (;@1;)
        local.get 2
        i32.load
        local.tee 2
        i32.load offset=4
        local.set 3
        local.get 2
        i32.load
        local.set 2
      end
      local.get 1
      local.get 3
      i32.store offset=4
      local.get 1
      local.get 2
      i32.store
      local.get 1
      i32.const 1049112
      local.get 0
      i32.load offset=4
      local.tee 2
      i32.load offset=8
      local.get 0
      i32.load offset=8
      local.get 2
      i32.load8_u offset=16
      local.get 2
      i32.load8_u offset=17
      call $_ZN3std9panicking20rust_panic_with_hook17h9aabd906218897c3E
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=12
    local.get 1
    i32.const -2147483648
    i32.store
    local.get 1
    i32.const 1049132
    local.get 0
    i32.load offset=4
    local.tee 2
    i32.load offset=8
    local.get 0
    i32.load offset=8
    local.get 2
    i32.load8_u offset=16
    local.get 2
    i32.load8_u offset=17
    call $_ZN3std9panicking20rust_panic_with_hook17h9aabd906218897c3E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17h4e632cc5d886f9dfE (type 1) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1049644
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 24
      i32.add
      i64.const 1
      i64.store align=4
      local.get 2
      i32.const 2
      i32.store offset=16
      local.get 2
      i32.const 1048980
      i32.store offset=12
      local.get 2
      i32.const 3
      i32.store offset=40
      local.get 2
      local.get 1
      i32.store offset=44
      local.get 2
      local.get 2
      i32.const 36
      i32.add
      i32.store offset=20
      local.get 2
      local.get 2
      i32.const 44
      i32.add
      i32.store offset=36
      local.get 2
      i32.const 12
      i32.add
      i32.const 1049020
      call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $rust_begin_unwind (type 6) (param i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.load offset=8
      local.tee 2
      br_if 0 (;@1;)
      i32.const 1049064
      call $_ZN4core6option13unwrap_failed17h0e0b231623e0d004E
      unreachable
    end
    local.get 1
    local.get 0
    i32.load offset=12
    i32.store offset=12
    local.get 1
    local.get 0
    i32.store offset=8
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    i32.const 4
    i32.add
    call $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17ha76513a70bb070b0E
    unreachable)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h579b72534bf3162bE (type 1) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.load
      i32.const -2147483648
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=12
      local.set 3
      local.get 2
      i32.const 36
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 4294967296
      i64.store offset=36 align=4
      local.get 2
      i32.const 36
      i32.add
      i32.const 1048920
      local.get 3
      call $_ZN4core3fmt5write17h4206e0695f244d58E
      drop
      local.get 2
      i32.const 24
      i32.add
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 3
      i32.store
      local.get 2
      local.get 2
      i64.load offset=36 align=4
      local.tee 5
      i64.store offset=24
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i64.store align=4
    end
    local.get 1
    i64.load align=4
    local.set 5
    local.get 1
    i64.const 4294967296
    i64.store align=4
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.tee 3
    local.get 1
    i32.const 8
    i32.add
    local.tee 1
    i32.load
    i32.store
    local.get 1
    i32.const 0
    i32.store
    i32.const 0
    i32.load8_u offset=1049645
    drop
    local.get 2
    local.get 5
    i64.store offset=8
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17h722157b3132392fcE
      unreachable
    end
    local.get 1
    local.get 2
    i64.load offset=8
    i64.store align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 3
    i32.load
    i32.store
    local.get 0
    i32.const 1049080
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h461458668667924bE (type 1) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.load
      i32.const -2147483648
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=12
      local.set 3
      local.get 2
      i32.const 20
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 4294967296
      i64.store offset=20 align=4
      local.get 2
      i32.const 20
      i32.add
      i32.const 1048920
      local.get 3
      call $_ZN4core3fmt5write17h4206e0695f244d58E
      drop
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 3
      i32.store
      local.get 2
      local.get 2
      i64.load offset=20 align=4
      local.tee 5
      i64.store offset=8
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i64.store align=4
    end
    local.get 0
    i32.const 1049080
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h1cef2c84414512a3E (type 1) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1049645
    drop
    local.get 1
    i32.load offset=4
    local.set 2
    local.get 1
    i32.load
    local.set 3
    block  ;; label = @1
      i32.const 8
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 8
      call $_ZN5alloc5alloc18handle_alloc_error17h722157b3132392fcE
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1049096
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17ha0044adbafb7f512E (type 1) (param i32 i32)
    local.get 0
    i32.const 1049096
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN3std9panicking20rust_panic_with_hook17h9aabd906218897c3E (type 14) (param i32 i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 6
    global.set $__stack_pointer
    i32.const 0
    i32.const 0
    i32.load offset=1050696
    local.tee 7
    i32.const 1
    i32.add
    i32.store offset=1050696
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.load8_u offset=1050704
        i32.const 255
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        i32.const 1
        i32.store8 offset=1050704
        i32.const 0
        i32.const 0
        i32.load offset=1050700
        i32.const 1
        i32.add
        i32.store offset=1050700
        local.get 6
        local.get 5
        i32.store8 offset=29
        local.get 6
        local.get 4
        i32.store8 offset=28
        local.get 6
        local.get 3
        i32.store offset=24
        local.get 6
        local.get 2
        i32.store offset=20
        local.get 6
        i32.const 1049152
        i32.store offset=16
        local.get 6
        i32.const 1048920
        i32.store offset=12
        i32.const 0
        i32.load offset=1050680
        local.tee 7
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 7
        i32.const 1
        i32.add
        i32.store offset=1050680
        block  ;; label = @3
          i32.const 0
          i32.load offset=1050688
          i32.eqz
          br_if 0 (;@3;)
          local.get 6
          local.get 0
          local.get 1
          i32.load offset=16
          call_indirect (type 1)
          local.get 6
          local.get 6
          i64.load
          i64.store offset=12 align=4
          i32.const 0
          i32.load offset=1050688
          local.get 6
          i32.const 12
          i32.add
          i32.const 0
          i32.load offset=1050692
          i32.load offset=20
          call_indirect (type 1)
          i32.const 0
          i32.load offset=1050680
          i32.const -1
          i32.add
          local.set 7
        end
        i32.const 0
        local.get 7
        i32.store offset=1050680
        i32.const 0
        i32.const 0
        i32.store8 offset=1050704
        local.get 4
        br_if 1 (;@1;)
      end
      unreachable
      unreachable
    end
    local.get 0
    local.get 1
    call $rust_panic
    unreachable)
  (func $rust_panic (type 1) (param i32 i32)
    local.get 0
    local.get 1
    call $__rust_start_panic
    drop
    unreachable
    unreachable)
  (func $__rg_oom (type 1) (param i32 i32)
    (local i32)
    local.get 1
    local.get 0
    i32.const 0
    i32.load offset=1050676
    local.tee 2
    i32.const 4
    local.get 2
    select
    call_indirect (type 1)
    unreachable
    unreachable)
  (func $__rust_start_panic (type 0) (param i32 i32) (result i32)
    unreachable
    unreachable)
  (func $_ZN5alloc5alloc18handle_alloc_error17h722157b3132392fcE (type 1) (param i32 i32)
    local.get 1
    local.get 0
    call $__rust_alloc_error_handler
    unreachable)
  (func $_ZN5alloc7raw_vec17capacity_overflow17h4e5e906b1729d011E (type 9)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=4
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1049216
    i32.store offset=8
    local.get 0
    i32.const 1049168
    i32.store offset=16
    local.get 0
    i32.const 8
    i32.add
    i32.const 1049224
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN4core3ops8function6FnOnce9call_once17haca5d5a6cc760cb6E (type 0) (param i32 i32) (result i32)
    local.get 0
    i32.load
    drop
    loop (result i32)  ;; label = @1
      br 0 (;@1;)
    end)
  (func $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h9a936179acd45b3dE (type 6) (param i32))
  (func $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE (type 1) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 1
    i32.store16 offset=28
    local.get 2
    local.get 1
    i32.store offset=24
    local.get 2
    local.get 0
    i32.store offset=20
    local.get 2
    i32.const 1049284
    i32.store offset=16
    local.get 2
    i32.const 1049240
    i32.store offset=12
    local.get 2
    i32.const 12
    i32.add
    call $rust_begin_unwind
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail17ha8b9a9b3afaec0e8E (type 11) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    i32.const 8
    i32.add
    i32.const 12
    i32.add
    i64.const 2
    i64.store align=4
    local.get 3
    i32.const 32
    i32.add
    i32.const 12
    i32.add
    i32.const 3
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049552
    i32.store offset=8
    local.get 3
    i32.const 3
    i32.store offset=36
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    local.get 3
    i32.const 4
    i32.add
    i32.store offset=40
    local.get 3
    local.get 3
    i32.store offset=32
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN4core9panicking5panic17h11a2021d92dc1cbbE (type 11) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 12
    i32.add
    i64.const 0
    i64.store align=4
    local.get 3
    i32.const 1
    i32.store offset=4
    local.get 3
    i32.const 1049240
    i32.store offset=8
    local.get 3
    local.get 1
    i32.store offset=28
    local.get 3
    local.get 0
    i32.store offset=24
    local.get 3
    local.get 3
    i32.const 24
    i32.add
    i32.store
    local.get 3
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h93fab4f89e9a461aE (type 0) (param i32 i32) (result i32)
    local.get 0
    i64.load32_u
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp7fmt_u6417h6066c8676cfadd83E)
  (func $_ZN4core3fmt5write17h4206e0695f244d58E (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 36
    i32.add
    local.get 1
    i32.store
    local.get 3
    i32.const 3
    i32.store8 offset=44
    local.get 3
    i32.const 32
    i32.store offset=28
    i32.const 0
    local.set 4
    local.get 3
    i32.const 0
    i32.store offset=40
    local.get 3
    local.get 0
    i32.store offset=32
    local.get 3
    i32.const 0
    i32.store offset=20
    local.get 3
    i32.const 0
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.load offset=16
              local.tee 5
              br_if 0 (;@5;)
              local.get 2
              i32.const 12
              i32.add
              i32.load
              local.tee 0
              i32.eqz
              br_if 1 (;@4;)
              local.get 2
              i32.load offset=8
              local.tee 1
              local.get 0
              i32.const 3
              i32.shl
              i32.add
              local.set 6
              local.get 0
              i32.const -1
              i32.add
              i32.const 536870911
              i32.and
              i32.const 1
              i32.add
              local.set 4
              local.get 2
              i32.load
              local.set 0
              i32.const 0
              local.set 7
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 8
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load offset=32
                  local.get 0
                  i32.load
                  local.get 8
                  local.get 3
                  i32.load offset=36
                  i32.load offset=12
                  call_indirect (type 2)
                  br_if 4 (;@3;)
                end
                local.get 1
                i32.load
                local.get 3
                i32.const 12
                i32.add
                local.get 1
                i32.const 4
                i32.add
                i32.load
                call_indirect (type 0)
                br_if 3 (;@3;)
                local.get 7
                i32.const 1
                i32.add
                local.set 7
                local.get 0
                i32.const 8
                i32.add
                local.set 0
                local.get 1
                i32.const 8
                i32.add
                local.tee 1
                local.get 6
                i32.ne
                br_if 0 (;@6;)
                br 2 (;@4;)
              end
            end
            local.get 2
            i32.const 20
            i32.add
            i32.load
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 5
            i32.shl
            local.set 9
            local.get 1
            i32.const -1
            i32.add
            i32.const 134217727
            i32.and
            i32.const 1
            i32.add
            local.set 4
            local.get 2
            i32.load offset=8
            local.set 10
            local.get 2
            i32.load
            local.set 0
            i32.const 0
            local.set 7
            i32.const 0
            local.set 11
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=32
                local.get 0
                i32.load
                local.get 1
                local.get 3
                i32.load offset=36
                i32.load offset=12
                call_indirect (type 2)
                br_if 3 (;@3;)
              end
              local.get 3
              local.get 5
              local.get 7
              i32.add
              local.tee 1
              i32.const 16
              i32.add
              i32.load
              i32.store offset=28
              local.get 3
              local.get 1
              i32.const 28
              i32.add
              i32.load8_u
              i32.store8 offset=44
              local.get 3
              local.get 1
              i32.const 24
              i32.add
              i32.load
              i32.store offset=40
              local.get 1
              i32.const 12
              i32.add
              i32.load
              local.set 6
              i32.const 0
              local.set 12
              i32.const 0
              local.set 8
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 8
                    i32.add
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 6
                  i32.const 3
                  i32.shl
                  local.set 13
                  i32.const 0
                  local.set 8
                  local.get 10
                  local.get 13
                  i32.add
                  local.tee 13
                  i32.load offset=4
                  i32.const 19
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 13
                  i32.load
                  i32.load
                  local.set 6
                end
                i32.const 1
                local.set 8
              end
              local.get 3
              local.get 6
              i32.store offset=16
              local.get 3
              local.get 8
              i32.store offset=12
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.set 8
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 8
                  i32.const 3
                  i32.shl
                  local.set 6
                  local.get 10
                  local.get 6
                  i32.add
                  local.tee 6
                  i32.load offset=4
                  i32.const 19
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 6
                  i32.load
                  i32.load
                  local.set 8
                end
                i32.const 1
                local.set 12
              end
              local.get 3
              local.get 8
              i32.store offset=24
              local.get 3
              local.get 12
              i32.store offset=20
              local.get 10
              local.get 1
              i32.const 20
              i32.add
              i32.load
              i32.const 3
              i32.shl
              i32.add
              local.tee 1
              i32.load
              local.get 3
              i32.const 12
              i32.add
              local.get 1
              i32.const 4
              i32.add
              i32.load
              call_indirect (type 0)
              br_if 2 (;@3;)
              local.get 11
              i32.const 1
              i32.add
              local.set 11
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 9
              local.get 7
              i32.const 32
              i32.add
              local.tee 7
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 4
          local.get 2
          i32.load offset=4
          i32.ge_u
          br_if 1 (;@2;)
          local.get 3
          i32.load offset=32
          local.get 2
          i32.load
          local.get 4
          i32.const 3
          i32.shl
          i32.add
          local.tee 1
          i32.load
          local.get 1
          i32.load offset=4
          local.get 3
          i32.load offset=36
          i32.load offset=12
          call_indirect (type 2)
          i32.eqz
          br_if 1 (;@2;)
        end
        i32.const 1
        local.set 1
        br 1 (;@1;)
      end
      i32.const 0
      local.set 1
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he52c1d820acf2419E (type 1) (param i32 i32)
    local.get 0
    i64.const -2328142212601399361
    i64.store offset=8
    local.get 0
    i64.const -3363810345684501719
    i64.store)
  (func $_ZN4core5slice5index22slice_index_order_fail17hfe0b37c521ea69d8E (type 11) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    i32.const 8
    i32.add
    i32.const 12
    i32.add
    i64.const 2
    i64.store align=4
    local.get 3
    i32.const 32
    i32.add
    i32.const 12
    i32.add
    i32.const 3
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049604
    i32.store offset=8
    local.get 3
    i32.const 3
    i32.store offset=36
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    local.get 3
    i32.const 4
    i32.add
    i32.store offset=40
    local.get 3
    local.get 3
    i32.store offset=32
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h3aff855fe938c13fE
    unreachable)
  (func $_ZN4core6option13unwrap_failed17h0e0b231623e0d004E (type 6) (param i32)
    i32.const 1049240
    i32.const 43
    local.get 0
    call $_ZN4core9panicking5panic17h11a2021d92dc1cbbE
    unreachable)
  (func $_ZN4core3fmt9Formatter12pad_integral17ha0b66658cc7a01daE (type 15) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        local.get 5
        i32.const 1
        i32.add
        local.set 6
        local.get 0
        i32.load offset=28
        local.set 7
        i32.const 45
        local.set 8
        br 1 (;@1;)
      end
      i32.const 43
      i32.const 1114112
      local.get 0
      i32.load offset=28
      local.tee 7
      i32.const 1
      i32.and
      local.tee 1
      select
      local.set 8
      local.get 1
      local.get 5
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 3
          call $_ZN4core3str5count14do_count_chars17h8c271f8a7fe90779E
          local.set 1
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
          br 1 (;@2;)
        end
        local.get 3
        i32.const 3
        i32.and
        local.set 9
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 4
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            i32.const 0
            local.set 10
            br 1 (;@3;)
          end
          local.get 3
          i32.const -4
          i32.and
          local.set 11
          i32.const 0
          local.set 1
          i32.const 0
          local.set 10
          loop  ;; label = @4
            local.get 1
            local.get 2
            local.get 10
            i32.add
            local.tee 12
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 11
            local.get 10
            i32.const 4
            i32.add
            local.tee 10
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 9
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 10
        i32.add
        local.set 12
        loop  ;; label = @3
          local.get 1
          local.get 12
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 1
          local.get 12
          i32.const 1
          i32.add
          local.set 12
          local.get 9
          i32.const -1
          i32.add
          local.tee 9
          br_if 0 (;@3;)
        end
      end
      local.get 1
      local.get 6
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h6c9a769777aad674E
        br_if 1 (;@1;)
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 2)
        return
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 9
        local.get 6
        i32.gt_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h6c9a769777aad674E
        br_if 1 (;@1;)
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 2)
        return
      end
      block  ;; label = @2
        local.get 7
        i32.const 8
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=16
        local.set 11
        local.get 0
        i32.const 48
        i32.store offset=16
        local.get 0
        i32.load8_u offset=32
        local.set 7
        i32.const 1
        local.set 1
        local.get 0
        i32.const 1
        i32.store8 offset=32
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h6c9a769777aad674E
        br_if 1 (;@1;)
        local.get 9
        local.get 6
        i32.sub
        i32.const 1
        i32.add
        local.set 1
        block  ;; label = @3
          loop  ;; label = @4
            local.get 1
            i32.const -1
            i32.add
            local.tee 1
            i32.eqz
            br_if 1 (;@3;)
            local.get 12
            i32.const 48
            local.get 10
            i32.load offset=16
            call_indirect (type 0)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        i32.const 1
        local.set 1
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 2)
        br_if 1 (;@1;)
        local.get 0
        local.get 7
        i32.store8 offset=32
        local.get 0
        local.get 11
        i32.store offset=16
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 9
      local.get 6
      i32.sub
      local.set 6
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_u offset=32
            local.tee 1
            br_table 2 (;@2;) 0 (;@4;) 1 (;@3;) 0 (;@4;) 2 (;@2;)
          end
          local.get 6
          local.set 1
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 6
        i32.const 1
        i32.shr_u
        local.set 1
        local.get 6
        i32.const 1
        i32.add
        i32.const 1
        i32.shr_u
        local.set 6
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 1
      local.get 0
      i32.const 24
      i32.add
      i32.load
      local.set 12
      local.get 0
      i32.load offset=16
      local.set 9
      local.get 0
      i32.load offset=20
      local.set 10
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 10
          local.get 9
          local.get 12
          i32.load offset=16
          call_indirect (type 0)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        return
      end
      i32.const 1
      local.set 1
      local.get 10
      local.get 12
      local.get 8
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h6c9a769777aad674E
      br_if 0 (;@1;)
      local.get 10
      local.get 4
      local.get 5
      local.get 12
      i32.load offset=12
      call_indirect (type 2)
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      loop  ;; label = @2
        block  ;; label = @3
          local.get 6
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 6
          local.get 6
          i32.lt_u
          return
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 10
        local.get 9
        local.get 12
        i32.load offset=16
        call_indirect (type 0)
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const -1
      i32.add
      local.get 6
      i32.lt_u
      return
    end
    local.get 1)
  (func $_ZN4core3str5count14do_count_chars17h8c271f8a7fe90779E (type 0) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 0
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.tee 2
        local.get 0
        i32.sub
        local.tee 3
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.sub
        local.tee 4
        i32.const 4
        i32.lt_u
        br_if 0 (;@2;)
        local.get 4
        i32.const 3
        i32.and
        local.set 5
        i32.const 0
        local.set 6
        i32.const 0
        local.set 1
        block  ;; label = @3
          local.get 2
          local.get 0
          i32.eq
          local.tee 7
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              local.get 0
              i32.const -1
              i32.xor
              i32.add
              i32.const 3
              i32.ge_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 8
              br 1 (;@4;)
            end
            i32.const 0
            local.set 8
            loop  ;; label = @5
              local.get 1
              local.get 0
              local.get 8
              i32.add
              local.tee 9
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 8
              i32.const 4
              i32.add
              local.tee 8
              br_if 0 (;@5;)
            end
          end
          local.get 7
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.sub
          local.set 2
          local.get 0
          local.get 8
          i32.add
          local.set 9
          loop  ;; label = @4
            local.get 1
            local.get 9
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 9
            i32.const 1
            i32.add
            local.set 9
            local.get 2
            i32.const 1
            i32.add
            local.tee 2
            br_if 0 (;@4;)
          end
        end
        local.get 0
        local.get 3
        i32.add
        local.set 8
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          local.get 4
          i32.const -4
          i32.and
          i32.add
          local.tee 9
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 9
          i32.load8_s offset=1
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
          local.get 5
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 9
          i32.load8_s offset=2
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
        end
        local.get 4
        i32.const 2
        i32.shr_u
        local.set 3
        local.get 6
        local.get 1
        i32.add
        local.set 2
        loop  ;; label = @3
          local.get 8
          local.set 6
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.const 192
          local.get 3
          i32.const 192
          i32.lt_u
          select
          local.tee 4
          i32.const 3
          i32.and
          local.set 5
          local.get 4
          i32.const 2
          i32.shl
          local.set 7
          block  ;; label = @4
            block  ;; label = @5
              local.get 4
              i32.const 252
              i32.and
              local.tee 10
              br_if 0 (;@5;)
              i32.const 0
              local.set 9
              br 1 (;@4;)
            end
            local.get 6
            local.get 10
            i32.const 2
            i32.shl
            i32.add
            local.set 0
            i32.const 0
            local.set 9
            local.get 6
            local.set 1
            loop  ;; label = @5
              local.get 1
              i32.const 12
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.const 8
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 9
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 9
              local.get 1
              i32.const 16
              i32.add
              local.tee 1
              local.get 0
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 3
          local.get 4
          i32.sub
          local.set 3
          local.get 6
          local.get 7
          i32.add
          local.set 8
          local.get 9
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 9
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 2
          i32.add
          local.set 2
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 6
        local.get 10
        i32.const 2
        i32.shl
        i32.add
        local.tee 9
        i32.load
        local.tee 1
        i32.const -1
        i32.xor
        i32.const 7
        i32.shr_u
        local.get 1
        i32.const 6
        i32.shr_u
        i32.or
        i32.const 16843009
        i32.and
        local.set 1
        block  ;; label = @3
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 9
          i32.load offset=4
          local.tee 8
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 8
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
          local.get 5
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 9
          i32.load offset=8
          local.tee 9
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 9
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
        end
        local.get 1
        i32.const 8
        i32.shr_u
        i32.const 459007
        i32.and
        local.get 1
        i32.const 16711935
        i32.and
        i32.add
        i32.const 65537
        i32.mul
        i32.const 16
        i32.shr_u
        local.get 2
        i32.add
        local.set 2
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 1
      i32.const 3
      i32.and
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 2
          i32.const 0
          local.set 9
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 3
        i32.const 0
        local.set 2
        i32.const 0
        local.set 9
        loop  ;; label = @3
          local.get 2
          local.get 0
          local.get 9
          i32.add
          local.tee 1
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 1
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 2
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 3
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 2
          local.get 3
          local.get 9
          i32.const 4
          i32.add
          local.tee 9
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 9
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 2
        local.get 1
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 2
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 8
        i32.const -1
        i32.add
        local.tee 8
        br_if 0 (;@2;)
      end
    end
    local.get 2)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h6c9a769777aad674E (type 13) (param i32 i32 i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 1114112
          i32.eq
          br_if 0 (;@3;)
          i32.const 1
          local.set 5
          local.get 0
          local.get 2
          local.get 1
          i32.load offset=16
          call_indirect (type 0)
          br_if 1 (;@2;)
        end
        local.get 3
        br_if 1 (;@1;)
        i32.const 0
        local.set 5
      end
      local.get 5
      return
    end
    local.get 0
    local.get 3
    local.get 4
    local.get 1
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN4core3fmt3num3imp7fmt_u6417h6066c8676cfadd83E (type 16) (param i64 i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 39
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i64.const 10000
        i64.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 5
        br 1 (;@1;)
      end
      i32.const 39
      local.set 4
      loop  ;; label = @2
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.add
        local.tee 6
        i32.const -4
        i32.add
        local.get 0
        local.get 0
        i64.const 10000
        i64.div_u
        local.tee 5
        i64.const 10000
        i64.mul
        i64.sub
        i32.wrap_i64
        local.tee 7
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 8
        i32.const 1
        i32.shl
        i32.const 1049300
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 6
        i32.const -2
        i32.add
        local.get 7
        local.get 8
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.const 1049300
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 0
        i64.const 99999999
        i64.gt_u
        local.set 6
        local.get 5
        local.set 0
        local.get 6
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 5
      i32.wrap_i64
      local.tee 6
      i32.const 99
      i32.le_u
      br_if 0 (;@1;)
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 5
      i32.wrap_i64
      local.tee 6
      local.get 6
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 6
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      i32.const 1049300
      i32.add
      i32.load16_u align=1
      i32.store16 align=1
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 10
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.const -2
        i32.add
        local.tee 4
        i32.add
        local.get 6
        i32.const 1
        i32.shl
        i32.const 1049300
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        br 1 (;@1;)
      end
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 6
      i32.const 48
      i32.add
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1049240
    i32.const 0
    local.get 3
    i32.const 9
    i32.add
    local.get 4
    i32.add
    i32.const 39
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17ha0b66658cc7a01daE
    local.set 4
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN17compiler_builtins3mem6memcpy17hff32d144aabc488bE (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 16
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.set 5
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        local.get 1
        local.set 6
        loop  ;; label = @3
          local.get 3
          local.get 6
          i32.load8_u
          i32.store8
          local.get 6
          i32.const 1
          i32.add
          local.set 6
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 5
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      local.tee 7
      i32.const -4
      i32.and
      local.tee 8
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 4
          i32.add
          local.tee 9
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          i32.const 1
          i32.lt_s
          br_if 1 (;@2;)
          local.get 9
          i32.const 3
          i32.shl
          local.tee 6
          i32.const 24
          i32.and
          local.set 2
          local.get 9
          i32.const -4
          i32.and
          local.tee 10
          i32.const 4
          i32.add
          local.set 1
          i32.const 0
          local.get 6
          i32.sub
          i32.const 24
          i32.and
          local.set 4
          local.get 10
          i32.load
          local.set 6
          loop  ;; label = @4
            local.get 5
            local.get 6
            local.get 2
            i32.shr_u
            local.get 1
            i32.load
            local.tee 6
            local.get 4
            i32.shl
            i32.or
            i32.store
            local.get 1
            i32.const 4
            i32.add
            local.set 1
            local.get 5
            i32.const 4
            i32.add
            local.tee 5
            local.get 3
            i32.lt_u
            br_if 0 (;@4;)
            br 2 (;@2;)
          end
        end
        local.get 8
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 9
        local.set 1
        loop  ;; label = @3
          local.get 5
          local.get 1
          i32.load
          i32.store
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 7
      i32.const 3
      i32.and
      local.set 2
      local.get 9
      local.get 8
      i32.add
      local.set 1
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 2
      i32.add
      local.set 5
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_u
        i32.store8
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 5
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $_ZN17compiler_builtins3mem6memcmp17had5d6514a23cceffE (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 4
          local.get 1
          i32.load8_u
          local.tee 5
          i32.ne
          br_if 1 (;@2;)
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 2
          i32.const -1
          i32.add
          local.tee 2
          i32.eqz
          br_if 2 (;@1;)
          br 0 (;@3;)
        end
      end
      local.get 4
      local.get 5
      i32.sub
      local.set 3
    end
    local.get 3)
  (func $memcpy (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memcpy17hff32d144aabc488bE)
  (func $memcmp (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memcmp17had5d6514a23cceffE)
  (table (;0;) 22 22 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1050705))
  (global (;2;) i32 (i32.const 1050720))
  (export "memory" (memory 0))
  (export "init_counter" (func $init_counter))
  (export "counter.counter_receive" (func $counter.counter_receive))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN70_$LT$wee_alloc..LargeAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$13min_cell_size17hc92800961319134bE $_ZN88_$LT$wee_alloc..size_classes..SizeClassAllocPolicy$u20$as$u20$wee_alloc..AllocPolicy$GT$13min_cell_size17h93ccb12e4c19367eE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h93fab4f89e9a461aE $_ZN3std5alloc24default_alloc_error_hook17h4e632cc5d886f9dfE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17heec836c805d21e7dE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h15bc49a521d9983aE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h8828f10ecba41348E $_ZN4core3fmt5Write9write_fmt17h784e68f74eb2f743E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h2803b11d586da195E $_ZN4core3ptr122drop_in_place$LT$$RF$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$17h6ecccaa8db774c73E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h194562d370a7e54fE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h1cef2c84414512a3E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17ha0044adbafb7f512E $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h205a557bbada610aE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h579b72534bf3162bE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h461458668667924bE $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h93070f1f038dbd8eE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hfb753a3e5605543cE $_ZN4core3ops8function6FnOnce9call_once17haca5d5a6cc760cb6E $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h9a936179acd45b3dE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he52c1d820acf2419E)
  (data $.rodata (i32.const 1048576) "/home/wolfgang/concordium-rust-smart-contracts/concordium-contracts-common/src/impls.rs\00\00\00\10\00W\00\00\00'\03\00\00<\00\00\00src/lib.rs\00\00h\00\10\00\0a\00\00\00\1c\01\00\00<\00\00\00h\00\10\00\0a\00\00\00]\01\00\00<\00\00\00requested allocation size overflowed\94\00\10\00$\00\00\00/home/wolfgang/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bumpalo-3.16.0/src/lib.rs\00\00\00\c0\00\10\00]\00\00\00\ea\01\00\00\05\00\00\00out of memory\00\00\000\01\10\00\0d\00\00\00\c0\00\10\00]\00\00\00m\07\00\00\05\00\00\00\05\00\00\00\0c\00\00\00\04\00\00\00\06\00\00\00\07\00\00\00\08\00\00\00memory allocation of  bytes failed\00\00p\01\10\00\15\00\00\00\85\01\10\00\0d\00\00\00library/std/src/alloc.rs\a4\01\10\00\18\00\00\00b\01\00\00\09\00\00\00library/std/src/panicking.rs\cc\01\10\00\1c\00\00\00\86\02\00\00\1e\00\00\00\05\00\00\00\0c\00\00\00\04\00\00\00\09\00\00\00\0a\00\00\00\08\00\00\00\04\00\00\00\0b\00\00\00\0a\00\00\00\08\00\00\00\04\00\00\00\0c\00\00\00\0d\00\00\00\0e\00\00\00\10\00\00\00\04\00\00\00\0f\00\00\00\10\00\00\00\11\00\00\00\00\00\00\00\01\00\00\00\12\00\00\00library/alloc/src/raw_vec.rscapacity overflow\00\00\00l\02\10\00\11\00\00\00P\02\10\00\1c\00\00\00:\02\00\00\05\00\00\00called `Option::unwrap()` on a `None` value\00\14\00\00\00\00\00\00\00\01\00\00\00\15\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899 out of range for slice of length range end index \00\00\be\03\10\00\10\00\00\00\9c\03\10\00\22\00\00\00slice index starts at  but ends at \00\e0\03\10\00\16\00\00\00\f6\03\10\00\0d\00\00\00")
  (data $.data (i32.const 1049620) "\14\04\10\00\04\00\00\00\18\00\00\00\14\04\10\00\14\04\10\00\00\00\00\00"))
