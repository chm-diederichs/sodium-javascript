var xsalsa20 = require('xsalsa20')

exports.crypto_stream_KEYBYTES = 32
exports.crypto_stream_NONCEBYTES = 24
exports.crypto_stream_PRIMITIVE = 'xsalsa20'

exports.crypto_stream = function (c, cpos, clen, nonce, key) {
  c.fill(0)
  exports.crypto_stream_xor(c, 0, c, 0, 0, nonce, key)
}

exports.crypto_stream_xor = function (c, cpos, m, mpos, clen, nonce, key) {
  var xor = xsalsa20(nonce, key)

  xor.update(m, c)
  xor.final()
}

exports.crypto_stream_xor_instance = function (nonce, key) {
  return new XOR(nonce, key)
}

function XOR (nonce, key) {
  this._instance = xsalsa20(nonce, key)
}

XOR.prototype.update = function (out, inp) {
  this._instance.update(inp, out)
}

XOR.prototype.final = function () {
  this._instance.finalize()
  this._instance = null
}
