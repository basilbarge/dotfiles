#!/bin/bash

# Get OS related variables to determine
# package manager to use
. /etc/os-release
echo $NAME

DOTFILES_REPO=$PWD

if [[ $NAME = "Ubuntu" ]]; then
	echo "Installing packages in Ubuntu"
	yes | sudo apt install neofetch
	yes | sudo apt install bat
	yes | sudo apt install git
	yes | sudo apt install tmux
	yes | sudo apt install curl

	# Install prequisites for neovim to build from source
	yes | sudo apt-get install ninja-build gettext cmake unzip curl
	yes | sudo apt-get install make cmake gettext

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

	# Install prequisites for neovim to build from source
	yes | sudo pacman -S base-devel cmake unzip ninja curl
	yes | sudo pacman -S make cmake gettext
fi

# Install and build Neovim from source
git clone https://github.com/neovim/neovim ~/neovim
cd ~/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Install tmux plugin manager
if [ -d $HOME/.tmux/plugins/tpm ]; then
	sudo rm -r $HOME/.tmux/plugins/tpm
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Create Symbolic links to dotfiles
if [ -f $HOME/.bash_aliases ] || [ -L $HOME/.bash_aliases ]; then
	echo "Removing .bash_aliases from home directory"
	sudo rm $HOME/.bash_aliases
fi
sudo ln -s $DOTFILES_REPO/.bash_aliases ~

if [ -f $HOME/.bashrc ] || [ -L $HOME/.bashrc ]; then
	echo "Removing .bash_rc from home directory"
	sudo rm $HOME/.bashrc
fi
sudo ln -s $DOTFILES_REPO/.bashrc ~

if [ -f $HOME/.inputrc ] || [ -L $HOME/.inputrc ]; then
	echo "Removing .inputrc from home directory"
	sudo rm $HOME/.inputrc
fi
sudo ln -s $DOTFILES_REPO/.inputrc ~

if [ -f $HOME/.tmux.conf ] || [ -L $HOME/.tmux.conf ]; then
	echo "Removing .tmux.conf from home directory"
	sudo rm $HOME/.tmux.conf
fi
sudo ln -s $DOTFILES_REPO/.tmux.conf ~

for ITEM in $DOTFILES_REPO/.config/*; 
do
	BASE=$(basename $ITEM)
	if [ -d $DOTFILES_REPO/.config/$BASE ]; then
		if [ -d $HOME/.config/$BASE ] || [ -L $HOME/.config/$BASE ]; then
			echo "Removing directories from .config in home directory"
			sudo rm -r $HOME/.config/$BASE
		fi
	elif [ -f $DOTFILES_REPO/.config/$ITEM ]; then
		if [ -f $HOME/.config/$BASE ] || [ -L $HOME/.config/$BASE ]; then
			echo "Removing files from .config in home directory"
			sudo rm $HOME/.config/$BASE
		fi
	fi
done
sudo ln -s $DOTFILES_REPO/.config/* ~/.config

# Install nvm and LTS of node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
# Source bashrc to get latest configuration
source ~/.bashrc
