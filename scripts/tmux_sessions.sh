#!/usr/bin/env bash

dirs=("${SESSION_DIRS:-"/home/$USER"}")

dir_list=$(echo "${dirs[@]}")

chosen_dir=$(find $dir_list -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ ! -d $chosen_dir ]]; then
	echo "Chosen directory doesn't exist"
	exit 1
fi

tmux new-session -A -s $(basename "$chosen_dir") -c "$chosen_dir"
