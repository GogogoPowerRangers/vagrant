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

FILES='DB2_Svr_V10.5_Linux_x86-64.tar.gz JSM_1.1_LAUNCHPAD_FOR_LINUX.zip WAS_V8.5.0.1_FOR_JAZZSM_LINUX_ML.zip'

rm -f $FILES

for f in $FILES
do
    if [ -f $HOME/itm/jazzsm/$f ] ; then
        ln -sf $HOME/itm/jazzsm/$f .
    else
        echo "$f not found"
    fi
done

#
