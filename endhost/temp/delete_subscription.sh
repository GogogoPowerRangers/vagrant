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

usage()
{
    echo "Usage: $0 -i id"
    echo "       id is database id"
    echo "Usage: $0 -s sid"
    echo "       sid is subscription id"
}

if [ "$1" = "" -o "$2" = "" ] ; then
    usage
    exit 1
fi

case "$1" in
-i ) curl -v -X DELETE --user prachi:password -k https://iguacu:3000/api/v1/subscriptions/$2 ;;
-s ) curl -v -X DELETE --user prachi:password -k https://iguacu:3000/api/v1/subscription?subscriptionID=$2 ;;
* ) usage; exit 1 ;;
esac

#
