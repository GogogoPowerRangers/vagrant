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

for f in /opt/ibm/ccm/oslc_pm/logs/* /opt/IBM/ITM/logs/* /opt/ibm/ccm/agent/logs/*
do
    if [ "$(sudo fuser $f)" = "" ] ; then
        sudo rm -f $f
    fi
done
