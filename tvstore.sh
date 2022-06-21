#!/bin/bash

jq 2> /dev/null

: ${U? user name required [U=]}
: ${P? password required [P=]}
: ${L? download location required [L=]}

rm -rf cookie
curl -s -c cookie -X POST --data-urlencode "username=${U}" --data-urlencode "password=${P}" https://tvstore.me/takelogin.php

available=""

final=""
exit=0
i=0
while [[ $exit == 0 ]]; do
    : $((i++))
    torrents=$(curl -s -b cookie "https://tvstore.me/tracking/?action=loadgroup&g=0&p=$i" | jq -r .data[].episodes[][])
    news="$(echo $torrents |  jq -r 'if .magyar == 2 then .torrents[] else "" end' | sort -nu)"
    for torrent in $news; do
        if [[ "$torrent" ]]; then
            details=$(curl -s -b cookie "https://tvstore.me/torrent/br_process.php?id=$torrent")
            if [[ $details = *"- Hun -"* ]] || [[ $details = *"- Hun/Eng -"* ]]; then
                series=$(echo "$details" | cut -d'\' -f5)
                episode=$(echo "$details" | cut -d'\' -f7)
                if [[ $episode = *"x"* ]]; then
                    episode=$(echo $episode | cut -d"x" -f2)
                else
                    episode=9999
                fi
                q=0
                for quality in WebDL-1080p HDTV-1080p WebDL-720p HDTV-720p HDTV-Rip WebRip DVDRip BDRip TVRip; do
                    : $((q++))
                    [[ $details = *"$quality"* ]] && available="$available\n$series~$episode~$q~https://tvstore.me/torrent/download.php?id=$torrent"
                done
            fi
        fi
    done
    last=$(echo $torrents | jq '.torrents[]' | tail -1)
    [[ $last == $final ]] && exit=1
    final=$last
done

downloaded=""
for item in `echo -e "$available" | sort -n | sed '/^\s*$/d'`; do
    id=$(echo $item | sed 's/^\([[:digit:]]\{1,100\}\)~\([[:digit:]]\{1,100\}\).*/\1~\2/')
    if [[ $downloaded != *" $id "* ]]; then
        curl -s -b cookie -o $L/$id.torrent $(echo $item | cut -d"~" -f4)
        downloaded="$downloaded $id "
    fi
done

rm -rf cookie
