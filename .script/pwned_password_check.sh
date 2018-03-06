#!/bin/bash

# Brief: Checks if a password has been leaked according to haveibeenpwned.com
# Author: Oliver Zeit
# Dependencies: bash, echo (GNU coreutils), awk, curl and grep

command -v awk > /dev/null || { echo "$0 requires awk! Aborting!"; exit 1; }
command -v curl > /dev/null || { echo "$0 requires curl! Aborting!"; exit 1; }
command -v grep > /dev/null || { echo "$0 requires grep! Aborting!"; exit 1; }

echo -n "Password: "
read -s password
echo

hashed_password=`echo -n ${password} | sha1sum | awk '{print $1}'`
hashed_password_five_chars=`echo -n ${hashed_password} | awk '{print substr($1,1,5)}'`
hashed_password_tail=`echo -n ${hashed_password} | awk '{print substr($1,6)}'`

echo "Hash: ${hashed_password}"
echo "Head: ${hashed_password_five_chars}"
echo "Tail:      ${hashed_password_tail}"

result=`curl https://api.pwnedpasswords.com/range/${hashed_password_five_chars} 2>&1 | grep -i ${hashed_password_tail}`

if [ -z "$result" ]; then
    echo ":) Not pwned! :)"
else
    echo "Pwnd: ${hashed_password_five_chars}${result}"
    echo ":( GOT PWNED! :("
fi

