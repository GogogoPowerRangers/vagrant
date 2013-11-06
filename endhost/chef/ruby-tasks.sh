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

tasks()
{
    if [ ! -d /home/endpoint/saas_endpoint ] ; then
        echo "/home/endpoint/saas_endpoint not found"
        return 1
    fi
    cd /home/endpoint/saas_endpoint
    if [ ! "$(pwd)" = "/home/endpoint/saas_endpoint" ] ; then
        echo "$(pwd) should be /home/endpoint/saas_endpoint"
        return 1
    fi
    if [ -f /home/endpoint/ruby-tasks.done ] ; then
        echo "/home/endpoint/ruby-tasks.done exists"
        echo "Delete /home/endpoint/ruby-tasks.done to run this script"
        return 0
    fi
    gem install bundler
    if [ $? -ne 0 ] ; then
        echo "gem install bundler failed"
        return 1
    fi
    bundle install
    if [ $? -ne 0 ] ; then
        echo "gem bundle install failed"
        return 1
    fi
    rake db:migrate
    if [ $? -ne 0 ] ; then
        echo "gem rake db:migrate failed"
        return 1
    fi
    touch /home/endpoint/ruby-tasks.done
    return 0
}

case "$1" in
-g ) tasks ;;
* ) rvmsudo $0 -g ;;
esac

exit $?

#
