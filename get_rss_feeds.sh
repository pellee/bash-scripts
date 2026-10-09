#!/usr/bin/env bash

path_file="/home/pelle/projects/bash/all_subs.html"
pattern_channel="https://www.youtube.com/@[A-Za-z0-9!@#$%^&*()_+=\.-]*"
pattern_rss_feed="https://www.youtube.com/feeds/videos.xml?channel_id=[A-Za-z0-9!@#$%^&*()_+=\.-]*"

channels=$(grep $pattern_channel $path_file -o | sort | uniq)

channels_splited=($(echo $channels | tr ' ' '\n'))

for channel in "${channels_splited[@]}"; do
  channel_name=$(echo $channel | cut --delimiter "@" --fields 2)
  rss_feed=$(curl $channel | grep $pattern_rss_feed -o | uniq)
  rss_feed="${rss_feed/channel_id=UC/playlist_id=UULF}"
  echo "${rss_feed} yt \"~${channel_name}\"" >> urls_for_newsboat.txt
done
