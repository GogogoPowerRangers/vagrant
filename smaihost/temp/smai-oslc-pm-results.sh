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

# Note: There is too much setup for this test -- need to simplify later
if [ "$HOSTNAME" = "" ] ; then
    HOSTNAME=$(hostname); export HOSTNAME
fi
if [ "$CANDLEHOME" = "" ] ; then
    case $(uname -s) in
    MINGW* | CYGWIN* ) CANDLEHOME=/cygdrive/c/IBM/ITM ;;
    * )
        if [ -d /opt/ibm/ccm/oslc_pm ] ; then
            CANDLEHOME=/opt/ibm/ccm/oslc_pm
        else
            CANDLEHOME=/opt/IBM/ITM
        fi
        ;;
    esac
    export CANDLEHOME
fi
if [ "$KASENV" = "" ] ; then
    case $(uname -s) in
    MINGW* | CYGWIN* ) KASENV=$CANDLEHOME/CAS/BIN/KASENV ;;
    * )
        if [ -f $CANDLEHOME/config/.as.environment ] ; then
            KASENV=$CANDLEHOME/config/.as.environment
        elif [ -f $CANDLEHOME/config/as.ini ] ; then
            KASENV=$CANDLEHOME/config/as.ini
        else
            echo "$CANDLEHOME/bin start/stop kasmain not found"
            exit 1
        fi
        ;;
    esac
fi
PATH=$HOME/jsm:$PATH; export PATH
CDP_DIR=$HOME/temp/$HOSTNAME/CDP
if [ ! -d $CDP_DIR ] ; then
    mkdir -p $CDP_DIR
fi
TEMS_DIR=$HOME/temp/$HOSTNAME/TEMS
if [ ! -d $TEMS_DIR ] ; then
    mkdir -p $TEMS_DIR
fi
NC185029_DIR=$HOME/jsm/nc185029
if [ ! -d $NC185029_DIR ] ; then
    mkdir $NC185029_DIR
fi

# Delete Unit Test results
if [ "$(grep 'KAS_CURI_DP_ENABLED=NO' $KASENV)" = "" ] ; then
    UNIT_DIR=$CDP_DIR
else
    UNIT_DIR=$TEMS_DIR
fi
rm -f $UNIT_DIR/* $UNIT_DIR/.as.*

# Get Registry Services files
cd $NC185029_DIR
jsm all

# Copy Unit Test results
echo "Copy files to $UNIT_DIR"
cp $KASENV $UNIT_DIR
rm -f $CANDLEHOME/logs/*.inv
rm -f $CANDLEHOME/logs/candle_installation.log
rm -f $CANDLEHOME/logs/itm_config.log
rm -f $CANDLEHOME/logs/itm_config.trc
rm -f $CANDLEHOME/logs/itm_synclock.trc
cp $CANDLEHOME/logs/kasmain* $UNIT_DIR 2> /dev/null
cp $CANDLEHOME/logs/*_as_*.log $UNIT_DIR
for f in ${HOSTNAME}*/*
do
    # There are multiple recordType entries; just use the first one
    pc=$(grep recordType $f 2> /dev/null | head -1 | sed -e 's/.*#//' -e 's/".*//')

    # This could be done with an XML parser but '<crtv:' is not easy to process
    if [ ! "$(grep '<crtv:ComputerSystem' $f)" = "" ] ; then
        crtv='ComputerSystem'
    elif [ ! "$(grep '<crtv:Database' $f)" = "" ] ; then
        crtv='Database'
    elif [ ! "$(grep '<crtv:DB2Instance' $f)" = "" ] ; then
        crtv='DB2Instance'
    elif [ ! "$(grep '<crtv:IPAddress' $f)" = "" ] ; then
        crtv='IPAddress'
    elif [ ! "$(grep '<crtv:Location' $f)" = "" ] ; then
        crtv='Location'
    elif [ ! "$(grep '<crtv:MQQueue' $f)" = "" ] ; then
        crtv='MQQueue'
    elif [ ! "$(grep '<crtv:OracleInstance' $f)" = "" ] ; then
        crtv='OracleInstance'
    elif [ ! "$(grep '<crtv:ServerAccessPoint' $f)" = "" ] ; then
        crtv='ServerAccessPoint'
    elif [ ! "$(grep '<crtv:ServiceInstance' $f)" = "" ] ; then
        crtv='ServiceInstance'
    elif [ ! "$(grep '<crtv:SoftwareServer' $f)" = "" ] ; then
        crtv='SoftwareServer'
    elif [ ! "$(grep '<crtv:StorageVolume' $f)" = "" ] ; then
        crtv='StorageVolume'
    elif [ ! "$(grep '<rdfs:Container' $f)" = "" ] ; then
        crtv='Container'
    elif [ ! "$(grep '<j.0:KNTAgentProcess' $f)" = "" ] ; then
        crtv='KNTAgentProcess'
    elif [ ! "$(grep '<rr:RegistrationRecord' $f)" = "" ] ; then
        crtv='RegistrationRecord'
    else
        crtv='UNKNOWN'
    fi

	file=$(basename $f | sed -e 's#\.xml##')
	echo "Test $UNIT_DIR/$pc-$crtv-$file"
	cp $f $UNIT_DIR/$pc-$crtv-$file.xml
	jsm-flat.py $f $UNIT_DIR/$pc-$crtv-$file.txt
done

#
