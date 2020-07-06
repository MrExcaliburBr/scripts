#! /bin/bash

#Refresh bar every 5s (I dont refresh everytime bc it takes to much cpu)

while true; do

#====================================================================================
#Date module
    
    DATE=$(date +"%d/%m/%y | %H:%M")

#====================================================================================

#====================================================================================
#Battery Module

#   Defing variables    
    CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

#   Change icon with charging statue ( "" from Cozette Vector) 
    [ $STATUS = "Discharging" ] && BATTERY="%$CAPACITY" || BATTERY="%$CAPACITY"; 
    
#   If the charge is equal or less then %15 it send a notification 
    [[ $STATUS = "Discharging" && $CAPACITY -le "15" ]] && notify-send "Battery Critical"
#====================================================================================

#====================================================================================
#Wifi status module
#   Set variable
    #WIFISTATUS=$(cat /sys/class/net/wlp3s0/operstate)

#   If wifi is up use this icon "", if not us that "" 
    case "$(cat /sys/class/net/wlp3s0/operstate)" in
	down ) WIFI="" ;; 
	up ) WIFI="" ;;
    
    esac

#====================================================================================

#====================================================================================
#Music module (cmus)

#   If cmus is running, then:
#    if [ -n "$(pgrep cmus)" ]; then

#   Check if music is playing or paused, en them puts a icon
#	case "$(cmus-remote -Q | grep -a '^status' | awk '{gsub("status ", "");print}')" in
#	    paused ) MSTATUS="" ;;
#	    playing ) MSTATUS="" ;;
	    
#	esac

#	Get name of the music
#	NAME=$(cmus-remote -Q | grep -a '^file' | awk '{gsub("file ", "");print}' | sed "s/.mp3//g; s/\\/home\\/zezin\\/music\\///g")
#	MUSIC=" | $MSTATUS $NAME"
	
#    elif [ -z "$(pgrep cmus)" ]; then
#	MUSIC=""
#    fi
#====================================================================================
#   if [[ -n "$(pgrep cmus)" && -n "$(cmus-remote -Q | grep -a '^file' | sed "s/file //g; s/.mp3//g; s/\\/home\\/zezin\\/music\\///g")" ]]; then
#       while true; do 
#           NAME="$(cmus-remote -Q | grep -a '^file' | sed "s/file //g; s/.mp3//g; s/\\/home\\/zezin\\/music\\///g")"
#           sleep 1s
#           NAME2="$(cmus-remote -Q | grep -a '^file' | sed "s/file //g; s/.mp3//g; s/\\/home\\/zezin\\/music\\///g")"
#           
#           if [ "$NAME" != "$NAME2" ]; then
#       	    notify-send -u low "Playing $NAME2"

#           fi
#       done
#   fi
    
#   Put the variables on the bar 
    xsetroot -name " | $WIFI | $BATTERY | $DATE | "

    sleep 5s

done
