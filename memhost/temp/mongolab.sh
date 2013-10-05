#!/bin/bash
#
# To connect using the shell:
# mongo ds049198.mongolab.com:49198/mongodb-test -u <dbuser> -p <dbpassword>
#
# To connect using a driver via the standard URI (what's this?):
# mongodb://<dbuser>:<dbpassword>@ds049198.mongolab.com:49198/mongodb-test
#
# REFERENCES
# http://juliensimon.blogspot.fr/2013/07/your-mongodb-instance-for-here-or-to-go.html
# http://juliensimon.blogspot.fr/2013/07/mongodb-and-python-gang-thegither.html
# http://juliensimon.blogspot.fr/2013/07/from-one-cloud-to-another-or-is-it-same.html
# http://juliensimon.blogspot.fr/2013/07/the-billion-dollar-app-nodejs-mongodb.html
# http://juliensimon.blogspot.fr/2013/08/nodejs-mongodb-part-2-here-comes.html
#
server()
{
    cd $HOME/cache/mongodb/bin
    ./mongodbd
}

test()
{
    cd $HOME/cache/mongodb/bin
    ./mongo ds049198.mongolab.com:49198/mongodb-test -u smadmin -p passw0rd
}

if [ "$1" = "server" ] ; then
    server
elif [ "$1" = "test" ] ; then
    test
fi

#
