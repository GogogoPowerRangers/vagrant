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

if [ "$SAAS_ENDPOINT_SCHEME" = "" ] ; then
    SAAS_ENDPOINT_SCHEME=https
fi
if [ "$SAAS_ENDPOINT_USER" = "" ] ; then
    SAAS_ENDPOINT_USER=prachi
fi
if [ "$SAAS_ENDPOINT_PASSWORD" = "" ] ; then
    SAAS_ENDPOINT_PASSWORD=password
fi
if [ "$SUBSCRIPTION_CALLBACK" = "" ] ; then
    SUBSCRIPTION_CALLBACK="https://localhost:5000/api/v1/callback"
fi
if [ "$SUBSCRIPTION_EMAIL" = "" ] ; then
    SUBSCRIPTION_EMAIL=user@us.ibm.com
fi
if [ "$SUBSCRIPTION_TYPE" = "" ] ; then
    SUBSCRIPTION_TYPE=trial
fi

usage()
{
    echo "Usage: $0 -d subscriptionID"
    echo "       ... deletes subscriptionID from subscriptions"
    echo "Usage: $0 -p subscriptionID"
    echo "       ... patches subscriptionID in subscriptions"
    echo "Usage: $0 -s subscriptionID"
    echo "       ... searches for subscriptionID in subscriptions"
}

patch_payload()
{
    rm -f $PAYLOAD
    echo > $PAYLOAD '{"callbackURL": "'$SUBSCRIPTION_CALLBACK'","requestorEmail": "'$SUBSCRIPTION_EMAIL'","subscriptionType": "'$SUBSCRIPTION_TYPE'"}'
}

if [ "$1" = "" -o "$2" = "" ] ; then
    usage
    exit 1
fi

CURL_OPTS="-v -H 'Accept: application/json' --user $SAAS_ENDPOINT_USER:$SAAS_ENDPOINT_PASSWORD -k"
LOG=/tmp/$(basename $0 | sed -e 's#\.sh$##')$1.log
PAYLOAD=/tmp/$(basename $0 | sed -e 's#\.sh$##')$1.json

case "$1" in
-d ) curl -X DELETE $CURL_OPTS $SAAS_ENDPOINT_SCHEME://localhost:3000/api/v1/subscriptions/$2/searches/1 > $LOG ;;
-p ) patch_payload
    curl -X PATCH $CURL_OPTS --data @$PAYLOAD $SAAS_ENDPOINT_SCHEME://localhost:3000/api/v1/subscriptions/$2/searches/1 > $LOG ;;
-s ) curl $CURL_OPTS $SAAS_ENDPOINT_SCHEME://localhost:3000/api/v1/subscriptions/$2/searches > $LOG; echo "" >> $LOG ;;
* ) usage; exit 1 ;;
esac

echo "Payload in $PAYLOAD. Results in $LOG"

#
