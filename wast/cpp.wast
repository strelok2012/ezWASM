(module
 (type $FUNCSIG$fi (func (param i32) (result f32)))
 (type $FUNCSIG$vi (func (param i32)))
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$ii (func (param i32) (result i32)))
 (import "env" "_ZdlPv" (func $_ZdlPv (param i32)))
 (import "env" "import_function" (func $import_function (param i32)))
 (import "js" "tbl" (table 11 11 anyfunc))
 (elem (i32.const 0) $__wasm_nullptr $_ZN4Vec3D2Ev $_ZN4Vec3D0Ev $_ZNK4Vec35indexEv $_ZNK4Vec37sq_distEv $_ZNK4Vec34getXEv $_ZNK4Vec34getYEv $_ZN4SizeD2Ev $_ZN4SizeD0Ev $_ZNK4Size8getWidthEv $_ZNK4Size9getHeightEv)
 (memory (import "js" "mem") 1)
 (data (i32.const 12) "\00\00\00\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00\05\00\00\00\06\00\00\00")
 (data (i32.const 44) "\00\00\00\00\00\00\00\00\07\00\00\00\08\00\00\00\t\00\00\00\n\00\00\00")
 (export "memory" (memory $0))
 (export "_Z8makeVec3fff" (func $_Z8makeVec3fff))
 (export "_Z10vec3SqDistRK4Vec3" (func $_Z10vec3SqDistRK4Vec3))
 (export "_Z9vec3IndexRK4Vec3" (func $_Z9vec3IndexRK4Vec3))
 (export "_Z8makeSizeff" (func $_Z8makeSizeff))
 (export "_Z12getSizeWidthRK4Size" (func $_Z12getSizeWidthRK4Size))
 (export "_Z13getSizeHeightRK4Size" (func $_Z13getSizeHeightRK4Size))
 (export "export_function" (func $export_function))
 (export "header_function" (func $header_function))
 (func $_Z8makeVec3fff (; 2 ;) (param $0 i32) (param $1 f32) (param $2 f32) (param $3 f32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (set_local $4
   (i32.const 12)
  )
  (set_local $5
   (i32.const 8)
  )
  (set_local $6
   (i32.add
    (get_local $4)
    (get_local $5)
   )
  )
  (set_local $7
   (get_local $6)
  )
  (i32.store
   (get_local $0)
   (get_local $7)
  )
  (f32.store offset=4
   (get_local $0)
   (get_local $1)
  )
  (f32.store offset=8
   (get_local $0)
   (get_local $2)
  )
  (f32.store offset=12
   (get_local $0)
   (get_local $3)
  )
  (return)
 )
 (func $_ZN4Vec3D2Ev (; 3 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (return
   (get_local $0)
  )
 )
 (func $_ZN4Vec3D0Ev (; 4 ;) (type $FUNCSIG$vi) (param $0 i32)
  (call $_ZdlPv
   (get_local $0)
  )
  (return)
 )
 (func $_ZNK4Vec35indexEv (; 5 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 f32)
  (local $3 f32)
  (local $4 f32)
  (local $5 f32)
  (local $6 f32)
  (local $7 f32)
  (local $8 f32)
  (set_local $8
   (f32.load offset=4
    (get_local $0)
   )
  )
  (set_local $7
   (f32.mul
    (get_local $8)
    (get_local $8)
   )
  )
  (set_local $6
   (f32.load offset=8
    (get_local $0)
   )
  )
  (set_local $5
   (f32.mul
    (get_local $6)
    (get_local $6)
   )
  )
  (set_local $4
   (f32.add
    (get_local $7)
    (get_local $5)
   )
  )
  (set_local $3
   (f32.load offset=12
    (get_local $0)
   )
  )
  (set_local $2
   (f32.mul
    (get_local $3)
    (get_local $3)
   )
  )
  (set_local $1
   (f32.add
    (get_local $4)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_ZNK4Vec37sq_distEv (; 6 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 f32)
  (local $3 f32)
  (local $4 f32)
  (local $5 f32)
  (local $6 f32)
  (local $7 f32)
  (local $8 f32)
  (set_local $8
   (f32.load offset=4
    (get_local $0)
   )
  )
  (set_local $7
   (f32.mul
    (get_local $8)
    (get_local $8)
   )
  )
  (set_local $6
   (f32.load offset=8
    (get_local $0)
   )
  )
  (set_local $5
   (f32.mul
    (get_local $6)
    (get_local $6)
   )
  )
  (set_local $4
   (f32.add
    (get_local $7)
    (get_local $5)
   )
  )
  (set_local $3
   (f32.load offset=12
    (get_local $0)
   )
  )
  (set_local $2
   (f32.mul
    (get_local $3)
    (get_local $3)
   )
  )
  (set_local $1
   (f32.add
    (get_local $4)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_ZNK4Vec34getXEv (; 7 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (set_local $1
   (f32.load offset=4
    (get_local $0)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_ZNK4Vec34getYEv (; 8 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (set_local $1
   (f32.load offset=8
    (get_local $0)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_Z10vec3SqDistRK4Vec3 (; 9 ;) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 i32)
  (local $3 i32)
  (set_local $3
   (i32.load
    (get_local $0)
   )
  )
  (set_local $2
   (i32.load offset=12
    (get_local $3)
   )
  )
  (set_local $1
   (call_indirect (type $FUNCSIG$fi)
    (get_local $0)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_Z9vec3IndexRK4Vec3 (; 10 ;) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 i32)
  (local $3 i32)
  (set_local $3
   (i32.load
    (get_local $0)
   )
  )
  (set_local $2
   (i32.load offset=8
    (get_local $3)
   )
  )
  (set_local $1
   (call_indirect (type $FUNCSIG$fi)
    (get_local $0)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_Z8makeSizeff (; 11 ;) (param $0 i32) (param $1 f32) (param $2 f32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (set_local $3
   (i32.const 44)
  )
  (set_local $4
   (i32.const 8)
  )
  (set_local $5
   (i32.add
    (get_local $3)
    (get_local $4)
   )
  )
  (set_local $6
   (get_local $5)
  )
  (i32.store
   (get_local $0)
   (get_local $6)
  )
  (f32.store offset=4
   (get_local $0)
   (get_local $1)
  )
  (f32.store offset=8
   (get_local $0)
   (get_local $2)
  )
  (return)
 )
 (func $_ZN4SizeD2Ev (; 12 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (return
   (get_local $0)
  )
 )
 (func $_ZN4SizeD0Ev (; 13 ;) (type $FUNCSIG$vi) (param $0 i32)
  (call $_ZdlPv
   (get_local $0)
  )
  (return)
 )
 (func $_ZNK4Size8getWidthEv (; 14 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (set_local $1
   (f32.load offset=4
    (get_local $0)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_ZNK4Size9getHeightEv (; 15 ;) (type $FUNCSIG$fi) (param $0 i32) (result f32)
  (local $1 f32)
  (set_local $1
   (f32.load offset=8
    (get_local $0)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_Z12getSizeWidthRK4Size (; 16 ;) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 i32)
  (local $3 i32)
  (set_local $3
   (i32.load
    (get_local $0)
   )
  )
  (set_local $2
   (i32.load offset=8
    (get_local $3)
   )
  )
  (set_local $1
   (call_indirect (type $FUNCSIG$fi)
    (get_local $0)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $_Z13getSizeHeightRK4Size (; 17 ;) (param $0 i32) (result f32)
  (local $1 f32)
  (local $2 i32)
  (local $3 i32)
  (set_local $3
   (i32.load
    (get_local $0)
   )
  )
  (set_local $2
   (i32.load offset=12
    (get_local $3)
   )
  )
  (set_local $1
   (call_indirect (type $FUNCSIG$fi)
    (get_local $0)
    (get_local $2)
   )
  )
  (return
   (get_local $1)
  )
 )
 (func $export_function (; 18 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (set_local $3
   (call $header_function
    (get_local $0)
   )
  )
  (call $import_function
   (get_local $3)
  )
  (set_local $1
   (i32.const 1)
  )
  (set_local $2
   (i32.add
    (get_local $0)
    (get_local $1)
   )
  )
  (return
   (get_local $2)
  )
 )
 (func $header_function (; 19 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (set_local $1
   (i32.const 3)
  )
  (set_local $2
   (i32.mul
    (get_local $0)
    (get_local $1)
   )
  )
  (return
   (get_local $2)
  )
 )
 (func $__wasm_nullptr (; 20 ;) (type $FUNCSIG$v)
  (unreachable)
 )
)
