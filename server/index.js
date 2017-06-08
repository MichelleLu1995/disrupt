var express    = require('express');
var app        = express();
var http	     = require('http').createServer(app)
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

        var username = req.body.username;
        var cardType = req.body.card_type;

        db.run("INSERT INTO users (Username, CardID) VALUES (?, (SELECT CardID FROM Cards WHERE CardType = ?))", username, cardType, function(err) {
          if (err) {res.send(err);
          } else {
            res.json({ message: 'User created successfully!' });
          }
        });

    });

// add a favorite for the user
app.route('/addfavorite')
    .post(function(req, res) {

        var userid = req.body.userid;
        var storename = req.body.storename;

        db.run("INSERT INTO Favorites (UserID, StoreID) VALUES (?, (SELECT StoreID FROM Stores WHERE StoreName = ?))",
          userid, storename, function(err) {
            if (err) {res.send(err);
            } else {
              res.json({ message: 'Favorite added successfully!' });
            }
        });

    });

// given a user ID and list of stores, determine the rewards possible
app.route('/getrewards')
    .post(function(req, res) {

        var userid = req.body.userid;
        var places = req.body.places;
        var deals = {items: []};
        var placesFormatted = "(";

        console.log(req.body);
        console.log(places);

        for (var i = 0; i < places.length; i++) {
          str = places[i].replace(/'/g, '');
          placesFormatted = placesFormatted.concat("\'" + str + "\'");
          if (i != places.length-1) {
            placesFormatted = placesFormatted.concat(",");
          }
        }
        placesFormatted = placesFormatted.concat(")");
        console.log(placesFormatted);

        // for now, assume the credit card is Venture
        var sql = "SELECT * FROM Rewards WHERE StoreName IN ";
        sql = sql.concat(placesFormatted);
        sql = sql.concat(" AND CardID = (SELECT CardID FROM Users WHERE UserID = " + userid + ")");

        db.all(sql, function(err, rows) {
          if (err) {
            res.send(err);
            console.log("FAILED");
          } else if (rows.length == 0) {
            console.log("nothing");
            res.json(deals);
          } else {
            for (var i = 0; i < rows.length; i++) {
              var row = rows[i];
              var data = {storename: row.StoreName, deal: row.Deal};
              deals.items.push(data);
            }
            res.json(deals);
            console.log("SUCCESS");
            console.log(deals);
          }
        });

    });




// Display date function
function dateDisplayed(timestamp) {
    var date = new Date(timestamp);
    return (date.getMonth() + 1 + '/' + date.getDate() + '/' + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds());
}
