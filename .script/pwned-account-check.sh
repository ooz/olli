#!/bin/bash

# Brief: Checks whether account data has been exposed according to haveibeenpwned.com
# Author: Oliver Zeit
#
# Requires echo, python, curl and jq

echo -n "Account: "
read account

encoded_account=`python -c "import urllib; print urllib.quote('''$account''')"`
echo "Checking: ${account} (${encoded_account})"

curl -s https://haveibeenpwned.com/api/v2/breachedaccount/${encoded_account} | jq .

