#!/usr/bin/env bash

# Get useful global variables
. "/home/basilbarge/dotfiles/installation/globals.sh"

# Get user defined helper functions
. "/home/basilbarge/dotfiles/installation/functions.sh"

demarcate "BUILDING NVIM"

exists nvim
status=$?

if [[ "$status" -eq 1 && $OS_UBUNTU ]]; then
	yes | sudo apt upgrade
	yes | sudo apt-get install ninja-build gettext cmake unzip curl
elif [[ "$status" -eq 1 && $OS_ARCH ]]; then
	yes | sudo pacman -Syu
	yes | sudo pacman -S base-devel cmake unzip ninja curl
fi

# Build neovim from source
if [ ! -d "/home/basilbarge/neovim" ]; then
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
