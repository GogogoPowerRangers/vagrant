// mem.js
var http = require('http');
var url = require('url');
var mc = require('mc');

var MongoClient = require('mongodb').MongoClient;
var ObjectId = require('mongodb').ObjectID;
var collection;

var DBUSER = "smadmin";
var DBPASSWORD = "passw0rd";
var DBHOST = "ds049198.mongolab.com:49198";

function onRequest(request, response) {
        // No id parameter -->  do nothing
        // id=0 --> list all documents
        // id=SOME_OBJECT_ID --> show the 'x' value for this document
        var query = url.parse(request.url,true).query;
        console.log("Request received, id="+query.id);

        response.writeHead(200, {"Content-Type": "text/html"});
        response.write("<html>");

        // XXX Missing check: query.id must be a proper ObjectId, i.e. 12-byte hex value

        if (query.id == null) {
                // No id parameter -->  do nothing
                response.write("Nothing to do, bleh");
                response.write("</HTML>");
                response.end();
        }
        else if (query.id == "0") {
                // id=0 --> list all documents
                collection.find().toArray(function (err, items) {
                        console.log ("Finding all documents");
                        for (var i = 0; i < items.length; i++) {
                                response.write(JSON.stringify(items[i])+"<br>");
                        }
                        response.write("</HTML>");
                        response.end();
                });
        }
        else {
                // id=SOME_OBJECT_ID --> show the 'x' value for this document
                // Check the cache first
                MemcacheClient.get(query.id, function(err, result) {
                if (!err) {
                        // Key found, display value
                        console.log("Cache hit,  key="+query.id+", value="+result[query.id]);
                        response.write("x="+result[query.id]);
                        response.write("</HTML>");
                        response.end();
                }
                else {
                        // Key not found, fetch value from DB
                        console.log("Cache miss, key "+query.id+". Querying...");
                        collection.findOne({"_id": new ObjectId(query.id)}, function (err, item) {
                                if (item == null) {
                                        response.write("Item does not exist, duh");
                                }
                                else {
                                console.log("Item found: "+JSON.stringify(item));
                                // Display value
                                response.write(JSON.stringify(item));
                                // Store value in cache with a 60 second TTL
                                MemcacheClient.set(query.id, item.x, { flags: 0, exptime: 60}, function(err, status) {
                                        if (!err) {
                                                console.log("Stored key="+query.id+", value="+item.x);
                                        }
                                        else {
                                                console.log("Couldn't store key="+query.id+", error="+err);
                                        }
                                });
                                }
                                response.write("</HTML>");
                                response.end();
                        });
                }
                });
        }
}

// Connect to the memcached server with its private AWS IP address
MemcacheClient = new mc.Client("10.234.177.74");
MemcacheClient.connect(function() {
        console.log("Connected to memcache");
});

// Connect to the MongoDB server hosted at MongoLab
MongoClient.connect("mongodb://" + DBUSER + ":" + DBPASSWORD + "@" + DBHOST + "/mongodb-test", function(err, db) {
        if (!err) {
                console.log("Connected to database");
                collection = db.collection("collection1");
        }
        else {
                console.log("Dude, where's my DB?");
        }
});

// Start the web server on port 8080 and wait for incoming requests
http.createServer(onRequest).listen(8080);
console.log("Web server started");

