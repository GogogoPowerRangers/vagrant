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
test -d /opt/ibm/ccm/agent/bin || sudo mkdir -p /opt/ibm/ccm/agent/bin
test -d /opt/ibm/ccm/agent/logs || sudo mkdir -p /opt/ibm/ccm/agent/logs
test -f /opt/ibm/ccm/agent/bin/itmcmd || echo "exit 0" | sudo tee /opt/ibm/ccm/agent/bin/itmcmd
sudo chmod 755 /opt/ibm/ccm/agent/bin/itmcmd
test -f /opt/ibm/ccm/agent/bin/uninstall.sh || echo "exit 0" | sudo tee /opt/ibm/ccm/agent/bin/uninstall.sh
sudo chmod 755 /opt/ibm/ccm/agent/bin/uninstall.sh

# Remove packages
sudo yum -y remove $(rpm -qa | grep smai)
