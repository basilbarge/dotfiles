#!/usr/bin/bash

# Get custom helper functions
. "/home/basilbarge/dotfiles/installation/globals.sh"

# Get custom helper functions
. "/home/basilbarge/dotfiles/installation/functions.sh"

DOTFILES_REPO="~/dotfiles"

if [[ !$(exists stow) && $OS_UBUNTU ]]; then
	yes | sudo apt update
	yes | sudo apt install stow
elif [[ !$(exists stow) && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S stow
fi

if [[ !$(exists $BAT_NAME) && $OS_UBUNTU ]]; then
	yes | sudo apt update
	yes | sudo apt install bat
elif [[ !$(exists $BAT_NAME) && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S bat
fi

if [[ !$(exists rg) && $OS_UBUNTU ]]; then
	yes | sudo apt update
	yes | sudo apt install ripgrep
elif [[ !$(exists rg) && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S ripgrep
fi

STOW_DIRS=$(find $DOTFILES_REPO -mindepth 1 -maxdepth 1 -type d)

# Use stow for all directories in the dotfiles repo
for DIR in $STOW_DIRS
do
	DIR_BASE_NAME=$(basename $DIR)

	if [[ $DIR_BASE_NAME == "bash-config" ]]; then
		stow --adopt $DIR_BASE_NAME
	elif [[ $DIR_BASE_NAME == ".git" ]]; then
		continue
	else
		stow $DIR_BASE_NAME
	fi
done

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"


# Build bat cache to make custome themes available
$BAT_NAME cache --build

# Install rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
