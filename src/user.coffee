db = require('./db') "#{__dirname}/../db/user"
module.exports =
  get: (username, callback) ->
    rs = db.createReadStream
      gte: "user:#{username}"
      lte: "user:#{username}"
    user =null
    rs.on 'data', (data) ->
      key = data.key.split ":"
      properties = data.value.split ":"
      user = {username : key[1], password:properties[1], name:properties[2],email:properties[3]}
      return user
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

  save: (username, password, name, email, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    ws.write key: "user:#{username}", value: "user:#{password}:#{name}:#{email}"
    ws.end()

  remove: (username, callback)->
    toDel = "user:#{username}"
    db.del(username, callback)
