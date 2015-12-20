# ECE NodeJS

## Quick start

Project is developed using [coffee](http://coffeescript.org/) and [jade](http://jade-lang.com/).

Tests are developed using [mocha](http://mochajs.org/) and [should](http://shouldjs.github.io/).

Before anything : `npm install` && `chmod 755 bin/*`

- `./bin/build` to compile the coffee code to javascript
- `./bin/populatedb` to add some metrics in the db
- `./bin/test` to run the tests
- `./bin/start` to run the code or `sudo ./bin/start` if there's an error about accessing files

Two accounts with metrics are already saved :

- Username : admin, Password : admin
- Username : user, Password : user

## About this work

The project in itself is a simple web dashboard that should allow you to :

- Login with a user
- Insert metrics once logged in
- Retrieve the user’s metrics and display it in a graph
- Only access the user’s metrics, not the rest of it

## Creators

- François CORDIER (francois_cordier@yahoo.fr)
- Baptiste ROY (roy-baptiste@hotmail.fr)

## Documentation

- [Stylus documentation](https://learnboost.github.io/stylus/)
- [Jade documentation](http://jade-lang.com/)
- [Coffee-script documentation](http://coffeescript.org/)
- [D3.JS documentation](http://d3js.org/)
- [JQuery documentation](http://code.jquery.com)
- [Bootstrap documentation](http://getbootstrap.com/)
- [Level-up documentation](https://github.com/Level/levelup)
