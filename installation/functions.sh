#!/usr/bin/env bash

function exists() {
	if [ $(which $1 = "") ]; then
		return 0
	else
		return 1
	fi
}
