(module
    (func $i32.log (import "debug" "log") (param i32))
    (func $i32.log_tee (import "debug" "log_tee") (param i32) (result i32))
    ;; No i64 interop with JS yet - but maybe coming with WebAssembly BigInt
    ;; So we can instead fake this by splitting the i64 into two i32 limbs,
    ;; however these are WASM functions using i32x2.log:
    (func $i32x2.log (import "debug" "log") (param i32) (param i32))
    (func $f32.log (import "debug" "log") (param f32))
    (func $f32.log_tee (import "debug" "log_tee") (param f32) (result f32))
    (func $f64.log (import "debug" "log") (param f64))
    (func $f64.log_tee (import "debug" "log_tee") (param f64) (result f64))
    
    (memory (export "memory") 10 65536)
    
    ;; i64 logging by splitting into two i32 limbs
    (func $i64.log
        (param $0 i64)
        (call $i32x2.log
            ;; Upper limb
            (i32.wrap/i64
                (i64.shr_s (get_local $0)
                    (i64.const 32)))
            ;; Lower limb
            (i32.wrap/i64 (get_local $0))))

    (func $i64.log_tee
        (param $0 i64)
        (result i64)
        (call $i64.log (get_local $0))
        (return (get_local $0)))

  (func $mul (export "mul") (param $h i32) (param $f i32) (param $g i32)
    (local $f0 i64)
    (local $f1 i64)
    (local $f2 i64)
    (local $f3 i64)
    (local $f4 i64)
    (local $f5 i64)
    (local $f6 i64)
    (local $f7 i64)
    (local $f8 i64)
    (local $f9 i64)

    (local $g0 i64)
    (local $g1 i64)
    (local $g2 i64)
    (local $g3 i64)
    (local $g4 i64)
    (local $g5 i64)
    (local $g6 i64)
    (local $g7 i64)
    (local $g8 i64)
    (local $g9 i64)

    (local $h0 i64)
    (local $h1 i64)
    (local $h2 i64)
    (local $h3 i64)
    (local $h4 i64)
    (local $h5 i64)
    (local $h6 i64)
    (local $h7 i64)
    (local $h8 i64)
    (local $h9 i64)
    
    (local $carry0 i64)
    (local $carry1 i64)
    (local $carry2 i64)
    (local $carry3 i64)
    (local $carry4 i64)
    (local $carry5 i64)
    (local $carry6 i64)
    (local $carry7 i64)
    (local $carry8 i64)
    (local $carry9 i64)

    (local $g1_19 i64)
    (local $g2_19 i64)
    (local $g3_19 i64)
    (local $g4_19 i64)
    (local $g5_19 i64)
    (local $g6_19 i64)
    (local $g7_19 i64)
    (local $g8_19 i64)
    (local $g9_19 i64)
    (local $f1_2  i64)
    (local $f3_2  i64)
    (local $f5_2  i64)
    (local $f7_2  i64)
    (local $f9_2  i64)

    (local $f0g0    i64)
    (local $f0g1    i64)
    (local $f0g2    i64)
    (local $f0g3    i64)
    (local $f0g4    i64)
    (local $f0g5    i64)
    (local $f0g6    i64)
    (local $f0g7    i64)
    (local $f0g8    i64)
    (local $f0g9    i64)
    (local $f1g0    i64)
    (local $f1g1_2  i64)
    (local $f1g2    i64)
    (local $f1g3_2  i64)
    (local $f1g4    i64)
    (local $f1g5_2  i64)
    (local $f1g6    i64)
    (local $f1g7_2  i64)
    (local $f1g8    i64)
    (local $f1g9_38 i64)
    (local $f2g0    i64)
    (local $f2g1    i64)
    (local $f2g2    i64)
    (local $f2g3    i64)
    (local $f2g4    i64)
    (local $f2g5    i64)
    (local $f2g6    i64)
    (local $f2g7    i64)
    (local $f2g8_19 i64)
    (local $f2g9_19 i64)
    (local $f3g0    i64)
    (local $f3g1_2  i64)
    (local $f3g2    i64)
    (local $f3g3_2  i64)
    (local $f3g4    i64)
    (local $f3g5_2  i64)
    (local $f3g6    i64)
    (local $f3g7_38 i64)
    (local $f3g8_19 i64)
    (local $f3g9_38 i64)
    (local $f4g0    i64)
    (local $f4g1    i64)
    (local $f4g2    i64)
    (local $f4g3    i64)
    (local $f4g4    i64)
    (local $f4g5    i64)
    (local $f4g6_19 i64)
    (local $f4g7_19 i64)
    (local $f4g8_19 i64)
    (local $f4g9_19 i64)
    (local $f5g0    i64)
    (local $f5g1_2  i64)
    (local $f5g2    i64)
    (local $f5g3_2  i64)
    (local $f5g4    i64)
    (local $f5g5_38 i64)
    (local $f5g6_19 i64)
    (local $f5g7_38 i64)
    (local $f5g8_19 i64)
    (local $f5g9_38 i64)
    (local $f6g0    i64)
    (local $f6g1    i64)
    (local $f6g2    i64)
    (local $f6g3    i64)
    (local $f6g4_19 i64)
    (local $f6g5_19 i64)
    (local $f6g6_19 i64)
    (local $f6g7_19 i64)
    (local $f6g8_19 i64)
    (local $f6g9_19 i64)
    (local $f7g0    i64)
    (local $f7g1_2  i64)
    (local $f7g2    i64)
    (local $f7g3_38 i64)
    (local $f7g4_19 i64)
    (local $f7g5_38 i64)
    (local $f7g6_19 i64)
    (local $f7g7_38 i64)
    (local $f7g8_19 i64)
    (local $f7g9_38 i64)
    (local $f8g0    i64)
    (local $f8g1    i64)
    (local $f8g2_19 i64)
    (local $f8g3_19 i64)
    (local $f8g4_19 i64)
    (local $f8g5_19 i64)
    (local $f8g6_19 i64)
    (local $f8g7_19 i64)
    (local $f8g8_19 i64)
    (local $f8g9_19 i64)
    (local $f9g0    i64)
    (local $f9g1_38 i64)
    (local $f9g2_19 i64)
    (local $f9g3_38 i64)
    (local $f9g4_19 i64)
    (local $f9g5_38 i64)
    (local $f9g6_19 i64)
    (local $f9g7_38 i64)
    (local $f9g8_19 i64)
    (local $f9g9_38 i64)

    (set_local $f0 (i64.load32_u offset=0  (get_local $f)))
    (set_local $f1 (i64.load32_u offset=4  (get_local $f)))
    (set_local $f2 (i64.load32_u offset=8  (get_local $f)))
    (set_local $f3 (i64.load32_u offset=12 (get_local $f)))
    (set_local $f4 (i64.load32_u offset=16 (get_local $f)))
    (set_local $f5 (i64.load32_u offset=20 (get_local $f)))
    (set_local $f6 (i64.load32_u offset=24 (get_local $f)))
    (set_local $f7 (i64.load32_u offset=28 (get_local $f)))
    (set_local $f8 (i64.load32_u offset=32 (get_local $f)))
    (set_local $f9 (i64.load32_u offset=36 (get_local $f)))

    (set_local $g0 (i64.load32_u offset=0  (get_local $g)))
    (set_local $g1 (i64.load32_u offset=4  (get_local $g)))
    (set_local $g2 (i64.load32_u offset=8  (get_local $g)))
    (set_local $g3 (i64.load32_u offset=12 (get_local $g)))
    (set_local $g4 (i64.load32_u offset=16 (get_local $g)))
    (set_local $g5 (i64.load32_u offset=20 (get_local $g)))
    (set_local $g6 (i64.load32_u offset=24 (get_local $g)))
    (set_local $g7 (i64.load32_u offset=28 (get_local $g)))
    (set_local $g8 (i64.load32_u offset=32 (get_local $g)))
    (set_local $g9 (i64.load32_u offset=36 (get_local $g)))

    (set_local $g1_19 (i64.mul (i64.const 19) (get_local $g1)))
    (set_local $g2_19 (i64.mul (i64.const 19) (get_local $g2)))
    (set_local $g3_19 (i64.mul (i64.const 19) (get_local $g3)))
    (set_local $g4_19 (i64.mul (i64.const 19) (get_local $g4)))
    (set_local $g5_19 (i64.mul (i64.const 19) (get_local $g5)))
    (set_local $g6_19 (i64.mul (i64.const 19) (get_local $g6)))
    (set_local $g7_19 (i64.mul (i64.const 19) (get_local $g7)))
    (set_local $g8_19 (i64.mul (i64.const 19) (get_local $g8)))
    (set_local $g9_19 (i64.mul (i64.const 19) (get_local $g9)))

    (set_local $f1_2 (i64.mul (i64.const 2) (get_local $f1)))
    (set_local $f3_2 (i64.mul (i64.const 2) (get_local $f3)))
    (set_local $f5_2 (i64.mul (i64.const 2) (get_local $f5)))
    (set_local $f7_2 (i64.mul (i64.const 2) (get_local $f7)))
    (set_local $f9_2 (i64.mul (i64.const 2) (get_local $f9)))

    (set_local $f0g0    (i64.mul (get_local $f0) (get_local $g0)))
    (set_local $f0g1    (i64.mul (get_local $f0) (get_local $g1)))
    (set_local $f0g2    (i64.mul (get_local $f0) (get_local $g2)))
    (set_local $f0g3    (i64.mul (get_local $f0) (get_local $g3)))
    (set_local $f0g4    (i64.mul (get_local $f0) (get_local $g4)))
    (set_local $f0g5    (i64.mul (get_local $f0) (get_local $g5)))
    (set_local $f0g6    (i64.mul (get_local $f0) (get_local $g6)))
    (set_local $f0g7    (i64.mul (get_local $f0) (get_local $g7)))
    (set_local $f0g8    (i64.mul (get_local $f0) (get_local $g8)))
    (set_local $f0g9    (i64.mul (get_local $f0) (get_local $g9)))
    (set_local $f1g0    (i64.mul (get_local $f1) (get_local $g0)))
    (set_local $f1g1_2  (i64.mul (get_local $f1_2) (get_local $g1)))
    (set_local $f1g2    (i64.mul (get_local $f1) (get_local $g2)))
    (set_local $f1g3_2  (i64.mul (get_local $f1_2) (get_local $g3)))
    (set_local $f1g4    (i64.mul (get_local $f1) (get_local $g4)))
    (set_local $f1g5_2  (i64.mul (get_local $f1_2) (get_local $g5)))
    (set_local $f1g6    (i64.mul (get_local $f1) (get_local $g6)))
    (set_local $f1g7_2  (i64.mul (get_local $f1_2) (get_local $g7)))
    (set_local $f1g8    (i64.mul (get_local $f1) (get_local $g8)))
    (set_local $f1g9_38 (i64.mul (get_local $f1_2) (get_local $g9_19)))
    (set_local $f2g0    (i64.mul (get_local $f2) (get_local $g0)))
    (set_local $f2g1    (i64.mul (get_local $f2) (get_local $g1)))
    (set_local $f2g2    (i64.mul (get_local $f2) (get_local $g2)))
    (set_local $f2g3    (i64.mul (get_local $f2) (get_local $g3)))
    (set_local $f2g4    (i64.mul (get_local $f2) (get_local $g4)))
    (set_local $f2g5    (i64.mul (get_local $f2) (get_local $g5)))
    (set_local $f2g6    (i64.mul (get_local $f2) (get_local $g6)))
    (set_local $f2g7    (i64.mul (get_local $f2) (get_local $g7)))
    (set_local $f2g8_19 (i64.mul (get_local $f2) (get_local $g8_19)))
    (set_local $f2g9_19 (i64.mul (get_local $f2) (get_local $g9_19)))
    (set_local $f3g0    (i64.mul (get_local $f3) (get_local $g0)))
    (set_local $f3g1_2  (i64.mul (get_local $f3_2) (get_local $g1)))
    (set_local $f3g2    (i64.mul (get_local $f3) (get_local $g2)))
    (set_local $f3g3_2  (i64.mul (get_local $f3_2) (get_local $g3)))
    (set_local $f3g4    (i64.mul (get_local $f3) (get_local $g4)))
    (set_local $f3g5_2  (i64.mul (get_local $f3_2) (get_local $g5)))
    (set_local $f3g6    (i64.mul (get_local $f3) (get_local $g6)))
    (set_local $f3g7_38 (i64.mul (get_local $f3_2) (get_local $g7_19)))
    (set_local $f3g8_19 (i64.mul (get_local $f3) (get_local $g8_19)))
    (set_local $f3g9_38 (i64.mul (get_local $f3_2) (get_local $g9_19)))
    (set_local $f4g0    (i64.mul (get_local $f4) (get_local $g0)))
    (set_local $f4g1    (i64.mul (get_local $f4) (get_local $g1)))
    (set_local $f4g2    (i64.mul (get_local $f4) (get_local $g2)))
    (set_local $f4g3    (i64.mul (get_local $f4) (get_local $g3)))
    (set_local $f4g4    (i64.mul (get_local $f4) (get_local $g4)))
    (set_local $f4g5    (i64.mul (get_local $f4) (get_local $g5)))
    (set_local $f4g6_19 (i64.mul (get_local $f4) (get_local $g6_19)))
    (set_local $f4g7_19 (i64.mul (get_local $f4) (get_local $g7_19)))
    (set_local $f4g8_19 (i64.mul (get_local $f4) (get_local $g8_19)))
    (set_local $f4g9_19 (i64.mul (get_local $f4) (get_local $g9_19)))
    (set_local $f5g0    (i64.mul (get_local $f5) (get_local $g0)))
    (set_local $f5g1_2  (i64.mul (get_local $f5_2) (get_local $g1)))
    (set_local $f5g2    (i64.mul (get_local $f5) (get_local $g2)))
    (set_local $f5g3_2  (i64.mul (get_local $f5_2) (get_local $g3)))
    (set_local $f5g4    (i64.mul (get_local $f5) (get_local $g4)))
    (set_local $f5g5_38 (i64.mul (get_local $f5_2) (get_local $g5_19)))
    (set_local $f5g6_19 (i64.mul (get_local $f5) (get_local $g6_19)))
    (set_local $f5g7_38 (i64.mul (get_local $f5_2) (get_local $g7_19)))
    (set_local $f5g8_19 (i64.mul (get_local $f5) (get_local $g8_19)))
    (set_local $f5g9_38 (i64.mul (get_local $f5_2) (get_local $g9_19)))
    (set_local $f6g0    (i64.mul (get_local $f6) (get_local $g0)))
    (set_local $f6g1    (i64.mul (get_local $f6) (get_local $g1)))
    (set_local $f6g2    (i64.mul (get_local $f6) (get_local $g2)))
    (set_local $f6g3    (i64.mul (get_local $f6) (get_local $g3)))
    (set_local $f6g4_19 (i64.mul (get_local $f6) (get_local $g4_19)))
    (set_local $f6g5_19 (i64.mul (get_local $f6) (get_local $g5_19)))
    (set_local $f6g6_19 (i64.mul (get_local $f6) (get_local $g6_19)))
    (set_local $f6g7_19 (i64.mul (get_local $f6) (get_local $g7_19)))
    (set_local $f6g8_19 (i64.mul (get_local $f6) (get_local $g8_19)))
    (set_local $f6g9_19 (i64.mul (get_local $f6) (get_local $g9_19)))
    (set_local $f7g0    (i64.mul (get_local $f7) (get_local $g0)))
    (set_local $f7g1_2  (i64.mul (get_local $f7_2) (get_local $g1)))
    (set_local $f7g2    (i64.mul (get_local $f7) (get_local $g2)))
    (set_local $f7g3_38 (i64.mul (get_local $f7_2) (get_local $g3_19)))
    (set_local $f7g4_19 (i64.mul (get_local $f7) (get_local $g4_19)))
    (set_local $f7g5_38 (i64.mul (get_local $f7_2) (get_local $g5_19)))
    (set_local $f7g6_19 (i64.mul (get_local $f7) (get_local $g6_19)))
    (set_local $f7g7_38 (i64.mul (get_local $f7_2) (get_local $g7_19)))
    (set_local $f7g8_19 (i64.mul (get_local $f7) (get_local $g8_19)))
    (set_local $f7g9_38 (i64.mul (get_local $f7_2) (get_local $g9_19)))
    (set_local $f8g0    (i64.mul (get_local $f8) (get_local $g0)))
    (set_local $f8g1    (i64.mul (get_local $f8) (get_local $g1)))
    (set_local $f8g2_19 (i64.mul (get_local $f8) (get_local $g2_19)))
    (set_local $f8g3_19 (i64.mul (get_local $f8) (get_local $g3_19)))
    (set_local $f8g4_19 (i64.mul (get_local $f8) (get_local $g4_19)))
    (set_local $f8g5_19 (i64.mul (get_local $f8) (get_local $g5_19)))
    (set_local $f8g6_19 (i64.mul (get_local $f8) (get_local $g6_19)))
    (set_local $f8g7_19 (i64.mul (get_local $f8) (get_local $g7_19)))
    (set_local $f8g8_19 (i64.mul (get_local $f8) (get_local $g8_19)))
    (set_local $f8g9_19 (i64.mul (get_local $f8) (get_local $g9_19)))
    (set_local $f9g0    (i64.mul (get_local $f9) (get_local $g0)))
    (set_local $f9g1_38 (i64.mul (get_local $f9_2) (get_local $g1_19)))
    (set_local $f9g2_19 (i64.mul (get_local $f9) (get_local $g2_19)))
    (set_local $f9g3_38 (i64.mul (get_local $f9_2) (get_local $g3_19)))
    (set_local $f9g4_19 (i64.mul (get_local $f9) (get_local $g4_19)))
    (set_local $f9g5_38 (i64.mul (get_local $f9_2) (get_local $g5_19)))
    (set_local $f9g6_19 (i64.mul (get_local $f9) (get_local $g6_19)))
    (set_local $f9g7_38 (i64.mul (get_local $f9_2) (get_local $g7_19)))
    (set_local $f9g8_19 (i64.mul (get_local $f9) (get_local $g8_19)))
    (set_local $f9g9_38 (i64.mul (get_local $f9_2) (get_local $g9_19)))

    (set_local $h0 (i64.add (get_local $f0g0) (i64.add (get_local $f1g9_38) (i64.add (get_local $f2g8_19) (i64.add (get_local $f3g7_38) (i64.add (get_local $f4g6_19) (i64.add (get_local $f5g5_38) (i64.add (get_local $f6g4_19) (i64.add (get_local $f7g3_38) (i64.add (get_local $f8g2_19) (get_local $f9g1_38)))))))))))
    (set_local $h1 (i64.add (get_local $f0g1) (i64.add (get_local $f1g0) (i64.add (get_local $f2g9_19) (i64.add (get_local $f3g8_19) (i64.add (get_local $f4g7_19) (i64.add (get_local $f5g6_19) (i64.add (get_local $f6g5_19) (i64.add (get_local $f7g4_19) (i64.add (get_local $f8g3_19) (get_local $f9g2_19)))))))))))
    (set_local $h2 (i64.add (get_local $f0g2) (i64.add (get_local $f1g1_2) (i64.add (get_local $f2g0) (i64.add (get_local $f3g9_38) (i64.add (get_local $f4g8_19) (i64.add (get_local $f5g7_38) (i64.add (get_local $f6g6_19) (i64.add (get_local $f7g5_38) (i64.add (get_local $f8g4_19) (get_local $f9g3_38)))))))))))
    (set_local $h3 (i64.add (get_local $f0g3) (i64.add (get_local $f1g2) (i64.add (get_local $f2g1) (i64.add (get_local $f3g0) (i64.add (get_local $f4g9_19) (i64.add (get_local $f5g8_19) (i64.add (get_local $f6g7_19) (i64.add (get_local $f7g6_19) (i64.add (get_local $f8g5_19) (get_local $f9g4_19)))))))))))
    (set_local $h4 (i64.add (get_local $f0g4) (i64.add (get_local $f1g3_2) (i64.add (get_local $f2g2) (i64.add (get_local $f3g1_2) (i64.add (get_local $f4g0) (i64.add (get_local $f5g9_38) (i64.add (get_local $f6g8_19) (i64.add (get_local $f7g7_38) (i64.add (get_local $f8g6_19) (get_local $f9g5_38)))))))))))
    (set_local $h5 (i64.add (get_local $f0g5) (i64.add (get_local $f1g4) (i64.add (get_local $f2g3) (i64.add (get_local $f3g2) (i64.add (get_local $f4g1) (i64.add (get_local $f5g0) (i64.add (get_local $f6g9_19) (i64.add (get_local $f7g8_19) (i64.add (get_local $f8g7_19) (get_local $f9g6_19)))))))))))
    (set_local $h6 (i64.add (get_local $f0g6) (i64.add (get_local $f1g5_2) (i64.add (get_local $f2g4) (i64.add (get_local $f3g3_2) (i64.add (get_local $f4g2) (i64.add (get_local $f5g1_2) (i64.add (get_local $f6g0) (i64.add (get_local $f7g9_38) (i64.add (get_local $f8g8_19) (get_local $f9g7_38)))))))))))
    (set_local $h7 (i64.add (get_local $f0g7) (i64.add (get_local $f1g6) (i64.add (get_local $f2g5) (i64.add (get_local $f3g4) (i64.add (get_local $f4g3) (i64.add (get_local $f5g2) (i64.add (get_local $f6g1) (i64.add (get_local $f7g0) (i64.add (get_local $f8g9_19) (get_local $f9g8_19)))))))))))
    (set_local $h8 (i64.add (get_local $f0g8) (i64.add (get_local $f1g7_2) (i64.add (get_local $f2g6) (i64.add (get_local $f3g5_2) (i64.add (get_local $f4g4) (i64.add (get_local $f5g3_2) (i64.add (get_local $f6g2) (i64.add (get_local $f7g1_2) (i64.add (get_local $f8g0) (get_local $f9g9_38)))))))))))
    (set_local $h9 (i64.add (get_local $f0g9) (i64.add (get_local $f1g8) (i64.add (get_local $f2g7) (i64.add (get_local $f3g6) (i64.add (get_local $f4g5) (i64.add (get_local $f5g4) (i64.add (get_local $f6g3) (i64.add (get_local $f7g2) (i64.add (get_local $f8g1) (get_local $f9g0)))))))))))

    ;; |h0| <= (1.65*1.65*2^52*(1+19+19+19+19)+1.65*1.65*2^50*(38+38+38+38+38))
    ;; i.e. |h0| <= 1.4*2^60; narrower ranges for h2, h4, h6, h8
    ;; |h1| <= (1.65*1.65*2^51*(1+1+19+19+19+19+19+19+19+19))
    ;; i.e. |h1| <= 1.7*2^59; narrower ranges for h3, h5, h7, h9    

    (set_local $carry0 (i64.shr_s (i64.add (get_local $h0) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h1 (i64.add (get_local $h1) (get_local $carry0)))
    (set_local $h0 (i64.sub (get_local $h0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry4 (i64.shr_s (i64.add (get_local $h4) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h5 (i64.add (get_local $h5) (get_local $carry4)))
    (set_local $h4 (i64.sub (get_local $h4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h0| <= 2^25 */
    ;; /* |h4| <= 2^25 */
    ;; /* |h1| <= 1.71*2^59 */
    ;; /* |h5| <= 1.71*2^59 */

    (set_local $carry1 (i64.shr_s (i64.add (get_local $h1) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h2 (i64.add (get_local $h2) (get_local $carry1)))
    (set_local $h1 (i64.sub (get_local $h1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 25)))))
    (set_local $carry5 (i64.shr_s (i64.add (get_local $h5) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h6 (i64.add (get_local $h6) (get_local $carry5)))
    (set_local $h5 (i64.sub (get_local $h5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h1| <= 2^24; from now on fits into int32 */
    ;; /* |h5| <= 2^24; from now on fits into int32 */
    ;; /* |h2| <= 1.41*2^60 */
    ;; /* |h6| <= 1.41*2^60 */

    (set_local $carry2 (i64.shr_s (i64.add (get_local $h2) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h3 (i64.add (get_local $h3) (get_local $carry2)))
    (set_local $h2 (i64.sub (get_local $h2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry6 (i64.shr_s (i64.add (get_local $h6) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h7 (i64.add (get_local $h7) (get_local $carry6)))
    (set_local $h6 (i64.sub (get_local $h6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h2| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h6| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h3| <= 1.71*2^59 */
    ;; /* |h7| <= 1.71*2^59 */

    (set_local $carry3 (i64.shr_s (i64.add (get_local $h3) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h4 (i64.add (get_local $h4) (get_local $carry3)))
    (set_local $h3 (i64.sub (get_local $h3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 25)))))
    (set_local $carry7 (i64.shr_s (i64.add (get_local $h7) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h8 (i64.add (get_local $h8) (get_local $carry7)))
    (set_local $h7 (i64.sub (get_local $h7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h3| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h7| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h4| <= 1.72*2^34 */
    ;; /* |h8| <= 1.41*2^60 */

    (set_local $carry4 (i64.shr_s (i64.add (get_local $h4) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h5 (i64.add (get_local $h5) (get_local $carry4)))
    (set_local $h4 (i64.sub (get_local $h4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry8 (i64.shr_s (i64.add (get_local $h8) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h9 (i64.add (get_local $h9) (get_local $carry8)))
    (set_local $h8 (i64.sub (get_local $h8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h4| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h8| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h5| <= 1.01*2^24 */
    ;; /* |h9| <= 1.71*2^59 */

    (set_local $carry9 (i64.shr_s (i64.add (get_local $h9) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h0 (i64.add (get_local $h0) (i64.mul (get_local $carry9) (i64.const 19))))
    (set_local $h9 (i64.sub (get_local $h9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h9| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h0| <= 1.1*2^39 */

    (set_local $carry0 (i64.shr_s (i64.add (get_local $h0) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h1 (i64.add (get_local $h1) (get_local $carry0)))
    (set_local $h0 (i64.sub (get_local $h0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h0| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h1| <= 1.01*2^24 */

    (i64.store32 offset=0  (get_local $h) (get_local $h0))
    (i64.store32 offset=4  (get_local $h) (get_local $h1))
    (i64.store32 offset=8  (get_local $h) (get_local $h2))
    (i64.store32 offset=12 (get_local $h) (get_local $h3))
    (i64.store32 offset=16 (get_local $h) (get_local $h4))
    (i64.store32 offset=20 (get_local $h) (get_local $h5))
    (i64.store32 offset=24 (get_local $h) (get_local $h6))
    (i64.store32 offset=28 (get_local $h) (get_local $h7))
    (i64.store32 offset=32 (get_local $h) (get_local $h8))
    (i64.store32 offset=36 (get_local $h) (get_local $h9)))

  (func $sq (export "sq") (param $h i32) (param $f i32) (param $double i32)
    (local $f0 i64)
    (local $f1 i64)
    (local $f2 i64)
    (local $f3 i64)
    (local $f4 i64)
    (local $f5 i64)
    (local $f6 i64)
    (local $f7 i64)
    (local $f8 i64)
    (local $f9 i64)

    (local $h0 i64)
    (local $h1 i64)
    (local $h2 i64)
    (local $h3 i64)
    (local $h4 i64)
    (local $h5 i64)
    (local $h6 i64)
    (local $h7 i64)
    (local $h8 i64)
    (local $h9 i64)
    
    (local $carry0 i64)
    (local $carry1 i64)
    (local $carry2 i64)
    (local $carry3 i64)
    (local $carry4 i64)
    (local $carry5 i64)
    (local $carry6 i64)
    (local $carry7 i64)
    (local $carry8 i64)
    (local $carry9 i64)

    (local $f0_2 i64)
    (local $f1_2 i64)
    (local $f2_2 i64)
    (local $f3_2 i64)
    (local $f4_2 i64)
    (local $f5_2 i64)
    (local $f6_2 i64)
    (local $f7_2 i64)

    (local $f5_38 i64)
    (local $f6_19 i64)
    (local $f7_38 i64)
    (local $f8_19 i64)
    (local $f9_38 i64)

    (local $f0f0 i64)
    (local $f0f1_2 i64)
    (local $f0f2_2 i64)
    (local $f0f3_2 i64)
    (local $f0f4_2 i64)
    (local $f0f5_2 i64)
    (local $f0f6_2 i64)
    (local $f0f7_2 i64)
    (local $f0f8_2 i64)
    (local $f0f9_2 i64)
    (local $f1f1_2 i64)
    (local $f1f2_2 i64)
    (local $f1f3_4 i64)
    (local $f1f4_2 i64)
    (local $f1f5_4 i64)
    (local $f1f6_2 i64)
    (local $f1f7_4 i64)
    (local $f1f8_2 i64)
    (local $f1f9_76 i64)
    (local $f2f2 i64)
    (local $f2f3_2 i64)
    (local $f2f4_2 i64)
    (local $f2f5_2 i64)
    (local $f2f6_2 i64)
    (local $f2f7_2 i64)
    (local $f2f8_38 i64)
    (local $f2f9_38 i64)
    (local $f3f3_2 i64)
    (local $f3f4_2 i64)
    (local $f3f5_4 i64)
    (local $f3f6_2 i64)
    (local $f3f7_76 i64)
    (local $f3f8_38 i64)
    (local $f3f9_76 i64)
    (local $f4f4 i64)
    (local $f4f5_2 i64)
    (local $f4f6_38 i64)
    (local $f4f7_38 i64)
    (local $f4f8_38 i64)
    (local $f4f9_38 i64)
    (local $f5f5_38 i64)
    (local $f5f6_38 i64)
    (local $f5f7_76 i64)
    (local $f5f8_38 i64)
    (local $f5f9_76 i64)
    (local $f6f6_19 i64)
    (local $f6f7_38 i64)
    (local $f6f8_38 i64)
    (local $f6f9_38 i64)
    (local $f7f7_38 i64)
    (local $f7f8_38 i64)
    (local $f7f9_76 i64)
    (local $f8f8_19 i64)
    (local $f8f9_38 i64)
    (local $f9f9_38 i64)

    (set_local $f0 (i64.load32_u offset=0  (get_local $f)))
    (set_local $f1 (i64.load32_u offset=4  (get_local $f)))
    (set_local $f2 (i64.load32_u offset=8  (get_local $f)))
    (set_local $f3 (i64.load32_u offset=12 (get_local $f)))
    (set_local $f4 (i64.load32_u offset=16 (get_local $f)))
    (set_local $f5 (i64.load32_u offset=20 (get_local $f)))
    (set_local $f6 (i64.load32_u offset=24 (get_local $f)))
    (set_local $f7 (i64.load32_u offset=28 (get_local $f)))
    (set_local $f8 (i64.load32_u offset=32 (get_local $f)))
    (set_local $f9 (i64.load32_u offset=36 (get_local $f)))

    (set_local $f0_2 (i64.and (i64.mul (i64.const 2 (get_local $f0))) (i64.const 0xffffffff)))
    (set_local $f1_2 (i64.and (i64.mul (i64.const 2 (get_local $f1))) (i64.const 0xffffffff)))
    (set_local $f2_2 (i64.and (i64.mul (i64.const 2 (get_local $f2))) (i64.const 0xffffffff)))
    (set_local $f3_2 (i64.and (i64.mul (i64.const 2 (get_local $f3))) (i64.const 0xffffffff)))
    (set_local $f4_2 (i64.and (i64.mul (i64.const 2 (get_local $f4))) (i64.const 0xffffffff)))
    (set_local $f5_2 (i64.and (i64.mul (i64.const 2 (get_local $f5))) (i64.const 0xffffffff)))
    (set_local $f6_2 (i64.and (i64.mul (i64.const 2 (get_local $f6))) (i64.const 0xffffffff)))
    (set_local $f7_2 (i64.and (i64.mul (i64.const 2 (get_local $f7))) (i64.const 0xffffffff)))

    (set_local $f5_38 (i64.and (i64.mul (i64.const 38 (get_local $f5))) (i64.const 0xffffffff)))
    (set_local $f6_19 (i64.and (i64.mul (i64.const 19 (get_local $f6))) (i64.const 0xffffffff)))
    (set_local $f7_38 (i64.and (i64.mul (i64.const 38 (get_local $f7))) (i64.const 0xffffffff)))
    (set_local $f8_19 (i64.and (i64.mul (i64.const 19 (get_local $f8))) (i64.const 0xffffffff)))
    (set_local $f9_38 (i64.and (i64.mul (i64.const 38 (get_local $f9))) (i64.const 0xffffffff)))
    
    (set_local $f0f0    (i64.mul (get_local $f0)   (get_local $f0)))
    (set_local $f0f1_2  (i64.mul (get_local $f0_2) (get_local $f1)))
    (set_local $f0f2_2  (i64.mul (get_local $f0_2) (get_local $f2)))
    (set_local $f0f3_2  (i64.mul (get_local $f0_2) (get_local $f3)))
    (set_local $f0f4_2  (i64.mul (get_local $f0_2) (get_local $f4)))
    (set_local $f0f5_2  (i64.mul (get_local $f0_2) (get_local $f5)))
    (set_local $f0f6_2  (i64.mul (get_local $f0_2) (get_local $f6)))
    (set_local $f0f7_2  (i64.mul (get_local $f0_2) (get_local $f7)))
    (set_local $f0f8_2  (i64.mul (get_local $f0_2) (get_local $f8)))
    (set_local $f0f9_2  (i64.mul (get_local $f0_2) (get_local $f9)))
    (set_local $f1f1_2  (i64.mul (get_local $f1_2) (get_local $f1)))
    (set_local $f1f2_2  (i64.mul (get_local $f1_2) (get_local $f2)))
    (set_local $f1f3_4  (i64.mul (get_local $f1_2) (get_local $f3_2)))
    (set_local $f1f4_2  (i64.mul (get_local $f1_2) (get_local $f4)))
    (set_local $f1f5_4  (i64.mul (get_local $f1_2) (get_local $f5_2)))
    (set_local $f1f6_2  (i64.mul (get_local $f1_2) (get_local $f6)))
    (set_local $f1f7_4  (i64.mul (get_local $f1_2) (get_local $f7_2)))
    (set_local $f1f8_2  (i64.mul (get_local $f1_2) (get_local $f8)))
    (set_local $f1f9_76 (i64.mul (get_local $f1_2) (get_local $f9_38)))
    (set_local $f2f2    (i64.mul (get_local $f2)   (get_local $f2)))
    (set_local $f2f3_2  (i64.mul (get_local $f2_2) (get_local $f3)))
    (set_local $f2f4_2  (i64.mul (get_local $f2_2) (get_local $f4)))
    (set_local $f2f5_2  (i64.mul (get_local $f2_2) (get_local $f5)))
    (set_local $f2f6_2  (i64.mul (get_local $f2_2) (get_local $f6)))
    (set_local $f2f7_2  (i64.mul (get_local $f2_2) (get_local $f7)))
    (set_local $f2f8_38 (i64.mul (get_local $f2_2) (get_local $f8_19)))
    (set_local $f2f9_38 (i64.mul (get_local $f2) (get_local $f9_38)))
    (set_local $f3f3_2  (i64.mul (get_local $f3_2) (get_local $f3)))
    (set_local $f3f4_2  (i64.mul (get_local $f3_2) (get_local $f4)))
    (set_local $f3f5_4  (i64.mul (get_local $f3_2) (get_local $f5_2)))
    (set_local $f3f6_2  (i64.mul (get_local $f3_2) (get_local $f6)))
    (set_local $f3f7_76 (i64.mul (get_local $f3_2) (get_local $f7_38)))
    (set_local $f3f8_38 (i64.mul (get_local $f3_2) (get_local $f8_19)))
    (set_local $f3f9_76 (i64.mul (get_local $f3_2) (get_local $f9_38)))
    (set_local $f4f4    (i64.mul (get_local $f4)   (get_local $f4)))
    (set_local $f4f5_2  (i64.mul (get_local $f4_2) (get_local $f5)))
    (set_local $f4f6_38 (i64.mul (get_local $f4_2) (get_local $f6_19)))
    (set_local $f4f7_38 (i64.mul (get_local $f4)   (get_local $f7_38)))
    (set_local $f4f8_38 (i64.mul (get_local $f4_2) (get_local $f8_19)))
    (set_local $f4f9_38 (i64.mul (get_local $f4)   (get_local $f9_38)))
    (set_local $f5f5_38 (i64.mul (get_local $f5)   (get_local $f5_38)))
    (set_local $f5f6_38 (i64.mul (get_local $f5_2) (get_local $f6_19)))
    (set_local $f5f7_76 (i64.mul (get_local $f5_2) (get_local $f7_38)))
    (set_local $f5f8_38 (i64.mul (get_local $f5_2) (get_local $f8_19)))
    (set_local $f5f9_76 (i64.mul (get_local $f5_2) (get_local $f9_38)))
    (set_local $f6f6_19 (i64.mul (get_local $f6)   (get_local $f6_19)))
    (set_local $f6f7_38 (i64.mul (get_local $f6)   (get_local $f7_38)))
    (set_local $f6f8_38 (i64.mul (get_local $f6_2) (get_local $f8_19)))
    (set_local $f6f9_38 (i64.mul (get_local $f6)   (get_local $f9_38)))
    (set_local $f7f7_38 (i64.mul (get_local $f7)   (get_local $f7_38)))
    (set_local $f7f8_38 (i64.mul (get_local $f7_2) (get_local $f8_19)))
    (set_local $f7f9_76 (i64.mul (get_local $f7_2) (get_local $f9_38)))
    (set_local $f8f8_19 (i64.mul (get_local $f8)   (get_local $f8_19)))
    (set_local $f8f9_38 (i64.mul (get_local $f8)   (get_local $f9_38)))
    (set_local $f9f9_38 (i64.mul (get_local $f9)   (get_local $f9_38)))

    ;; int64_t h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    (set_local $h0 (i64.add (get_local $f0f0)   (i64.add (get_local $f1f9_76) (i64.add (get_local $f2f8_38) (i64.add (get_local $f3f7_76) (i64.add (get_local $f4f6_38) (get_local $f5f5_38)))))))

    ;; int64_t h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    (set_local $h1 (i64.add (get_local $f0f1_2) (i64.add (get_local $f2f9_38) (i64.add (get_local $f3f8_38) (i64.add (get_local $f4f7_38) (get_local $f5f6_38))))))

    ;; int64_t h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    (set_local $h2 (i64.add (get_local $f0f2_2) (i64.add (get_local $f1f1_2)  (i64.add (get_local $f3f9_76) (i64.add (get_local $f4f8_38) (i64.add (get_local $f5f7_76) (get_local $f6f6_19)))))))

    ;; int64_t h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    (set_local $h3 (i64.add (get_local $f0f3_2) (i64.add (get_local $f1f2_2)  (i64.add (get_local $f4f9_38) (i64.add (get_local $f5f8_38) (get_local $f6f7_38))))))

    ;; int64_t h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    (set_local $h4 (i64.add (get_local $f0f4_2) (i64.add (get_local $f1f3_4)  (i64.add (get_local $f2f2)    (i64.add (get_local $f5f9_76) (i64.add (get_local $f6f8_38) (get_local $f7f7_38)))))))

    ;; int64_t h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    (set_local $h5 (i64.add (get_local $f0f5_2) (i64.add (get_local $f1f4_2)  (i64.add (get_local $f2f3_2)  (i64.add (get_local $f6f9_38) (get_local $f7f8_38))))))

    ;; int64_t h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    (set_local $h6 (i64.add (get_local $f0f6_2) (i64.add (get_local $f1f5_4)  (i64.add (get_local $f2f4_2)  (i64.add (get_local $f3f3_2)  (i64.add (get_local $f7f9_76) (get_local $f8f8_19)))))))

    ;; int64_t h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    (set_local $h7 (i64.add (get_local $f0f7_2) (i64.add (get_local $f1f6_2)  (i64.add (get_local $f2f5_2)  (i64.add (get_local $f3f4_2)  (get_local $f8f9_38))))))

    ;; int64_t h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    (set_local $h8 (i64.add (get_local $f0f8_2) (i64.add (get_local $f1f7_4)  (i64.add (get_local $f2f6_2)  (i64.add (get_local $f3f5_4)  (i64.add (get_local $f4f4)    (get_local $f9f9_38)))))))

    ;; int64_t h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
    (set_local $h9 (i64.add (get_local $f0f9_2) (i64.add (get_local $f1f8_2)  (i64.add (get_local $f2f7_2)  (i64.add (get_local $f3f6_2)  (get_local $f4f5_2 ))))))

    (if (i32.eq (get_local $double) (i32.const 1))
      (then
        (set_local $h0 (i64.add (get_local $h0) (get_local $h0)))
        (set_local $h1 (i64.add (get_local $h1) (get_local $h1)))
        (set_local $h2 (i64.add (get_local $h2) (get_local $h2)))
        (set_local $h3 (i64.add (get_local $h3) (get_local $h3)))
        (set_local $h4 (i64.add (get_local $h4) (get_local $h4)))
        (set_local $h5 (i64.add (get_local $h5) (get_local $h5)))
        (set_local $h6 (i64.add (get_local $h6) (get_local $h6)))
        (set_local $h7 (i64.add (get_local $h7) (get_local $h7)))
        (set_local $h8 (i64.add (get_local $h8) (get_local $h8)))
        (set_local $h9 (i64.add (get_local $h9) (get_local $h9)))))

    ;; |h0| <= (1.65*1.65*2^52*(1+19+19+19+19)+1.65*1.65*2^50*(38+38+38+38+38))
    ;; i.e. |h0| <= 1.4*2^60; narrower ranges for h2, h4, h6, h8
    ;; |h1| <= (1.65*1.65*2^51*(1+1+19+19+19+19+19+19+19+19))
    ;; i.e. |h1| <= 1.7*2^59; narrower ranges for h3, h5, h7, h9    

    (set_local $carry0 (i64.shr_s (i64.add (get_local $h0) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h1 (i64.add (get_local $h1) (get_local $carry0)))
    (set_local $h0 (i64.sub (get_local $h0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry4 (i64.shr_s (i64.add (get_local $h4) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h5 (i64.add (get_local $h5) (get_local $carry4)))
    (set_local $h4 (i64.sub (get_local $h4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h0| <= 2^25 */
    ;; /* |h4| <= 2^25 */
    ;; /* |h1| <= 1.71*2^59 */
    ;; /* |h5| <= 1.71*2^59 */

    (set_local $carry1 (i64.shr_s (i64.add (get_local $h1) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h2 (i64.add (get_local $h2) (get_local $carry1)))
    (set_local $h1 (i64.sub (get_local $h1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 25)))))
    (set_local $carry5 (i64.shr_s (i64.add (get_local $h5) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h6 (i64.add (get_local $h6) (get_local $carry5)))
    (set_local $h5 (i64.sub (get_local $h5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h1| <= 2^24; from now on fits into int32 */
    ;; /* |h5| <= 2^24; from now on fits into int32 */
    ;; /* |h2| <= 1.41*2^60 */
    ;; /* |h6| <= 1.41*2^60 */

    (set_local $carry2 (i64.shr_s (i64.add (get_local $h2) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h3 (i64.add (get_local $h3) (get_local $carry2)))
    (set_local $h2 (i64.sub (get_local $h2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry6 (i64.shr_s (i64.add (get_local $h6) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h7 (i64.add (get_local $h7) (get_local $carry6)))
    (set_local $h6 (i64.sub (get_local $h6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h2| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h6| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h3| <= 1.71*2^59 */
    ;; /* |h7| <= 1.71*2^59 */

    (set_local $carry3 (i64.shr_s (i64.add (get_local $h3) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h4 (i64.add (get_local $h4) (get_local $carry3)))
    (set_local $h3 (i64.sub (get_local $h3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 25)))))
    (set_local $carry7 (i64.shr_s (i64.add (get_local $h7) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h8 (i64.add (get_local $h8) (get_local $carry7)))
    (set_local $h7 (i64.sub (get_local $h7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h3| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h7| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h4| <= 1.72*2^34 */
    ;; /* |h8| <= 1.41*2^60 */

    (set_local $carry4 (i64.shr_s (i64.add (get_local $h4) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h5 (i64.add (get_local $h5) (get_local $carry4)))
    (set_local $h4 (i64.sub (get_local $h4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 26)))))
    (set_local $carry8 (i64.shr_s (i64.add (get_local $h8) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h9 (i64.add (get_local $h9) (get_local $carry8)))
    (set_local $h8 (i64.sub (get_local $h8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h4| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h8| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h5| <= 1.01*2^24 */
    ;; /* |h9| <= 1.71*2^59 */

    (set_local $carry9 (i64.shr_s (i64.add (get_local $h9) (i64.shl (i64.const 1) (i64.const 24)) (i64.const 25))))
    (set_local $h0 (i64.add (get_local $h0) (i64.mul (get_local $carry9) (i64.const 19))))
    (set_local $h9 (i64.sub (get_local $h9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 25)))))

    ;; /* |h9| <= 2^24; from now on fits into int32 unchanged */
    ;; /* |h0| <= 1.1*2^39 */

    (set_local $carry0 (i64.shr_s (i64.add (get_local $h0) (i64.shl (i64.const 1) (i64.const 25)) (i64.const 26))))
    (set_local $h1 (i64.add (get_local $h1) (get_local $carry0)))
    (set_local $h0 (i64.sub (get_local $h0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 26)))))

    ;; /* |h0| <= 2^25; from now on fits into int32 unchanged */
    ;; /* |h1| <= 1.01*2^24 */

    ;; carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    ;; h1 += carry0;
    ;; h0 -= carry0 * ((uint64_t) 1L << 26);
    ;; carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    ;; h5 += carry4;
    ;; h4 -= carry4 * ((uint64_t) 1L << 26);

    ;; carry1 = (h1 + (int64_t)(1L << 24)) >> 25;
    ;; h2 += carry1;
    ;; h1 -= carry1 * ((uint64_t) 1L << 25);
    ;; carry5 = (h5 + (int64_t)(1L << 24)) >> 25;
    ;; h6 += carry5;
    ;; h5 -= carry5 * ((uint64_t) 1L << 25);

    ;; carry2 = (h2 + (int64_t)(1L << 25)) >> 26;
    ;; h3 += carry2;
    ;; h2 -= carry2 * ((uint64_t) 1L << 26);
    ;; carry6 = (h6 + (int64_t)(1L << 25)) >> 26;
    ;; h7 += carry6;
    ;; h6 -= carry6 * ((uint64_t) 1L << 26);

    ;; carry3 = (h3 + (int64_t)(1L << 24)) >> 25;
    ;; h4 += carry3;
    ;; h3 -= carry3 * ((uint64_t) 1L << 25);
    ;; carry7 = (h7 + (int64_t)(1L << 24)) >> 25;
    ;; h8 += carry7;
    ;; h7 -= carry7 * ((uint64_t) 1L << 25);

    ;; carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    ;; h5 += carry4;
    ;; h4 -= carry4 * ((uint64_t) 1L << 26);
    ;; carry8 = (h8 + (int64_t)(1L << 25)) >> 26;
    ;; h9 += carry8;
    ;; h8 -= carry8 * ((uint64_t) 1L << 26);

    ;; carry9 = (h9 + (int64_t)(1L << 24)) >> 25;
    ;; h0 += carry9 * 19;
    ;; h9 -= carry9 * ((uint64_t) 1L << 25);

    ;; carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    ;; h1 += carry0;
    ;; h0 -= carry0 * ((uint64_t) 1L << 26);

    (i64.store32 offset=0  (get_local $h) (get_local $h0))
    (i64.store32 offset=4  (get_local $h) (get_local $h1))
    (i64.store32 offset=8  (get_local $h) (get_local $h2))
    (i64.store32 offset=12 (get_local $h) (get_local $h3))
    (i64.store32 offset=16 (get_local $h) (get_local $h4))
    (i64.store32 offset=20 (get_local $h) (get_local $h5))
    (i64.store32 offset=24 (get_local $h) (get_local $h6))
    (i64.store32 offset=28 (get_local $h) (get_local $h7))
    (i64.store32 offset=32 (get_local $h) (get_local $h8))
    (i64.store32 offset=36 (get_local $h) (get_local $h9)))


  (func $sc25519_mul (export "sc25519_mul") (param $s i32) (param $a i32) (param $b i32)
    (local $a0 i64)
    (local $a1 i64)
    (local $a2 i64)
    (local $a3 i64)
    (local $a4 i64)
    (local $a5 i64)
    (local $a6 i64)
    (local $a7 i64)
    (local $a8 i64)
    (local $a9 i64)
    (local $a10 i64)
    (local $a11 i64)

    (local $b0 i64)
    (local $b1 i64)
    (local $b2 i64)
    (local $b3 i64)
    (local $b4 i64)
    (local $b5 i64)
    (local $b6 i64)
    (local $b7 i64)
    (local $b8 i64)
    (local $b9 i64)
    (local $b10 i64)
    (local $b11 i64)

    (local $s0 i64)
    (local $s1 i64)
    (local $s2 i64)
    (local $s3 i64)
    (local $s4 i64)
    (local $s5 i64)
    (local $s6 i64)
    (local $s7 i64)
    (local $s8 i64)
    (local $s9 i64)
    (local $s10 i64)
    (local $s11 i64)
    (local $s12 i64)
    (local $s13 i64)
    (local $s14 i64)
    (local $s15 i64)
    (local $s16 i64)
    (local $s17 i64)
    (local $s18 i64)
    (local $s19 i64)
    (local $s20 i64)
    (local $s21 i64)
    (local $s22 i64)
    (local $s23 i64)

    (local $carry0 i64)
    (local $carry1 i64)
    (local $carry2 i64)
    (local $carry3 i64)
    (local $carry4 i64)
    (local $carry5 i64)
    (local $carry6 i64)
    (local $carry7 i64)
    (local $carry8 i64)
    (local $carry9 i64)
    (local $carry10 i64)
    (local $carry11 i64)
    (local $carry12 i64)
    (local $carry13 i64)
    (local $carry14 i64)
    (local $carry15 i64)
    (local $carry16 i64)
    (local $carry17 i64)
    (local $carry18 i64)
    (local $carry19 i64)
    (local $carry20 i64)
    (local $carry21 i64)
    (local $carry22 i64)

    (set_local $a0 (i64.load32_u offset=0  (get_local $a)))
    (set_local $a1 (i64.load32_u offset=4  (get_local $a)))
    (set_local $a2 (i64.load32_u offset=8  (get_local $a)))
    (set_local $a3 (i64.load32_u offset=12 (get_local $a)))
    (set_local $a4 (i64.load32_u offset=16 (get_local $a)))
    (set_local $a5 (i64.load32_u offset=20 (get_local $a)))
    (set_local $a6 (i64.load32_u offset=24 (get_local $a)))
    (set_local $a7 (i64.load32_u offset=28 (get_local $a)))
    (set_local $a8 (i64.load32_u offset=32 (get_local $a)))
    (set_local $a9 (i64.load32_u offset=36 (get_local $a)))
    (set_local $a10 (i64.load32_u offset=40 (get_local $a)))
    (set_local $a11 (i64.load32_u offset=44 (get_local $a)))

    (set_local $b0 (i64.load32_u offset=0  (get_local $b)))
    (set_local $b1 (i64.load32_u offset=4  (get_local $b)))
    (set_local $b2 (i64.load32_u offset=8  (get_local $b)))
    (set_local $b3 (i64.load32_u offset=12 (get_local $b)))
    (set_local $b4 (i64.load32_u offset=16 (get_local $b)))
    (set_local $b5 (i64.load32_u offset=20 (get_local $b)))
    (set_local $b6 (i64.load32_u offset=24 (get_local $b)))
    (set_local $b7 (i64.load32_u offset=28 (get_local $b)))
    (set_local $b8 (i64.load32_u offset=32 (get_local $b)))
    (set_local $b9 (i64.load32_u offset=36 (get_local $b)))
    (set_local $b10 (i64.load32_u offset=40 (get_local $b)))
    (set_local $b11 (i64.load32_u offset=44 (get_local $b)))

;;     s0  = a0  * b0 ;
;;     s1  = a0  * b1  + a1  * b0;
;;     s2  = a0  * b2  + a1  * b1  + a2  * b0;
;;     s3  = a0  * b3  + a1  * b2  + a2  * b1 + a3  * b0;
;;     s4  = a0  * b4  + a1  * b3  + a2  * b2 + a3  * b1 + a4  * b0;
;;     s5  = a0  * b5  + a1  * b4  + a2  * b3 + a3  * b2 + a4  * b1 + a5  * b0;
;;     s6  = a0  * b6  + a1  * b5  + a2  * b4 + a3  * b3 + a4  * b2 + a5  * b1 + a6  * b0;
;;     s7  = a0  * b7  + a1  * b6  + a2  * b5 + a3  * b4 + a4  * b3 + a5  * b2 + a6  * b1 + a7  * b0;
;;     s8  = a0  * b8  + a1  * b7  + a2  * b6 + a3  * b5 + a4  * b4 + a5  * b3 + a6  * b2 + a7  * b1 + a8  * b0;
;;     s9  = a0  * b9  + a1  * b8  + a2  * b7 + a3  * b6 + a4  * b5 + a5  * b4 + a6  * b3 + a7  * b2 + a8  * b1 + a9  * b0;
;;     s10 = a0  * b10 + a1  * b9  + a2  * b8 + a3  * b7 + a4  * b6 + a5  * b5 + a6  * b4 + a7  * b3 + a8  * b2 + a9  * b1 + a10 * b0;
;;     s11 = a0  * b11 + a1  * b10 + a2  * b9 + a3  * b8 + a4  * b7 + a5  * b6 + a6  * b5 + a7  * b4 + a8  * b3 + a9  * b2 + a10 * b1 + a11 * b0;
;;     s12 = a1  * b11 + a2  * b10 + a3  * b9 + a4  * b8 + a5  * b7 + a6  * b6 + a7  * b5 + a8  * b4 + a9  * b3 + a10 * b2 + a11 * b1;
;;     s13 = a2  * b11 + a3  * b10 + a4  * b9 + a5  * b8 + a6  * b7 + a7  * b6 + a8  * b5 + a9  * b4 + a10 * b3 + a11 * b2;
;;     s14 = a3  * b11 + a4  * b10 + a5  * b9 + a6  * b8 + a7  * b7 + a8  * b6 + a9  * b5 + a10 * b4 + a11 * b3;
;;     s15 = a4  * b11 + a5  * b10 + a6  * b9 + a7  * b8 + a8  * b7 + a9  * b6 + a10 * b5 + a11 * b4;
;;     s16 = a5  * b11 + a6  * b10 + a7  * b9 + a8  * b8 + a9  * b7 + a10 * b6 + a11 * b5;
;;     s17 = a6  * b11 + a7  * b10 + a8  * b9 + a9  * b8 + a10 * b7 + a11 * b6;
;;     s18 = a7  * b11 + a8  * b10 + a9  * b9 + a10 * b8 + a11 * b7;
;;     s19 = a8  * b11 + a9  * b10 + a10 * b9 + a11 * b8;
;;     s20 = a9  * b11 + a10 * b10 + a11 * b9;
;;     s21 = a10 * b11 + a11 * b10;
;;     s22 = a11 * b11;
;;     s23 = 0;
    
    (set_local $s0  (i64.mul (get_local $a0) (get_local $b0)))
    (set_local $s1  (i64.add (i64.mul (get_local $a0) (get_local $b1 )) (i64.mul (get_local $a1) (get_local $b0))))
    (set_local $s2  (i64.add (i64.mul (get_local $a0) (get_local $b2 )) (i64.add (i64.mul (get_local $a1) (get_local $b1 )) (i64.mul (get_local $a2) (get_local $b0)))))
    (set_local $s3  (i64.add (i64.mul (get_local $a0) (get_local $b3 )) (i64.add (i64.mul (get_local $a1) (get_local $b2 )) (i64.add (i64.mul (get_local $a2) (get_local $b1)) (i64.mul (get_local $a3) (get_local $b0))))))
    (set_local $s4  (i64.add (i64.mul (get_local $a0) (get_local $b4 )) (i64.add (i64.mul (get_local $a1) (get_local $b3 )) (i64.add (i64.mul (get_local $a2) (get_local $b2)) (i64.add (i64.mul (get_local $a3) (get_local $b1)) (i64.mul (get_local $a4) (get_local $b0)))))))
    (set_local $s5  (i64.add (i64.mul (get_local $a0) (get_local $b5 )) (i64.add (i64.mul (get_local $a1) (get_local $b4 )) (i64.add (i64.mul (get_local $a2) (get_local $b3)) (i64.add (i64.mul (get_local $a3) (get_local $b2)) (i64.add (i64.mul (get_local $a4) (get_local $b1)) (i64.mul (get_local $a5) (get_local $b0))))))))
    (set_local $s6  (i64.add (i64.mul (get_local $a0) (get_local $b6 )) (i64.add (i64.mul (get_local $a1) (get_local $b5 )) (i64.add (i64.mul (get_local $a2) (get_local $b4)) (i64.add (i64.mul (get_local $a3) (get_local $b3)) (i64.add (i64.mul (get_local $a4) (get_local $b2)) (i64.add (i64.mul (get_local $a5) (get_local $b1)) (i64.mul (get_local $a6) (get_local $b0)))))))))
    (set_local $s7  (i64.add (i64.mul (get_local $a0) (get_local $b7 )) (i64.add (i64.mul (get_local $a1) (get_local $b6 )) (i64.add (i64.mul (get_local $a2) (get_local $b5)) (i64.add (i64.mul (get_local $a3) (get_local $b4)) (i64.add (i64.mul (get_local $a4) (get_local $b3)) (i64.add (i64.mul (get_local $a5) (get_local $b2)) (i64.add (i64.mul (get_local $a6) (get_local $b1)) (i64.mul (get_local $a7) (get_local $b0))))))))))
    (set_local $s8  (i64.add (i64.mul (get_local $a0) (get_local $b8 )) (i64.add (i64.mul (get_local $a1) (get_local $b7 )) (i64.add (i64.mul (get_local $a2) (get_local $b6)) (i64.add (i64.mul (get_local $a3) (get_local $b5)) (i64.add (i64.mul (get_local $a4) (get_local $b4)) (i64.add (i64.mul (get_local $a5) (get_local $b3)) (i64.add (i64.mul (get_local $a6) (get_local $b2)) (i64.add (i64.mul (get_local $a7) (get_local $b1)) (i64.mul (get_local $a8) (get_local $b0)))))))))))
    (set_local $s9  (i64.add (i64.mul (get_local $a0) (get_local $b9 )) (i64.add (i64.mul (get_local $a1) (get_local $b8 )) (i64.add (i64.mul (get_local $a2) (get_local $b7)) (i64.add (i64.mul (get_local $a3) (get_local $b6)) (i64.add (i64.mul (get_local $a4) (get_local $b5)) (i64.add (i64.mul (get_local $a5) (get_local $b4)) (i64.add (i64.mul (get_local $a6) (get_local $b3)) (i64.add (i64.mul (get_local $a7) (get_local $b2)) (i64.add (i64.mul (get_local $a8) (get_local $b1)) (i64.mul (get_local $a9) (get_local $b0))))))))))))
    (set_local $s10 (i64.add (i64.mul (get_local $a0) (get_local $b10)) (i64.add (i64.mul (get_local $a1) (get_local $b9 )) (i64.add (i64.mul (get_local $a2) (get_local $b8)) (i64.add (i64.mul (get_local $a3) (get_local $b7)) (i64.add (i64.mul (get_local $a4) (get_local $b6)) (i64.add (i64.mul (get_local $a5) (get_local $b5)) (i64.add (i64.mul (get_local $a6) (get_local $b4)) (i64.add (i64.mul (get_local $a7) (get_local $b3)) (i64.add (i64.mul (get_local $a8) (get_local $b2)) (i64.add (i64.mul (get_local $a9) (get_local $b1) (i64.mul (get_local $a10) (get_local $b0))))))))))))))
    (set_local $s11 (i64.add (i64.mul (get_local $a0) (get_local $b11)) (i64.add (i64.mul (get_local $a1) (get_local $b10)) (i64.add (i64.mul (get_local $a2) (get_local $b9)) (i64.add (i64.mul (get_local $a3) (get_local $b8)) (i64.add (i64.mul (get_local $a4) (get_local $b7)) (i64.add (i64.mul (get_local $a5) (get_local $b6)) (i64.add (i64.mul (get_local $a6) (get_local $b5)) (i64.add (i64.mul (get_local $a7) (get_local $b4)) (i64.add (i64.mul (get_local $a8) (get_local $b3)) (i64.add (i64.mul (get_local $a9) (get_local $b2)) (i64.add (i64.mul (get_local $a10) (get_local $b1)) (i64.mul (get_local $a11) (get_local $b0))))))))))))))
    (set_local $s12 (i64.add (i64.mul (get_local $a1) (get_local $b11)) (i64.add (i64.mul (get_local $a2) (get_local $b10)) (i64.add (i64.mul (get_local $a3) (get_local $b9)) (i64.add (i64.mul (get_local $a4) (get_local $b8)) (i64.add (i64.mul (get_local $a5) (get_local $b7)) (i64.add (i64.mul (get_local $a6) (get_local $b6)) (i64.add (i64.mul (get_local $a7) (get_local $b5)) (i64.add (i64.mul (get_local $a8) (get_local $b4)) (i64.add (i64.mul (get_local $a9) (get_local $b3)) (i64.add (i64.mul (get_local $a10) (get_local $b2)) (i64.mul (get_local $a11) (get_local $b1)))))))))))))
    (set_local $s13 (i64.add (i64.mul (get_local $a2) (get_local $b11)) (i64.add (i64.mul (get_local $a3) (get_local $b10)) (i64.add (i64.mul (get_local $a4) (get_local $b9)) (i64.add (i64.mul (get_local $a5) (get_local $b8)) (i64.add (i64.mul (get_local $a6) (get_local $b7)) (i64.add (i64.mul (get_local $a7) (get_local $b6)) (i64.add (i64.mul (get_local $a8) (get_local $b5)) (i64.add (i64.mul (get_local $a9) (get_local $b4)) (i64.add (i64.mul (get_local $a10) (get_local $b3)) (i64.mul (get_local $a11) (get_local $b2))))))))))))
    (set_local $s14 (i64.add (i64.mul (get_local $a3) (get_local $b11)) (i64.add (i64.mul (get_local $a4) (get_local $b10)) (i64.add (i64.mul (get_local $a5) (get_local $b9)) (i64.add (i64.mul (get_local $a6) (get_local $b8)) (i64.add (i64.mul (get_local $a7) (get_local $b7)) (i64.add (i64.mul (get_local $a8) (get_local $b6)) (i64.add (i64.mul (get_local $a9) (get_local $b5)) (i64.add (i64.mul (get_local $a10) (get_local $b4)) (i64.mul (get_local $a11) (get_local $b3)))))))))))
    (set_local $s15 (i64.add (i64.mul (get_local $a4) (get_local $b11)) (i64.add (i64.mul (get_local $a5) (get_local $b10)) (i64.add (i64.mul (get_local $a6) (get_local $b9)) (i64.add (i64.mul (get_local $a7) (get_local $b8)) (i64.add (i64.mul (get_local $a8) (get_local $b7)) (i64.add (i64.mul (get_local $a9) (get_local $b6)) (i64.add (i64.mul (get_local $a10) (get_local $b5)) (i64.mul (get_local $a11) (get_local $b4))))))))))
    (set_local $s16 (i64.add (i64.mul (get_local $a5) (get_local $b11)) (i64.add (i64.mul (get_local $a6) (get_local $b10)) (i64.add (i64.mul (get_local $a7) (get_local $b9)) (i64.add (i64.mul (get_local $a8) (get_local $b8)) (i64.add (i64.mul (get_local $a9) (get_local $b7)) (i64.add (i64.mul (get_local $a10) (get_local $b6)) (i64.mul (get_local $a11) (get_local $b5)))))))))
    (set_local $s17 (i64.add (i64.mul (get_local $a6) (get_local $b11)) (i64.add (i64.mul (get_local $a7) (get_local $b10)) (i64.add (i64.mul (get_local $a8) (get_local $b9)) (i64.add (i64.mul (get_local $a9) (get_local $b8)) (i64.add (i64.mul (get_local $a10) (get_local $b7)) (i64.mul (get_local $a11) (get_local $b6))))))))
    (set_local $s18 (i64.add (i64.mul (get_local $a7) (get_local $b11)) (i64.add (i64.mul (get_local $a8) (get_local $b10)) (i64.add (i64.mul (get_local $a9) (get_local $b9)) (i64.add (i64.mul (get_local $a10) (get_local $b8)) (i64.mul (get_local $a11) (get_local $b7)))))))
    (set_local $s19 (i64.add (i64.mul (get_local $a8) (get_local $b11)) (i64.add (i64.mul (get_local $a9) (get_local $b10)) (i64.add (i64.mul (get_local $a10) (get_local $b9)) (i64.mul (get_local $a11) (get_local $b8))))))
    (set_local $s20 (i64.add (i64.mul (get_local $a9) (get_local $b11)) (i64.add (i64.mul (get_local $a10) (get_local $b10))  (i64.mul (get_local $a11) (get_local $b9)))))
    (set_local $s21 (i64.add (i64.mul (get_local $a10) (get_local $b11)) (i64.mul (get_local $a11) (get_local $b10))))
    (set_local $s22 (i64.mul (get_local $a11) (get_local $b11)))
    (set_local $s23 (i64.const 0))

;;     carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
;;     s1 += carry0;
;;     s0 -= carry0 * ((uint64_t) 1L << 21);
;;     carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
;;     s3 += carry2;
;;     s2 -= carry2 * ((uint64_t) 1L << 21);
;;     carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
;;     s5 += carry4;
;;     s4 -= carry4 * ((uint64_t) 1L << 21);
;;     carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
;;     s7 += carry6;
;;     s6 -= carry6 * ((uint64_t) 1L << 21);
;;     carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
;;     s9 += carry8;
;;     s8 -= carry8 * ((uint64_t) 1L << 21);
;;     carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
;;     s11 += carry10;
;;     s10 -= carry10 * ((uint64_t) 1L << 21);
;;     carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
;;     s13 += carry12;
;;     s12 -= carry12 * ((uint64_t) 1L << 21);
;;     carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
;;     s15 += carry14;
;;     s14 -= carry14 * ((uint64_t) 1L << 21);
;;     carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
;;     s17 += carry16;
;;     s16 -= carry16 * ((uint64_t) 1L << 21);
;;     carry18 = (s18 + (int64_t) (1L << 20)) >> 21;
;;     s19 += carry18;
;;     s18 -= carry18 * ((uint64_t) 1L << 21);
;;     carry20 = (s20 + (int64_t) (1L << 20)) >> 21;
;;     s21 += carry20;
;;     s20 -= carry20 * ((uint64_t) 1L << 21);
;;     carry22 = (s22 + (int64_t) (1L << 20)) >> 21;
;;     s23 += carry22;
;;     s22 -= carry22 * ((uint64_t) 1L << 21);

    (set_local $carry0 (i64.shr_s (i64.add (get_local $s0) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s1 (i64.add (get_local $s1) (get_local $carry0)))
    (set_local $s0 (i64.sub (get_local $s0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry2 (i64.shr_s (i64.add (get_local $s2) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s3 (i64.add (get_local $s3) (get_local $carry2)))
    (set_local $s2 (i64.sub (get_local $s2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry4 (i64.shr_s (i64.add (get_local $s4) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s5 (i64.add (get_local $s5) (get_local $carry4)))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry6 (i64.shr_s (i64.add (get_local $s6) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s7 (i64.add (get_local $s7) (get_local $carry6)))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry8 (i64.shr_s (i64.add (get_local $s8) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s9 (i64.add (get_local $s9) (get_local $carry8)))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry10 (i64.shr_s (i64.add (get_local $s10) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s11 (i64.add (get_local $s11) (get_local $carry10)))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $carry10) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry12 (i64.shr_s (i64.add (get_local $s12) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s13 (i64.add (get_local $s13) (get_local $carry12)))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $carry12) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry14 (i64.shr_s (i64.add (get_local $s14) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s15 (i64.add (get_local $s15) (get_local $carry14)))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $carry14) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry16 (i64.shr_s (i64.add (get_local $s16) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s17 (i64.add (get_local $s17) (get_local $carry16)))
    (set_local $s16 (i64.sub (get_local $s16) (i64.mul (get_local $carry16) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry18 (i64.shr_s (i64.add (get_local $s18) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s19 (i64.add (get_local $s19) (get_local $carry18)))
    (set_local $s18 (i64.sub (get_local $s18) (i64.mul (get_local $carry18) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry20 (i64.shr_s (i64.add (get_local $s20) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s21 (i64.add (get_local $s21) (get_local $carry20)))
    (set_local $s20 (i64.sub (get_local $s20) (i64.mul (get_local $carry20) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry22 (i64.shr_s (i64.add (get_local $s22) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s23 (i64.add (get_local $s23) (get_local $carry22)))
    (set_local $s22 (i64.sub (get_local $s22) (i64.mul (get_local $carry22) (i64.shl (i64.const 1) (i64.const 21)))))

;;     carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
;;     s2 += carry1;
;;     s1 -= carry1 * ((uint64_t) 1L << 21);
;;     carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
;;     s4 += carry3;
;;     s3 -= carry3 * ((uint64_t) 1L << 21);
;;     carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
;;     s6 += carry5;
;;     s5 -= carry5 * ((uint64_t) 1L << 21);
;;     carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
;;     s8 += carry7;
;;     s7 -= carry7 * ((uint64_t) 1L << 21);
;;     carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
;;     s10 += carry9;
;;     s9 -= carry9 * ((uint64_t) 1L << 21);
;;     carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
;;     s12 += carry11;
;;     s11 -= carry11 * ((uint64_t) 1L << 21);
;;     carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
;;     s14 += carry13;
;;     s13 -= carry13 * ((uint64_t) 1L << 21);
;;     carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
;;     s16 += carry15;
;;     s15 -= carry15 * ((uint64_t) 1L << 21);
;;     carry17 = (s17 + (int64_t) (1L << 20)) >> 21;
;;     s18 += carry17;
;;     s17 -= carry17 * ((uint64_t) 1L << 21);
;;     carry19 = (s19 + (int64_t) (1L << 20)) >> 21;
;;     s20 += carry19;
;;     s19 -= carry19 * ((uint64_t) 1L << 21);
;;     carry21 = (s21 + (int64_t) (1L << 20)) >> 21;
;;     s22 += carry21;
;;     s21 -= carry21 * ((uint64_t) 1L << 21);

    (set_local $carry1 (i64.shr_s (i64.add (get_local $s1) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s2 (i64.add (get_local $s2) (get_local $carry1)))
    (set_local $s1 (i64.sub (get_local $s1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry3 (i64.shr_s (i64.add (get_local $s3) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s4 (i64.add (get_local $s4) (get_local $carry3)))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry5 (i64.shr_s (i64.add (get_local $s5) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s6 (i64.add (get_local $s6) (get_local $carry5)))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry7 (i64.shr_s (i64.add (get_local $s7) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s8 (i64.add (get_local $s8) (get_local $carry7)))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry9 (i64.shr_s (i64.add (get_local $s9) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s10 (i64.add (get_local $s10) (get_local $carry9)))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry11 (i64.shr_s (i64.add (get_local $s11) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s12 (i64.add (get_local $s12) (get_local $carry11)))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $carry11) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry13 (i64.shr_s (i64.add (get_local $s13) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s14 (i64.add (get_local $s14) (get_local $carry13)))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $carry13) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry15 (i64.shr_s (i64.add (get_local $s15) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s16 (i64.add (get_local $s16) (get_local $carry15)))
    (set_local $s15 (i64.sub (get_local $s15) (i64.mul (get_local $carry15) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry17 (i64.shr_s (i64.add (get_local $s17) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s18 (i64.add (get_local $s18) (get_local $carry17)))
    (set_local $s17 (i64.sub (get_local $s17) (i64.mul (get_local $carry17) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry19 (i64.shr_s (i64.add (get_local $s19) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s20 (i64.add (get_local $s20) (get_local $carry19)))
    (set_local $s19 (i64.sub (get_local $s19) (i64.mul (get_local $carry19) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry21 (i64.shr_s (i64.add (get_local $s21) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s22 (i64.add (get_local $s22) (get_local $carry21)))
    (set_local $s21 (i64.sub (get_local $s21) (i64.mul (get_local $carry21) (i64.shl (i64.const 1) (i64.const 21)))))

;;     s11 += s23 * 666643;
;;     s12 += s23 * 470296;
;;     s13 += s23 * 654183;
;;     s14 -= s23 * 997805;
;;     s15 += s23 * 136657;
;;     s16 -= s23 * 683901;

    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s23) (i64.const 666643))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s23) (i64.const 470296))))
    (set_local $s13 (i64.add (get_local $s13) (i64.mul (get_local $s23) (i64.const 654183))))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $s23) (i64.const 997805))))
    (set_local $s15 (i64.add (get_local $s15) (i64.mul (get_local $s23) (i64.const 136657))))
    (set_local $s16 (i64.sub (get_local $s16) (i64.mul (get_local $s23) (i64.const 683901))))
;;     s10 += s22 * 666643;
;;     s11 += s22 * 470296;
;;     s12 += s22 * 654183;
;;     s13 -= s22 * 997805;
;;     s14 += s22 * 136657;
;;     s15 -= s22 * 683901;


    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s22) (i64.const 666643))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s22) (i64.const 470296))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s22) (i64.const 654183))))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $s22) (i64.const 997805))))
    (set_local $s14 (i64.add (get_local $s14) (i64.mul (get_local $s22) (i64.const 136657))))
    (set_local $s15 (i64.sub (get_local $s15) (i64.mul (get_local $s22) (i64.const 683901))))

;;     s9 += s21 * 666643;
;;     s10 += s21 * 470296;
;;     s11 += s21 * 654183;
;;     s12 -= s21 * 997805;
;;     s13 += s21 * 136657;
;;     s14 -= s21 * 683901;

    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s21) (i64.const 666643))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s21) (i64.const 470296))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s21) (i64.const 654183))))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $s21) (i64.const 997805))))
    (set_local $s13 (i64.add (get_local $s13) (i64.mul (get_local $s21) (i64.const 136657))))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $s21) (i64.const 683901))))
;;     s8 += s20 * 666643;
;;     s9 += s20 * 470296;
;;     s10 += s20 * 654183;
;;     s11 -= s20 * 997805;
;;     s12 += s20 * 136657;
;;     s13 -= s20 * 683901;

    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s20) (i64.const 666643))))
    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s20) (i64.const 470296))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s20) (i64.const 654183))))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $s20) (i64.const 997805))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s20) (i64.const 136657))))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $s20) (i64.const 683901))))

;;     s7 += s19 * 666643;
;;     s8 += s19 * 470296;
;;     s9 += s19 * 654183;
;;     s10 -= s19 * 997805;
;;     s11 += s19 * 136657;
;;     s12 -= s19 * 683901;

    (set_local $s7  (i64.add (get_local $s7 ) (i64.mul (get_local $s19) (i64.const 666643))))
    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s19) (i64.const 470296))))
    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s19) (i64.const 654183))))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $s19) (i64.const 997805))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s19) (i64.const 136657))))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $s19) (i64.const 683901))))

;;     s6 += s18 * 666643;
;;     s7 += s18 * 470296;
;;     s8 += s18 * 654183;
;;     s9 -= s18 * 997805;
;;     s10 += s18 * 136657;
;;     s11 -= s18 * 683901;


    (set_local $s6  (i64.add (get_local $s6 ) (i64.mul (get_local $s18) (i64.const 666643))))
    (set_local $s7  (i64.add (get_local $s7 ) (i64.mul (get_local $s18) (i64.const 470296))))
    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s18) (i64.const 654183))))
    (set_local $s9  (i64.sub (get_local $s9 ) (i64.mul (get_local $s18) (i64.const 997805))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s18) (i64.const 136657))))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $s18) (i64.const 683901))))


;;     carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
;;     s7 += carry6;
;;     s6 -= carry6 * ((uint64_t) 1L << 21);
;;     carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
;;     s9 += carry8;
;;     s8 -= carry8 * ((uint64_t) 1L << 21);
;;     carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
;;     s11 += carry10;
;;     s10 -= carry10 * ((uint64_t) 1L << 21);
;;     carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
;;     s13 += carry12;
;;     s12 -= carry12 * ((uint64_t) 1L << 21);
;;     carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
;;     s15 += carry14;
;;     s14 -= carry14 * ((uint64_t) 1L << 21);
;;     carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
;;     s17 += carry16;
;;     s16 -= carry16 * ((uint64_t) 1L << 21);

    (set_local $carry6 (i64.shr_s (i64.add (get_local $s6) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s7 (i64.add (get_local $s7) (get_local $carry6)))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry8 (i64.shr_s (i64.add (get_local $s8) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s9 (i64.add (get_local $s9) (get_local $carry8)))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry10 (i64.shr_s (i64.add (get_local $s10) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s11 (i64.add (get_local $s11) (get_local $carry10)))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $carry10) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry12 (i64.shr_s (i64.add (get_local $s12) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s13 (i64.add (get_local $s13) (get_local $carry12)))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $carry12) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry14 (i64.shr_s (i64.add (get_local $s14) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s15 (i64.add (get_local $s15) (get_local $carry14)))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $carry14) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry16 (i64.shr_s (i64.add (get_local $s16) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s17 (i64.add (get_local $s17) (get_local $carry16)))
    (set_local $s16 (i64.sub (get_local $s16) (i64.mul (get_local $carry16) (i64.shl (i64.const 1) (i64.const 21)))))


;;     carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
;;     s8 += carry7;
;;     s7 -= carry7 * ((uint64_t) 1L << 21);
;;     carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
;;     s10 += carry9;
;;     s9 -= carry9 * ((uint64_t) 1L << 21);
;;     carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
;;     s12 += carry11;
;;     s11 -= carry11 * ((uint64_t) 1L << 21);
;;     carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
;;     s14 += carry13;
;;     s13 -= carry13 * ((uint64_t) 1L << 21);
;;     carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
;;     s16 += carry15;
;;     s15 -= carry15 * ((uint64_t) 1L << 21);

    (set_local $carry7 (i64.shr_s (i64.add (get_local $s7) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s8 (i64.add (get_local $s8) (get_local $carry7)))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry9 (i64.shr_s (i64.add (get_local $s9) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s10 (i64.add (get_local $s10) (get_local $carry9)))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry11 (i64.shr_s (i64.add (get_local $s11) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s12 (i64.add (get_local $s12) (get_local $carry11)))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $carry11) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry13 (i64.shr_s (i64.add (get_local $s13) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s14 (i64.add (get_local $s14) (get_local $carry13)))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $carry13) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry15 (i64.shr_s (i64.add (get_local $s15) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s16 (i64.add (get_local $s16) (get_local $carry15)))
    (set_local $s15 (i64.sub (get_local $s15) (i64.mul (get_local $carry15) (i64.shl (i64.const 1) (i64.const 21)))))

;;     s5 += s17 * 666643;
;;     s6 += s17 * 470296;
;;     s7 += s17 * 654183;
;;     s8 -= s17 * 997805;
;;     s9 += s17 * 136657;
;;     s10 -= s17 * 683901;

    (set_local $s5 (i64.add (get_local $s5 ) (i64.mul (get_local $s17) (i64.const 666643))))
    (set_local $s6 (i64.add (get_local $s6 ) (i64.mul (get_local $s17) (i64.const 470296))))
    (set_local $s7 (i64.add (get_local $s7 ) (i64.mul (get_local $s17) (i64.const 654183))))
    (set_local $s8 (i64.sub (get_local $s8 ) (i64.mul (get_local $s17) (i64.const 997805))))
    (set_local $s9 (i64.add (get_local $s9 ) (i64.mul (get_local $s17) (i64.const 136657))))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $s17) (i64.const 683901))))
;;     s4 += s16 * 666643;
;;     s5 += s16 * 470296;
;;     s6 += s16 * 654183;
;;     s7 -= s16 * 997805;
;;     s8 += s16 * 136657;
;;     s9 -= s16 * 683901;

    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s16) (i64.const 666643))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s16) (i64.const 470296))))
    (set_local $s6 (i64.add (get_local $s6) (i64.mul (get_local $s16) (i64.const 654183))))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $s16) (i64.const 997805))))
    (set_local $s8 (i64.add (get_local $s8) (i64.mul (get_local $s16) (i64.const 136657))))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $s16) (i64.const 683901))))

;;     s3 += s15 * 666643;
;;     s4 += s15 * 470296;
;;     s5 += s15 * 654183;
;;     s6 -= s15 * 997805;
;;     s7 += s15 * 136657;
;;     s8 -= s15 * 683901;


    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s15) (i64.const 666643))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s15) (i64.const 470296))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s15) (i64.const 654183))))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $s15) (i64.const 997805))))
    (set_local $s7 (i64.add (get_local $s7) (i64.mul (get_local $s15) (i64.const 136657))))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $s15) (i64.const 683901))))
;;     s2 += s14 * 666643;
;;     s3 += s14 * 470296;
;;     s4 += s14 * 654183;
;;     s5 -= s14 * 997805;
;;     s6 += s14 * 136657;
;;     s7 -= s14 * 683901;

    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s14) (i64.const 666643))))
    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s14) (i64.const 470296))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s14) (i64.const 654183))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s14) (i64.const 997805))))
    (set_local $s6 (i64.add (get_local $s6) (i64.mul (get_local $s14) (i64.const 136657))))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $s14) (i64.const 683901))))

;;     s1 += s13 * 666643;
;;     s2 += s13 * 470296;
;;     s3 += s13 * 654183;
;;     s4 -= s13 * 997805;
;;     s5 += s13 * 136657;
;;     s6 -= s13 * 683901;

    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s13) (i64.const 666643))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s13) (i64.const 470296))))
    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s13) (i64.const 654183))))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $s13) (i64.const 997805))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s13) (i64.const 136657))))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $s13) (i64.const 683901))))

;;     s0 += s12 * 666643;
;;     s1 += s12 * 470296;
;;     s2 += s12 * 654183;
;;     s3 -= s12 * 997805;
;;     s4 += s12 * 136657;
;;     s5 -= s12 * 683901;
;;     s12 = 0;

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))
    (set_local $s12 (i64.const 0))

;;     carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
;;     s1 += carry0;
;;     s0 -= carry0 * ((uint64_t) 1L << 21);
;;     carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
;;     s3 += carry2;
;;     s2 -= carry2 * ((uint64_t) 1L << 21);
;;     carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
;;     s5 += carry4;
;;     s4 -= carry4 * ((uint64_t) 1L << 21);
;;     carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
;;     s7 += carry6;
;;     s6 -= carry6 * ((uint64_t) 1L << 21);
;;     carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
;;     s9 += carry8;
;;     s8 -= carry8 * ((uint64_t) 1L << 21);

    (set_local $carry0 (i64.shr_s (i64.add (get_local $s0) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s1 (i64.add (get_local $s1) (get_local $carry0)))
    (set_local $s0 (i64.sub (get_local $s0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry2 (i64.shr_s (i64.add (get_local $s2) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s3 (i64.add (get_local $s3) (get_local $carry2)))
    (set_local $s2 (i64.sub (get_local $s2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry4 (i64.shr_s (i64.add (get_local $s4) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s5 (i64.add (get_local $s5) (get_local $carry4)))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry6 (i64.shr_s (i64.add (get_local $s6) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s7 (i64.add (get_local $s7) (get_local $carry6)))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry8 (i64.shr_s (i64.add (get_local $s8) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s9 (i64.add (get_local $s9) (get_local $carry8)))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 21)))))

;; ************************************** bug is in next 3 lines
;;     carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
;;     s11 += carry10;
;;     s10 -= carry10 * ((uint64_t) 1L << 21);

    (set_local $carry10 (i64.shr_s (i64.add (get_local $s10) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s11 (i64.add (get_local $s11) (get_local $carry10)))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $carry10) (i64.shl (i64.const 1) (i64.const 21)))))

;;     carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
;;     s2 += carry1;
;;     s1 -= carry1 * ((uint64_t) 1L << 21);
;;     carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
;;     s4 += carry3;
;;     s3 -= carry3 * ((uint64_t) 1L << 21);
;;     carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
;;     s6 += carry5;
;;     s5 -= carry5 * ((uint64_t) 1L << 21);
;;     carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
;;     s8 += carry7;
;;     s7 -= carry7 * ((uint64_t) 1L << 21);
;;     carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
;;     s10 += carry9;
;;     s9 -= carry9 * ((uint64_t) 1L << 21);
;;     carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
;;     s12 += carry11;
;;     s11 -= carry11 * ((uint64_t) 1L << 21);

    (set_local $carry1 (i64.shr_s (i64.add (get_local $s1) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s2 (i64.add (get_local $s2) (get_local $carry1)))
    (set_local $s1 (i64.sub (get_local $s1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry3 (i64.shr_s (i64.add (get_local $s3) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s4 (i64.add (get_local $s4) (get_local $carry3)))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry5 (i64.shr_s (i64.add (get_local $s5) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s6 (i64.add (get_local $s6) (get_local $carry5)))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry7 (i64.shr_s (i64.add (get_local $s7) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s8 (i64.add (get_local $s8) (get_local $carry7)))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry9 (i64.shr_s (i64.add (get_local $s9) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s10 (i64.add (get_local $s10) (get_local $carry9)))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry11 (i64.shr_s (i64.add (get_local $s11) (i64.shl (i64.const 1) (i64.const 20))) (i64.const 21)))
    (set_local $s12 (i64.add (get_local $s12) (get_local $carry11)))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $carry11) (i64.shl (i64.const 1) (i64.const 21)))))


;;     s0 += s12 * 666643;
;;     s1 += s12 * 470296;
;;     s2 += s12 * 654183;
;;     s3 -= s12 * 997805;
;;     s4 += s12 * 136657;
;;     s5 -= s12 * 683901;
;;     s12 = 0;

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))

;;     carry0 = s0 >> 21;
;;     s1 += carry0;
;;     s0 -= carry0 * ((uint64_t) 1L << 21);
;;     carry1 = s1 >> 21;
;;     s2 += carry1;
;;     s1 -= carry1 * ((uint64_t) 1L << 21);
;;     carry2 = s2 >> 21;
;;     s3 += carry2;
;;     s2 -= carry2 * ((uint64_t) 1L << 21);
;;     carry3 = s3 >> 21;
;;     s4 += carry3;
;;     s3 -= carry3 * ((uint64_t) 1L << 21);
;;     carry4 = s4 >> 21;
;;     s5 += carry4;
;;     s4 -= carry4 * ((uint64_t) 1L << 21);
;;     carry5 = s5 >> 21;
;;     s6 += carry5;
;;     s5 -= carry5 * ((uint64_t) 1L << 21);
;;     carry6 = s6 >> 21;
;;     s7 += carry6;
;;     s6 -= carry6 * ((uint64_t) 1L << 21);
;;     carry7 = s7 >> 21;
;;     s8 += carry7;
;;     s7 -= carry7 * ((uint64_t) 1L << 21);
;;     carry8 = s8 >> 21;
;;     s9 += carry8;
;;     s8 -= carry8 * ((uint64_t) 1L << 21);
;;     carry9 = s9 >> 21;
;;     s10 += carry9;
;;     s9 -= carry9 * ((uint64_t) 1L << 21);
;;     carry10 = s10 >> 21;
;;     s11 += carry10;
;;     s10 -= carry10 * ((uint64_t) 1L << 21);
;;     carry11 = s11 >> 21;
;;     s12 += carry11;
;;     s11 -= carry11 * ((uint64_t) 1L << 21);


    (set_local $carry0 (i64.shr_s (get_local $s0) (i64.const 21)))
    (set_local $s1 (i64.add (get_local $s1) (get_local $carry0)))
    (set_local $s0 (i64.sub (get_local $s0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry1 (i64.shr_s (get_local $s1) (i64.const 21)))
    (set_local $s2 (i64.add (get_local $s2) (get_local $carry1)))
    (set_local $s1 (i64.sub (get_local $s1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry2 (i64.shr_s (get_local $s2) (i64.const 21)))
    (set_local $s3 (i64.add (get_local $s3) (get_local $carry2)))
    (set_local $s2 (i64.sub (get_local $s2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry3 (i64.shr_s (get_local $s3) (i64.const 21)))
    (set_local $s4 (i64.add (get_local $s4) (get_local $carry3)))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry4 (i64.shr_s (get_local $s4) (i64.const 21)))
    (set_local $s5 (i64.add (get_local $s5) (get_local $carry4)))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 21)))))
    
    (set_local $carry5 (i64.shr_s (get_local $s5) (i64.const 21)))
    (set_local $s6 (i64.add (get_local $s6) (get_local $carry5)))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry6 (i64.shr_s (get_local $s6) (i64.const 21)))
    (set_local $s7 (i64.add (get_local $s7) (get_local $carry6)))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry7 (i64.shr_s (get_local $s7) (i64.const 21)))
    (set_local $s8 (i64.add (get_local $s8) (get_local $carry7)))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry8 (i64.shr_s (get_local $s8) (i64.const 21)))
    (set_local $s9 (i64.add (get_local $s9) (get_local $carry8)))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry9 (i64.shr_s (get_local $s9) (i64.const 21)))
    (set_local $s10 (i64.add (get_local $s10) (get_local $carry9)))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry10 (i64.shr_s (get_local $s10) (i64.const 21)))
    (set_local $s11 (i64.add (get_local $s11) (get_local $carry10)))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $carry10) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry11 (i64.shr_s (get_local $s11) (i64.const 21)))
    (set_local $s12 (i64.add (get_local $s12) (get_local $carry11)))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $carry11) (i64.shl (i64.const 1) (i64.const 21)))))

    ;; (call $i64.log (get_local $carry0 ))
    ;; (call $i32.log (i32.const 0 ))
    ;; (call $i64.log (get_local $carry1 ))
    ;; (call $i32.log (i32.const 1 ))
    ;; (call $i64.log (get_local $carry2 ))
    ;; (call $i32.log (i32.const 2 ))
    ;; (call $i64.log (get_local $carry3 ))
    ;; (call $i32.log (i32.const 3 ))
    ;; (call $i64.log (get_local $carry4 ))
    ;; (call $i32.log (i32.const 4 ))
    ;; (call $i64.log (get_local $carry5 ))
    ;; (call $i32.log (i32.const 5 ))
    ;; (call $i64.log (get_local $carry6 ))
    ;; (call $i32.log (i32.const 6 ))
    ;; (call $i64.log (get_local $carry7 ))
    ;; (call $i32.log (i32.const 7 ))
    ;; (call $i64.log (get_local $carry8 ))
    ;; (call $i32.log (i32.const 8 ))
    ;; (call $i64.log (get_local $carry9 ))
    ;; (call $i32.log (i32.const 9 ))
    ;; (call $i64.log (get_local $carry10))
    ;; (call $i32.log (i32.const 10))
    ;; (call $i64.log (get_local $carry11))
    ;; (call $i32.log (i32.const 11))
    ;; (call $i64.log (get_local $carry12))
    ;; (call $i32.log (i32.const 12))
    ;; (call $i64.log (get_local $carry13))
    ;; (call $i32.log (i32.const 13))
    ;; (call $i64.log (get_local $carry14))
    ;; (call $i32.log (i32.const 14))
    ;; (call $i64.log (get_local $carry15))
    ;; (call $i32.log (i32.const 15))
    ;; (call $i64.log (get_local $carry16))
    ;; (call $i32.log (i32.const 16))
    ;; (call $i64.log (get_local $carry17))
    ;; (call $i32.log (i32.const 17))
    ;; (call $i64.log (get_local $carry18))
    ;; (call $i32.log (i32.const 18))
    ;; (call $i64.log (get_local $carry19))
    ;; (call $i32.log (i32.const 19))
    ;; (call $i64.log (get_local $carry20))
    ;; (call $i32.log (i32.const 20))
    ;; (call $i64.log (get_local $carry21))
    ;; (call $i32.log (i32.const 21))
    ;; (call $i64.log (get_local $carry22))
    ;; (call $i32.log (i32.const 22))

;;     s0 += s12 * 666643;
;;     s1 += s12 * 470296;
;;     s2 += s12 * 654183;
;;     s3 -= s12 * 997805;
;;     s4 += s12 * 136657;
;;     s5 -= s12 * 683901;

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))


;;     carry0 = s0 >> 21;
;;     s1 += carry0;
;;     s0 -= carry0 * ((uint64_t) 1L << 21);
;;     carry1 = s1 >> 21;
;;     s2 += carry1;
;;     s1 -= carry1 * ((uint64_t) 1L << 21);
;;     carry2 = s2 >> 21;
;;     s3 += carry2;
;;     s2 -= carry2 * ((uint64_t) 1L << 21);
;;     carry3 = s3 >> 21;
;;     s4 += carry3;
;;     s3 -= carry3 * ((uint64_t) 1L << 21);
;;     carry4 = s4 >> 21;
;;     s5 += carry4;
;;     s4 -= carry4 * ((uint64_t) 1L << 21);
;;     carry5 = s5 >> 21;
;;     s6 += carry5;
;;     s5 -= carry5 * ((uint64_t) 1L << 21);
;;     carry6 = s6 >> 21;
;;     s7 += carry6;
;;     s6 -= carry6 * ((uint64_t) 1L << 21);
;;     carry7 = s7 >> 21;
;;     s8 += carry7;
;;     s7 -= carry7 * ((uint64_t) 1L << 21);
;;     carry8 = s8 >> 21;
;;     s9 += carry8;
;;     s8 -= carry8 * ((uint64_t) 1L << 21);
;;     carry9 = s9 >> 21;
;;     s10 += carry9;
;;     s9 -= carry9 * ((uint64_t) 1L << 21);
;;     carry10 = s10 >> 21;
;;     s11 += carry10;
;;     s10 -= carry10 * ((uint64_t) 1L << 21);

    (set_local $carry0 (i64.shr_s (get_local $s0) (i64.const 21)))
    (set_local $s1 (i64.add (get_local $s1) (get_local $carry0)))
    (set_local $s0 (i64.sub (get_local $s0) (i64.mul (get_local $carry0) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry1 (i64.shr_s (get_local $s1) (i64.const 21)))
    (set_local $s2 (i64.add (get_local $s2) (get_local $carry1)))
    (set_local $s1 (i64.sub (get_local $s1) (i64.mul (get_local $carry1) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry2 (i64.shr_s (get_local $s2) (i64.const 21)))
    (set_local $s3 (i64.add (get_local $s3) (get_local $carry2)))
    (set_local $s2 (i64.sub (get_local $s2) (i64.mul (get_local $carry2) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry3 (i64.shr_s (get_local $s3) (i64.const 21)))
    (set_local $s4 (i64.add (get_local $s4) (get_local $carry3)))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $carry3) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry4 (i64.shr_s (get_local $s4) (i64.const 21)))
    (set_local $s5 (i64.add (get_local $s5) (get_local $carry4)))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $carry4) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry5 (i64.shr_s (get_local $s5) (i64.const 21)))
    (set_local $s6 (i64.add (get_local $s6) (get_local $carry5)))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $carry5) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry6 (i64.shr_s (get_local $s6) (i64.const 21)))
    (set_local $s7 (i64.add (get_local $s7) (get_local $carry6)))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $carry6) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry7 (i64.shr_s (get_local $s7) (i64.const 21)))
    (set_local $s8 (i64.add (get_local $s8) (get_local $carry7)))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $carry7) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry8 (i64.shr_s (get_local $s8) (i64.const 21)))
    (set_local $s9 (i64.add (get_local $s9) (get_local $carry8)))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $carry8) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry9 (i64.shr_s (get_local $s9) (i64.const 21)))
    (set_local $s10 (i64.add (get_local $s10) (get_local $carry9)))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $carry9) (i64.shl (i64.const 1) (i64.const 21)))))

    (set_local $carry10 (i64.shr_s (get_local $s10) (i64.const 21)))
    (set_local $s11 (i64.add (get_local $s11) (get_local $carry10)))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $carry10) (i64.shl (i64.const 1) (i64.const 21)))))

    (call $i64.log (get_local $s0))
    (call $i64.log (get_local $s1))
    (call $i64.log (get_local $s2))
    (call $i64.log (get_local $s3))
    (call $i64.log (get_local $s4))
    (call $i64.log (get_local $s5))
    (call $i64.log (get_local $s6))
    (call $i64.log (get_local $s7))
    (call $i64.log (get_local $s8))
    (call $i64.log (get_local $s9))
    (call $i64.log (get_local $s10))
    (call $i64.log (get_local $s11))

;;     s[0]  = s0 >> 0;
;;     s[1]  = s0 >> 8;
;;     s[2]  = (s0 >> 16) | (s1 * ((uint64_t) 1 << 5));
;;     s[3]  = s1 >> 3;
;;     s[4]  = s1 >> 11;
;;     s[5]  = (s1 >> 19) | (s2 * ((uint64_t) 1 << 2));
;;     s[6]  = s2 >> 6;
;;     s[7]  = (s2 >> 14) | (s3 * ((uint64_t) 1 << 7));

    (get_local $s)

    (i64.and (get_local $s0) (i64.const 0xff))
    (i64.and (get_local $s0) (i64.const 0xff00))
    (i64.or)
    (get_local $s0)
    (i64.shl (i64.mul (get_local $s1) (i64.const 32)) (i64.const 16))
    (i64.or)
    (i64.const 0xff0000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s1) (i64.const 21))
    (i64.const 0xff000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s1) (i64.const 21))
    (i64.const 0xff00000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s1) (i64.const 21))
    (i64.shl (i64.mul (get_local $s2) (i64.const 4)) (i64.const 40))
    (i64.or)
    (i64.const 0xff0000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s2) (i64.const 42))
    (i64.const 0xff000000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s2) (i64.const 42))
    (i64.shl (i64.mul (get_local $s3) (i64.const 128)) (i64.const 56))
    (i64.or)
    (i64.const 0xff00000000000000)
    (i64.and)
    (i64.or)
    
    (i64.store offset=0)

;;     s[8]  = s3 >> 1;
;;     s[9]  = s3 >> 9;
;;     s[10] = (s3 >> 17) | (s4 * ((uint64_t) 1 << 4));
;;     s[11] = s4 >> 4;
;;     s[12] = s4 >> 12;
;;     s[13] = (s4 >> 20) | (s5 * ((uint64_t) 1 << 1));
;;     s[14] = s5 >> 7;
;;     s[15] = (s5 >> 15) | (s6 * ((uint64_t) 1 << 6));

    (get_local $s)

    (i64.and (i64.shr_s (get_local $s3) (i64.const 1)) (i64.const 0xff))
    (i64.and (i64.shr_s (get_local $s3) (i64.const 1)) (i64.const 0xff00))
    (i64.or)
    (i64.shr_s (get_local $s3) (i64.const 1))
    (i64.shl (i64.mul (get_local $s4) (i64.const 16)) (i64.const 16))
    (i64.or)
    (i64.const 0xff0000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s4) (i64.const 20))
    (i64.const 0xff000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s4) (i64.const 20))
    (i64.const 0xff00000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s4) (i64.const 20))
    (i64.shl (i64.mul (get_local $s5) (i64.const 2)) (i64.const 40))
    (i64.or)
    (i64.const 0xff0000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s5) (i64.const 41))
    (i64.const 0xff000000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s5) (i64.const 41))
    (i64.shl (i64.mul (get_local $s6) (i64.const 64)) (i64.const 56))
    (i64.or)
    (i64.const 0xff00000000000000)
    (i64.and)
    (i64.or)

    (i64.store offset=8)

;;     s[16] = s6 >> 2;
;;     s[17] = s6 >> 10;
;;     s[18] = (s6 >> 18) | (s7 * ((uint64_t) 1 << 3));
;;     s[19] = s7 >> 5;
;;     s[20] = s7 >> 13;
;;     s[21] = s8 >> 0;
;;     s[22] = s8 >> 8;
;;     s[23] = (s8 >> 16) | (s9 * ((uint64_t) 1 << 5));

    (get_local $s)

    (i64.and (i64.shr_s (get_local $s6) (i64.const 2)) (i64.const 0xff))
    (i64.and (i64.shr_s (get_local $s6) (i64.const 2)) (i64.const 0xff00))
    (i64.or)
    (i64.shr_s (get_local $s6) (i64.const 2))
    (i64.shl (i64.mul (get_local $s7) (i64.const 8)) (i64.const 16))
    (i64.or)
    (i64.const 0xff0000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s7) (i64.const 19))
    (i64.const 0xff000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s7) (i64.const 19))
    (i64.const 0xff00000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s8) (i64.const 40))
    (i64.const 0xff0000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s8) (i64.const 40))
    (i64.const 0xff000000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s8) (i64.const 40))
    (i64.shl (i64.mul (get_local $s9) (i64.const 32)) (i64.const 56))
    (i64.or)
    (i64.const 0xff00000000000000)
    (i64.and)
    (i64.or)

    (i64.store offset=16)

;;     s[24] = s9 >> 3;
;;     s[25] = s9 >> 11;
;;     s[26] = (s9 >> 19) | (s10 * ((uint64_t) 1 << 2));
;;     s[27] = s10 >> 6;
;;     s[28] = (s10 >> 14) | (s11 * ((uint64_t) 1 << 7));
;;     s[29] = s11 >> 1;
;;     s[30] = s11 >> 9;
;;     s[31] = s11 >> 17;

    (get_local $s)

    (i64.and (i64.shr_s (get_local $s9) (i64.const 3)) (i64.const 0xff))
    (i64.and (i64.shr_s (get_local $s9) (i64.const 3)) (i64.const 0xff00))
    (i64.or)
    (i64.shr_s (get_local $s9) (i64.const 3))
    (i64.shl (i64.mul (get_local $s10) (i64.const 4)) (i64.const 16))
    (i64.or)
    (i64.const 0xff0000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s10) (i64.const 18))
    (i64.const 0xff000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s10) (i64.const 18))
    (i64.shl (i64.mul (get_local $s11) (i64.const 128)) (i64.const 32))
    (i64.or)
    (i64.const 0xff00000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s11) (i64.const 39))
    (i64.const 0xff0000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s11) (i64.const 39))
    (i64.const 0xff000000000000)
    (i64.and)
    (i64.or)
    (i64.shl (get_local $s11) (i64.const 39))
    (i64.const 0xff00000000000000)
    (i64.and)
    (i64.or)

    (i64.store offset=24))
)
