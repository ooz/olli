#!/bin/bash
# Edit contacts file.

# Source:
# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
SCRIPTS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PEOPLE_FILE="people.txt"
vim "$SCRIPTS_DIR/$PEOPLE_FILE"

