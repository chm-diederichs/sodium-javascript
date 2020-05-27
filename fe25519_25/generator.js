function carry (i) {
  return `    (set_local $carry${i} (i64.shr_u (i64.add (get_local $s${i}) (i64.shl (i64.const 1) (i64.const 20)) (i64.const 21))))
    (set_local $s${i + 1} (i64.add (get_local $s${i + 1}) (get_local $carry${i})))
    (set_local $s${i} (i64.sub (get_local $s${i}) (i64.mul (get_local $carry${i}) (i64.shl (i64.const 1) (i64.const 21)))))\n`
}

/*
  carry0 = s0 >> 21;
  s1 += carry0;
  s0 -= carry0 * ((uint64_t) 1L << 21);
*/

function _carry (i) {
  return `    (set_local $carry${i} (i64.shr_u (get_local $s${i}) (i64.const 21)))
    (set_local $s${i + 1} (i64.add (get_local $s${i + 1}) (get_local $carry${i})))
    (set_local $s${i} (i64.sub (get_local $s${i}) (i64.mul (get_local $carry${i}) (i64.shl (i64.const 1) (i64.const 21)))))\n`
}

for (let i = 0; i < 12; i++) console.log(_carry(i))
