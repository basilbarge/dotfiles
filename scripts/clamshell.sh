#!/usr/bin/bash

if [[ $1 == "open" ]]; then
	echo "open"
	hyprctl eval 'hl.monitor({output="eDP-1", disabled=false})'
else
	echo "close"
	hyprctl eval 'hl.monitor({output="eDP-1", disabled=true})'
fi
