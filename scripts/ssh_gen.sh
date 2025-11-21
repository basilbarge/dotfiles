#!/usr/bin/env bash

while getopts 'e:' opt; do
	case "${opt}" in
		e) email=$OPTARG ;;
		*) fatal 'bad option' ;;
 esac
done

if [[ $OPTIND = 1 ]]; then
	echo "No email given for ssh key"
	exit 1
fi

echo -n "Enter filename for ssh key:" 

read ssh_file

# Generate ssh key using script parameter as email
ssh-keygen -t ed25519 -C $email -f "/home/basilbarge/.ssh/$ssh_file"

eval "$(ssh-agent -s)"


ssh-add "/home/basilbarge/.ssh/$ssh_file"
