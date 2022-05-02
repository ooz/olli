#!/bin/bash

for f in *.flv
      do
      ffmpeg -i "$f" -f mp3 -vn -acodec libmp3lame "${f%.flv}.mp3"
done

for f in *.mp4
      do
      ffmpeg -i "$f" -f mp3 -vn -acodec libmp3lame "${f%.mp4}.mp3"
done

for f in *.mkv
      do
      ffmpeg -i "$f" -f mp3 -vn -acodec libmp3lame "${f%.mkv}.mp3"
done
