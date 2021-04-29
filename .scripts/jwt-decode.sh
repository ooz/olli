#!/bin/bash

# Brief: Decodes Header and Payload of a JWT
# Author: Oliver Zeit
#
# Requires jq

# Support passing JWT as first argument or read it from stdin
if [ "$#" -ne 1 ]; then
    input=$(</dev/stdin)
fi

echo "${1:-$input}" | tr '.' '\n' | head -n 2 | xargs -I {} sh -c "echo {} | base64 -d | jq"

