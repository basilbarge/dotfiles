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
	yes | sudo apt install zellij
	yes | sudo apt install curl
	yes | sudo apt install i3
	yes | sudo apt install stow
	yes | sudo apt install tldr
	yes | sudo apt install fzf

	# Update tldr doc repository
	tldr -u

	# Install Wezterm
	#$curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
	#echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	#sudo apt update
	#sudo apt install wezterm

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
	yes | sudo pacman -S zellij
	yes | sudo pacman -S curl
	yes | sudo pacman -S eza
	yes | sudo pacman -S stow
	yes | sudo pacman -S fzf

	# Make sure inetutils is installed to give us hostname command
	yes | sudo pacman -S inetutils

	yes | sudo pacman -S tldr

	# Update tldr doc respository
	tldr -u

	# Install prequisites for neovim to build from source
	yes | sudo pacman -S base-devel cmake unzip ninja curl
	yes | sudo pacman -S make cmake gettext
fi


# Install nvm and LTS of node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts

# Install oh-my-bash for easy terminal customization
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

stow --adopt bash-config
stow nvim
stow zellij
stow eza
stow bat

# Build bat cache to make custome themes available
bat cache --build

git reset --hard

git config --global core.pager "bat --style=plain" --replace-all

# Source bashrc to get latest configuration
source ~/.bashrc
