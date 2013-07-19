# Python JSON pretty print Shell function
pjson()
{
    python -c "import json; import sys; print json.dumps(json.loads(sys.stdin.read()), sort_keys = False, indent = 2)"
}

# Note: Security not enabled on yangpa.usca.ibm.com Hub TEMS (HUB_YANGPA).
#       Just provide dummy login of user sysadmin and password password.
CURL_OPTS='--user sysadmin:password -H "Accept:application/json"'
CDP=http://yangpa.usca.ibm.com:15210/ibm/tivoli/rest/providers
ID=itm.HUB_YANGPA

# Retrieve the list of providers directly
curl $CURL_OPTS $CDP | pjson

# Locate all the installed products and affinities
curl $CURL_OPTS $CDP/$ID/datasources | pjson

# Locate all managed systems
curl $CURL_OPTS $CDP/$ID/datasources/TMSAgent.%26IBM.STATIC000/datasets/msys/items?properties=all | pjson

# Locate only the originnode and online status of managed systems
curl $CURL_OPTS $CDP/$ID/datasources/TMSAgent.%26IBM.STATIC000/datasets/msys/items?properties=ORIGINNODE,AVAILABLE | pjson

#
