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

sudo /opt/ibm/ccm/oslc_pm/bin/itmcmd agent stop as
sudo killall -9 /opt/ibm/ccm/oslc_pm/lx8266/as/bin/kasmain
sudo chown -R $LOGNAME:users /opt/ibm/ccm/oslc_pm
sudo rm -f /opt/ibm/ccm/oslc_pm/logs/*
/opt/ibm/ccm/oslc_pm/bin/itmcmd agent start as

#
