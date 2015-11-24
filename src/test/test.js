//Tests

var request = require('superagent');
var should = require('should');

describe('homepage', function(){
  it('should respond to GET',function(done){
    request
      .get('http://127.0.0.1:1337')
      .end(function(res){
        should(res.status).equal(404);
        done();
    })
  })
});
