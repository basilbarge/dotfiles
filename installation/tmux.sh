#!/usr/bin/env bash

# Get useful global vars
. "/home/$USER/dotfiles/installation/globals.sh"

# Get global helper functions
. "/home/$USER/dotfiles/installation/functions.sh"

tpm_dir="/home/$USER/.tmux/plugins/tpm"

exists git
status=$?

if [[ $status = 1 && $OS_UBUNTU = 0 ]]; then
	sudo apt install git
elif [[ $status = 1 && $OS_ARCH = 0 ]]; then
	sudo pacman -S git
fi

if [[ ! -d "/home/$USER/.tmux/plugins/tpm" ]]; then
	echo "Installing tmux plugin manager"
	git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
	exit 0
fi

echo "tmux plugin manager is already installed"

