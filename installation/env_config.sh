#!/usr/bin/env bash

# Get custom helper functions
. "/home/basilbarge/dotfiles/installation/globals.sh"

# Get custom helper functions
. "/home/basilbarge/dotfiles/installation/functions.sh"

DOTFILES_REPO="/home/basilbarge/dotfiles"

demarcate "CONFIGURING BASH ENVIRONMENT"

exists stow
status=$?

if [[ "$status" -eq 1 && $OS_UBUNTU == 0 ]]; then
	yes | sudo apt update
	yes | sudo apt install stow
elif [[ "$status" -eq 1 && $OS_ARCH == 0]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S stow
fi

exists $BAT_NAME
status=$?

if [[ "$status" -eq 1 && $OS_UBUNTU == 0 ]]; then
	yes | sudo apt update
	yes | sudo apt install bat
elif [[ "$status" -eq 1 && $OS_ARCH == 0 ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S bat
fi

exists rg
status=$?

if [[ "$status" -eq 1 && $OS_UBUNTU == 0 ]]; then
	yes | sudo apt update
	yes | sudo apt install ripgrep
elif [[ "$status" -eq 1 && $OS_ARCH == 0 ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S ripgrep
fi

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

STOW_DIRS=$(find $DOTFILES_REPO -mindepth 1 -maxdepth 1 -type d)

# Use stow for all directories in the dotfiles repo
for DIR in $STOW_DIRS
do
	DIR_BASE_NAME=$(basename $DIR)

	if [[ $DIR_BASE_NAME == "bash-config" ]]; then
		stow --dir="/home/basilbarge/dotfiles" --target="/home/basilbarge/" --adopt $DIR_BASE_NAME
	elif [[ $DIR_BASE_NAME == ".git" || $DIR_BASE_NAME == "installation" ]]; then
		continue
	else
		stow --dir="/home/basilbarge/dotfiles" --target="/home/basilbarge" $DIR_BASE_NAME
	fi
done



# Build bat cache to make custome themes available
$BAT_NAME cache --build

# Install rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
