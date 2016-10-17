#!/bin/sh 
tmux new-session -d 'zsh'
tmux new-window -t 7 'mc'
tmux new-window -t 8 'htop'
tmux new-window -t 9 -n 'logs' 'tail -f -n 50 /var/log/auth.log | ccze'
tmux split-window -v -t 9 -p 50 'tail -f -n 50 /var/log/syslog | ccze'
tmux select-window -t 1 
tmux -2 attach-session -d 
