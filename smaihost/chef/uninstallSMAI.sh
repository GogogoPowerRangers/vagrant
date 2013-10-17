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
echo "INFO: Run ./uninstallFabric.sh"
./uninstallFabric.sh
echo "INFO: Run ./uninstallLinuxOS.sh"
./uninstallLinuxOS.sh
echo "INFO: Run ./uninstallFixups.sh"
./uninstallFixups.sh

if [ -d /opt/ibm/ccm ] ; then
    sudo rm -rf /opt/ibm/ccm
fi
if [ -d /opt/ibm/wlp ] ; then
    sudo rm -rf /opt/ibm/wlp
fi

find /opt/ibm | grep -v 'java-x86_64'
find /opt/IBM | grep -v 'java-x86_64'
