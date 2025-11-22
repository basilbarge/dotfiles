#!/usr/bin/env bash

# Get OS related variables
. /etc/os-release

if [[ $NAME = "Ubuntu" ]]; then
	OS_UBUNTU=0
	OS_ARCH=1
elif [[ $NAME = "Arch Linux" ]]; then
	OS_UBUNTU=1
	OS_ARCH=0
fi

if [[ $OS_UBUNTU = 0 ]]; then
	BAT_NAME="batcat"
elif [[ $OS_ARCH = 0 ]]; then
	BAT_NAME="bat"
fi
