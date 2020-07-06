#! /bin/sh
var=$(printf "Reboot\nLock\nShutdown" | dmenu -i -p "What you want to do?")
case $var in 
    Reboot ) reboot;;
    Lock ) slock;;
    Shutdown ) shutdown now;;
esac
