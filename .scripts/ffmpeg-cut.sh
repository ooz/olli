#!/bin/bash

# Brief: Cuts out a part of a longer audio file
# Author: Oliver Zeit
#
# Requires ffmpeg

if [ "$#" -ne 3 ]; then
    echo "Needs filename, starttime, duration parameters, e.g."
    echo "$0 concert.mp3 01:40:37 00:02:50"
    exit 1
fi

ffmpeg -i $1 -vn -acodec copy -ss $2 -t $3 "part_$1"

