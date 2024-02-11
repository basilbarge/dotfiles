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
git clone https://github.com/neovim/neovim ~
cd ~/neovim $$ sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

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

for ITEM in $PWD/.config/*; 
do
	BASE=$(basename $ITEM)
	if [ -d $PWD/.config/$BASE ]; then
		if [ -d $HOME/.config/$BASE ]; then
			sudo rm -r $HOME/.config/$BASE
		fi
	elif [ -f $PWD/.config/$ITEM ]; then
		if [ -f $HOME/.config/$BASE ]; then
			sudo rm $HOME/.config/$BASE
		fi
	fi
done
sudo ln -s $PWD/.config/* ~/.config

# Install nvm and LTS of node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
# Source bashrc to get latest configuration
. ~/.bashrc
