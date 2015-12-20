express = require 'express'
metrics = require './metrics'
user = require './user'
app = express()

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine','jade'
app.use '/', express.static "#{__dirname}/../public"
session = require 'express-session'
LevelStore = require('level-session-store')(session)
app.use require('body-parser')()
app.use session
  secret: 'MyAppSecret'
  store: new LevelStore './db/sessions'
  resave: true
  saveUninitialized: true

authCheck = (req, res, next) ->
  unless req.session.loggedIn == true
    res.redirect '/login'
  else
    next()

app.get '/', authCheck, (req, res) ->
  res.render 'index', name: req.session.username

app.get '/addMetric', (req, res) ->
  res.render 'addMetric', name: req.session.username

app.post '/addMetric', (req, res) ->
  metrics.saveNew req.session.username, req.body.timestamp, req.body.value, (err, data) ->
    if err then throw error
    else
      res.redirect '/'

app.get '/metrics.json', (req, res) ->
  metrics.get req.session.username, (err, data) ->
    res.status(200).json data

app.get '/login', (req, res) ->
  res.render 'login'

app.get '/signup', (req, res) ->
  res.render 'signup'

app.post '/login', (req, res) ->
  user.get req.body.username, (err, data) ->
    return next err if err
    unless req.body.username == data.username && req.body.password == data.password
      res.redirect '/login'
    else
      req.session.loggedIn = true
      req.session.username = data.username
      res.redirect '/'

app.post '/signup', (req, res) ->
  user.save req.body.username, req.body.password, req.body.name, req.body.email, (err) ->
    res.redirect('/signup') if err
    res.redirect '/login'

app.get '/logout', (req, res) ->
  delete req.session.loggedIn
  delete req.session.username
  res.redirect '/login'


app.listen app.get('port'), () ->
  console.log "server listening on #{app.get 'port'}"
