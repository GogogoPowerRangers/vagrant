#!/bin/ksh
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

export CANDLEHOME=/opt/IBM/ITM
. $CANDLEHOME/bin/kdsmain.env
cd $CANDLEHOME/tables
$CANDLEHOME/bin/kdsmain > $CANDLEHOME/logs/kdsmain.log 2>&1 &

#
