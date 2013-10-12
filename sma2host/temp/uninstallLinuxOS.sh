#!/bin/bash
#
# Licensed Materials - Property of IBM
#
# 2013-IBM
#
# (C) Copyright IBM Corp. 2013  All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with
# IBM Corp.
#

sudo killall -KILL klzagent
sudo kill -KILL kcawd

if [ -d /tmp/smai-fabric ] ; then
    cd /tmp/smai-fabric
    sudo ./uninstall.sh
    cd /tmp
fi

sudo yum remove -y smai-os-06.30.02.00-1.el6.x86_64
sudo yum remove -y smai-framework-core-06.35.00.00-1.el6.x86_64
sudo yum remove -y smai-framework-jre-07.04.02.00-1.el6.x86_64

sudo rm -rf /opt/ibm/ccm/agent
sudo rm -rf /opt/IBM/*

sudo rm -rf /opt/ibm/ccm
sudo rm -rf /opt/ibm/gaian
sudo rm -rf /opt/ibm/wlp

sudo rm -rf /tmp/smai-*

#
