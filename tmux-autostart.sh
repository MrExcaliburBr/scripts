#!/bin/bash
if tmux ls &> /dev/null; then 
    tmux a -t master

else 
    tmux new-session -d -s master -n sm nvim
    tmux new-window -t master -n fm 'nnn'
    tmux new-window -t master -n new 'newsboat'
    tmux new-window -t master -n chat 'cordless'
    tmux new-window -t master -n mus 'cmus'
    tmux a -t master:sm
fi
