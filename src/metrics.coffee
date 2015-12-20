db = require('./db') "#{__dirname}/../db/metrics"


module.exports =
  ###
    get()
    -----
    Returns some hard coded metrics
  ###
  get: (username, callback) ->
    metrics = []
    metric = []
    rs = db.createReadStream
      gte: "metrics:#{username}:1"
      lte: "metrics:#{username}:999999999999"
    rs.on 'data', (data) ->
      value = data.value.split ":"
      metric.push(timestamp: parseInt(value[1]), value: parseInt(value[2]))
      return metric

    rs.on 'error', callback

    rs.on 'close', ->
      callback null, metric

  save: (user, m, callback)->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for metric, index in m
      {timestamp, value} = metric
      ws.write key: "metrics:#{user}:#{index+1}", value: "metrics:#{timestamp}:#{value}"
    console.log "Batch saved !"
    ws.end()

  saveNew: (user, timestamp, value, callback)->
    this.get user, (err, data) ->
      console.log value
      ws = db.createWriteStream()
      ws.on 'error', callback
      ws.on 'close', callback
      ws.write key: "metrics:#{user}:#{data.length+1}", value: "metrics:#{timestamp}:#{value}"
      console.log "New user metric saved !"
      ws.end()


    ###
      remove(id, metrics, cb)
      --------------------
      Remove some metrics with a given id

      Parameters:

    ###
