#!/bin/sh

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a
# aaand modified for my needs

get_brightness() {
  xbacklight -get | cut -d '.' -f 1
}

send_notification() {
  icon=""
  brightness=$(get_brightness)

  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  slashes=$(( brightness / 10 ))
  blanks=$(( $(( 100 - brightness )) / 10 ))
  bar=$(seq -s "█" 0 $slashes | sed 's/[0-9]//g')$(seq -s " " 0 $blanks | sed 's/[0-9]//g')"▏"

  # Send the notification
  dunstify -r 5555 -u normal " $icon  $bar"
}

case $1 in
  up)
    # increase the backlight by 10%
    xbacklight -inc 10
    send_notification
    ;;
  down)
    # decrease the backlight by 10%
    xbacklight -dec 10 
    send_notification
    ;;
esac
