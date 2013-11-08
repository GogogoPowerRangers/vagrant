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

sudo test -f /home/endpoint/thin-tasks.done && exit 0

fix=`grep '/usr/local/rvm/environments' /etc/init.d/thin`
if [ ${fix}x = x ] ; then
    sudo cp -f /etc/init.d/thin /tmp/thin.backup
    sudo chmod 755 /tmp/thin.backup
    cat /tmp/thin.backup | sed -e 's|# Do NOT "set -e"|# Do NOT "set -e"\nsource /usr/local/rvm/environments/ruby-2.0.0-p247|' | sudo tee /etc/init.d/thin > /tmp/thin.new
    sudo chmod 755 /tmp/thin.new
fi
sudo touch /home/endpoint/thin-tasks.done
sudo chown endpoint:endpoint /home/endpoint/thin-tasks.done
