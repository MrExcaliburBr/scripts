#! /bin/sh

var=$(du -a ~/code/scripts/* ~/.config/* | awk '{print $2}' | fzf )  
[ -z $var ] || nvim $var

