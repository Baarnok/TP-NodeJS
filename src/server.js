// Import a module
var http = require('http')
// Declare an http server
http.createServer(function (req, res) {
 // Write a response header
 res.writeHead(200, {'Content-Type': 'text/plain'});
 // Write a response content
 res.end('Hello World\n');
// Start the server
}).listen(1337, '127.0.0.1')
// curl localhost:1337 or go to http://localhost:1337
