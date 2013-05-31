assert = require('assert')
main = require('../src/index')

obj = {
  handle: 'mattly'
  twitter: -> "@#{@handle}"
  reply: -> "#{@twitter}: "
}

main(obj)

assert.ok(obj._behold)
assert.ok(obj._behold.handle)
assert.equal(obj._behold.handle.value, 'mattly')
assert.ok(obj._behold.twitter)
assert.ok(obj._behold.reply)

changed = 0
trackChange = (val) ->
  console.log(val)
  changed += 1

main.subscribe(obj, 'handle', trackChange)
main.subscribe(obj, 'twitter', trackChange)
main.subscribe(obj, 'reply', trackChange)
assert.equal(obj._behold.handle.subscribers.length, 1)
assert.equal(obj._behold.twitter.subscribers.length, 1)
assert.equal(obj._behold.reply.subscribers.length, 1)

obj.handle = 'lyonheart'
assert.equal(obj.handle, 'lyonheart')
assert.equal(obj.twitter, '@lyonheart')
assert.equal(obj.reply, '@lyonheart: ')

afterChange = ->
  assert.equal(changed, 3)
setTimeout(afterChange, 1)
