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

install()
{
    if [ -f /usr/bin/apt-get ] ; then
        sudo apt-get clean
        sudo apt-get -f install
        sudo apt-get update --fix-missing
        sudo apt-get -y install curl
        sudo apt-get -y install mongodb-clients
        sudo apt-get -y install build-essential
        sudo apt-get -y install python-dev
        sudo apt-get -y install python-pip
        sudo pip install pymongo
        sudo apt-get -y install nodejs npm
        npm install node-gyp
        npm install mongodb
        sudo apt-get -y install memcached
        npm install mc
        sudo apt-get -y autoremove
    else
        echo "install: `uname -s` is not supported"; exit 1
    fi
}

install

#
