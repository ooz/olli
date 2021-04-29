#!/usr/bin/env bash

ANY_KEY="Press any key to continue!"
INSTALL_SCRIPT_LOCATION="https://getmic.ro"
echo "Installing micro editor from $INSTALL_SCRIPT_LOCATION"
echo "Please read the script first! $ANY_KEY"
read
curl -s $INSTALL_SCRIPT_LOCATION | less
echo "Install? $ANY_KEY"
read
curl -s $INSTALL_SCRIPT_LOCATION | bash

