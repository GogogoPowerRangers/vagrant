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

task()
{
    chown -R endpoint:endpoint /home/endpoint
    chmod 755 /home/endpoint
    usermod -G wheel endpoint
    echo '/usr/local/rvm/gems/ruby-2.0.0-p247/bin/thin' >> /home/endpoint/.bash_profile
    if [ "$(grep '^# %wheel  ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers)" = "" ] ; then
        cp /etc/sudoers /tmp/sudoers.$$.backup
        echo '%wheel  ALL=(ALL)       NOPASSWD: ALL' >> /tmp/sudoers.$$.backup
    fi
}

if [ "$1" = "-t" ] ; then
    task
else
    sudo $0 -t
fi

#
