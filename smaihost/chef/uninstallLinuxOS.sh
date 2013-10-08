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

sudo killall -KILL kcawd
sudo killall -KILL klzagent
sudo yum remove -y smai-wrt-oslc-support-07.40.00.00-1.el6.noarch
sudo yum remove -y smai-os-06.30.02.00-1.el6.x86_64
sudo yum remove -y smai-framework-core-06.35.00.00-1.el6.x86_64
sudo yum remove -y smai-framework-jre-07.04.02.00-1.el6.x86_64
sudo rm -rf /opt/ibm/ccm/agent
sudo rm -rf /opt/IBM/ITM

#
