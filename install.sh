#!/bin/bash

# Get OS related variables to determine
# package manager to use
. /etc/os-release
echo $NAME

if [[ $NAME = "Ubuntu" ]]; then
	echo "Installing packages in Ubuntu"
	yes | sudo apt install neofetch
	yes | sudo apt install bat
	yes | sudo apt install git
	yes | sudo apt install tmux
	yes | sudo apt install curl

	# Install gh cli
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
elif [[ $NAME = "Arch Linux" ]]; then
	echo "Installing packages for Arch Linux"
	yes | sudo pacman -S neofetch
	yes | sudo pacman -S bat
	yes | sudo pacman -S git
	yes | sudo pacman -S github-cli
	yes | sudo pacman -S tmux
	yes | sudo pacman -S curl
fi

# Install tmux plugin manager
if [ -d $HOME/.tmux/plugins/tpm ]; then
	sudo rm -r $HOME/.tmux/plugins/tpm
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Create Symbolic links to dotfiles
if [ -f $HOME/.bash_aliases ]; then
	sudo rm $HOME/.bash_aliases
fi
sudo ln -s $PWD/.bash_aliases ~

if [ -f $HOME/.bashrc ]; then
	sudo rm $HOME/.bashrc
fi
sudo ln -s $PWD/.bashrc ~

if [ -f $HOME/.inputrc ]; then
	sudo rm $HOME/.inputrc
fi
sudo ln -s $PWD/.inputrc ~

if [ -f $HOME/.tmux.conf ]; then
	sudo rm $HOME/.tmux.conf
fi
sudo ln -s $PWD/.tmux.conf ~

sudo ln -s $PWD/.config/* ~/.config

# Source bashrc to get latest configuration
. ~/.bashrc
