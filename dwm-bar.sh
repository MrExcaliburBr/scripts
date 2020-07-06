#! /bin/sh

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
    [ $STATUS = "Discharging" ] && BATTERY="%$CAPACITY" || BATTERY="%$CAPACITY" 
    
#   If the charge is equal or less then %15 it send a notification 
    [ $STATUS = "Discharging" ] && [ $CAPACITY -le "15" ] && BATTERY="%$CAPACITY" && notify-send "Battery Critical"
    
#====================================================================================

#====================================================================================
#Wifi status module

#   If wifi is up use this icon "", if not us that "" 
    case "$(cat /sys/class/net/wlp3s0/operstate)" in
	down ) WIFI="" ;; 
	up ) WIFI="" ;;
    
    esac

#====================================================================================

#====================================================================================
#Music module (cmus)

#   if cmus is running, then proceed
    if ps -C cmus > /dev/null; then

#	Defining variables
        NAME=$(cmus-remote -Q | grep "file" | sed 's=file /home/zezin/music/==g; s=.mp3==g')
	TIME=$(cmus-remote -Q | grep "position" | sed 's=position ==g')
	MUSICSTATUS=$(cmus-remote -Q | grep "status" | sed 's=status ==g')

#	If time is between 0 and 2 and the music is plauing notify   
	[ $TIME -ge "0" ] && [ $TIME -le "2" ] && [ $MUSICSTATUS = "playing" ] && notify-send "Now playing $NAME"

#	Change icon for play and pause
	[ $MUSICSTATUS = "playing" ] && ICON="⏵" || ICON="⏸" 

#	If cmus was running set icon, if not its a empty string	
	MUSIC=" | $ICON $NAME"

    else
	MUSIC=""

    fi

#   Put the variables on the bar 
    xsetroot -name "$MUSIC | $WIFI | $BATTERY | $DATE | "

    sleep 1s

done
