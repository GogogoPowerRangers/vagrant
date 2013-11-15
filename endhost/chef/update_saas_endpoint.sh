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

BACKUP_LABEL=`date +%Y-%m-%d-%H-%M-%S`

tasks()
{
    source /usr/local/rvm/environments/ruby-2.0.0-p247

    if [ ! -d /home/endpoint/saas_endpoint ] ; then
        echo "/home/endpoint/saas_endpoint not found"
        return 1
    fi
    cd /home/endpoint
    if [ ! "$(pwd)" = "/home/endpoint" ] ; then
        echo "$(pwd) should be /home/endpoint"
        return 1
    fi
    service thin stop
    echo "Backup /home/endpoint/saas_endpoint to saas_endpoint.$BACKUP_LABEL"
     mv saas_endpoint saas_endpoint.$BACKUP_LABEL
    if [ ! -d saas_endpoint.$BACKUP_LABEL -o -d saas_endpoint ] ; then
        echo "Backup failed from /home/endpoint/saas_endpoint to saas_endpoint.$BACKUP_LABEL"
        echo "You may need to remove and install endpoint controller"
        return 1
    fi
    echo "Update /home/endpoint/saas_endpoint using /tmp/vagrant-chef-1/chef-solo-1/cookbooks/saasendpoint/files/default/saas_endpoint.zip"
    unzip -qo /tmp/vagrant-chef-1/chef-solo-1/cookbooks/saasendpoint/files/default/saas_endpoint.zip
    cd /home/endpoint/saas_endpoint
    rake db:migrate
    tar -zxvf /vagrant/chef/db-development.sqlite3.tar.gz
    chown -R endpoint:endpoint /home/endpoint
    service thin start
}

case "$1" in
-t ) tasks ;;
* ) /usr/local/rvm/bin/rvmsudo $0 -t ;;
esac

exit $?

#
