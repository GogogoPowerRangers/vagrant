#!/bin/ksh
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

FILES='SmartCloudMonitoring-ApplicationInsightAgentConsumerVMV1.1.0.1.tar SmartCloudMonitoring-ApplicationInsightFabricNodeV1.1.0.1.tar ibm-java-x86_64-jre-7.0-4.0.x86_64.rpm'

rm -f $FILES

for f in $FILES
do
    if [ -f $HOME/itm/smai/$f ] ; then
        ln -sf $HOME/itm/smai/$f .
    else
        echo "$f not found"
    fi
done

#
