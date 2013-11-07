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

# Use thin.sh if thin running as service does not process HTTP requests.
# Seems to be a problem with VM hosts.
# Limitation: Requires login window and Ctrl-C termination.

tasks()
{
    source /usr/local/rvm/environments/ruby-2.0.0-p247

    if [ ! -d /home/endpoint/saas_endpoint ] ; then
        echo "/home/endpoint/saas_endpoint not found"
        return 1
    fi
    cd /home/endpoint/saas_endpoint
    if [ ! "$(pwd)" = "/home/endpoint/saas_endpoint" ] ; then
        echo "$(pwd) should be /home/endpoint/saas_endpoint"
        return 1
    fi
    bundle exec thin start
}

case "$1" in
-t ) tasks ;;
* ) /usr/local/rvm/bin/rvmsudo $0 -t ;;
esac

exit $?

#
