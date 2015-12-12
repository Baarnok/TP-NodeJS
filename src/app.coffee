express = require 'express'
app = express()
metrics = require './metrics'
db = require './db'
user = require './user'

app.set 'port', 1889
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use '/', express.static "#{__dirname}/../public"
app.use require('body-parser')()

session = require 'express-session'
LevelStore = require('level-session-store')(session)

app.use session
  secret: 'MyAppSecret'
  store: new LevelStore './db/sessions'
  resave: true
  saveUninitialized: true

app.get '/', (req, res) ->
  res.render 'index',
    locals:
      title: 'My ECE test page'

app.get '/metrics.json', (req, res) ->
  res.status(200).json metrics.get()

app.get '/hello/:name', (req, res) ->
  res.status(200).send req.params.name

app.post '/metric/:id.json', (req, res) ->
  metrics.save req.params.id, req.body, (err) ->
    if err then res.status(500).json err
    else res.status(200).send "Metrics saved"

app.get '/login', (req, res) ->
  res.render 'login'

app.post 'login', (req, res) ->
  user.get req.body.username, (err, data) ->
    console.log req.body.password == data.password
    if err then throw error
    unless req.body.password == data.password
      res.redirect '/login'
    else
      req.session.loggedIn =true
      req.session.username = req.body.username
      res.redirect '/'

app.get '/logout', (req, res) ->
  delete req.session.loggedIn
  delete req.session.username
  res.redirect '/login'

 app.get '/signup', (req, res) ->
  res.render 'signup', title: 'SignUp'

 authCheck = (req, res, next) ->
  unless req.session.loggedIn == true
    res.redirect '/login'
  else
    next()

  app.get '/', authCheck, (req, res) ->
    res.render 'index', name: req.session.username

app.listen app.get('port'), () ->
  console.log "listening on #{app.get 'port'}"
