(module
  (import "js" "table" (table 1 anyfunc))
  (elem (i32.const 0) $sc_reduce)

  (memory $0 1)
  (export "memory" (memory $0))

  (func $sc_reduce (export "sc_reduce")
    (param $s i32)

    (param $s0 i64)
    (param $s1 i64)
    (param $s2 i64)
    (param $s3 i64)
    (param $s4 i64)
    (param $s5 i64)
    (param $s6 i64)
    (param $s7 i64)
    (param $s8 i64)
    (param $s9 i64)
    (param $s10 i64)
    (param $s11 i64)
    (param $s12 i64)
    (param $s13 i64)
    (param $s14 i64)
    (param $s15 i64)
    (param $s16 i64)
    (param $s17 i64)
    (param $s18 i64)
    (param $s19 i64)
    (param $s20 i64)
    (param $s21 i64)
    (param $s22 i64)
    (param $s23 i64)

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

    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s23) (i64.const 666643))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s23) (i64.const 470296))))
    (set_local $s13 (i64.add (get_local $s13) (i64.mul (get_local $s23) (i64.const 654183))))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $s23) (i64.const 997805))))
    (set_local $s15 (i64.add (get_local $s15) (i64.mul (get_local $s23) (i64.const 136657))))
    (set_local $s16 (i64.sub (get_local $s16) (i64.mul (get_local $s23) (i64.const 683901))))

    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s22) (i64.const 666643))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s22) (i64.const 470296))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s22) (i64.const 654183))))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $s22) (i64.const 997805))))
    (set_local $s14 (i64.add (get_local $s14) (i64.mul (get_local $s22) (i64.const 136657))))
    (set_local $s15 (i64.sub (get_local $s15) (i64.mul (get_local $s22) (i64.const 683901))))

    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s21) (i64.const 666643))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s21) (i64.const 470296))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s21) (i64.const 654183))))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $s21) (i64.const 997805))))
    (set_local $s13 (i64.add (get_local $s13) (i64.mul (get_local $s21) (i64.const 136657))))
    (set_local $s14 (i64.sub (get_local $s14) (i64.mul (get_local $s21) (i64.const 683901))))

    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s20) (i64.const 666643))))
    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s20) (i64.const 470296))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s20) (i64.const 654183))))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $s20) (i64.const 997805))))
    (set_local $s12 (i64.add (get_local $s12) (i64.mul (get_local $s20) (i64.const 136657))))
    (set_local $s13 (i64.sub (get_local $s13) (i64.mul (get_local $s20) (i64.const 683901))))

    (set_local $s7  (i64.add (get_local $s7 ) (i64.mul (get_local $s19) (i64.const 666643))))
    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s19) (i64.const 470296))))
    (set_local $s9  (i64.add (get_local $s9 ) (i64.mul (get_local $s19) (i64.const 654183))))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $s19) (i64.const 997805))))
    (set_local $s11 (i64.add (get_local $s11) (i64.mul (get_local $s19) (i64.const 136657))))
    (set_local $s12 (i64.sub (get_local $s12) (i64.mul (get_local $s19) (i64.const 683901))))

    (set_local $s6  (i64.add (get_local $s6 ) (i64.mul (get_local $s18) (i64.const 666643))))
    (set_local $s7  (i64.add (get_local $s7 ) (i64.mul (get_local $s18) (i64.const 470296))))
    (set_local $s8  (i64.add (get_local $s8 ) (i64.mul (get_local $s18) (i64.const 654183))))
    (set_local $s9  (i64.sub (get_local $s9 ) (i64.mul (get_local $s18) (i64.const 997805))))
    (set_local $s10 (i64.add (get_local $s10) (i64.mul (get_local $s18) (i64.const 136657))))
    (set_local $s11 (i64.sub (get_local $s11) (i64.mul (get_local $s18) (i64.const 683901))))

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
    
    (set_local $s5 (i64.add (get_local $s5 ) (i64.mul (get_local $s17) (i64.const 666643))))
    (set_local $s6 (i64.add (get_local $s6 ) (i64.mul (get_local $s17) (i64.const 470296))))
    (set_local $s7 (i64.add (get_local $s7 ) (i64.mul (get_local $s17) (i64.const 654183))))
    (set_local $s8 (i64.sub (get_local $s8 ) (i64.mul (get_local $s17) (i64.const 997805))))
    (set_local $s9 (i64.add (get_local $s9 ) (i64.mul (get_local $s17) (i64.const 136657))))
    (set_local $s10 (i64.sub (get_local $s10) (i64.mul (get_local $s17) (i64.const 683901))))

    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s16) (i64.const 666643))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s16) (i64.const 470296))))
    (set_local $s6 (i64.add (get_local $s6) (i64.mul (get_local $s16) (i64.const 654183))))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $s16) (i64.const 997805))))
    (set_local $s8 (i64.add (get_local $s8) (i64.mul (get_local $s16) (i64.const 136657))))
    (set_local $s9 (i64.sub (get_local $s9) (i64.mul (get_local $s16) (i64.const 683901))))

    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s15) (i64.const 666643))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s15) (i64.const 470296))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s15) (i64.const 654183))))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $s15) (i64.const 997805))))
    (set_local $s7 (i64.add (get_local $s7) (i64.mul (get_local $s15) (i64.const 136657))))
    (set_local $s8 (i64.sub (get_local $s8) (i64.mul (get_local $s15) (i64.const 683901))))

    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s14) (i64.const 666643))))
    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s14) (i64.const 470296))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s14) (i64.const 654183))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s14) (i64.const 997805))))
    (set_local $s6 (i64.add (get_local $s6) (i64.mul (get_local $s14) (i64.const 136657))))
    (set_local $s7 (i64.sub (get_local $s7) (i64.mul (get_local $s14) (i64.const 683901))))

    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s13) (i64.const 666643))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s13) (i64.const 470296))))
    (set_local $s3 (i64.add (get_local $s3) (i64.mul (get_local $s13) (i64.const 654183))))
    (set_local $s4 (i64.sub (get_local $s4) (i64.mul (get_local $s13) (i64.const 997805))))
    (set_local $s5 (i64.add (get_local $s5) (i64.mul (get_local $s13) (i64.const 136657))))
    (set_local $s6 (i64.sub (get_local $s6) (i64.mul (get_local $s13) (i64.const 683901))))

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))
    (set_local $s12 (i64.const 0))

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

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))
    (set_local $s12 (i64.const 0))

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

    (set_local $s0 (i64.add (get_local $s0) (i64.mul (get_local $s12) (i64.const 666643))))
    (set_local $s1 (i64.add (get_local $s1) (i64.mul (get_local $s12) (i64.const 470296))))
    (set_local $s2 (i64.add (get_local $s2) (i64.mul (get_local $s12) (i64.const 654183))))
    (set_local $s3 (i64.sub (get_local $s3) (i64.mul (get_local $s12) (i64.const 997805))))
    (set_local $s4 (i64.add (get_local $s4) (i64.mul (get_local $s12) (i64.const 136657))))
    (set_local $s5 (i64.sub (get_local $s5) (i64.mul (get_local $s12) (i64.const 683901))))

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

  (func $sc25519_reduce (export "sc25519_reduce") (param $s i32)
    (get_local $s)
    (i64.load32_u offset=0  (get_local $s))
    (i64.load32_u offset=4  (get_local $s))
    (i64.load32_u offset=8  (get_local $s))
    (i64.load32_u offset=12 (get_local $s))
    (i64.load32_u offset=16 (get_local $s))
    (i64.load32_u offset=20 (get_local $s))
    (i64.load32_u offset=24 (get_local $s))
    (i64.load32_u offset=28 (get_local $s))
    (i64.load32_u offset=32 (get_local $s))
    (i64.load32_u offset=36 (get_local $s))
    (i64.load32_u offset=40 (get_local $s))
    (i64.load32_u offset=44 (get_local $s))
    (i64.load32_u offset=48 (get_local $s))
    (i64.load32_u offset=52 (get_local $s))
    (i64.load32_u offset=56 (get_local $s))
    (i64.load32_u offset=60 (get_local $s))
    (i64.load32_u offset=64 (get_local $s))
    (i64.load32_u offset=68 (get_local $s))
    (i64.load32_u offset=72 (get_local $s))
    (i64.load32_u offset=76 (get_local $s))
    (i64.load32_u offset=80 (get_local $s))
    (i64.load32_u offset=84 (get_local $s))
    (i64.load32_u offset=88 (get_local $s))
    (i64.load32_u offset=92 (get_local $s))
    (call $sc_reduce)))

    
