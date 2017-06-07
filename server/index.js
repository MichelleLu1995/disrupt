var express    = require('express');
var app        = express();
var http	   = require('http').createServer(app)
 
// Set port
var port = process.env.PORT || 8080;
 
// Start server listening on port 8080
http.listen(port, function(){
  console.log('listening on port: ' + port);
});


// SQLite database
var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database('db/app.db');

db.serialize(function() {
  // create tables here
});

db.close();
