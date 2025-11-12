#!/bin/bash

# Get OS related variables to determine
# package manager to use
. /etc/os-release
echo $NAME

DOTFILES_REPO=$PWD

if [[ $NAME = "Ubuntu" ]]; then
	echo "Installing packages in Ubuntu"

	sudo apt update

	yes | sudo apt install bat
	yes | sudo apt install git
	yes | sudo apt install curl
	yes | sudo apt install i3
	yes | sudo apt install stow
	yes | sudo apt install tldr
	yes | sudo apt install fzf
	yes | sudo apt install rg

	BAT_NAME="batcat"

	# Install eza
	yes | sudo apt install gpg
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt install -y eza

	# Update tldr doc repository
	tldr -u

	# Install prequisites for neovim to build from source
	yes | sudo apt-get install ninja-build gettext cmake unzip curl

	# Install gh cli
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
elif [[ $NAME = "Arch Linux" ]]; then
	echo "Installing packages for Arch Linux"
	
	sudo pacman -Syu

	yes | sudo pacman -S bat
	yes | sudo pacman -S git
	yes | sudo pacman -S github-cli
	yes | sudo pacman -S curl
	yes | sudo pacman -S eza
	yes | sudo pacman -S stow
	yes | sudo pacman -S fzf
	yes | sudo pacman -S ripgrep

	BAT_NAME="bat"

	# Make sure inetutils is installed to give us hostname command
	yes | sudo pacman -S inetutils

	yes | sudo pacman -S tldr

	# Update tldr doc respository
	tldr -u

	# Install prequisites for neovim to build from source
	sudo pacman -S base-devel cmake unzip ninja curl
fi

# Build neovim from source
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install

# Navigate back to dotfiles directory to finish install
cd ~/dotfiles

# Install rust and cargo with rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


# Install nvm and LTS of node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

STOW_DIRS=$(find $(pwd) -mindepth 1 -maxdepth 1 -type d)

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

# Build bat cache to make custome themes available
$BAT_NAME cache --build

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

# Source bashrc to get latest configuration
source ~/.bashrc
