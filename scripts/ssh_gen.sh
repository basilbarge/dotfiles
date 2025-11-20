#!/usr/bin/env bash

echo -n "Enter filename for ssh key:" 

read ssh_file

# Generate ssh key using script parameter as email
ssh-keygen -t ed25519 -C $1 -f "/home/basilbarge/.ssh/$ssh_file"

eval "$(ssh-agent -s)"

ssh-add "/home/basilbarge/.ssh/$ssh_file"
