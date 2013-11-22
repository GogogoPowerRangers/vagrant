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

SUBSCRIPTIONS_DIR=/home/endpoint/saas_endpoint/tmp/subscriptions
DELETE_ALL=NO
if [ "$1" = "-a" ] ; then
    DELETE_ALL=YES
fi

if [ ! -d $SUBSCRIPTIONS_DIR ] ; then
    echo "Endpoint Controller is missing $SUBSCRIPTIONS_DIR"
    exit 1
fi

for dir in $SUBSCRIPTIONS_DIR/*
do
    if [ -d $dir ] ; then
        subscription_id=`basename $dir`
        check=`./subscription.rb -s $subscription_id | grep '"subscription_id" *:'`
        if [ "$check" = "" -o "$DELETE_ALL" = "YES" ] ; then
            echo "Delete $SUBSCRIPTIONS_DIR/$subscription_id"
            sudo rm -rf $SUBSCRIPTIONS_DIR/$subscription_id
        else
            echo "KEEP: $SUBSCRIPTIONS_DIR/$subscription_id"
        fi
    fi
done
