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
if [ -f /usr/bin/apt-get ] ; then
    sudo apt-get -y install erlang-nox
    echo "deb http://www.rabbitmq.com/debian/ testing main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list > /dev/null
    curl -L -o $HOME/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    sudo apt-key add $HOME/rabbitmq-signing-key-public.asc
    sudo apt-get -y update
    sudo apt-get -y --allow-unauthenticated --force-yes install rabbitmq-server
    sudo apt-get -y install git
    cd $HOME
    git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git
    cd joemiller.me-intro-to-sensu/
    sudo ./ssl_certs.sh clean
    sudo ./ssl_certs.sh generate
    sudo mkdir /etc/rabbitmq/ssl
    sudo cp server_key.pem /etc/rabbitmq/ssl/
    sudo cp server_cert.pem /etc/rabbitmq/ssl/
    sudo cp testca/cacert.pem /etc/rabbitmq/ssl/
fi
