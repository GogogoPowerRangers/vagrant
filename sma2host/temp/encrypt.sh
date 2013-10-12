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

export CANDLEHOME=/opt/ibm/ccm/oslc_pm
cd $CANDLEHOME/lx8266/as/bin
if [ ! -f kglcryut ] ; then
    cp -p $HOME/itmdev/sdk/lnxx86x6-l24-g44/dst/bin/kglcryut .
fi

export ICCRTE_DIR=$CANDLEHOME/lx8266/gs

export KEYFILE_DIR=$CANDLEHOME/keyfiles
export KDEBE_KEYRING_FILE=$KEYFILE_DIR/keyfile.kdb
export KDEBE_KEYRING_STASH=$KEYFILE_DIR/keyfile.sth

export LD_LIBRARY_PATH=$CANDLEHOME/lx8266/as/lib
export LIBPATH=$CANDLEHOME/aix616/as/lib
export SHLIB_PATH=$CANDLEHOME/hpx116/as/lib

./kglcryut Encrypt "passw0rd"

#
