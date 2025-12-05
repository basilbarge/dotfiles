#!/usr/bin/env bash

while getopts 'e:' opt; do
	case "${opt}" in
		e) email=$OPTARG ;;
		*) echo 'bad option'; exit 1 ;;
 esac
done

if [[ $OPTIND = 1 ]]; then
	echo "No email given for ssh key"
	exit 1
fi

echo -n "Enter filename for ssh key:" 

read ssh_file

if [[ -f "/home/basilbarge/.ssh/$ssh_file" ]];then
	echo "ssh file with name /home/basilbarge/.ssh/$ssh_file already exists."
	exit 1
fi

# Generate ssh key using script parameter as email
ssh-keygen -t ed25519 -C $email -f "/home/basilbarge/.ssh/$ssh_file"

eval "$(ssh-agent -s)"


ssh-add "/home/basilbarge/.ssh/$ssh_file"
