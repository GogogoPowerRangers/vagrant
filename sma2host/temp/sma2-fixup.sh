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
if [ ! "$(ps -ef | grep java | grep gaian | grep -v grep)" = "" ] ; then
    sudo stop fabricNode
fi
if [ ! "$(ps -ef | grep java | grep gaian| grep -v grep)" = "" ] ; then
    echo "fabricNode is running"
    exit 1
fi

sudo rpm -e smai-apmui smai-scr smai-oslc-* smai

for f in fabricNode.conf
do
    file=/etc/init/$f
    echo "Removing $file"
    sudo rm -f $file
done

#
