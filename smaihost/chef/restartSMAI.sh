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

clearLogs()
{
    ( cd /opt/ibm/wlp/usr/servers/server1/logs && sudo rm -f *_* ffdc/* )
}

startSMAI()
{
    sudo start fabricNode
    echo "Wait and restart XML toolkit and APM UI"
    sleep 10
    sudo /opt/ibm/ccm/SCR/XMLtoolkit/bin/tbsmrdr_start.sh
    sleep 10
    sudo start apmui
}

stopSMAI()
{
    sudo stop fabricNode
    sudo stop liberty
    sudo /opt/ibm/ccm/SCR/XMLtoolkit/bin/tbsmrdr_stop.sh
    sudo stop apmui
}

stopSMAI
startSMAI

#
