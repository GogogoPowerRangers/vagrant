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
sudo stop fabricNode
sudo stop liberty
sudo stop scr
sudo /opt/ibm/ccm/SCR/XMLtoolkit/bin/tbsmrdr_stop.sh
sudo rm -rf /opt/ibm/ccm/SCR
sudo rm -rf /opt/ibm/gaian
sudo rm -rf /opt/ibm/ccm/logs
sudo rm -rf /opt/ibm/ccm/properties

#
