#!/usr/bin/env python
# REFERENCES
# http://juliensimon.blogspot.fr/2013/07/your-mongodb-instance-for-here-or-to-go.html
# http://juliensimon.blogspot.fr/2013/07/mongodb-and-python-gang-thegither.html
# http://juliensimon.blogspot.fr/2013/07/from-one-cloud-to-another-or-is-it-same.html
# http://juliensimon.blogspot.fr/2013/07/the-billion-dollar-app-nodejs-mongodb.html
# http://juliensimon.blogspot.fr/2013/08/nodejs-mongodb-part-2-here-comes.html
from pymongo import *

connection = MongoClient("mongodb://smadmin:passw0rd@ds049198.mongolab.com:49198/mongodb-test", 49198)
db = connection["mongodb-test"]
c = db["collection1"]
posts = c.find()
for post in posts:
    print (post)

