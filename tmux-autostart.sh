#!/bin/sh

tmux new-session -d -n zsh -s base
tmux new-window -d -t '=base' -n 'new'
tmux send-keys -t '=base:=new' 'newsboat' Enter
tmux new-window -d -t '=base' -n 'file'
tmux send-keys -t '=base:=file' 'ranger' Enter
tmux new-window -d -t '=base' -n 'mus'
tmux send-keys -t '=base:=mus' 'cmus' Enter
tmux attach-session -t base
