#!/bin/bash

# Simple script to control master volume.
# Usage: volume.sh <volume in percent>
# Defaulting to 56% if no volume parameter is given.
#
# Author: Oliver Zscheyge

if [ $# -eq 1 ]; then
	amixer -c 0 set Master $1%
else
	amixer -c 0 set Master 56%
fi

