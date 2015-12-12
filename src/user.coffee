user = require('./db') "#{__dirname}/../db/user"

module.exports =
  get: (username, callback) ->
    user = {}
    rs = db.createReadStream
      start: "user:#{username}"
      stop: "user:#{username}"
    rs.on 'data', (data) ->
      [_, _username] = data.key.split ':'
      [_password, _name, _email] = data.value.split ':'
      user = username : _username, password: _password, name: _name, email: _email if _username == username
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    ws.write key: "user:#{username}", value: "#{password}:#{name}:#{email}"
    ws.end()

  remove: (username, callback) ->
    ws = db.createWriteStream type: 'del'
    ws.on 'error', callback
    ws.on 'close', callback
    ks = db.createKeyStream()
    ks.on 'close', ->
            ws.end()
    ks.on 'data', (data) ->
      [_, _username] = data.split ':'
      if _username == username
        ws.write key: "#{data}"
