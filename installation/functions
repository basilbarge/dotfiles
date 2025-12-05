#!/usr/bin/env bash


function exists() {
	return $(command -v $1 >/dev/null 2>&1)
}

function gh_install() {
	(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
		&& sudo mkdir -p -m 755 /etc/apt/keyrings \
		&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
		&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
}

function demarcate() {
	shopt -s checkwinsize
	(:)

	local title=$1
	local title_length=${#title}

	local halfway=$((COLUMNS / 2))
	local title_start=$((halfway - (($title_length / 2))))
	local title_end=$((halfway + (($title_length / 2))))
	local section_char='*'
	local empty_char=' '

	local padding=4
	 local s=''

	for ((i = 0; i < $((COLUMNS)); i++)); do
		s+=$section_char
	done

	printf "%s" "$s"

	s=''

	for ((i = 0; i < $(($title_start - $padding)); i++)); do
		s+=$section_char
	done
	for ((i = $(($title_start - $padding)); i < $title_start; i++)); do
		s+=$empty_char
	done
	s+=$title
	for ((i = $title_end; i < $(($title_end + $padding)); i++)); do
		s+=$empty_char
	done
	for ((i = $(($title_end + $padding)); i < $((COLUMNS)); i++)); do
		s+=$section_char
	done
	  
	printf "%s" "$s"

	s=''

	for ((i = 0; i < $((COLUMNS)); i++)); do
		s+=$section_char
	done

	printf "%s" "$s"
}
