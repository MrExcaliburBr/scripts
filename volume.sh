#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  amixer -c 1 get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer -c 1 get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  iconSound="墳"
  iconMuted="婢"
  if is_mute ; then
    dunstify -r 2593 -u normal " $iconMuted "
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    slashes=$(( $volume / 5 ))
    blanks=$(( $(( 100 - $volume )) / 5 ))
    bar=$(seq -s "█" 0 $slashes | sed 's/[0-9]//g')$(seq -s " " 0 $blanks | sed 's/[0-9]//g')"▏"
    # Send the notification
    dunstify -r 2593 -u normal " $iconSound  $bar"
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    amixer -c 1 set Master on > /dev/null
    # up the volume (+ 5%)
    amixer -c 1 sset Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    amixer -c 1 set Master on > /dev/null
    amixer -c 1 sset Master 5%- > /dev/null
    send_notification
    ;;
  mute)
    # toggle mute
    amixer -c 1 set Master 1+ toggle > /dev/null
    send_notification
    ;;
esac
