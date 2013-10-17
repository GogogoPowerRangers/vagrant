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

# Fixups for missing scripts
scripts()
{
    test -d /opt/ibm/ccm/$1/bin || sudo mkdir -p /opt/ibm/ccm/$1/bin
    test -d /opt/ibm/ccm/$1/logs || sudo mkdir -p /opt/ibm/ccm/$1/logs
    test -f /opt/ibm/ccm/$1/bin/itmcmd || echo "exit 0" | sudo tee /opt/ibm/ccm/$1/bin/itmcmd
    sudo chmod 755 /opt/ibm/ccm/$1/bin/itmcmd
    test -f /opt/ibm/ccm/$1/bin/uninstall.sh || echo "exit 0" | sudo tee /opt/ibm/ccm/$1/bin/uninstall.sh
    sudo chmod 755 /opt/ibm/ccm/$1/bin/uninstall.sh
}

scripts agent
scripts oslc_pm

# Remove packages
sudo yum -y remove $(rpm -qa | grep smai)
