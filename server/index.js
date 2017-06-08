var express    = require('express');
var app        = express();
var http	     = require('http').createServer(app)
//var routes     = require('./routes');
var bodyParser = require('body-parser');
 
// Set port
var port = process.env.PORT || 8080;

// express app will use body-parser to get data from POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
 
// Start server listening on port 8080
http.listen(port, function(){
  console.log('listening on port: ' + port);
});


// SQLite database
var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database('db/app.db');

db.serialize(function() {
  // create tables here
  //db.run("CREATE TABLE users (name text NOT NULL UNIQUE)");
});


// Logger
app.use(function timeLog(req, res, next) {
  console.log('Request Received: ', dateDisplayed(Date.now()));
  next();
});

// Hello World
app.get('/', function(req, res) {
    res.json({ message: 'Hello World!' });   
});

// add a user to the database
app.route('/adduser')
    .post(function(req, res) {

        var name = req.body.name;
        var cardType = req.body.card_type;

        db.run("INSERT INTO users (name, cardtype) VALUES (?, ?)", name, cardType, function(err) {
          if (err) {res.send(err);
          } else {
            res.json({ message: 'User created successfully!' });
          }
        });

    });


app.route('/getrewards')
    .post(function(req, res) {

        //var username = req.body.username;
        var places = req.body.places;
        var deals = {items: []};
        var placesFormatted = "(";

        for (var i = 0; i < places.length; i++) {
          placesFormatted = placesFormatted.concat("\'" + places[i] + "\'");
          if (i != places.length-1) {
            placesFormatted = placesFormatted.concat(",");
          }
        }
        placesFormatted = placesFormatted.concat(")");

        // for now, assume the credit card is Venture
        var sql = "SELECT * FROM Venture WHERE StoreName IN ";
        sql = sql.concat(placesFormatted);

        db.all(sql, function(err, rows) {
          if (err) {
            res.send(err);
          } else if (rows.length == 0) {
          } else {
            for (var i = 0; i < rows.length; i++) {
              var row = rows[i];
              var data = {storename: row.StoreName, deal: row.Deal};
              deals.items.push(data);
            }
            res.json(deals);
          }
        });

    });




// Display date function
function dateDisplayed(timestamp) {
    var date = new Date(timestamp);
    return (date.getMonth() + 1 + '/' + date.getDate() + '/' + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
}
