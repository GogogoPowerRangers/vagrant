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

if [ ! -d /opt/ibm/ccm/agent/registry ] ; then
    echo "/opt/ibm/ccm/agent/registry: Too broken to continue"
    exit 1
fi
if [ ! -d /opt/ibm/ccm/agent/install-images/klz/unix ] ; then
    echo "/opt/ibm/ccm/agent/install-images/klz/unix: Too broken to continue"
    exit 1
fi
if [ -f /opt/ibm/ccm/agent/lx8266/lz/bin/klzagent ] ; then
    echo "Delete /opt/ibm/ccm/agent/lx8266/lz/bin/klzagent if you want to continue"
    exit 1
fi
cd /opt/ibm/ccm/agent
sudo cp -pf /opt/ibm/ccm/agent/install-images/klz/unix/lzlx8266.ver registry
ls -l registry/lzlx8266.ver
sudo unzip -qo /opt/ibm/ccm/agent/install-images/klz/unix/lzlx8266.jar
sudo chmod -R 755 /opt/ibm/ccm/agent/lx8266/lz/bin/* /opt/ibm/ccm/agent/lx8266/lz/lib/*
ls -l /opt/ibm/ccm/agent/lx8266/lz/bin/klzagent
if [ ! -f /opt/ibm/ccm/agent/config/.ConfigData/klzenv ] ; then
    cp /opt/ibm/ccm/agent/config/.ConfigData/.tmp/klzenv /opt/ibm/ccm/agent/config/.ConfigData
fi

#
