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

for file in APMaaS_Agents.tar APMaaS_Agents.zip APMaaS_Deploy_Script.tar APMaaS_Deploy_Script.zip
do
    sudo rsync -a -v -z /vagrant_data/$file /home/endpoint/saas_endpoint/bin/tasks/apm/generate_deployment_artifacts
    sudo chown endpoint:endpoint /home/endpoint/saas_endpoint/bin/tasks/apm/generate_deployment_artifacts/$file
done
sudo touch /home/endpoint/artifacts-tasks.done
sudo chown endpoint:endpoint /home/endpoint/artifacts-tasks.done
