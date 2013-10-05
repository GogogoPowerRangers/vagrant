// www.js
// REFERENCES
// http://juliensimon.blogspot.fr/2013/07/your-mongodb-instance-for-here-or-to-go.html
// http://juliensimon.blogspot.fr/2013/07/mongodb-and-python-gang-thegither.html
// http://juliensimon.blogspot.fr/2013/07/from-one-cloud-to-another-or-is-it-same.html
// http://juliensimon.blogspot.fr/2013/07/the-billion-dollar-app-nodejs-mongodb.html
// http://juliensimon.blogspot.fr/2013/08/nodejs-mongodb-part-2-here-comes.html
var http = require("http");
var MongoClient = require('mongodb').MongoClient;
var c;

var DBUSER = "smadmin";
var DBPASSWORD = "passw0rd";

function onRequest(request, response) {
  console.log("Request received");
  c.find().toArray(function (err, items) {
        response.writeHead(200, {"Content-Type": "text/html"});
        response.write("<HTML>");
        for (var i = 0; i < items.length; i++) {
                response.write(JSON.stringify(items[i])+"<br>");
        }
        response.write("</HTML>");
        response.end();
  });
}

MongoClient.connect("mongodb://" + DBUSER + ":" + DBPASSWORD + "@ds049198.mongolab.com:49198/mongodb-test", function(err, db) {
        if (!err) {
                console.log("Connected to database");
                c = db.collection("collection1");
        }
        else {
                console.log("Dude, where's my DB?");
        }
});

http.createServer(onRequest).listen(8080);
console.log("Web server started");

