#!/bin/bash

# Get OS related variables
. /etc/os-release

# Get helpful global variables
. "/home/basilbarge/dotfiles/installation/globals.sh"

# Get custom helper functions
. "/home/basilbarge/dotfiles/installation/functions.sh"

echo "*******************************************"
echo "**************CONFIGURING GIT**************"
echo "*******************************************"


if [[ !$(exists git) && $OS_UBUNTU ]]; then
	yes | sudo apt update
	yes | sudo apt install git
elif [[ !$(exists git) && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S git
fi

if [[ !$(exists $BAT_NAME) && $OS_UBUNTU ]]; then
	yes | sudo apt update
	yes | sudo apt install bat
elif [[ !$(exists $BAT_NAME) && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S bat
fi

if [[ !$(exists gh) && $OS_UBUNTU ]]; then
	(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
		&& sudo mkdir -p -m 755 /etc/apt/keyrings \
		&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
		&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
elif [[ !$(exists gh) && $OS_ARCH ]]; then
	sudo pacman -Syu
	sudo pacman github-cli
fi

git reset --hard

git config --global core.editor "nvim"

git config --global core.pager "$BAT_NAME --style=plain" --replace-all

git config --global push.autoSetupRemote true

git config --global merge.tool nvimdiff2

git config --global diff.tool nvimdiff

gh config set editor "nvim"

gh config set pager "$BAT_NAME --style=plain" --replace-all

# Configure global git settings
git config --global user.email "zachb.barge@gmail.com" 
git config --global user.name "Zach Barge"

# Initialize and update submodules
git submodule init
git submodule update
