#! /bin/sh
var=$(echo " " | dmenu -i -p "Search")
[ -z $var ] || qutebrowser --qt-flag ignore-gpu-blacklist --qt-flag enable-gpu-rasterization --qt-flag enable-native-gpu-memory-buffers --qt-flag num-raster-threads=4 --target window "$var"

