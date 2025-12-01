#!/usr/bin/env bash

dirs=("${SESSION_DIRS:-"/home/$USER"}")

chosen_dir=$(find -L $SESSION_DIRS -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ ! -d $chosen_dir ]]; then
	echo "Chosen directory doesn't exist"
	exit 1
fi

tmux new-session -A -s $(basename "$chosen_dir") -c "$chosen_dir"
