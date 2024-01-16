#!/bin/bash

# Get OS related variables to determine
# package manager to use
. /etc/os-release
echo $NAME

if [[ $NAME = "Ubuntu" ]]; then
	echo "Installing packages in Ubuntu"
	sudo apt install neofetch
	sudo apt install bat
	sudo apt install git
	sudo apt install tmux

	# Install gh cli
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
elif [[ $NAME = "Arch Linux" ]]; then
	echo "Installing packages for Arch Linux"
	sudo pacman -S neofetch
	sudo pacman -S bat
	sudo pacman -S git
	sudo pacman -S github-cli
	sudo pacman -S tmux
fi

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
