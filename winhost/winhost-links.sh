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

FILES='DB2_ESE_10_Win_x86-64.exe ibm-java-jre-60-win-x86_64.zip install_liberty.zip setup-dbconfig-windows_64.exe setup-scr-windows_64.exe'

rm -f $FILES

for f in $FILES
do
    if [ -f $HOME/itm/scr/$f ] ; then
        ln -sf $HOME/itm/scr/$f .
    elif [ -f $HOME/itm/db2-java6/$f ] ; then
        ln -sf $HOME/itm/db2-java6/$f .
    else
        echo "$f not found"
    fi
done

#
