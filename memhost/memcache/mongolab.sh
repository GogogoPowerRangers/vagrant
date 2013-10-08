#!/bin/bash
#
# Copyright 2013 Dean Okamura
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# -------------------------------------------------------------------------
# To connect using the shell:
# mongo ds049198.mongolab.com:49198/mongodb-test -u <DBUSER> -p <DBPASSWORD>
#
# To connect using a driver via the standard URI (what's this?):
# mongodb://<DBUSER>:<DBPASSWORD>@ds049198.mongolab.com:49198/mongodb-test
#
# REFERENCES
# http://juliensimon.blogspot.fr/2013/07/your-mongodb-instance-for-here-or-to-go.html
# http://juliensimon.blogspot.fr/2013/07/mongodb-and-python-gang-thegither.html
# http://juliensimon.blogspot.fr/2013/07/from-one-cloud-to-another-or-is-it-same.html
# http://juliensimon.blogspot.fr/2013/07/the-billion-dollar-app-nodejs-mongodb.html
# http://juliensimon.blogspot.fr/2013/08/nodejs-mongodb-part-2-here-comes.html
#
DBUSER=smadmin
DBPASSWORD=passw0rd

install_mongodb()
{
    if [ -d $HOME/cache/mongodb/bin ] ; then
        return
    fi
    if [ ! -d $HOME/cache ] ; then
        mkdir $HOME/cache
    fi
    cd $HOME/cache
    case `uname -s` in
    Darwin )
        curl http://downloads.mongodb.org/osx/mongodb-osx-x86_64-2.4.6.tgz > mongodb.tar.gz
        ;;
    Linux )
        sudo apt-get -y install curl
        curl http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.6.tgz > mongodb.tar.gz
        ;;
    * ) echo "install_mongodb: `uname -s` is not supported"; exit 1 ;;
    esac
    tar -zxvf mongodb.tar.gz
    ln -sf mongodb-*-2.4.6 mongodb
    sudo mkdir -p /data/db
    sudo chown `id -u` /data/db
}

server()
{
    install_mongodb
    cd $HOME/cache/mongodb/bin
    ./mongod
}

test()
{
    install_mongodb
    cd $HOME/cache/mongodb/bin
    ./mongo ds049198.mongolab.com:49198/mongodb-test -u $DBUSER -p DBPASSWORD
}

if [ "$1" = "server" ] ; then
    server
elif [ "$1" = "test" ] ; then
    test
fi

#
