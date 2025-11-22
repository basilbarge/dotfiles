#!/usr/bin/env bash

# Get useful global variables
. "/home/$USER/dotfiles/installation/globals.sh"

# Get user defined helper functions
. "/home/$USER/dotfiles/installation/functions.sh"

demarcate "BUILDING NVIM"

exists nvim
status=$?

if [[ "$status" = 1 && $OS_UBUNTU = 0 ]]; then
	yes | sudo apt upgrade
	yes | sudo apt-get install ninja-build gettext cmake unzip curl
elif [[ "$status" = 1 && $OS_ARCH = 0 ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S base-devel cmake unzip ninja curl
fi

# Build neovim from source
if [ ! -d "/home/$USER/neovim" ]; then
	git clone https://github.com/neovim/neovim ~/neovim
fi

cd ~/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo

while getopts "sn" flag; do
	case "${flag}" in
		s) git checkout stable ;;
		n) git checkout nightly ;;
		*) git checkout stable ;;
	esac
done

sudo make install

cd ~/dotfiles
