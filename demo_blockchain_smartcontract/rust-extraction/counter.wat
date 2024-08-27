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
  (import "concordium" "accept" (func (;0;) (type 3)))
  (import "concordium" "simple_transfer" (func (;1;) (type 4)))
  (import "concordium" "combine_and" (func (;2;) (type 0)))
  (import "concordium" "get_slot_time" (func (;3;) (type 5)))
  (import "concordium" "get_init_origin" (func (;4;) (type 6)))
  (import "concordium" "get_receive_sender" (func (;5;) (type 6)))
  (import "concordium" "get_receive_self_address" (func (;6;) (type 6)))
  (import "concordium" "get_receive_self_balance" (func (;7;) (type 5)))
  (import "concordium" "get_receive_invoker" (func (;8;) (type 6)))
  (import "concordium" "state_size" (func (;9;) (type 3)))
  (import "concordium" "load_state" (func (;10;) (type 2)))
  (import "concordium" "write_state" (func (;11;) (type 2)))
  (import "concordium" "resize_state" (func (;12;) (type 7)))
  (import "concordium" "get_parameter_section" (func (;13;) (type 2)))
  (func (;14;) (type 1) (param i32 i32)
    (local i32 i32 i64)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 2
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        br_if 0 (;@2;)
        call 0
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
          i32.load8_u offset=24
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
      i32.load offset=4
      local.set 3
      local.get 1
      i64.load offset=16
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
        local.get 4
        i64.const -1
        i64.gt_s
        br_if 0 (;@2;)
        local.get 0
        i64.const 3
        i64.store
        br 1 (;@1;)
      end
      local.get 2
      local.get 4
      call 1
      local.set 1
      local.get 2
      local.get 3
      call 14
      block  ;; label = @2
        local.get 2
        i64.load
        local.tee 4
        i64.const 5
        i64.ne
        br_if 0 (;@2;)
        local.get 1
        local.get 2
        i32.load offset=8
        call 2
        local.set 1
        local.get 0
        i64.const 5
        i64.store
        local.get 0
        local.get 1
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 0
      local.get 2
      i64.load offset=8
      i64.store offset=8
      local.get 0
      local.get 4
      i64.store
    end
    local.get 2
    i32.const 32
    i32.add
    global.set 0)
  (func (;15;) (type 0) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i64)
    global.get 0
    i32.const 64
    i32.sub
    local.tee 2
    global.set 0
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
        call 27
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
            call 27
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
          call 27
          local.get 2
          i32.load offset=40
          br_if 2 (;@1;)
          local.get 2
          i32.load offset=44
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          i64.load offset=16
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
              call 27
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
              call 27
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
          call 27
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
    global.set 0
    local.get 6)
  (func (;16;) (type 8) (param i64) (result i32)
    (local i32 i32 i32 i64)
    global.get 0
    i32.const 64
    i32.sub
    local.tee 1
    global.set 0
    i32.const 0
    local.set 2
    local.get 1
    i32.const 0
    i32.store offset=12
    local.get 1
    i32.const 16
    i32.add
    call 19
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
          call 29
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
        call 3
        drop
        local.get 1
        i32.const 32
        i32.add
        call 4
        local.get 1
        i32.const 32
        i32.add
        call 4
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.load offset=24
              local.tee 3
              i32.load offset=16
              local.tee 2
              i32.const 48
              i32.lt_u
              br_if 0 (;@5;)
              local.get 2
              i32.const -48
              i32.add
              i32.const -8
              i32.and
              local.tee 2
              local.get 3
              i32.load
              i32.lt_u
              br_if 0 (;@5;)
              local.get 3
              local.get 2
              i32.store offset=16
              local.get 2
              br_if 1 (;@4;)
            end
            local.get 1
            i32.const 16
            i32.add
            i32.const 8
            i32.const 48
            call 23
            local.tee 2
            i32.eqz
            br_if 1 (;@3;)
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
          call 15
          select
          local.set 2
          local.get 1
          i32.const 16
          i32.add
          call 20
          br 2 (;@1;)
        end
        call 22
        unreachable
      end
      local.get 1
      i32.const 16
      i32.add
      call 20
      i32.const -42000001
      local.set 2
    end
    local.get 1
    i32.const 64
    i32.add
    global.set 0
    local.get 2)
  (func (;17;) (type 8) (param i64) (result i32)
    (local i32 i32 i32 i32 i64 i64 i32 i64)
    global.get 0
    i32.const 208
    i32.sub
    local.tee 1
    global.set 0
    local.get 1
    i32.const 0
    i32.store offset=96
    local.get 1
    i32.const 100
    i32.add
    call 19
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
    call 29
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
                    call 29
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
                          call 29
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
                        call 29
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
                        local.get 3
                        br_if 1 (;@9;)
                      end
                      local.get 1
                      i32.const 100
                      i32.add
                      i32.const 8
                      i32.const 16
                      call 23
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
                    call 24
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
                  call 26
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
                          call 24
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
                      call 25
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
                      call 25
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
                    i32.store offset=192
                    local.get 1
                    local.get 1
                    i64.load offset=175 align=1
                    i64.store offset=112
                    local.get 1
                    local.get 1
                    i32.const 155
                    i32.add
                    i32.load align=1
                    i32.store offset=195 align=1
                    local.get 1
                    i64.load offset=159 align=1
                    local.set 6
                    local.get 1
                    i64.load offset=167 align=1
                    local.set 8
                  end
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
                      local.get 2
                      br_if 1 (;@8;)
                    end
                    local.get 1
                    i32.const 100
                    i32.add
                    i32.const 8
                    i32.const 48
                    call 23
                    local.tee 2
                    i32.eqz
                    br_if 1 (;@7;)
                  end
                  local.get 2
                  local.get 7
                  i32.store8
                  local.get 2
                  local.get 1
                  i32.load offset=192
                  i32.store offset=1 align=1
                  local.get 2
                  local.get 8
                  i64.store offset=16
                  local.get 2
                  local.get 6
                  i64.store offset=8
                  local.get 2
                  local.get 1
                  i64.load offset=112
                  i64.store offset=24
                  local.get 2
                  local.get 5
                  i64.store offset=40
                  local.get 2
                  i32.const 4
                  i32.add
                  local.get 1
                  i32.load offset=195 align=1
                  i32.store align=1
                  local.get 2
                  i32.const 32
                  i32.add
                  local.get 1
                  i32.const 120
                  i32.add
                  i64.load
                  i64.store
                  call 3
                  drop
                  local.get 1
                  i32.const 152
                  i32.add
                  call 5
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 1
                        i32.load8_u offset=152
                        local.tee 4
                        br_table 0 (;@10;) 1 (;@9;) 8 (;@2;)
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
                      br 1 (;@8;)
                    end
                    local.get 1
                    local.get 1
                    i64.load offset=161 align=1
                    i64.store offset=128
                    local.get 1
                    local.get 1
                    i64.load offset=153 align=1
                    i64.store offset=120
                  end
                  local.get 1
                  local.get 4
                  i32.store8 offset=112
                  local.get 1
                  i32.const 192
                  i32.add
                  call 6
                  local.get 1
                  i32.const 1
                  i32.store8 offset=152
                  local.get 1
                  local.get 1
                  i64.load offset=200
                  i64.store offset=168
                  local.get 1
                  local.get 1
                  i64.load offset=192
                  i64.store offset=160
                  local.get 1
                  i32.const 112
                  i32.add
                  local.get 1
                  i32.const 152
                  i32.add
                  call 33
                  drop
                  call 7
                  drop
                  local.get 1
                  i32.const 152
                  i32.add
                  call 8
                  local.get 1
                  i32.const 152
                  i32.add
                  call 5
                  local.get 1
                  i32.load8_u offset=152
                  i32.const 2
                  i32.ge_u
                  br_if 5 (;@2;)
                  local.get 1
                  i32.const 152
                  i32.add
                  call 6
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
                                  local.get 4
                                  br_if 5 (;@10;)
                                end
                                local.get 1
                                i32.const 100
                                i32.add
                                i32.const 8
                                i32.const 48
                                call 23
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
                          i32.const 1048588
                          call 72
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
                          local.get 4
                          br_if 1 (;@10;)
                        end
                        local.get 1
                        i32.const 100
                        i32.add
                        i32.const 8
                        i32.const 48
                        call 23
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
                          local.get 2
                          br_if 1 (;@10;)
                        end
                        local.get 1
                        i32.const 100
                        i32.add
                        i32.const 8
                        i32.const 64
                        call 23
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
                      call 28
                      i64.const 2
                      local.set 5
                      local.get 4
                      local.get 1
                      i32.const 96
                      i32.add
                      call 15
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const 152
                      i32.add
                      local.get 2
                      call 14
                      local.get 1
                      i64.load offset=152
                      local.set 5
                      local.get 1
                      i32.const 100
                      i32.add
                      call 20
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
                    call 20
                    br 5 (;@3;)
                  end
                  i32.const 1048604
                  call 72
                  unreachable
                end
                call 22
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
          call 20
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
      call 51
      unreachable
    end
    local.get 1
    i32.const 208
    i32.add
    global.set 0
    local.get 2)
  (func (;18;) (type 1) (param i32 i32)
    local.get 0
    local.get 1
    call 62
    return)
  (func (;19;) (type 6) (param i32)
    local.get 0
    i32.const 1049396
    i32.store offset=8
    local.get 0
    i32.const 0
    i32.store)
  (func (;20;) (type 6) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.const 1049396
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 0
        i32.load offset=12
        local.set 1
        local.get 0
        i32.load
        local.get 0
        i32.load offset=8
        local.get 0
        i32.load offset=4
        call 31
        local.get 1
        local.set 0
        local.get 1
        i32.const 1049396
        i32.ne
        br_if 0 (;@2;)
      end
    end)
  (func (;21;) (type 9)
    (local i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 0
    global.set 0
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1048656
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1048760
    call 67
    unreachable)
  (func (;22;) (type 9)
    (local i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 0
    global.set 0
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1048792
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1048800
    call 67
    unreachable)
  (func (;23;) (type 2) (param i32 i32 i32) (result i32)
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
      i32.load offset=8
      local.tee 4
      i32.load offset=20
      local.tee 7
      i32.sub
      local.set 8
      local.get 6
      local.get 7
      i32.ge_u
      local.set 5
    end
    i32.const 0
    local.set 9
    block  ;; label = @1
      local.get 4
      i32.load offset=8
      i32.const -24
      i32.add
      local.tee 6
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
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
          br_if 0 (;@3;)
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
            block  ;; label = @5
              local.get 10
              i32.popcnt
              i32.const 1
              i32.ne
              br_if 0 (;@5;)
              i32.const -2147483648
              local.get 10
              i32.sub
              local.set 12
              br 1 (;@4;)
            end
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
                  local.get 6
                  local.get 2
                  i32.lt_u
                  br_if 6 (;@1;)
                  block  ;; label = @8
                    local.get 6
                    i32.const 463
                    i32.gt_u
                    br_if 0 (;@8;)
                    local.get 4
                    i32.load offset=20
                    br_if 7 (;@1;)
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
                  br 6 (;@1;)
                end
              end
              loop  ;; label = @6
                i32.const 0
                local.set 9
                local.get 6
                local.get 11
                i32.lt_u
                br_if 5 (;@1;)
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
                br 5 (;@1;)
              end
            end
            local.get 5
            i32.eqz
            br_if 2 (;@2;)
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
                br_if 5 (;@1;)
                local.get 3
                local.set 6
                local.get 3
                local.get 11
                i32.ge_u
                br_if 1 (;@5;)
                br 5 (;@1;)
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
          loop  ;; label = @4
            local.get 3
            i32.const 0
            i32.ne
            local.get 0
            i32.load offset=4
            local.tee 3
            local.get 2
            i32.gt_u
            i32.and
            local.set 13
            local.get 3
            i32.const 464
            i32.lt_u
            local.set 14
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 13
                  local.get 6
                  local.get 2
                  i32.ge_u
                  local.get 14
                  i32.and
                  i32.and
                  br_if 0 (;@7;)
                  local.get 6
                  local.get 11
                  i32.ge_u
                  br_if 1 (;@6;)
                  i32.const 0
                  return
                end
                local.get 0
                i32.load offset=8
                i32.load offset=20
                i32.eqz
                br_if 0 (;@6;)
                local.get 6
                i32.const 464
                i32.ge_u
                br_if 0 (;@6;)
                i32.const 0
                return
              end
              block  ;; label = @6
                block  ;; label = @7
                  local.get 6
                  local.get 7
                  local.get 6
                  local.get 7
                  i32.gt_u
                  select
                  local.tee 3
                  i32.const 4096
                  i32.lt_u
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 3
                    i32.const 4143
                    i32.add
                    local.tee 9
                    local.get 3
                    i32.const 48
                    i32.add
                    i32.ge_u
                    br_if 0 (;@8;)
                    i32.const 0
                    return
                  end
                  local.get 9
                  i32.const -4096
                  i32.and
                  i32.const -48
                  i32.add
                  local.set 3
                  br 1 (;@6;)
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
              br_if 2 (;@3;)
              local.get 6
              i32.const 1
              i32.shr_u
              local.set 6
              local.get 5
              local.get 8
              local.get 3
              i32.lt_u
              i32.and
              br_if 0 (;@5;)
              local.get 12
              local.get 9
              i32.lt_u
              br_if 0 (;@5;)
            end
            i32.const 0
            i32.load8_u offset=1049421
            drop
            block  ;; label = @5
              local.get 9
              local.get 10
              call 30
              local.tee 13
              br_if 0 (;@5;)
              local.get 0
              i32.load
              local.set 3
              br 1 (;@4;)
            end
          end
          local.get 4
          i32.load offset=20
          local.set 7
          local.get 13
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
          local.get 13
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
          br 2 (;@1;)
        end
        call 21
        unreachable
      end
      loop  ;; label = @2
        local.get 6
        i32.const 1
        i32.shr_u
        local.set 3
        block  ;; label = @3
          local.get 6
          local.get 7
          local.get 6
          local.get 7
          i32.gt_u
          select
          local.tee 6
          i32.const 4096
          i32.lt_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 9
          local.get 6
          i32.const 4143
          i32.add
          i32.const 4095
          i32.lt_u
          br_if 2 (;@1;)
          local.get 3
          local.set 6
          local.get 3
          local.get 11
          i32.ge_u
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 3
        local.set 6
        local.get 3
        local.get 11
        i32.ge_u
        br_if 0 (;@2;)
      end
      i32.const 0
      return
    end
    local.get 9)
  (func (;24;) (type 10) (param i32 i32 i32 i32)
    (local i32)
    local.get 1
    i32.load
    local.set 4
    local.get 1
    local.get 4
    local.get 2
    local.get 3
    local.get 4
    call 10
    local.tee 3
    i32.add
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func (;25;) (type 1) (param i32 i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
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
    call 10
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
    global.set 0)
  (func (;26;) (type 1) (param i32 i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
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
    call 10
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
    global.set 0)
  (func (;27;) (type 10) (param i32 i32 i32 i32)
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
      call 11
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
  (func (;28;) (type 1) (param i32 i32)
    block  ;; label = @1
      call 9
      local.get 1
      i32.le_u
      br_if 0 (;@1;)
      local.get 1
      call 12
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
  (func (;29;) (type 10) (param i32 i32 i32 i32)
    (local i32)
    local.get 1
    i32.load
    local.set 4
    local.get 1
    local.get 4
    local.get 2
    local.get 3
    local.get 4
    call 13
    local.tee 3
    i32.add
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func (;30;) (type 0) (param i32 i32) (result i32)
    i32.const 1049424
    local.get 1
    local.get 0
    call 38)
  (func (;31;) (type 11) (param i32 i32 i32)
    i32.const 1049424
    local.get 0
    local.get 2
    local.get 1
    call 39)
  (func (;32;) (type 12) (param i32 i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 1049424
      local.get 2
      local.get 3
      call 38
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
      call 79
      drop
      i32.const 1049424
      local.get 0
      local.get 2
      local.get 1
      call 39
    end
    local.get 4)
  (func (;33;) (type 0) (param i32 i32) (result i32)
    (local i32 i32)
    local.get 1
    i32.load8_u
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load8_u
        br_if 0 (;@2;)
        i32.const 0
        local.set 3
        local.get 2
        i32.const 255
        i32.and
        br_if 1 (;@1;)
        local.get 0
        i32.const 1
        i32.add
        local.get 1
        i32.const 1
        i32.add
        i32.const 32
        call 80
        i32.eqz
        return
      end
      i32.const 0
      local.set 3
      local.get 2
      i32.const 255
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i64.load offset=8
      local.get 1
      i64.load offset=8
      i64.ne
      br_if 0 (;@1;)
      local.get 0
      i64.load offset=16
      local.get 1
      i64.load offset=16
      i64.eq
      local.set 3
    end
    local.get 3)
  (func (;34;) (type 10) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 4
    global.set 0
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
          i32.const 1
          i32.const 1
          call 36
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
          br_if 0 (;@3;)
          local.get 5
          local.get 4
          i32.load offset=12
          i32.store
          i32.const 1
          local.set 7
          i32.const 0
          local.set 8
          br 2 (;@1;)
        end
        i32.const 0
        local.set 8
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
        i32.const 1
        local.set 7
        local.get 2
        i32.const 4
        local.get 4
        i32.const 12
        i32.add
        i32.const 1
        i32.const 1
        call 36
        local.set 1
        local.get 5
        local.get 4
        i32.load offset=12
        i32.store
        local.get 1
        i32.eqz
        br_if 1 (;@1;)
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
      local.set 7
      local.get 1
      local.set 8
    end
    local.get 0
    local.get 8
    i32.store offset=4
    local.get 0
    local.get 7
    i32.store
    local.get 4
    i32.const 16
    i32.add
    global.set 0)
  (func (;35;) (type 0) (param i32 i32) (result i32)
    i32.const 512)
  (func (;36;) (type 13) (param i32 i32 i32 i32 i32) (result i32)
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
    loop  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 5
          i32.load offset=8
          local.tee 1
          i32.const 1
          i32.and
          br_if 0 (;@3;)
          local.get 5
          i32.const 8
          i32.add
          local.set 9
          br 1 (;@2;)
        end
        loop  ;; label = @3
          local.get 5
          local.get 1
          i32.const -2
          i32.and
          i32.store offset=8
          block  ;; label = @4
            block  ;; label = @5
              local.get 5
              i32.load offset=4
              local.tee 10
              i32.const -4
              i32.and
              local.tee 9
              br_if 0 (;@5;)
              i32.const 0
              local.set 11
              br 1 (;@4;)
            end
            i32.const 0
            local.get 9
            local.get 9
            i32.load8_u
            i32.const 1
            i32.and
            select
            local.set 11
          end
          block  ;; label = @4
            local.get 5
            i32.load
            local.tee 1
            i32.const -4
            i32.and
            local.tee 12
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 2
            i32.and
            br_if 0 (;@4;)
            local.get 12
            local.get 12
            i32.load offset=4
            i32.const 3
            i32.and
            local.get 9
            i32.or
            i32.store offset=4
            local.get 5
            i32.load offset=4
            local.tee 10
            i32.const -4
            i32.and
            local.set 9
            local.get 5
            i32.load
            local.set 1
          end
          block  ;; label = @4
            local.get 9
            i32.eqz
            br_if 0 (;@4;)
            local.get 9
            local.get 9
            i32.load
            i32.const 3
            i32.and
            local.get 1
            i32.const -4
            i32.and
            i32.or
            i32.store
            local.get 5
            i32.load offset=4
            local.set 10
            local.get 5
            i32.load
            local.set 1
          end
          local.get 5
          local.get 10
          i32.const 3
          i32.and
          i32.store offset=4
          local.get 5
          local.get 1
          i32.const 3
          i32.and
          i32.store
          block  ;; label = @4
            local.get 1
            i32.const 2
            i32.and
            i32.eqz
            br_if 0 (;@4;)
            local.get 11
            local.get 11
            i32.load
            i32.const 2
            i32.or
            i32.store
          end
          local.get 2
          local.get 11
          i32.store
          local.get 11
          local.set 5
          local.get 11
          i32.load offset=8
          local.tee 1
          i32.const 1
          i32.and
          br_if 0 (;@3;)
        end
        local.get 11
        i32.const 8
        i32.add
        local.set 9
        local.get 11
        local.set 5
      end
      block  ;; label = @2
        local.get 5
        i32.load
        i32.const -4
        i32.and
        local.tee 11
        local.get 9
        i32.sub
        local.get 8
        i32.lt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 9
            local.get 3
            local.get 0
            local.get 4
            call_indirect (type 0)
            i32.const 2
            i32.shl
            i32.add
            i32.const 8
            i32.add
            local.get 11
            local.get 8
            i32.sub
            local.get 7
            i32.and
            local.tee 1
            i32.le_u
            br_if 0 (;@4;)
            local.get 9
            i32.load
            local.set 1
            local.get 6
            local.get 9
            i32.and
            br_if 2 (;@2;)
            local.get 2
            local.get 1
            i32.const -4
            i32.and
            i32.store
            local.get 5
            i32.load
            local.set 9
            local.get 5
            local.set 1
            br 1 (;@3;)
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
            local.tee 12
            i32.const -4
            i32.and
            local.tee 10
            i32.eqz
            br_if 0 (;@4;)
            local.get 12
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
          local.get 9
          local.get 9
          i32.load
          i32.const -2
          i32.and
          i32.store
          local.get 5
          local.get 5
          i32.load
          local.tee 9
          i32.const 3
          i32.and
          local.get 1
          i32.or
          local.tee 11
          i32.store
          block  ;; label = @4
            local.get 9
            i32.const 2
            i32.and
            br_if 0 (;@4;)
            local.get 1
            i32.load
            local.set 9
            br 1 (;@3;)
          end
          local.get 5
          local.get 11
          i32.const -3
          i32.and
          i32.store
          local.get 1
          i32.load
          i32.const 2
          i32.or
          local.set 9
        end
        local.get 1
        local.get 9
        i32.const 1
        i32.or
        i32.store
        local.get 1
        i32.const 8
        i32.add
        return
      end
      local.get 2
      local.get 1
      i32.store
      local.get 1
      local.set 5
      local.get 1
      br_if 0 (;@1;)
    end
    i32.const 0)
  (func (;37;) (type 0) (param i32 i32) (result i32)
    local.get 1)
  (func (;38;) (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 3
    global.set 0
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
        local.get 1
        i32.const 4
        i32.gt_u
        br_if 0 (;@2;)
        local.get 5
        i32.const -1
        i32.add
        local.tee 2
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
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
        block  ;; label = @3
          local.get 5
          local.get 1
          local.get 3
          i32.const 12
          i32.add
          local.get 3
          i32.const 8
          i32.add
          i32.const 2
          call 36
          local.tee 2
          br_if 0 (;@3;)
          local.get 3
          local.get 3
          i32.const 8
          i32.add
          local.get 5
          local.get 3
          call 34
          i32.const 0
          local.set 2
          local.get 3
          i32.load
          br_if 0 (;@3;)
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
          call 36
          local.set 2
        end
        local.get 0
        local.get 3
        i32.load offset=12
        i32.store
        br 1 (;@1;)
      end
      local.get 3
      local.get 0
      i32.load offset=1024
      i32.store offset=12
      block  ;; label = @2
        local.get 5
        local.get 1
        local.get 3
        i32.const 12
        i32.add
        i32.const 1048816
        i32.const 1
        call 36
        local.tee 2
        br_if 0 (;@2;)
        block  ;; label = @3
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
          br_if 0 (;@3;)
          i32.const 0
          local.set 2
          br 1 (;@2;)
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
        i32.const 1048816
        i32.const 1
        call 36
        local.set 2
      end
      local.get 0
      local.get 3
      i32.load offset=12
      i32.store offset=1024
    end
    local.get 3
    i32.const 16
    i32.add
    global.set 0
    local.get 2)
  (func (;39;) (type 10) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 4
        i32.gt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 3
        i32.add
        i32.const 2
        i32.shr_u
        i32.const -1
        i32.add
        local.tee 3
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
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
        return
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
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.const 4
                  i32.add
                  local.tee 6
                  i32.load
                  i32.const -4
                  i32.and
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 7
                  i32.load
                  local.tee 8
                  i32.const 1
                  i32.and
                  i32.eqz
                  br_if 1 (;@6;)
                end
                local.get 2
                i32.const -4
                i32.and
                local.tee 7
                i32.eqz
                br_if 3 (;@3;)
                local.get 2
                i32.const 2
                i32.and
                i32.eqz
                br_if 1 (;@5;)
                br 3 (;@3;)
              end
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
            local.get 7
            i32.load8_u
            i32.const 1
            i32.and
            br_if 1 (;@3;)
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
          local.get 4
          local.set 3
          br 1 (;@2;)
        end
        local.get 1
        local.get 4
        i32.store
      end
      local.get 0
      local.get 3
      i32.store offset=1024
    end)
  (func (;40;) (type 1) (param i32 i32)
    local.get 0
    i64.const 5041207419464534576
    i64.store offset=8
    local.get 0
    i64.const -5105653475403511251
    i64.store)
  (func (;41;) (type 1) (param i32 i32)
    local.get 0
    i64.const 7199936582794304877
    i64.store offset=8
    local.get 0
    i64.const -5076933981314334344
    i64.store)
  (func (;42;) (type 1) (param i32 i32)
    local.get 0
    i64.const -8484938609489840307
    i64.store offset=8
    local.get 0
    i64.const -6823977629611271971
    i64.store)
  (func (;43;) (type 11) (param i32 i32 i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 3
    global.set 0
    block  ;; label = @1
      local.get 1
      local.get 2
      i32.add
      local.tee 2
      local.get 1
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 0
      call 65
      unreachable
    end
    i32.const 1
    local.set 4
    local.get 0
    i32.load
    local.tee 5
    i32.const 1
    i32.shl
    local.tee 1
    local.get 2
    local.get 1
    local.get 2
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
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 3
      local.get 5
      i32.store offset=28
      local.get 3
      local.get 0
      i32.load offset=4
      i32.store offset=20
    end
    local.get 3
    local.get 4
    i32.store offset=24
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    local.get 1
    local.get 3
    i32.const 20
    i32.add
    call 50
    block  ;; label = @1
      local.get 3
      i32.load offset=8
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=12
      local.get 3
      i32.load offset=16
      call 65
      unreachable
    end
    local.get 3
    i32.load offset=12
    local.set 2
    local.get 0
    local.get 1
    i32.store
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 3
    i32.const 32
    i32.add
    global.set 0)
  (func (;44;) (type 0) (param i32 i32) (result i32)
    local.get 0
    i32.const 1048816
    local.get 1
    call 70)
  (func (;45;) (type 6) (param i32)
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
      call 31
    end)
  (func (;46;) (type 6) (param i32)
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
      call 31
    end)
  (func (;47;) (type 0) (param i32 i32) (result i32)
    (local i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
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
            call 48
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
        call 43
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
      call 79
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
    global.set 0
    i32.const 0)
  (func (;48;) (type 6) (param i32)
    (local i32 i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 1
    global.set 0
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 2
      i32.const 1
      i32.add
      local.tee 3
      br_if 0 (;@1;)
      i32.const 0
      i32.const 0
      call 65
      unreachable
    end
    local.get 2
    i32.const 1
    i32.shl
    local.tee 4
    local.get 3
    local.get 4
    local.get 3
    i32.gt_u
    select
    local.tee 3
    i32.const 8
    local.get 3
    i32.const 8
    i32.gt_u
    select
    local.tee 3
    i32.const -1
    i32.xor
    i32.const 31
    i32.shr_u
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      local.get 1
      local.get 2
      i32.store offset=28
      local.get 1
      local.get 0
      i32.load offset=4
      i32.store offset=20
      i32.const 1
      local.set 2
    end
    local.get 1
    local.get 2
    i32.store offset=24
    local.get 1
    i32.const 8
    i32.add
    local.get 4
    local.get 3
    local.get 1
    i32.const 20
    i32.add
    call 50
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=12
      local.get 1
      i32.load offset=16
      call 65
      unreachable
    end
    local.get 1
    i32.load offset=12
    local.set 2
    local.get 0
    local.get 3
    i32.store
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 1
    i32.const 32
    i32.add
    global.set 0)
  (func (;49;) (type 2) (param i32 i32 i32) (result i32)
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
      call 43
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
    call 79
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func (;50;) (type 10) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          i32.const 0
          i32.lt_s
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
                  i32.load offset=8
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
                  i32.load8_u offset=1049421
                  drop
                  br 2 (;@5;)
                end
                local.get 3
                i32.load
                local.get 4
                local.get 1
                local.get 2
                call 32
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
              i32.load8_u offset=1049421
              drop
            end
            local.get 2
            local.get 1
            call 30
            local.set 3
          end
          block  ;; label = @4
            local.get 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            local.get 2
            i32.store offset=8
            local.get 0
            local.get 3
            i32.store offset=4
            local.get 0
            i32.const 0
            i32.store
            return
          end
          local.get 0
          local.get 2
          i32.store offset=8
          local.get 0
          local.get 1
          i32.store offset=4
          br 2 (;@1;)
        end
        local.get 0
        i32.const 0
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      i32.store offset=4
    end
    local.get 0
    i32.const 1
    i32.store)
  (func (;51;) (type 9)
    unreachable
    unreachable)
  (func (;52;) (type 6) (param i32)
    local.get 0
    call 53
    unreachable)
  (func (;53;) (type 6) (param i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    global.set 0
    local.get 0
    i32.load
    local.tee 2
    i32.load offset=12
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            br_table 0 (;@4;) 1 (;@3;) 2 (;@2;)
          end
          local.get 3
          br_if 1 (;@2;)
          i32.const 1
          local.set 2
          i32.const 0
          local.set 3
          br 2 (;@1;)
        end
        local.get 3
        br_if 0 (;@2;)
        local.get 2
        i32.load
        local.tee 2
        i32.load offset=4
        local.set 3
        local.get 2
        i32.load
        local.set 2
        br 1 (;@1;)
      end
      local.get 1
      local.get 2
      i32.store offset=12
      local.get 1
      i32.const -2147483648
      i32.store
      local.get 1
      i32.const 1049028
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
      call 60
      unreachable
    end
    local.get 1
    local.get 3
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1049008
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
    call 60
    unreachable)
  (func (;54;) (type 1) (param i32 i32)
    (local i32)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 2
    global.set 0
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1049420
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 2
      i32.store offset=12
      local.get 2
      i32.const 1048876
      i32.store offset=8
      local.get 2
      i64.const 1
      i64.store offset=20 align=4
      local.get 2
      local.get 1
      i32.store offset=44
      local.get 2
      i32.const 3
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 44
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 2
      i32.const 8
      i32.add
      i32.const 1048916
      call 67
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set 0)
  (func (;55;) (type 6) (param i32)
    (local i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    global.set 0
    block  ;; label = @1
      local.get 0
      i32.load offset=8
      local.tee 2
      br_if 0 (;@1;)
      i32.const 1048960
      call 72
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
    call 52
    unreachable)
  (func (;56;) (type 1) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 2
    global.set 0
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
      i32.const 1048816
      local.get 3
      call 70
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
    i32.load8_u offset=1049421
    drop
    local.get 2
    local.get 5
    i64.store offset=8
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call 30
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call 66
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
    i32.const 1048976
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set 0)
  (func (;57;) (type 1) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 2
    global.set 0
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
      i32.const 1048816
      local.get 3
      call 70
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
    i32.const 1048976
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set 0)
  (func (;58;) (type 1) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1049421
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
      call 30
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 8
      call 66
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1048992
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func (;59;) (type 1) (param i32 i32)
    local.get 0
    i32.const 1048992
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func (;60;) (type 14) (param i32 i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 6
    global.set 0
    i32.const 0
    i32.const 0
    i32.load offset=1050468
    local.tee 7
    i32.const 1
    i32.add
    i32.store offset=1050468
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.load8_u offset=1050476
        i32.const 255
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        i32.const 1
        i32.store8 offset=1050476
        i32.const 0
        i32.const 0
        i32.load offset=1050472
        i32.const 1
        i32.add
        i32.store offset=1050472
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
        i32.const 1049048
        i32.store offset=16
        local.get 6
        i32.const 1
        i32.store offset=12
        i32.const 0
        i32.load offset=1050456
        local.tee 7
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 7
        i32.const 1
        i32.add
        i32.store offset=1050456
        block  ;; label = @3
          i32.const 0
          i32.load offset=1050460
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
          i32.load offset=1050460
          local.get 6
          i32.const 12
          i32.add
          i32.const 0
          i32.load offset=1050464
          i32.load offset=20
          call_indirect (type 1)
          i32.const 0
          i32.load offset=1050456
          i32.const -1
          i32.add
          local.set 7
        end
        i32.const 0
        local.get 7
        i32.store offset=1050456
        i32.const 0
        i32.const 0
        i32.store8 offset=1050476
        local.get 4
        br_if 1 (;@1;)
      end
      unreachable
      unreachable
    end
    local.get 0
    local.get 1
    call 61
    unreachable)
  (func (;61;) (type 1) (param i32 i32)
    local.get 0
    local.get 1
    call 63
    drop
    unreachable
    unreachable)
  (func (;62;) (type 1) (param i32 i32)
    (local i32)
    local.get 1
    local.get 0
    i32.const 0
    i32.load offset=1050452
    local.tee 2
    i32.const 4
    local.get 2
    select
    call_indirect (type 1)
    unreachable
    unreachable)
  (func (;63;) (type 0) (param i32 i32) (result i32)
    unreachable
    unreachable)
  (func (;64;) (type 9)
    (local i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 0
    global.set 0
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1049084
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1049120
    call 67
    unreachable)
  (func (;65;) (type 1) (param i32 i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      call 64
      unreachable
    end
    local.get 0
    local.get 1
    call 66
    unreachable)
  (func (;66;) (type 1) (param i32 i32)
    local.get 1
    local.get 0
    call 18
    unreachable)
  (func (;67;) (type 1) (param i32 i32)
    (local i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 2
    global.set 0
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
    i32.const 1049180
    i32.store offset=16
    local.get 2
    i32.const 1
    i32.store offset=12
    local.get 2
    i32.const 12
    i32.add
    call 55
    unreachable)
  (func (;68;) (type 11) (param i32 i32 i32)
    (local i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 3
    global.set 0
    local.get 3
    i32.const 0
    i32.store offset=16
    local.get 3
    i32.const 1
    i32.store offset=4
    local.get 3
    i64.const 4
    i64.store offset=8 align=4
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
    call 67
    unreachable)
  (func (;69;) (type 0) (param i32 i32) (result i32)
    local.get 0
    i64.load32_u
    i32.const 1
    local.get 1
    call 76)
  (func (;70;) (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 3
    global.set 0
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
    local.get 1
    i32.store offset=36
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
              i32.load offset=12
              local.tee 0
              i32.eqz
              br_if 1 (;@4;)
              local.get 2
              i32.load offset=8
              local.set 1
              local.get 0
              i32.const 3
              i32.shl
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
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load offset=32
                  local.get 0
                  i32.load
                  local.get 7
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
                i32.load offset=4
                call_indirect (type 0)
                br_if 3 (;@3;)
                local.get 1
                i32.const 8
                i32.add
                local.set 1
                local.get 0
                i32.const 8
                i32.add
                local.set 0
                local.get 6
                i32.const -8
                i32.add
                local.tee 6
                br_if 0 (;@6;)
                br 2 (;@4;)
              end
            end
            local.get 2
            i32.load offset=20
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 5
            i32.shl
            local.set 8
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
            local.set 9
            local.get 2
            i32.load
            local.set 0
            i32.const 0
            local.set 6
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
              local.get 6
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
              local.set 7
              i32.const 0
              local.set 10
              i32.const 0
              local.set 11
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 8
                    i32.add
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 7
                  i32.const 3
                  i32.shl
                  local.set 12
                  i32.const 0
                  local.set 11
                  local.get 9
                  local.get 12
                  i32.add
                  local.tee 12
                  i32.load offset=4
                  br_if 1 (;@6;)
                  local.get 12
                  i32.load
                  local.set 7
                end
                i32.const 1
                local.set 11
              end
              local.get 3
              local.get 7
              i32.store offset=16
              local.get 3
              local.get 11
              i32.store offset=12
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.set 7
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 7
                  i32.const 3
                  i32.shl
                  local.set 11
                  local.get 9
                  local.get 11
                  i32.add
                  local.tee 11
                  i32.load offset=4
                  br_if 1 (;@6;)
                  local.get 11
                  i32.load
                  local.set 7
                end
                i32.const 1
                local.set 10
              end
              local.get 3
              local.get 7
              i32.store offset=24
              local.get 3
              local.get 10
              i32.store offset=20
              local.get 9
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
              i32.load offset=4
              call_indirect (type 0)
              br_if 2 (;@3;)
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 8
              local.get 6
              i32.const 32
              i32.add
              local.tee 6
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
    global.set 0
    local.get 1)
  (func (;71;) (type 1) (param i32 i32)
    local.get 0
    i64.const -8484938609489840307
    i64.store offset=8
    local.get 0
    i64.const -6823977629611271971
    i64.store)
  (func (;72;) (type 6) (param i32)
    i32.const 1049136
    i32.const 43
    local.get 0
    call 68
    unreachable)
  (func (;73;) (type 15) (param i32 i32 i32 i32 i32 i32) (result i32)
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
          call 74
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
          i32.const 12
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
        call 75
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
        call 75
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
        call 75
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
      i32.load offset=16
      local.set 9
      local.get 0
      i32.load offset=24
      local.set 12
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
      call 75
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
  (func (;74;) (type 0) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
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
              local.get 0
              local.get 2
              i32.sub
              local.tee 8
              i32.const -4
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 9
              br 1 (;@4;)
            end
            i32.const 0
            local.set 9
            loop  ;; label = @5
              local.get 1
              local.get 0
              local.get 9
              i32.add
              local.tee 2
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 9
              i32.const 4
              i32.add
              local.tee 9
              br_if 0 (;@5;)
            end
          end
          local.get 7
          br_if 0 (;@3;)
          local.get 0
          local.get 9
          i32.add
          local.set 2
          loop  ;; label = @4
            local.get 1
            local.get 2
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            local.get 8
            i32.const 1
            i32.add
            local.tee 8
            br_if 0 (;@4;)
          end
        end
        local.get 0
        local.get 3
        i32.add
        local.set 9
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 9
          local.get 4
          i32.const -4
          i32.and
          i32.add
          local.tee 2
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
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
          local.get 2
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
        local.set 8
        loop  ;; label = @3
          local.get 9
          local.set 4
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.const 192
          local.get 3
          i32.const 192
          i32.lt_u
          select
          local.tee 6
          i32.const 3
          i32.and
          local.set 7
          local.get 6
          i32.const 2
          i32.shl
          local.set 5
          i32.const 0
          local.set 2
          block  ;; label = @4
            local.get 3
            i32.const 4
            i32.lt_u
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            i32.const 1008
            i32.and
            i32.add
            local.set 0
            i32.const 0
            local.set 2
            local.get 4
            local.set 1
            loop  ;; label = @5
              local.get 1
              i32.load offset=12
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
              i32.load offset=4
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
              i32.load
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
              local.get 2
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 2
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
          local.get 6
          i32.sub
          local.set 3
          local.get 4
          local.get 5
          i32.add
          local.set 9
          local.get 2
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 2
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 8
          i32.add
          local.set 8
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 4
        local.get 6
        i32.const 252
        i32.and
        i32.const 2
        i32.shl
        i32.add
        local.tee 2
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
          local.get 7
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=4
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
          local.get 7
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=8
          local.tee 2
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 2
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
        local.get 8
        i32.add
        return
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
      local.set 9
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          i32.const 0
          local.set 2
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 3
        i32.const 0
        local.set 8
        i32.const 0
        local.set 2
        loop  ;; label = @3
          local.get 8
          local.get 0
          local.get 2
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
          local.set 8
          local.get 3
          local.get 2
          i32.const 4
          i32.add
          local.tee 2
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 9
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 8
        local.get 1
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 8
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 9
        i32.const -1
        i32.add
        local.tee 9
        br_if 0 (;@2;)
      end
    end
    local.get 8)
  (func (;75;) (type 13) (param i32 i32 i32 i32 i32) (result i32)
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
  (func (;76;) (type 16) (param i64 i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 3
    global.set 0
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
        i32.const 1049196
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
        i32.const 1049196
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
      i32.const 1049196
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
        i32.const 1049196
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
      i32.or
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1
    i32.const 0
    local.get 3
    i32.const 9
    i32.add
    local.get 4
    i32.add
    i32.const 39
    local.get 4
    i32.sub
    call 73
    local.set 4
    local.get 3
    i32.const 48
    i32.add
    global.set 0
    local.get 4)
  (func (;77;) (type 2) (param i32 i32 i32) (result i32)
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
  (func (;78;) (type 2) (param i32 i32 i32) (result i32)
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
  (func (;79;) (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call 77)
  (func (;80;) (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call 78)
  (table (;0;) 18 18 funcref)
  (memory (;0;) 17)
  (global (;0;) (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1050477))
  (global (;2;) i32 (i32.const 1050480))
  (export "memory" (memory 0))
  (export "init_counter" (func 16))
  (export "counter.counter_receive" (func 17))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func 35 37 69 54 45 49 47 44 40 41 58 59 46 56 57 42 71)
  (data (;0;) (i32.const 1048576) "src/lib.rs\00\00\00\00\10\00\0a\00\00\00\1c\01\00\00<\00\00\00\00\00\10\00\0a\00\00\00]\01\00\00<\00\00\00requested allocation size overflowed,\00\10\00$\00\00\00/home/wolfgang/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bumpalo-3.16.0/src/lib.rs\00\00\00X\00\10\00]\00\00\00\ea\01\00\00\05\00\00\00out of memory\00\00\00\c8\00\10\00\0d\00\00\00X\00\10\00]\00\00\00m\07\00\00\05\00\00\00\05\00\00\00\0c\00\00\00\04\00\00\00\06\00\00\00\07\00\00\00\08\00\00\00memory allocation of  bytes failed\00\00\08\01\10\00\15\00\00\00\1d\01\10\00\0d\00\00\00library/std/src/alloc.rs<\01\10\00\18\00\00\00b\01\00\00\09\00\00\00library/std/src/panicking.rsd\01\10\00\1c\00\00\00\8b\02\00\00\1e\00\00\00\05\00\00\00\0c\00\00\00\04\00\00\00\09\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\0a\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\0b\00\00\00\0c\00\00\00\0d\00\00\00\10\00\00\00\04\00\00\00\0e\00\00\00\0f\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\10\00\00\00capacity overflow\00\00\00\e8\01\10\00\11\00\00\00library/alloc/src/raw_vec.rs\04\02\10\00\1c\00\00\00\19\00\00\00\05\00\00\00called `Option::unwrap()` on a `None` value\00\00\00\00\00\00\00\00\00\01\00\00\00\11\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899")
  (data (;1;) (i32.const 1049396) "4\03\10\00\04\00\00\00\18\00\00\004\03\10\004\03\10\00\00\00\00\00"))
