var wasm = require('./mult.js')({
  imports: {
    debug: {
      log (...args) {
        console.log(...args.map(int => (int >>> 0).toString(16).padStart(8, '0')))
      },
      log_tee (arg) {
        console.log((arg >>> 0).toString(16).padStart(8, '0'))
        return arg
      }
    }
  }
})

const a = new Uint32Array(10)
for (let i = 0; i < 10; i++) a[i] = i

const b = new Uint32Array(10)
// for (let i = 0; i < 10; i++) b[i] = 1
b[0] = 2**25
b[1] = 2**25
b[2] = 2**24
b[3] = 2**25
b[4] = 2**25
b[5] = 2**24
b[6] = 2**24
b[7] = 2**24
b[8] = 2**24
b[9] = 2**24

const two = new Uint32Array(10)
two[0] = 2

  let abuf = Buffer.from(a.buffer)
  let bbuf = Buffer.from(b.buffer)
  let twobuf = Buffer.from(two.buffer)
  // console.log(twobuf)
  wasm.memory.set(abuf)
  // console.log(bbuf)
  wasm.memory.set(bbuf, 40)
  wasm.memory.set(twobuf, 200)
  // console.log(wasm.memory)

  wasm.exports.mul(80, 40, 40)
  wasm.exports.sq(120, 40, 0)
  wasm.exports.sq(160, 40, 1)
  wasm.exports.mul(240, 120, 200)
  // wasm.exports.mul(120, 40, 80)

  const cbuf = Buffer.from(wasm.memory.slice(160, 200))
  const dbuf = Buffer.from(wasm.memory.slice(240, 280))
  // for (let i = 0; i < 10; i++) console.log(abuf.readInt32LE(4 * i))
  // for (let i = 0; i < 10; i++) console.log(cbuf.readInt32LE(4 * i))
  // console.log('-')
  // for (let i = 0; i < 10; i++) console.log(dbuf.readInt32LE(4 * i))

  let res = true
  for (let i = 0; i < 10; i++) res &= cbuf.readInt32LE(4 * i) === dbuf.readInt32LE(4 * i)

  console.log(res === 1)
// }
