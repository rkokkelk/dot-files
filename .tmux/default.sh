#!/bin/sh 
tmux new-session -d 'zsh'
tmux new-window -t 7 'mc'
tmux new-window -t 8 'htop'
tmux new-window -t 9 -n 'logs' 'tail -f /var/log/messages.log | ccze'
tmux split-window -v -t 9 -p 50 'tail -f /var/log/messages.log | ccze'
tmux select-window -t 1 
tmux -2 attach-session -d 
