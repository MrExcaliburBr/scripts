#! /bin/sh
transmission-daemon
transmission-remote -a "$1" && notify-send "added torrent to list"
st -e tremc
